From: Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] i2c: stm32f7: Make structure stm32f7_i2c_algo constant
Date: Thu, 15 Aug 2019 11:28:57 +0530
Message-ID: <20190815055857.1944-1-nishkadg.linux@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pierre-yves.mordret@st.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, linux-i2c@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Nishka Dasgupta <nishkadg.linux@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Static structure stm32f7_i2c_algo, of type i2c_algorithm, is used only
when it is assigned to constant field algo of a variable having type
i2c_adapter. As stm32f7_i2c_algo is therefore never modified, make it
const as well to protect it from unintended modification.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/i2c/busses/i2c-stm32f7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 266d1c269b83..d36cf08461f7 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -1809,7 +1809,7 @@ static u32 stm32f7_i2c_func(struct i2c_adapter *adap)
 		I2C_FUNC_SMBUS_I2C_BLOCK;
 }
 
-static struct i2c_algorithm stm32f7_i2c_algo = {
+static const struct i2c_algorithm stm32f7_i2c_algo = {
 	.master_xfer = stm32f7_i2c_xfer,
 	.smbus_xfer = stm32f7_i2c_smbus_xfer,
 	.functionality = stm32f7_i2c_func,
-- 
2.19.1
