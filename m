From: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 21/22] i2c-designware: Tx abort cleanups
Date: Fri, 06 Nov 2009 21:51:57 +0900
Message-ID: <4AF41BED.1050406@necel.com>
References: <4AF419B6.1000802@necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4AF419B6.1000802-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

* ABRT_MASTER_DIS: Fix a typo.

* i2c_dw_handle_tx_abort: Return an appropriate error number
  depending on abort_source.

* i2c_dw_xfer: Add a missing abort_source initialization.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware.c |   47 +++++++++++++++++++++++++++++-----
 1 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index e6b1e6e..887aed6 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -123,9 +123,27 @@
 #define ABRT_SBYTE_ACKDET	7
 #define ABRT_SBYTE_NORSTRT	9
 #define ABRT_10B_RD_NORSTRT	10
-#define ARB_MASTER_DIS		11
+#define ABRT_MASTER_DIS		11
 #define ARB_LOST		12
 
+#define DW_IC_TX_ABRT_7B_ADDR_NOACK	(1UL << ABRT_7B_ADDR_NOACK)
+#define DW_IC_TX_ABRT_10ADDR1_NOACK	(1UL << ABRT_10ADDR1_NOACK)
+#define DW_IC_TX_ABRT_10ADDR2_NOACK	(1UL << ABRT_10ADDR2_NOACK)
+#define DW_IC_TX_ABRT_TXDATA_NOACK	(1UL << ABRT_TXDATA_NOACK)
+#define DW_IC_TX_ABRT_GCALL_NOACK	(1UL << ABRT_GCALL_NOACK)
+#define DW_IC_TX_ABRT_GCALL_READ	(1UL << ABRT_GCALL_READ)
+#define DW_IC_TX_ABRT_SBYTE_ACKDET	(1UL << ABRT_SBYTE_ACKDET)
+#define DW_IC_TX_ABRT_SBYTE_NORSTRT	(1UL << ABRT_SBYTE_NORSTRT)
+#define DW_IC_TX_ABRT_10B_RD_NORSTRT	(1UL << ABRT_10B_RD_NORSTRT)
+#define DW_IC_TX_ABRT_MASTER_DIS	(1UL << ABRT_MASTER_DIS)
+#define DW_IC_TX_ARB_LOST		(1UL << ARB_LOST)
+
+#define DW_IC_TX_ABRT_NOACK		(DW_IC_TX_ABRT_7B_ADDR_NOACK | \
+					 DW_IC_TX_ABRT_10ADDR1_NOACK | \
+					 DW_IC_TX_ABRT_10ADDR2_NOACK | \
+					 DW_IC_TX_ABRT_TXDATA_NOACK | \
+					 DW_IC_TX_ABRT_GCALL_NOACK)
+
 static char *abort_sources[] = {
 	[ABRT_7B_ADDR_NOACK]	=
 		"slave address not acknowledged (7bit mode)",
@@ -472,6 +490,24 @@ i2c_dw_read(struct dw_i2c_dev *dev)
 	}
 }
 
+static int i2c_dw_handle_tx_abort(struct dw_i2c_dev *dev)
+{
+	unsigned long abort_source = dev->abort_source;
+	int i;
+
+	for_each_bit(i, &abort_source, ARRAY_SIZE(abort_sources))
+		dev_err(dev->dev, "%s: %s\n", __func__, abort_sources[i]);
+
+	if (abort_source & DW_IC_TX_ARB_LOST)
+		return -EAGAIN;
+	else if (abort_source & DW_IC_TX_ABRT_NOACK)
+		return -EREMOTEIO;
+	else if (abort_source & DW_IC_TX_ABRT_GCALL_READ)
+		return -EINVAL; /* wrong msgs[] data */
+	else
+		return -EIO;
+}
+
 /*
  * Prepare controller for a transaction and call i2c_dw_xfer_msg
  */
@@ -493,6 +529,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	dev->msg_read_idx = 0;
 	dev->msg_err = 0;
 	dev->status = STATUS_IDLE;
+	dev->abort_source = 0;
 
 	ret = i2c_dw_wait_bus_not_busy(dev);
 	if (ret < 0)
@@ -526,12 +563,8 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 	/* We have an error */
 	if (dev->cmd_err == DW_IC_ERR_TX_ABRT) {
-		unsigned long abort_source = dev->abort_source;
-		int i;
-
-		for_each_bit(i, &abort_source, ARRAY_SIZE(abort_sources)) {
-		    dev_err(dev->dev, "%s: %s\n", __func__, abort_sources[i]);
-		}
+		ret = i2c_dw_handle_tx_abort(dev);
+		goto done;
 	}
 	ret = -EIO;
 
-- 
1.6.5.2
