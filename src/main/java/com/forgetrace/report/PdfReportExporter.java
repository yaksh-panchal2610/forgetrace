package com.forgetrace.report;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.font.PDFont;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.font.Standard14Fonts;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.nio.file.Path;
import java.util.List;

@Component
public class PdfReportExporter implements ReportExporter {

    private static final float MARGIN = 36f;
    private static final float ROW_HEIGHT = 16f;
    private static final float FONT_SIZE = 8.5f;

    @Override
    public ReportFormat format() {
        return ReportFormat.PDF;
    }

    @Override
    public void export(ReportData data, Path file) throws IOException {
        PDFont regular = new PDType1Font(Standard14Fonts.FontName.HELVETICA);
        PDFont bold = new PDType1Font(Standard14Fonts.FontName.HELVETICA_BOLD);
        PDRectangle landscape = new PDRectangle(PDRectangle.A4.getHeight(), PDRectangle.A4.getWidth());
        float colWidth = (landscape.getWidth() - 2 * MARGIN) / Math.max(1, data.headers().size());

        try (PDDocument document = new PDDocument()) {
            PageWriter w = new PageWriter(document, landscape, regular, bold);
            w.newPage();
            w.line(bold, 16f, data.title(), 24f);
            w.line(regular, 10f, data.subtitle(), 18f);
            for (String s : data.summaryLines()) {
                w.line(regular, 9.5f, s, 13f);
            }
            w.y -= 10f;
            w.tableHeader(data.headers(), colWidth);
            if (data.rows().isEmpty()) {
                w.line(regular, 10f, "No records in this period.", 14f);
            }
            for (List<String> row : data.rows()) {
                if (w.y < MARGIN + ROW_HEIGHT) {
                    w.newPage();
                    w.tableHeader(data.headers(), colWidth);
                }
                w.tableRow(row, colWidth);
            }
            w.close();
            document.save(file.toFile());
        }
    }

    private static final class PageWriter {
        private final PDDocument document;
        private final PDRectangle size;
        private final PDFont regular;
        private final PDFont bold;
        private PDPageContentStream cs;
        private float y;
        private int pageNumber;

        PageWriter(PDDocument document, PDRectangle size, PDFont regular, PDFont bold) {
            this.document = document;
            this.size = size;
            this.regular = regular;
            this.bold = bold;
        }

        void newPage() throws IOException {
            close();
            PDPage page = new PDPage(size);
            document.addPage(page);
            pageNumber++;
            cs = new PDPageContentStream(document, page);
            y = size.getHeight() - MARGIN;
            put(regular, 8f, MARGIN, MARGIN / 2, "ForgeTrace report - page " + pageNumber);
        }

        void line(PDFont font, float fontSize, String text, float advance) throws IOException {
            put(font, fontSize, MARGIN, y, text);
            y -= advance;
        }

        void tableHeader(List<String> headers, float colWidth) throws IOException {
            cs.setNonStrokingColor(0.90f, 0.93f, 0.96f);
            cs.addRect(MARGIN, y - 5f, colWidth * headers.size(), ROW_HEIGHT);
            cs.fill();
            cs.setNonStrokingColor(0f, 0f, 0f);
            for (int i = 0; i < headers.size(); i++) {
                put(bold, FONT_SIZE, MARGIN + i * colWidth + 3f, y, fit(bold, headers.get(i), colWidth - 6f));
            }
            y -= ROW_HEIGHT;
        }

        void tableRow(List<String> row, float colWidth) throws IOException {
            for (int i = 0; i < row.size(); i++) {
                put(regular, FONT_SIZE, MARGIN + i * colWidth + 3f, y, fit(regular, row.get(i), colWidth - 6f));
            }
            cs.setStrokingColor(0.85f, 0.85f, 0.85f);
            cs.moveTo(MARGIN, y - 5f);
            cs.lineTo(MARGIN + colWidth * row.size(), y - 5f);
            cs.stroke();
            y -= ROW_HEIGHT;
        }

        void put(PDFont font, float fontSize, float x, float atY, String text) throws IOException {
            cs.beginText();
            cs.setFont(font, fontSize);
            cs.newLineAtOffset(x, atY);
            cs.showText(clean(text));
            cs.endText();
        }

        String fit(PDFont font, String text, float maxWidth) throws IOException {
            String s = clean(text);
            if (width(font, s) <= maxWidth) {
                return s;
            }
            while (s.length() > 1 && width(font, s + "..") > maxWidth) {
                s = s.substring(0, s.length() - 1);
            }
            return s + "..";
        }

        float width(PDFont font, String s) throws IOException {
            return font.getStringWidth(s) / 1000f * FONT_SIZE;
        }

        static String clean(String value) {
            if (value == null) {
                return "";
            }
            StringBuilder sb = new StringBuilder(value.length());
            for (char c : value.toCharArray()) {
                if (Character.isWhitespace(c) || Character.isSpaceChar(c)) {
                    sb.append(' ');
                } else if (c < 32 || c > 126) {
                    sb.append('?');
                } else {
                    sb.append(c);
                }
            }
            return sb.toString();
        }

        void close() throws IOException {
            if (cs != null) {
                cs.close();
                cs = null;
            }
        }
    }
}