From: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
Subject: [PATCH 16/16] i2c-designware: Add I2C_FUNC_SMBUS_* bits
Date: Tue, 13 Oct 2009 11:54:21 +0900
Message-ID: <4AD3EBDD.50105@necel.com>
References: <4AD3E974.8080200@necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <4AD3E974.8080200@necel.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: baruch@tkos.co.il, linux-i2c@vger.kernel.org
Cc: ben-linux@fluff.org, linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

This will ease our testing a bit with i2c-tools.  Note that DW I2C core
doesn't support I2C_FUNC_SMBUS_QUICK, as it's not capable of slave-
addressing-only I2C transactions.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---
 drivers/i2c/busses/i2c-designware.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index 6f85e28..80c8b8a 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -529,7 +529,14 @@ done:
 
 static u32 i2c_dw_func(struct i2c_adapter *adap)
 {
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
