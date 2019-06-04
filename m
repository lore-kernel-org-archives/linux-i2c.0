From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH] i2c: i2c-stm32f7: Add I2C_SMBUS_I2C_BLOCK_DATA support
Date: Tue, 4 Jun 2019 15:20:51 +0200
Message-ID: <1559654451-26612-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, pierre-yves.mordret@st.com
Cc: mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, linux-i2c@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, fabrice.gasnier@st.com
List-Id: linux-i2c@vger.kernel.org

This patch adds the support of I2C_SMBUS_I2C_BLOCK_DATA transaction type
for the stm32f7 SMBUS Controller.
Use emulated I2C_SMBUS_I2C_BLOCK_DATA transactions as there is no specific
hardware in STM32 I2C to manage this (e.g. like no need for PEC here).
Emulated transfer will fall back calling i2c transfer method where there's
already support for DMAs for example.
So, use the I2C_FUNC_SMBUS_I2C_BLOCK in stm32f7_i2c_func(), and rely on
emulated transfer by returning -EOPNOTSUPP in the smbus_xfer() routine
for such a case.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/i2c/busses/i2c-stm32f7.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 48337be..68a751e 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -953,6 +953,9 @@ static int stm32f7_i2c_smbus_xfer_msg(struct stm32f7_i2c_dev *i2c_dev,
 		cr2 &= ~STM32F7_I2C_CR2_RD_WRN;
 		f7_msg->read_write = I2C_SMBUS_READ;
 		break;
+	case I2C_SMBUS_I2C_BLOCK_DATA:
+		/* Rely on emulated i2c transfer (through master_xfer) */
+		return -EOPNOTSUPP;
 	default:
 		dev_err(dev, "Unsupported smbus protocol %d\n", f7_msg->size);
 		return -EOPNOTSUPP;
@@ -1803,7 +1806,8 @@ static u32 stm32f7_i2c_func(struct i2c_adapter *adap)
 		I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
 		I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
 		I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_SMBUS_BLOCK_PROC_CALL |
-		I2C_FUNC_SMBUS_PROC_CALL | I2C_FUNC_SMBUS_PEC;
+		I2C_FUNC_SMBUS_PROC_CALL | I2C_FUNC_SMBUS_PEC |
+		I2C_FUNC_SMBUS_I2C_BLOCK;
 }
 
 static struct i2c_algorithm stm32f7_i2c_algo = {
-- 
2.7.4
