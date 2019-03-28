From: "Adamski, Krzysztof (Nokia - PL/Wroclaw)"
        <krzysztof.adamski@nokia.com>
Subject: [PATCH] axxia-i2c: use auto cmd for last message
Date: Thu, 28 Mar 2019 11:19:45 +0000
Message-ID: <20190328111858.GA17086@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Content-ID: <51E43BBE31C5E44EA30B74CEA2E66618@eurprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
List-Id: linux-i2c@vger.kernel.org

Some recent commits to this driver were trying to make sure the TSS
interrupt is not generated on busy system due to 25ms timer expiring
between commands. It can still happen, however if STOP command is not
issued on time at the end of the transmission. If wait_for_completion in
axxia_i2c_xfer_msg() would not return after 25ms of getting an
interrupt, TSS will be generated and idev->err_msg will be set to
-ETIMEDOUT which will be returned from the axxia_i2c_xfer_msg(), even
though the transfer did actually succeed (STOP is automatically issued
when TSS triggers).

Fortunately, apart from already used manual and sequence commands, the
controller also has so called auto command. It works just like manual
mode but it but an automatic STOP is issued when either transfer length
is met or NAK is received from slave device.

This patch changes the axxia_i2c_xfer_msg() function so that auto
command is used for last message in transaction letting hardware manage
issuing STOP. TSS is disabled just after command transferring last
message finishes. Auto command, just like sequence, ends with SS
interrupt instead of SNS so handling of both had to be unified.

The axxia_i2c_stop() is no longer needed as the transfer can only end
with following conditions:
- fully successful - then last message was send by AUTO command and STOP
  was issued automatically
- NAK received - STOP is issued automatically by controller
- arbitration lost - STOP should not be issued as we don't control the
  bus
- IP interrupt received - this is sent when transfer length is set to 0
  for auto/sequence command. The check for that is done before START is
  send so no STOP is required
- TSS received between commands - STOP is issued by the controller

Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 drivers/i2c/busses/i2c-axxia.c | 57 ++++++++++++----------------------
 1 file changed, 19 insertions(+), 38 deletions(-)

diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.=
c
index bf564391091f..1c7b41f45c83 100644
--- a/drivers/i2c/busses/i2c-axxia.c
+++ b/drivers/i2c/busses/i2c-axxia.c
@@ -99,6 +99,7 @@
  * @adapter: core i2c abstraction
  * @i2c_clk: clock reference for i2c input clock
  * @bus_clk_rate: current i2c bus clock rate
+ * @last: a flag indicating is this is last message in transfer
  */
 struct axxia_i2c_dev {
 	void __iomem *base;
@@ -112,6 +113,7 @@ struct axxia_i2c_dev {
 	struct i2c_adapter adapter;
 	struct clk *i2c_clk;
 	u32 bus_clk_rate;
+	bool last;
 };
=20
 static void i2c_int_disable(struct axxia_i2c_dev *idev, u32 mask)
@@ -324,15 +326,14 @@ static irqreturn_t axxia_i2c_isr(int irq, void *_dev)
 		/* Stop completed */
 		i2c_int_disable(idev, ~MST_STATUS_TSS);
 		complete(&idev->msg_complete);
-	} else if (status & MST_STATUS_SNS) {
+	} else if (status & (MST_STATUS_SNS | MST_STATUS_SS)) {
 		/* Transfer done */
-		i2c_int_disable(idev, ~MST_STATUS_TSS);
+		int mask =3D idev->last ? ~0 : ~MST_STATUS_TSS;
+
+		i2c_int_disable(idev, mask);
 		if (i2c_m_rd(idev->msg_r) && idev->msg_xfrd_r < idev->msg_r->len)
 			axxia_i2c_empty_rx_fifo(idev);
 		complete(&idev->msg_complete);
-	} else if (status & MST_STATUS_SS) {
-		/* Auto/Sequence transfer done */
-		complete(&idev->msg_complete);
 	} else if (status & MST_STATUS_TSS) {
 		/* Transfer timeout */
 		idev->msg_err =3D -ETIMEDOUT;
@@ -405,6 +406,7 @@ static int axxia_i2c_xfer_seq(struct axxia_i2c_dev *ide=
v, struct i2c_msg msgs[])
 	idev->msg_r =3D &msgs[1];
 	idev->msg_xfrd =3D 0;
 	idev->msg_xfrd_r =3D 0;
+	idev->last =3D true;
 	axxia_i2c_fill_tx_fifo(idev);
=20
 	writel(CMD_SEQUENCE, idev->base + MST_COMMAND);
@@ -415,10 +417,6 @@ static int axxia_i2c_xfer_seq(struct axxia_i2c_dev *id=
ev, struct i2c_msg msgs[])
 	time_left =3D wait_for_completion_timeout(&idev->msg_complete,
 						I2C_XFER_TIMEOUT);
=20
-	i2c_int_disable(idev, int_mask);
-
-	axxia_i2c_empty_rx_fifo(idev);
-
 	if (idev->msg_err =3D=3D -ENXIO) {
 		if (axxia_i2c_handle_seq_nak(idev))
 			axxia_i2c_init(idev);
@@ -438,9 +436,10 @@ static int axxia_i2c_xfer_seq(struct axxia_i2c_dev *id=
ev, struct i2c_msg msgs[])
 	return idev->msg_err;
 }
=20
-static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *idev, struct i2c_msg *=
msg)
+static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *idev, struct i2c_msg *=
msg,
+			      bool last)
 {
-	u32 int_mask =3D MST_STATUS_ERR | MST_STATUS_SNS;
+	u32 int_mask =3D MST_STATUS_ERR;
 	u32 rx_xfer, tx_xfer;
 	unsigned long time_left;
 	unsigned int wt_value;
@@ -449,6 +448,7 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *ide=
v, struct i2c_msg *msg)
 	idev->msg_r =3D msg;
 	idev->msg_xfrd =3D 0;
 	idev->msg_xfrd_r =3D 0;
+	idev->last =3D last;
 	reinit_completion(&idev->msg_complete);
=20
 	axxia_i2c_set_addr(idev, msg);
@@ -478,8 +478,13 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *id=
ev, struct i2c_msg *msg)
 	if (idev->msg_err)
 		goto out;
=20
-	/* Start manual mode */
-	writel(CMD_MANUAL, idev->base + MST_COMMAND);
+	if (!last) {
+		writel(CMD_MANUAL, idev->base + MST_COMMAND);
+		int_mask |=3D MST_STATUS_SNS;
+	} else {
+		writel(CMD_AUTO, idev->base + MST_COMMAND);
+		int_mask |=3D MST_STATUS_SS;
+	}
=20
 	writel(WT_EN | wt_value, idev->base + WAIT_TIMER_CONTROL);
=20
@@ -507,28 +512,6 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *id=
ev, struct i2c_msg *msg)
 	return idev->msg_err;
 }
=20
-static int axxia_i2c_stop(struct axxia_i2c_dev *idev)
-{
-	u32 int_mask =3D MST_STATUS_ERR | MST_STATUS_SCC | MST_STATUS_TSS;
-	unsigned long time_left;
-
-	reinit_completion(&idev->msg_complete);
-
-	/* Issue stop */
-	writel(0xb, idev->base + MST_COMMAND);
-	i2c_int_enable(idev, int_mask);
-	time_left =3D wait_for_completion_timeout(&idev->msg_complete,
-					      I2C_STOP_TIMEOUT);
-	i2c_int_disable(idev, int_mask);
-	if (time_left =3D=3D 0)
-		return -ETIMEDOUT;
-
-	if (readl(idev->base + MST_COMMAND) & CMD_BUSY)
-		dev_warn(idev->dev, "busy after stop\n");
-
-	return 0;
-}
-
 /* This function checks if the msgs[] array contains messages compatible w=
ith
  * Sequence mode of operation. This mode assumes there will be exactly one
  * write of non-zero length followed by exactly one read of non-zero lengt=
h,
@@ -558,9 +541,7 @@ axxia_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg=
 msgs[], int num)
 	i2c_int_enable(idev, MST_STATUS_TSS);
=20
 	for (i =3D 0; ret =3D=3D 0 && i < num; ++i)
-		ret =3D axxia_i2c_xfer_msg(idev, &msgs[i]);
-
-	axxia_i2c_stop(idev);
+		ret =3D axxia_i2c_xfer_msg(idev, &msgs[i], i =3D=3D (num - 1));
=20
 	return ret ? : i;
 }
--=20
2.20.1
