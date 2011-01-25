From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: [PATCH] i2c-intel-mid: I2C FIFO buffer size setting and fragmentation
Date: Tue, 25 Jan 2011 14:28:07 +0000
Message-ID: <20110125142728.10001.85888.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

=46rom: Major Lee <major_lee-8+ZHUTgF1KZBDgjK7y7TUQ@public.gmane.org>

The FIFO buffer size is different with different CPU stepping.
Define it as 32-byte; it is safe for all CPU stepping.

There is a problem when xfer size is greater then FIFO buffer size.
Implement software fragmentation in host bus driver so that the
I=C2=B2C slave device drivers need not to be modified or to know about =
the
limits.

Signed-off-by: Major Lee <major_lee-8+ZHUTgF1KZBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---

 drivers/i2c/busses/i2c-intel-mid.c |   95 +++++++++++++++++-----------=
--------
 1 files changed, 46 insertions(+), 49 deletions(-)


diff --git a/drivers/i2c/busses/i2c-intel-mid.c b/drivers/i2c/busses/i2=
c-intel-mid.c
index 3975736..da4bbdd 100644
--- a/drivers/i2c/busses/i2c-intel-mid.c
+++ b/drivers/i2c/busses/i2c-intel-mid.c
@@ -54,6 +54,10 @@ enum mid_i2c_status {
 	STATUS_STANDBY
 };
=20
+/* The FIFO buffer size is different with different CPU stepping */
+/* Define it as 32-byte; it is safe for all CPU stepping */
+#define I2C_FIFO_SIZE	32
+
 /**
  * struct intel_mid_i2c_private	- per device I=C2=B2C context
  * @adap: core i2c layer adapter information
@@ -62,7 +66,6 @@ enum mid_i2c_status {
  * @speed: speed mode for this port
  * @complete: completion object for transaction wait
  * @abort: reason for last abort
- * @rx_buf: pointer into working receive buffer
  * @rx_buf_len: receive buffer length
  * @status: adapter state machine
  * @msg: the message we are currently processing
@@ -79,7 +82,6 @@ struct intel_mid_i2c_private {
 	int speed;
 	struct completion complete;
 	u32 abort;
-	u8 *rx_buf;
 	int rx_buf_len;
 	enum mid_i2c_status status;
 	struct i2c_msg *msg;
@@ -560,17 +562,15 @@ static int xfer_read(struct i2c_adapter *adap, un=
signed char *buf, int length)
 	int i =3D length;
 	int err;
=20
-	if (length >=3D 256) {
-		dev_err(&adap->dev,
-			"I2C FIFO cannot support larger than 256 bytes\n");
-		return -EMSGSIZE;
-	}
-
 	INIT_COMPLETION(i2c->complete);
=20
 	readl(i2c->base + IC_CLR_INTR);
 	writel(0x0044, i2c->base + IC_INTR_MASK);
=20
+	i2c->rx_buf_len =3D length;
+	/* set receive FIFO threshold */
+	writel((uint16_t)(length - 1), i2c->base + IC_RX_TL);
+
 	i2c->status =3D STATUS_READ_START;
=20
 	while (i--)
@@ -614,12 +614,6 @@ static int xfer_write(struct i2c_adapter *adap,
 	struct intel_mid_i2c_private *i2c =3D i2c_get_adapdata(adap);
 	int i, err;
=20
-	if (length >=3D 256) {
-		dev_err(&adap->dev,
-			"I2C FIFO cannot support larger than 256 bytes\n");
-		return -EMSGSIZE;
-	}
-
 	INIT_COMPLETION(i2c->complete);
=20
 	readl(i2c->base + IC_CLR_INTR);
@@ -748,6 +742,9 @@ static int intel_mid_i2c_xfer(struct i2c_adapter *a=
dap,
 {
 	struct intel_mid_i2c_private *i2c =3D i2c_get_adapdata(adap);
 	int i, err =3D 0;
+	u16 len;
+	u8 *buf;
+	u16 xfer_len;
=20
 	/* if number of messages equal 0*/
 	if (num =3D=3D 0)
@@ -785,13 +782,35 @@ static int intel_mid_i2c_xfer(struct i2c_adapter =
*adap,
 	for (i =3D 0; i < num; i++) {
 		i2c->msg =3D pmsg;
 		i2c->status =3D STATUS_IDLE;
-		/* Read or Write */
-		if (pmsg->flags & I2C_M_RD) {
-			dev_dbg(&adap->dev, "I2C_M_RD\n");
-			err =3D xfer_read(adap, pmsg->buf, pmsg->len);
-		} else {
-			dev_dbg(&adap->dev, "I2C_M_WR\n");
-			err =3D xfer_write(adap, pmsg->buf, pmsg->len);
+
+		if (pmsg->len && pmsg->buf) {
+			len =3D pmsg->len;
+			buf =3D pmsg->buf;
+			xfer_len =3D 0;
+
+			while (len && buf) {
+				/* Fragment xfer data */
+				if (len >=3D I2C_FIFO_SIZE)
+					xfer_len =3D I2C_FIFO_SIZE;
+				else
+					xfer_len =3D len;
+				/* Read or Write */
+				if (pmsg->flags & I2C_M_RD) {
+					dev_dbg(&adap->dev, "I2C_M_RD\n");
+					err =3D xfer_read(adap, buf, xfer_len);
+				} else {
+					dev_dbg(&adap->dev, "I2C_M_WR\n");
+					err =3D xfer_write(adap, buf, xfer_len);
+				}
+				if (err < 0)
+					break;
+
+				len -=3D xfer_len;
+				if (len)
+					buf +=3D xfer_len;
+				else /* len =3D=3D 0 */
+					break;
+			}
 		}
 		if (err < 0)
 			break;
@@ -875,32 +894,12 @@ static int mrst_i2c_runtime_idle(struct device *d=
ev)
 static void i2c_isr_read(struct intel_mid_i2c_private *i2c)
 {
 	struct i2c_msg *msg =3D i2c->msg;
-	int rx_num;
-	u32 len;
-	u8 *buf;
-
-	if (!(msg->flags & I2C_M_RD))
-		return;
+	u32 len =3D i2c->rx_buf_len;
+	u8 *buf =3D msg->buf;
=20
-	if (i2c->status !=3D STATUS_READ_IN_PROGRESS) {
-		len =3D msg->len;
-		buf =3D msg->buf;
-	} else {
-		len =3D i2c->rx_buf_len;
-		buf =3D i2c->rx_buf;
-	}
-
-	rx_num =3D readl(i2c->base + IC_RXFLR);
-
-	for (; len > 0 && rx_num > 0; len--, rx_num--)
+	while (len--)
 		*buf++ =3D readl(i2c->base + IC_DATA_CMD);
-
-	if (len > 0) {
-		i2c->status =3D STATUS_READ_IN_PROGRESS;
-		i2c->rx_buf_len =3D len;
-		i2c->rx_buf =3D buf;
-	} else
-		i2c->status =3D STATUS_READ_SUCCESS;
+	i2c->status =3D STATUS_READ_SUCCESS;
=20
 	return;
 }
@@ -936,10 +935,8 @@ static irqreturn_t intel_mid_i2c_isr(int this_irq,=
 void *dev)
 		goto exit;
 	}
=20
-	if (stat & TX_EMPTY) {
-		if (readl(i2c->base + IC_STATUS) & 0x4)
-			i2c->status =3D STATUS_WRITE_SUCCESS;
-	}
+	if (stat & TX_EMPTY)
+		i2c->status =3D STATUS_WRITE_SUCCESS;
=20
 exit:
 	if (i2c->status =3D=3D STATUS_READ_SUCCESS ||
