From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 01/14] i2c: jz4780: suppress txabrt reports for i2cdetect
Date: Tue, 11 Feb 2020 22:41:18 +0100
Message-ID: <7facef52af9cff6ebe26ff321a7fd4f1ac640f74.1581457290.git.hns@goldelico.com>
References: <cover.1581457290.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <cover.1581457290.git.hns@goldelico.com>
Sender: netdev-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>, Paul Boddie <paul@boddie.org.uk>, Alex Smith <alex.smith@imgtec.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "David S. Miller" <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, Andi Kleen <ak@linux.intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Miquel Raynal <miquel.raynal@bootlin.com>, =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>, Richard Fontana <rfontana@redhat.com>
Cc: devicetree@vger.kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org, netdev@vger.kernel.org, linux-gpio@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-i2c@vger.kernel.org

This suppresses "simple" error reasons

	ABRT_7B_ADDR_NOACK
	ABRT_10ADDR1_NOACK
	ABRT_10ADDR2_NOACK

from flooding the console log when running i2cdetect on
addresses without a responding slave.

Additionally, reading the JZ4780_I2C_TAR in this situation
seems to harm the controller state.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/i2c/busses/i2c-jz4780.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-jz4780.c b/drivers/i2c/busses/i2c-jz4780.c
index 16a67a64284a..55b7518435f1 100644
--- a/drivers/i2c/busses/i2c-jz4780.c
+++ b/drivers/i2c/busses/i2c-jz4780.c
@@ -578,6 +578,9 @@ static void jz4780_i2c_txabrt(struct jz4780_i2c *i2c, int src)
 {
 	int i;
 
+	if (!(src & ~7))
+		return;
+
 	dev_err(&i2c->adap.dev, "txabrt: 0x%08x\n", src);
 	dev_err(&i2c->adap.dev, "device addr=%x\n",
 		jz4780_i2c_readw(i2c, JZ4780_I2C_TAR));
-- 
2.23.0
