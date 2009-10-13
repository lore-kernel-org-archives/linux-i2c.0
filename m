From: "Olivares, Ricardo Perez" <richo-l0cyMroinI0@public.gmane.org>
Subject: FW: [PATCH 16/16] i2c-designware: Add I2C_FUNC_SMBUS_* bits
Date: Tue, 13 Oct 2009 17:05:05 -0500
Message-ID: <A69FA2915331DC488A831521EAE36FE401554D74B3@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

 

-----Original Message-----
From: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Shinya Kuribayashi
Sent: Monday, October 12, 2009 9:54 PM
To: baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org; linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Subject: [PATCH 16/16] i2c-designware: Add I2C_FUNC_SMBUS_* bits

This will ease our testing a bit with i2c-tools.  Note that DW I2C core doesn't support I2C_FUNC_SMBUS_QUICK, as it's not capable of slave- addressing-only I2C transactions.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index 6f85e28..80c8b8a 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -529,7 +529,14 @@ done:
 
 static u32 i2c_dw_func(struct i2c_adapter *adap)  {
-	return I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR;
+	return	I2C_FUNC_I2C |
+		I2C_FUNC_10BIT_ADDR |
+		I2C_FUNC_SMBUS_BYTE |
+		I2C_FUNC_SMBUS_BYTE_DATA |
+		I2C_FUNC_SMBUS_WORD_DATA |
+		I2C_FUNC_SMBUS_BLOCK_DATA |
+		I2C_FUNC_SMBUS_I2C_BLOCK |
+		I2C_FUNC_SMBUS_I2C_BLOCK_2;
 }
 
 static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
--
1.6.5

--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
