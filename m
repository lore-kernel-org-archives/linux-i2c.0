From: "Adamski, Krzysztof (Nokia - PL/Wroclaw)"
        <krzysztof.adamski@nokia.com>
Subject: [PATCH] i2c-axxia: properly handle master timeout
Date: Fri, 16 Nov 2018 13:24:41 +0000
Message-ID: <20181116132334.GA3951@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Content-ID: <0534958739C2E047B36637E20B8B91AC@eurprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Guenter Roeck <linux@roeck-us.net>, "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>, Tobias Jordan <Tobias.Jordan@elektrobit.com>, Peter Rosin <peda@axentia.se>, Anders Berg <anders.berg@intel.com>
List-Id: linux-i2c@vger.kernel.org

According to Intel (R) Axxia TM Lionfish Communication Processor
Peripheral Subsystem Hardware Reference Manual, the AXXIA I2C module
have a programmable Master Wait Timer, which among others, checks the
time between commands send in manual mode. When a timeout (25ms) passes,
TSS bit is set in Master Interrupt Status register and a Stop command is
issued by the hardware.

The axxia_i2c_xfer(), does not properly handle this situation, however.
For each message a separate axxia_i2c_xfer_msg() is called and this
function incorrectly assumes that any interrupt might happen only when
waiting for completion. This is mostly correct but there is one
exception - a master timeout can trigger if enough time has passed
between individual transfers. It will, by definition, happen between
transfers when the interrupts are disabled by the code. If that happens,
the hardware issues Stop command.

The interrupt indicating timeout will not be triggered as soon as we
enable them since the Master Interrupt Status is cleared when master
mode is entered again (which happens before enabling irqs) meaning this
error is lost and the transfer is continued even though the Stop was
issued on the bus. The subsequent operations completes without error but
a bogus value (0xFF in case of read) is read as the client device is
confused because aborted transfer. No error is returned from
master_xfer() making caller believe that a valid value was read.

To fix the problem, the TSS bit (indicating timeout) in Master Interrupt
Status register is checked before each transfer. If it is set, there was
a timeout before this transfer and (as described above) the hardware
already issued Stop command so the transaction should be aborted thus
-ETIMEOUT is returned from the master_xfer() callback. In order to be
sure no timeout was issued we can't just read the status just before
starting new transaction as there will always be a small window of time
(few CPU cycles at best) where this might still happen. For this reason
we have to temporally disable the timer before checking for TSS bit.
Disabling it will, however, clear the TSS bit so in order to preserve
that information, we have to read it in ISR so we have to ensure that
the TSS interrupt is not masked between transfers of one transaction.
There is no need to call bus recovery or controller reinitialization if
that happens so it's skipped.

Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 drivers/i2c/busses/i2c-axxia.c | 40 ++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.=
c
index 8e60048a33f8..51d34959709b 100644
--- a/drivers/i2c/busses/i2c-axxia.c
+++ b/drivers/i2c/busses/i2c-axxia.c
@@ -74,8 +74,7 @@
 				 MST_STATUS_ND)
 #define   MST_STATUS_ERR	(MST_STATUS_NAK | \
 				 MST_STATUS_AL  | \
-				 MST_STATUS_IP  | \
-				 MST_STATUS_TSS)
+				 MST_STATUS_IP)
 #define MST_TX_BYTES_XFRD	0x50
 #define MST_RX_BYTES_XFRD	0x54
 #define SCL_HIGH_PERIOD		0x80
@@ -241,7 +240,7 @@ static int axxia_i2c_empty_rx_fifo(struct axxia_i2c_dev=
 *idev)
 			 */
 			if (c <=3D 0 || c > I2C_SMBUS_BLOCK_MAX) {
 				idev->msg_err =3D -EPROTO;
-				i2c_int_disable(idev, ~0);
+				i2c_int_disable(idev, ~MST_STATUS_TSS);
 				complete(&idev->msg_complete);
 				break;
 			}
@@ -299,14 +298,19 @@ static irqreturn_t axxia_i2c_isr(int irq, void *_dev)
=20
 	if (status & MST_STATUS_SCC) {
 		/* Stop completed */
-		i2c_int_disable(idev, ~0);
+		i2c_int_disable(idev, ~MST_STATUS_TSS);
 		complete(&idev->msg_complete);
 	} else if (status & MST_STATUS_SNS) {
 		/* Transfer done */
-		i2c_int_disable(idev, ~0);
+		i2c_int_disable(idev, ~MST_STATUS_TSS);
 		if (i2c_m_rd(idev->msg) && idev->msg_xfrd < idev->msg->len)
 			axxia_i2c_empty_rx_fifo(idev);
 		complete(&idev->msg_complete);
+	} else if (status & MST_STATUS_TSS) {
+		/* Transfer timeout */
+		idev->msg_err =3D -ETIMEDOUT;
+		i2c_int_disable(idev, ~MST_STATUS_TSS);
+		complete(&idev->msg_complete);
 	} else if (unlikely(status & MST_STATUS_ERR)) {
 		/* Transfer error */
 		i2c_int_disable(idev, ~0);
@@ -339,10 +343,10 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *i=
dev, struct i2c_msg *msg)
 	u32 rx_xfer, tx_xfer;
 	u32 addr_1, addr_2;
 	unsigned long time_left;
+	unsigned int wt_value;
=20
 	idev->msg =3D msg;
 	idev->msg_xfrd =3D 0;
-	idev->msg_err =3D 0;
 	reinit_completion(&idev->msg_complete);
=20
 	if (i2c_m_ten(msg)) {
@@ -383,9 +387,18 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *id=
ev, struct i2c_msg *msg)
 	else if (axxia_i2c_fill_tx_fifo(idev) !=3D 0)
 		int_mask |=3D MST_STATUS_TFL;
=20
+	wt_value =3D WT_VALUE(readl(idev->base + WAIT_TIMER_CONTROL));
+	/* Disable wait timer temporarly */
+	writel(wt_value, idev->base + WAIT_TIMER_CONTROL);
+	/* Check if timeout error happened */
+	if (idev->msg_err)
+		goto out;
+
 	/* Start manual mode */
 	writel(CMD_MANUAL, idev->base + MST_COMMAND);
=20
+	writel(WT_EN | wt_value, idev->base + WAIT_TIMER_CONTROL);
+
 	i2c_int_enable(idev, int_mask);
=20
 	time_left =3D wait_for_completion_timeout(&idev->msg_complete,
@@ -396,13 +409,15 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *i=
dev, struct i2c_msg *msg)
 	if (readl(idev->base + MST_COMMAND) & CMD_BUSY)
 		dev_warn(idev->dev, "busy after xfer\n");
=20
-	if (time_left =3D=3D 0)
+	if (time_left =3D=3D 0) {
 		idev->msg_err =3D -ETIMEDOUT;
-
-	if (idev->msg_err =3D=3D -ETIMEDOUT)
 		i2c_recover_bus(&idev->adapter);
+		axxia_i2c_init(idev);
+	}
=20
-	if (unlikely(idev->msg_err) && idev->msg_err !=3D -ENXIO)
+out:
+	if (unlikely(idev->msg_err) && idev->msg_err !=3D -ENXIO &&
+			idev->msg_err !=3D -ETIMEDOUT)
 		axxia_i2c_init(idev);
=20
 	return idev->msg_err;
@@ -410,7 +425,7 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *ide=
v, struct i2c_msg *msg)
=20
 static int axxia_i2c_stop(struct axxia_i2c_dev *idev)
 {
-	u32 int_mask =3D MST_STATUS_ERR | MST_STATUS_SCC;
+	u32 int_mask =3D MST_STATUS_ERR | MST_STATUS_SCC | MST_STATUS_TSS;
 	unsigned long time_left;
=20
 	reinit_completion(&idev->msg_complete);
@@ -437,6 +452,9 @@ axxia_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg=
 msgs[], int num)
 	int i;
 	int ret =3D 0;
=20
+	idev->msg_err =3D 0;
+	i2c_int_enable(idev, MST_STATUS_TSS);
+
 	for (i =3D 0; ret =3D=3D 0 && i < num; ++i)
 		ret =3D axxia_i2c_xfer_msg(idev, &msgs[i]);
=20
--=20
2.17.2
