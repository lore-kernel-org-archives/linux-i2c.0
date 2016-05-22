From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] i2c: I2C_RCAR should depend on HAS_DMA
Date: Sun, 22 May 2016 09:38:35 +0200
Message-ID: <1463902715-12680-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-i2c@vger.kernel.org

If NO_DMA=y:

    drivers/built-in.o: In function `rcar_i2c_dma_unmap':
    i2c-rcar.c:(.text+0x6f06c6): undefined reference to `bad_dma_ops'
    drivers/built-in.o: In function `rcar_i2c_dma':
    i2c-rcar.c:(.text+0x6f07e2): undefined reference to `bad_dma_ops'
    i2c-rcar.c:(.text+0x6f0838): undefined reference to `bad_dma_ops'

Add a dependency on HAS_DMA to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/i2c/busses/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 2dd40ddf04de3117..8ffb0d7015b0f4fe 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -985,6 +985,7 @@ config I2C_XLP9XX
 
 config I2C_RCAR
 	tristate "Renesas R-Car I2C Controller"
+	depends on HAS_DMA
 	depends on ARCH_RENESAS || COMPILE_TEST
 	select I2C_SLAVE
 	help
-- 
1.9.1
