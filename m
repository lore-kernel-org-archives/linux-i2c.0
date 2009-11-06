From: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 15/22] i2c-designware: i2c_dw_func: Set I2C_FUNC_SMBUS_foo
 bits
Date: Fri, 06 Nov 2009 21:50:02 +0900
Message-ID: <4AF41B7A.8010609@necel.com>
References: <4AF419B6.1000802@necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4AF419B6.1000802-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Set proper I2C_FUNC_SMBUS_* bits so that the driver could be used with
some utilities requiring SMBus functionalities, such as i2c-tools.

Note that DW I2C core doesn't support I2C_FUNC_SMBUS_QUICK, as it's not
capable of zero-length data transactions.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index c3702a8..5ba7e55 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -528,7 +528,12 @@ done:
 
 static u32 i2c_dw_func(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR;
+	return	I2C_FUNC_I2C |
+		I2C_FUNC_10BIT_ADDR |
+		I2C_FUNC_SMBUS_BYTE |
+		I2C_FUNC_SMBUS_BYTE_DATA |
+		I2C_FUNC_SMBUS_WORD_DATA |
+		I2C_FUNC_SMBUS_I2C_BLOCK;
 }
 
 static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
-- 
1.6.5.2
