From: Colin King <colin.king@canonical.com>
Subject: [PATCH] i2c-stm32f4: remove redundant initialization of pointer reg
Date: Tue, 16 Jan 2018 17:44:04 +0000
Message-ID: <20180116174404.19464-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer reg is assigned a value that is never read, it is later
overwritten with a new value, hence the redundant initialization can
be removed.

Cleans up clang warning:
drivers/i2c/busses/i2c-stm32f4.c:352:16: warning: Value stored to 'reg'
during its initialization is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/i2c/busses/i2c-stm32f4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-stm32f4.c b/drivers/i2c/busses/i2c-stm32f4.c
index 47c8d00de53f..ba600d77a3f8 100644
--- a/drivers/i2c/busses/i2c-stm32f4.c
+++ b/drivers/i2c/busses/i2c-stm32f4.c
@@ -349,7 +349,7 @@ static void stm32f4_i2c_read_msg(struct stm32f4_i2c_dev *i2c_dev)
 static void stm32f4_i2c_terminate_xfer(struct stm32f4_i2c_dev *i2c_dev)
 {
 	struct stm32f4_i2c_msg *msg = &i2c_dev->msg;
-	void __iomem *reg = i2c_dev->base + STM32F4_I2C_CR2;
+	void __iomem *reg;
 
 	stm32f4_i2c_disable_irq(i2c_dev);
 
-- 
2.15.1
