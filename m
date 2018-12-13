From: "Adamski, Krzysztof (Nokia - PL/Wroclaw)"
        <krzysztof.adamski@nokia.com>
Subject: [PATCH v2] i2c: axxia: support sequence command mode
Date: Thu, 13 Dec 2018 12:09:38 +0000
Message-ID: <20181213120926.GA10479@localhost.localdomain>
References: <20181211200435.abk3jdsmltz7c26w@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211200435.abk3jdsmltz7c26w@ninjato>
Content-Language: en-US
Content-ID: <820069974CB8F348B78F6929DDEA2E52@eurprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Guenter Roeck <linux@roeck-us.net>, Tobias Jordan <Tobias.Jordan@elektrobit.com>, Peter Rosin <peda@axentia.se>, "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
List-Id: linux-i2c@vger.kernel.org

In order to comply with SMBus specification, the Axxia I=B2C module will
abort the multi message transfer if the delay between finishing sending
one message and starting another is longer than 25ms. Unfortunately it
isn't that hard to trigger this situation on a busy system. In order to
fix this problem, we should make sure hardware does whole transaction
without waiting for software to fill some data.

Fortunately, in addition to Manual mode that is currently used by the
driver to perform I=B2C transfers, the module supports also so called
Sequence mode. In this mode, the module automatically performs
predefined sequence of operations - it sends a slave address, transmits
specified number of bytes from the FIFO, changes transfer direction,
resends the slave address and then reads specified number of bytes to
FIFO. While very inflexible, this does fit a most common case of multi
message transfer - the one where you first write a register number you
want to read and then read it.

To use this mode effectively, a number of conditions must be met to
ensure the transaction does fit the predefined sequence. In case this is
not the case, a fallback to manual mode is used.

The initialization of this mode is very similar to Manual mode. The most
notable difference is different bit in the Master Interrupt Status
designating finishing of transaction. Also some of the errors, like TSS,
cannot happen in this mode.

While it is possible to support transactions requesting a read of any
size (RFL interrupt will be generated when FIFO size is not enough) the
TFL interrupt is not available in this mode, thus the write part of the
transaction cannot exceed FIFO_SIZE (8).

Note that in case of a NAK during transaction, the NA/ND status bits
will be set before STOP command is generated, triggering an interrupt
while the controller is still busy. Current solution for this problem is
to actively wait for this command to stop before leaving xfer callback.

Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
---

Sorry for those problems I still don't know why my checkpatch did not
complain about it (have to verify that) and I did add smatch to my
arsenal now.

Changes in v2:
- added timeout to axxia_i2c_handle_seq_nak()
- changed udelay to usleep_range in axxia_i2c_handle_seq_nak()

 drivers/i2c/busses/i2c-axxia.c | 108 ++++++++++++++++++++++++++++++---
 1 file changed, 101 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.=
c
index 35258321e81b..03f1ce75a32e 100644
--- a/drivers/i2c/busses/i2c-axxia.c
+++ b/drivers/i2c/busses/i2c-axxia.c
@@ -12,6 +12,7 @@
  */
 #include <linux/clk.h>
 #include <linux/clkdev.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
@@ -25,6 +26,7 @@
 #define I2C_XFER_TIMEOUT    (msecs_to_jiffies(250))
 #define I2C_STOP_TIMEOUT    (msecs_to_jiffies(100))
 #define FIFO_SIZE           8
+#define SEQ_LEN             2
=20
 #define GLOBAL_CONTROL		0x00
 #define   GLOBAL_MST_EN         BIT(0)
@@ -51,6 +53,7 @@
 #define   CMD_BUSY		(1<<3)
 #define   CMD_MANUAL		(0x00 | CMD_BUSY)
 #define   CMD_AUTO		(0x01 | CMD_BUSY)
+#define   CMD_SEQUENCE		(0x02 | CMD_BUSY)
 #define MST_RX_XFER		0x2c
 #define MST_TX_XFER		0x30
 #define MST_ADDR_1		0x34
@@ -87,7 +90,9 @@
  * axxia_i2c_dev - I2C device context
  * @base: pointer to register struct
  * @msg: pointer to current message
- * @msg_xfrd: number of bytes transferred in msg
+ * @msg_r: pointer to current read message (sequence transfer)
+ * @msg_xfrd: number of bytes transferred in tx_fifo
+ * @msg_xfrd_r: number of bytes transferred in rx_fifo
  * @msg_err: error code for completed message
  * @msg_complete: xfer completion object
  * @dev: device reference
@@ -98,7 +103,9 @@
 struct axxia_i2c_dev {
 	void __iomem *base;
 	struct i2c_msg *msg;
+	struct i2c_msg *msg_r;
 	size_t msg_xfrd;
+	size_t msg_xfrd_r;
 	int msg_err;
 	struct completion msg_complete;
 	struct device *dev;
@@ -227,14 +234,14 @@ static int i2c_m_recv_len(const struct i2c_msg *msg)
  */
 static int axxia_i2c_empty_rx_fifo(struct axxia_i2c_dev *idev)
 {
-	struct i2c_msg *msg =3D idev->msg;
+	struct i2c_msg *msg =3D idev->msg_r;
 	size_t rx_fifo_avail =3D readl(idev->base + MST_RX_FIFO);
-	int bytes_to_transfer =3D min(rx_fifo_avail, msg->len - idev->msg_xfrd);
+	int bytes_to_transfer =3D min(rx_fifo_avail, msg->len - idev->msg_xfrd_r)=
;
=20
 	while (bytes_to_transfer-- > 0) {
 		int c =3D readl(idev->base + MST_DATA);
=20
-		if (idev->msg_xfrd =3D=3D 0 && i2c_m_recv_len(msg)) {
+		if (idev->msg_xfrd_r =3D=3D 0 && i2c_m_recv_len(msg)) {
 			/*
 			 * Check length byte for SMBus block read
 			 */
@@ -247,7 +254,7 @@ static int axxia_i2c_empty_rx_fifo(struct axxia_i2c_dev=
 *idev)
 			msg->len =3D 1 + c;
 			writel(msg->len, idev->base + MST_RX_XFER);
 		}
-		msg->buf[idev->msg_xfrd++] =3D c;
+		msg->buf[idev->msg_xfrd_r++] =3D c;
 	}
=20
 	return 0;
@@ -287,7 +294,7 @@ static irqreturn_t axxia_i2c_isr(int irq, void *_dev)
 	}
=20
 	/* RX FIFO needs service? */
-	if (i2c_m_rd(idev->msg) && (status & MST_STATUS_RFL))
+	if (i2c_m_rd(idev->msg_r) && (status & MST_STATUS_RFL))
 		axxia_i2c_empty_rx_fifo(idev);
=20
 	/* TX FIFO needs service? */
@@ -320,9 +327,12 @@ static irqreturn_t axxia_i2c_isr(int irq, void *_dev)
 	} else if (status & MST_STATUS_SNS) {
 		/* Transfer done */
 		i2c_int_disable(idev, ~MST_STATUS_TSS);
-		if (i2c_m_rd(idev->msg) && idev->msg_xfrd < idev->msg->len)
+		if (i2c_m_rd(idev->msg_r) && idev->msg_xfrd_r < idev->msg_r->len)
 			axxia_i2c_empty_rx_fifo(idev);
 		complete(&idev->msg_complete);
+	} else if (status & MST_STATUS_SS) {
+		/* Auto/Sequence transfer done */
+		complete(&idev->msg_complete);
 	} else if (status & MST_STATUS_TSS) {
 		/* Transfer timeout */
 		idev->msg_err =3D -ETIMEDOUT;
@@ -363,6 +373,70 @@ static void axxia_i2c_set_addr(struct axxia_i2c_dev *i=
dev, struct i2c_msg *msg)
 	writel(addr_2, idev->base + MST_ADDR_2);
 }
=20
+/* The NAK interrupt will be sent _before_ issuing STOP command
+ * so the controller might still be busy processing it. No
+ * interrupt will be sent at the end so we have to poll for it
+ */
+static int axxia_i2c_handle_seq_nak(struct axxia_i2c_dev *idev)
+{
+	unsigned long timeout =3D jiffies + I2C_XFER_TIMEOUT;
+
+	do {
+		if ((readl(idev->base + MST_COMMAND) & CMD_BUSY) =3D=3D 0)
+			return 0;
+		usleep_range(1, 100);
+	} while (time_before(jiffies, timeout));
+
+	return -ETIMEDOUT;
+}
+
+static int axxia_i2c_xfer_seq(struct axxia_i2c_dev *idev, struct i2c_msg m=
sgs[])
+{
+	u32 int_mask =3D MST_STATUS_ERR | MST_STATUS_SS | MST_STATUS_RFL;
+	u32 rlen =3D i2c_m_recv_len(&msgs[1]) ? I2C_SMBUS_BLOCK_MAX : msgs[1].len=
;
+	unsigned long time_left;
+
+	axxia_i2c_set_addr(idev, &msgs[0]);
+
+	writel(msgs[0].len, idev->base + MST_TX_XFER);
+	writel(rlen, idev->base + MST_RX_XFER);
+
+	idev->msg =3D &msgs[0];
+	idev->msg_r =3D &msgs[1];
+	idev->msg_xfrd =3D 0;
+	idev->msg_xfrd_r =3D 0;
+	axxia_i2c_fill_tx_fifo(idev);
+
+	writel(CMD_SEQUENCE, idev->base + MST_COMMAND);
+
+	reinit_completion(&idev->msg_complete);
+	i2c_int_enable(idev, int_mask);
+
+	time_left =3D wait_for_completion_timeout(&idev->msg_complete,
+						I2C_XFER_TIMEOUT);
+
+	i2c_int_disable(idev, int_mask);
+
+	axxia_i2c_empty_rx_fifo(idev);
+
+	if (idev->msg_err =3D=3D -ENXIO) {
+		if (axxia_i2c_handle_seq_nak(idev))
+			axxia_i2c_init(idev);
+	} else if (readl(idev->base + MST_COMMAND) & CMD_BUSY)
+		dev_warn(idev->dev, "busy after xfer\n");
+
+	if (time_left =3D=3D 0) {
+		idev->msg_err =3D -ETIMEDOUT;
+		i2c_recover_bus(&idev->adapter);
+		axxia_i2c_init(idev);
+	}
+
+	if (unlikely(idev->msg_err) && idev->msg_err !=3D -ENXIO)
+		axxia_i2c_init(idev);
+
+	return idev->msg_err;
+}
+
 static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *idev, struct i2c_msg *=
msg)
 {
 	u32 int_mask =3D MST_STATUS_ERR | MST_STATUS_SNS;
@@ -371,7 +445,9 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *ide=
v, struct i2c_msg *msg)
 	unsigned int wt_value;
=20
 	idev->msg =3D msg;
+	idev->msg_r =3D msg;
 	idev->msg_xfrd =3D 0;
+	idev->msg_xfrd_r =3D 0;
 	reinit_completion(&idev->msg_complete);
=20
 	axxia_i2c_set_addr(idev, msg);
@@ -452,6 +528,18 @@ static int axxia_i2c_stop(struct axxia_i2c_dev *idev)
 	return 0;
 }
=20
+/* This function checks if the msgs[] array contains messages compatible w=
ith
+ * Sequence mode of operation. This mode assumes there will be exactly one
+ * write of non-zero length followed by exactly one read of non-zero lengt=
h,
+ * both targeted at the same client device.
+ */
+static bool axxia_i2c_sequence_ok(struct i2c_msg msgs[], int num)
+{
+	return num =3D=3D SEQ_LEN && !i2c_m_rd(&msgs[0]) && i2c_m_rd(&msgs[1]) &&
+	       msgs[0].len > 0 && msgs[0].len <=3D FIFO_SIZE &&
+	       msgs[1].len > 0 && msgs[0].addr =3D=3D msgs[1].addr;
+}
+
 static int
 axxia_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 {
@@ -460,6 +548,12 @@ axxia_i2c_xfer(struct i2c_adapter *adap, struct i2c_ms=
g msgs[], int num)
 	int ret =3D 0;
=20
 	idev->msg_err =3D 0;
+
+	if (axxia_i2c_sequence_ok(msgs, num)) {
+		ret =3D axxia_i2c_xfer_seq(idev, msgs);
+		return ret ? : SEQ_LEN;
+	}
+
 	i2c_int_enable(idev, MST_STATUS_TSS);
=20
 	for (i =3D 0; ret =3D=3D 0 && i < num; ++i)
--=20
2.17.2
