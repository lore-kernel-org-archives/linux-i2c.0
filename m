From: sxauwsk <sxauwsk@163.com>
Subject: [PATCH] i2c: cadence: try reset when master receive error interrupts
Date: Wed, 30 Jan 2019 03:52:14 +0800
Message-ID: <20190129195214.30272-1-sxauwsk@163.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, sxauwsk@163.com
List-Id: linux-i2c@vger.kernel.org

When the adapter receive error interrupts, such as NACK, arbitration lost,
cdns_i2c_master_xfer return to the caller directly instead of resuming 
the adapter which resulted in the adapter being out of control.

So when driver detect err_status then try to repair and fix it.

Signed-off-by: sxauwsk <sxauwsk@163.com>
---
 drivers/i2c/busses/i2c-cadence.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index b13605718291..e10048d7524a 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -548,10 +548,6 @@ static int cdns_i2c_process_msg(struct cdns_i2c *id, struct i2c_msg *msg,
 	cdns_i2c_writereg(CDNS_I2C_IXR_ALL_INTR_MASK,
 			  CDNS_I2C_IDR_OFFSET);
 
-	/* If it is bus arbitration error, try again */
-	if (id->err_status & CDNS_I2C_IXR_ARB_LOST)
-		return -EAGAIN;
-
 	return 0;
 }
 
@@ -617,13 +613,19 @@ static int cdns_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 			id->bus_hold_flag = 0;
 
 		ret = cdns_i2c_process_msg(id, msgs, adap);
-		if (ret)
+		if (!ret)
 			goto out;
 
 		/* Report the other error interrupts to application */
 		if (id->err_status) {
 			cdns_i2c_master_reset(adap);
 
+			/* If it is bus arbitration error, try again */
+			if (id->err_status & CDNS_I2C_IXR_ARB_LOST) {
+				ret = -EAGAIN;
+				goto out;
+			}
+
 			if (id->err_status & CDNS_I2C_IXR_NACK) {
 				ret = -ENXIO;
 				goto out;
-- 
2.19.2
