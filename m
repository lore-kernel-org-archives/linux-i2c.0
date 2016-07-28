From: Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH v3 3/3] i2c: designware: do not disable adapter after transfer
Date: Thu, 28 Jul 2016 19:03:44 -0300
Message-ID: <1469743424-2480-4-git-send-email-lucas.demarchi@intel.com>
References: <1469743424-2480-1-git-send-email-lucas.demarchi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1469743424-2480-1-git-send-email-lucas.demarchi@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: christian.ruppert@alitech.com, linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com, jarkko.nikula@linux.intel.com, Lucas De Marchi <lucas.demarchi@intel.com>, =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
List-Id: linux-i2c@vger.kernel.org

Disabling the adapter after each transfer adds additional delays
for each I2C transfer. Even if we don't wait for it to be disabled
anymore, on next transfer we will need to if we have several transfers
in a row.

Now during the transfer init we check if IC_TAR can be changed
dynamically, the status register for no activity and TX buffer being
empty. In this case we don't need to disable it

When a transfer fails the adapter will still be disabled - this is a
conservative approach. When transfers succeed, the adapter is left
enabled and it's configured so to disable interrupts.

Alternating register reads on 2 slaves:
perf stat -r4 chrt -f 10 ./i2c-test /dev/i2c-1 25000 0x40 0x6 0x1e 0x00

Before:
	8.638705161 seconds time elapsed                  ( +-  5.90% )
After:
	7.516821591 seconds time elapsed                  ( +-  0.11% )

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Jos=C3=A9 Roberto de Souza <jose.souza@intel.com>
---
 drivers/i2c/busses/i2c-designware-core.c | 55 +++++++++++++++++++++---=
--------
 1 file changed, 37 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/bus=
ses/i2c-designware-core.c
index a8408db..d260689 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -89,7 +89,9 @@
 					 DW_IC_INTR_TX_ABRT | \
 					 DW_IC_INTR_STOP_DET)
=20
-#define DW_IC_STATUS_ACTIVITY	0x1
+#define DW_IC_STATUS_ACTIVITY		0x1
+#define DW_IC_STATUS_TFE		BIT(2)
+#define DW_IC_STATUS_MST_ACTIVITY	BIT(5)
=20
 #define DW_IC_ERR_TX_ABRT	0x1
=20
@@ -431,9 +433,25 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *de=
v)
 {
 	struct i2c_msg *msgs =3D dev->msgs;
 	u32 ic_tar =3D 0;
+	bool enabled;
=20
-	/* Disable the adapter */
-	__i2c_dw_enable_and_wait(dev, false);
+	enabled =3D dw_readl(dev, DW_IC_ENABLE_STATUS) & 1;
+
+	if (enabled) {
+		u32 ic_status;
+
+		/*
+		 * Only disable adapter if ic_tar and ic_con can't be
+		 * dynamically updated
+		 */
+		ic_status =3D dw_readl(dev, DW_IC_STATUS);
+		if (!dev->dynamic_tar_update_enabled ||
+		    (ic_status & DW_IC_STATUS_MST_ACTIVITY) ||
+		    !(ic_status & DW_IC_STATUS_TFE)) {
+			__i2c_dw_enable_and_wait(dev, false);
+			enabled =3D false;
+		}
+	}
=20
 	/* if the slave address is ten bit address, enable 10BITADDR */
 	if (dev->dynamic_tar_update_enabled) {
@@ -462,8 +480,8 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev=
)
 	/* enforce disabled interrupts (due to HW issues) */
 	i2c_dw_disable_int(dev);
=20
-	/* Enable the adapter */
-	__i2c_dw_enable(dev, true);
+	if (!enabled)
+		__i2c_dw_enable(dev, true);
=20
 	/* Clear and enable interrupts */
 	dw_readl(dev, DW_IC_CLR_INTR);
@@ -644,7 +662,8 @@ static int i2c_dw_handle_tx_abort(struct dw_i2c_dev=
 *dev)
 }
=20
 /*
- * Prepare controller for a transaction and call i2c_dw_xfer_msg
+ * Prepare controller for a transaction and start transfer by calling
+ * i2c_dw_xfer_init()
  */
 static int
 i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
@@ -691,16 +710,6 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_m=
sg msgs[], int num)
 		goto done;
 	}
=20
-	/*
-	 * We must disable the adapter before returning and signaling the end
-	 * of the current transfer. Otherwise the hardware might continue
-	 * generating interrupts which in turn causes a race condition with
-	 * the following transfer.  Needs some more investigation if the
-	 * additional interrupts are a hardware bug or this driver doesn't
-	 * handle them correctly yet.
-	 */
-	__i2c_dw_enable(dev, false);
-
 	if (dev->msg_err) {
 		ret =3D dev->msg_err;
 		goto done;
@@ -838,9 +847,19 @@ static irqreturn_t i2c_dw_isr(int this_irq, void *=
dev_id)
 	 */
=20
 tx_aborted:
-	if ((stat & (DW_IC_INTR_TX_ABRT | DW_IC_INTR_STOP_DET)) || dev->msg_e=
rr)
+	if ((stat & (DW_IC_INTR_TX_ABRT | DW_IC_INTR_STOP_DET))
+			|| dev->msg_err) {
+		/*
+		 * We must disable interruts before returning and signaling
+		 * the end of the current transfer. Otherwise the hardware
+		 * might continue generating interrupts for non-existent
+		 * transfers.
+		 */
+		i2c_dw_disable_int(dev);
+		dw_readl(dev, DW_IC_CLR_INTR);
+
 		complete(&dev->cmd_complete);
-	else if (unlikely(dev->accessor_flags & ACCESS_INTR_MASK)) {
+	} else if (unlikely(dev->accessor_flags & ACCESS_INTR_MASK)) {
 		/* workaround to trigger pending interrupt */
 		stat =3D dw_readl(dev, DW_IC_INTR_MASK);
 		i2c_dw_disable_int(dev);
--=20
2.7.4
