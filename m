From: Alain Volmat <alain.volmat@st.com>
Subject: [PATCH] i2c: stm32f7: do not backup read-only PECR register
Date: Thu, 5 Mar 2020 13:59:01 +0100
Message-ID: <1583413141-1268-1-git-send-email-alain.volmat@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, pierre-yves.mordret@st.com
Cc: alain.volmat@st.com, alexandre.torgue@st.com, linux-i2c@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, fabrice.gasnier@st.com
List-Id: linux-i2c@vger.kernel.org

The PECR register provides received packet computed PEC value. 
It makes no sense restoring its value after a reset, and anyway,
as read-only register it cannot be restored.

Fixes: ea6dd25deeb5 ("i2c: stm32f7: add PM_SLEEP suspend/resume support")
Signed-off-by: Alain Volmat <alain.volmat@st.com>
---
 drivers/i2c/busses/i2c-stm32f7.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 378956ac6d1d..4d7401d62b71 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -176,7 +176,6 @@
  * @cr2: Control register 2
  * @oar1: Own address 1 register
  * @oar2: Own address 2 register
- * @pecr: PEC register
  * @tmgr: Timing register
  */
 struct stm32f7_i2c_regs {
@@ -184,7 +183,6 @@ struct stm32f7_i2c_regs {
 	u32 cr2;
 	u32 oar1;
 	u32 oar2;
-	u32 pecr;
 	u32 tmgr;
 };
 
@@ -2146,7 +2144,6 @@ static int stm32f7_i2c_regs_backup(struct stm32f7_i2c_dev *i2c_dev)
 	backup_regs->cr2 = readl_relaxed(i2c_dev->base + STM32F7_I2C_CR2);
 	backup_regs->oar1 = readl_relaxed(i2c_dev->base + STM32F7_I2C_OAR1);
 	backup_regs->oar2 = readl_relaxed(i2c_dev->base + STM32F7_I2C_OAR2);
-	backup_regs->pecr = readl_relaxed(i2c_dev->base + STM32F7_I2C_PECR);
 	backup_regs->tmgr = readl_relaxed(i2c_dev->base + STM32F7_I2C_TIMINGR);
 
 	pm_runtime_put_sync(i2c_dev->dev);
@@ -2178,7 +2175,6 @@ static int stm32f7_i2c_regs_restore(struct stm32f7_i2c_dev *i2c_dev)
 	writel_relaxed(backup_regs->cr2, i2c_dev->base + STM32F7_I2C_CR2);
 	writel_relaxed(backup_regs->oar1, i2c_dev->base + STM32F7_I2C_OAR1);
 	writel_relaxed(backup_regs->oar2, i2c_dev->base + STM32F7_I2C_OAR2);
-	writel_relaxed(backup_regs->pecr, i2c_dev->base + STM32F7_I2C_PECR);
 
 	pm_runtime_put_sync(i2c_dev->dev);
 
-- 
2.7.4
