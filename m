From: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 22/22] i2c-designware: Cosmetic cleanups
Date: Fri, 06 Nov 2009 21:52:22 +0900
Message-ID: <4AF41C06.7010909@necel.com>
References: <4AF419B6.1000802@necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4AF419B6.1000802-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware.c |   27 ++++++++++++++-------------
 1 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index 887aed6..4534d45 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -1,5 +1,5 @@
 /*
- * Synopsys Designware I2C adapter driver (master only).
+ * Synopsys DesignWare I2C adapter driver (master only).
  *
  * Based on the TI DAVINCI I2C adapter driver.
  *
@@ -145,27 +145,27 @@
 					 DW_IC_TX_ABRT_GCALL_NOACK)
 
 static char *abort_sources[] = {
-	[ABRT_7B_ADDR_NOACK]	=
+	[ABRT_7B_ADDR_NOACK] =
 		"slave address not acknowledged (7bit mode)",
-	[ABRT_10ADDR1_NOACK]	=
+	[ABRT_10ADDR1_NOACK] =
 		"first address byte not acknowledged (10bit mode)",
-	[ABRT_10ADDR2_NOACK]	=
+	[ABRT_10ADDR2_NOACK] =
 		"second address byte not acknowledged (10bit mode)",
-	[ABRT_TXDATA_NOACK]		=
+	[ABRT_TXDATA_NOACK] =
 		"data not acknowledged",
-	[ABRT_GCALL_NOACK]		=
+	[ABRT_GCALL_NOACK] =
 		"no acknowledgement for a general call",
-	[ABRT_GCALL_READ]		=
+	[ABRT_GCALL_READ] =
 		"read after general call",
-	[ABRT_SBYTE_ACKDET]		=
+	[ABRT_SBYTE_ACKDET] =
 		"start byte acknowledged",
-	[ABRT_SBYTE_NORSTRT]	=
+	[ABRT_SBYTE_NORSTRT] =
 		"trying to send start byte when restart is disabled",
-	[ABRT_10B_RD_NORSTRT]	=
+	[ABRT_10B_RD_NORSTRT] =
 		"trying to read when restart is disabled (10bit mode)",
-	[ARB_MASTER_DIS]		=
+	[ABRT_MASTER_DIS] =
 		"trying to use disabled adapter",
-	[ARB_LOST]			=
+	[ARB_LOST] =
 		"lost arbitration",
 };
 
@@ -394,7 +394,8 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 	intr_mask = DW_IC_INTR_DEFAULT_MASK;
 
 	for (; dev->msg_write_idx < dev->msgs_num; dev->msg_write_idx++) {
-		/* if target address has changed, we need to
+		/*
+		 * if target address has changed, we need to
 		 * reprogram the target address in the i2c
 		 * adapter when we are done with this transfer
 		 */
-- 
1.6.5.2
