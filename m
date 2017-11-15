From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 1/6] pinctrl: sh-pfc: r8a77995: add missing pins SCL0 and SDA0 to pinmux data
Date: Wed, 15 Nov 2017 16:25:21 +0100
Message-ID: <1510759526-30346-2-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1510759526-30346-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1510759526-30346-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, horms@verge.net.au, wsa@the-dreams.de, geert@linux-m68k.org
Cc: magnus.damm@gmail.com, linux-i2c@vger.kernel.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Required for I2C0 operation.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77995.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77995.c b/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
index 89b7541..2c9a71a 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
@@ -518,6 +518,8 @@ static const u16 pinmux_data[] = {
 	PINMUX_SINGLE(QSPI0_MISO_IO1),
 	PINMUX_SINGLE(QSPI0_MOSI_IO0),
 	PINMUX_SINGLE(QSPI0_SPCLK),
+	PINMUX_SINGLE(SCL0),
+	PINMUX_SINGLE(SDA0),
 
 	/* IPSR0 */
 	PINMUX_IPSR_MSEL(IP0_3_0,	IRQ0_A, SEL_IRQ_0_0),
-- 
2.7.4
