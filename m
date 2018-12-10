From: "Adamski, Krzysztof (Nokia - PL/Wroclaw)"
        <krzysztof.adamski@nokia.com>
Subject: [PATCH 1/3] i2c-axxia: dedicated function to set client addr
Date: Mon, 10 Dec 2018 15:00:52 +0000
Message-ID: <120bc3dbc7fad29807ff9f7c74575a66e6da15a6.1544453688.git.krzysztof.adamski@nokia.com>
References: <cover.1544453688.git.krzysztof.adamski@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1544453688.git.krzysztof.adamski@nokia.com>
Content-Language: en-US
Content-ID: <E34369BA36F7E341BB244F349EE2F73E@eurprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Guenter Roeck <linux@roeck-us.net>, Tobias Jordan <Tobias.Jordan@elektrobit.com>, Peter Rosin <peda@axentia.se>
List-Id: linux-i2c@vger.kernel.org

This patch moves configuration of hardware registers used for setting
i2c client address to separate function. It is preparatory change for
next commit.

Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
---
 drivers/i2c/busses/i2c-axxia.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.=
c
index 51d34959709b..d37caf694fbf 100644
--- a/drivers/i2c/busses/i2c-axxia.c
+++ b/drivers/i2c/busses/i2c-axxia.c
@@ -337,17 +337,9 @@ static irqreturn_t axxia_i2c_isr(int irq, void *_dev)
 	return IRQ_HANDLED;
 }
=20
-static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *idev, struct i2c_msg *=
msg)
+static void axxia_i2c_set_addr(struct axxia_i2c_dev *idev, struct i2c_msg =
*msg)
 {
-	u32 int_mask =3D MST_STATUS_ERR | MST_STATUS_SNS;
-	u32 rx_xfer, tx_xfer;
 	u32 addr_1, addr_2;
-	unsigned long time_left;
-	unsigned int wt_value;
-
-	idev->msg =3D msg;
-	idev->msg_xfrd =3D 0;
-	reinit_completion(&idev->msg_complete);
=20
 	if (i2c_m_ten(msg)) {
 		/* 10-bit address
@@ -367,6 +359,23 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *id=
ev, struct i2c_msg *msg)
 		addr_2 =3D 0;
 	}
=20
+	writel(addr_1, idev->base + MST_ADDR_1);
+	writel(addr_2, idev->base + MST_ADDR_2);
+}
+
+static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *idev, struct i2c_msg *=
msg)
+{
+	u32 int_mask =3D MST_STATUS_ERR | MST_STATUS_SNS;
+	u32 rx_xfer, tx_xfer;
+	unsigned long time_left;
+	unsigned int wt_value;
+
+	idev->msg =3D msg;
+	idev->msg_xfrd =3D 0;
+	reinit_completion(&idev->msg_complete);
+
+	axxia_i2c_set_addr(idev, msg);
+
 	if (i2c_m_rd(msg)) {
 		/* I2C read transfer */
 		rx_xfer =3D i2c_m_recv_len(msg) ? I2C_SMBUS_BLOCK_MAX : msg->len;
@@ -379,8 +388,6 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *ide=
v, struct i2c_msg *msg)
=20
 	writel(rx_xfer, idev->base + MST_RX_XFER);
 	writel(tx_xfer, idev->base + MST_TX_XFER);
-	writel(addr_1, idev->base + MST_ADDR_1);
-	writel(addr_2, idev->base + MST_ADDR_2);
=20
 	if (i2c_m_rd(msg))
 		int_mask |=3D MST_STATUS_RFL;
--=20
2.17.2
