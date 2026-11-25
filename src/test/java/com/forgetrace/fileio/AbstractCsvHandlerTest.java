package com.forgetrace.fileio;

import org.junit.jupiter.api.Test;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

class AbstractCsvHandlerTest {

    @Test
    void formulaCellsAreNeutralised() {
        assertThat(AbstractCsvHandler.escape("=SUM(A1:A9)")).isEqualTo("'=SUM(A1:A9)");
        assertThat(AbstractCsvHandler.escape("+91 98")).isEqualTo("'+91 98");
        assertThat(AbstractCsvHandler.escape("@cmd")).isEqualTo("'@cmd");
    }

    @Test
    void commasAndQuotesAreQuoted() {
        assertThat(AbstractCsvHandler.escape("Pune, MH")).isEqualTo("\"Pune, MH\"");
        assertThat(AbstractCsvHandler.escape("5\" pipe")).isEqualTo("\"5\"\" pipe\"");
        assertThat(AbstractCsvHandler.escape(null)).isEmpty();
    }

    @Test
    void parsesQuotedValues() {
        assertThat(AbstractCsvHandler.parseLine("CNC-1,\"Pune, MH\",\"5\"\" pipe\",")).containsExactly("CNC-1", "Pune, MH", "5\" pipe", "");
    }

    @Test
    void parseOfEscapedValueRoundTrips() {
        String original = "Line \"A\", bay 3";
        assertThat(AbstractCsvHandler.parseLine(AbstractCsvHandler.escape(original))).isEqualTo(List.of(original));
    }
}