package com.forgetrace.mapper;

import com.forgetrace.dto.request.RfqCreateRequest;
import com.forgetrace.dto.response.RfqDetailView;
import com.forgetrace.dto.response.RfqSummary;
import com.forgetrace.entity.Rfq;
import com.forgetrace.entity.RfqAttachment;
import org.springframework.stereotype.Component;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

/**
 * RFQ entity <-> DTOs.
 * Specifications are stored in the JSONB column as [["Thickness","2 mm"],["Finish","Powder coat"]].
 * A tiny JSON writer/reader is included so no extra library is needed.
 */
@Component
public class RfqMapper {

    public RfqSummary toSummary(Rfq rfq, long quotationCount, boolean alreadyQuoted) {
        return new RfqSummary(
                rfq.getId(), rfq.getRfqNumber(), rfq.getTitle(),
                rfq.getBuyerOrganization().getDisplayName(),
                rfq.getProcess().getProcessName(), rfq.getMaterial().getMaterialName(),
                rfq.getQuantity(), rfq.getQuantityUnit(),
                rfq.getDeliveryDate(), rfq.getQuoteDeadline(), rfq.getStatus(),
                quotationCount, alreadyQuoted);
    }

    public RfqDetailView toDetail(Rfq rfq, List<RfqAttachment> attachments, Instant now) {
        List<RfqDetailView.AttachmentItem> files = attachments.stream()
                .map(a -> new RfqDetailView.AttachmentItem(a.getFile().getId(), a.getFile().getOriginalFilename(),
                        a.getFile().getSizeBytes()))
                .toList();
        return new RfqDetailView(
                rfq.getId(), rfq.getRfqNumber(), rfq.getTitle(), rfq.getDescription(),
                rfq.getBuyerOrganization().getId(), rfq.getBuyerOrganization().getDisplayName(),
                rfq.getProcess().getProcessName(), rfq.getMaterial().getMaterialName(),
                rfq.getQuantity(), rfq.getQuantityUnit(),
                jsonToSpecs(rfq.getSpecifications()),
                rfq.getToleranceNotes(), rfq.getDeliveryDate(), rfq.getDeliveryAddress(),
                rfq.getQuoteDeadline(), rfq.getStatus(), rfq.getCreatedAt(),
                files, rfq.isOpenFor(now));
    }

    // ---------- Specifications <-> JSON ----------

    /** Keeps only rows with a name; returns null when there are none. */
    public String specsToJson(List<RfqCreateRequest.SpecRow> rows) {
        if (rows == null) {
            return null;
        }
        List<String> pairs = new ArrayList<>();
        for (RfqCreateRequest.SpecRow row : rows) {
            if (row == null || row.getName() == null || row.getName().isBlank()) {
                continue;
            }
            String value = row.getValue() == null ? "" : row.getValue().trim();
            pairs.add("[" + quote(row.getName().trim()) + "," + quote(value) + "]");
        }
        return pairs.isEmpty() ? null : "[" + String.join(",", pairs) + "]";
    }

    /** Reads back our own [[name,value],...] format by pairing the string values in order. */
    public List<RfqDetailView.SpecItem> jsonToSpecs(String json) {
        List<RfqDetailView.SpecItem> items = new ArrayList<>();
        if (json == null || json.isBlank()) {
            return items;
        }
        List<String> strings = readStrings(json);
        for (int i = 0; i + 1 < strings.size(); i += 2) {
            items.add(new RfqDetailView.SpecItem(strings.get(i), strings.get(i + 1)));
        }
        return items;
    }

    static String quote(String text) {
        StringBuilder out = new StringBuilder("\"");
        for (char c : text.toCharArray()) {
            switch (c) {
                case '"' -> out.append("\\\"");
                case '\\' -> out.append("\\\\");
                case '\n' -> out.append("\\n");
                case '\r' -> out.append("\\r");
                case '\t' -> out.append("\\t");
                default -> {
                    if (c < 0x20) {
                        out.append(String.format("\\u%04x", (int) c));
                    } else {
                        out.append(c);
                    }
                }
            }
        }
        return out.append('"').toString();
    }

    static List<String> readStrings(String json) {
        List<String> values = new ArrayList<>();
        int i = 0;
        while (i < json.length()) {
            if (json.charAt(i) != '"') {
                i++;
                continue;
            }
            StringBuilder value = new StringBuilder();
            i++; // skip opening quote
            while (i < json.length() && json.charAt(i) != '"') {
                char c = json.charAt(i);
                if (c == '\\' && i + 1 < json.length()) {
                    char next = json.charAt(++i);
                    switch (next) {
                        case 'n' -> value.append('\n');
                        case 'r' -> value.append('\r');
                        case 't' -> value.append('\t');
                        case 'b' -> value.append('\b');
                        case 'f' -> value.append('\f');
                        case 'u' -> {
                            if (i + 4 < json.length()) {
                                value.append((char) Integer.parseInt(json.substring(i + 1, i + 5), 16));
                                i += 4;
                            }
                        }
                        default -> value.append(next); // \" \\ \/
                    }
                } else {
                    value.append(c);
                }
                i++;
            }
            values.add(value.toString());
            i++; // skip closing quote
        }
        return values;
    }
}