package com.forgetrace.qr;

import com.google.zxing.BinaryBitmap;
import com.google.zxing.MultiFormatReader;
import com.google.zxing.client.j2se.BufferedImageLuminanceSource;
import com.google.zxing.common.HybridBinarizer;
import org.junit.jupiter.api.Test;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;

import static org.assertj.core.api.Assertions.assertThat;

class QrCodeGeneratorTest {

    private final QrCodeGenerator generator = new QrCodeGenerator();

    @Test
    void producesPngImage() {
        byte[] png = generator.png("https://forgetrace.example/p/abc", 300);
        assertThat(png[0]).isEqualTo((byte) 0x89);
        assertThat(new String(png, 1, 3)).isEqualTo("PNG");
    }

    @Test
    void qrDecodesBackToPassportUrl() throws Exception {
        String url = "http://localhost:8080/p/3f2a6c1e-8a7b-4d2e-9b1f-0c5d7e8f9a10";
        BufferedImage image = ImageIO.read(new ByteArrayInputStream(generator.png(url, 360)));
        BinaryBitmap bitmap = new BinaryBitmap(new HybridBinarizer(new BufferedImageLuminanceSource(image)));
        assertThat(new MultiFormatReader().decode(bitmap).getText()).isEqualTo(url);
    }
}