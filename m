From: Alain Volmat <alain.volmat@st.com>
Subject: [PATCH v2] i2c: stm32f7: do not backup read-only PECR register
Date: Tue, 10 Mar 2020 12:58:41 +0100
Message-ID: <1583841521-27897-1-git-send-email-alain.volmat@st.com>
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
Reviewed-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
v2: rebase on top of other i2c-stm32f7 patches integrated within i2c-next

 drivers/i2c/busses/i2c-stm32f7.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 8fe7f8caf91b..6418f5982894 100644
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
 
@@ -2196,7 +2194,6 @@ static int stm32f7_i2c_regs_backup(struct stm32f7_i2c_dev *i2c_dev)
 	backup_regs->cr2 = readl_relaxed(i2c_dev->base + STM32F7_I2C_CR2);
 	backup_regs->oar1 = readl_relaxed(i2c_dev->base + STM32F7_I2C_OAR1);
 	backup_regs->oar2 = readl_relaxed(i2c_dev->base + STM32F7_I2C_OAR2);
-	backup_regs->pecr = readl_relaxed(i2c_dev->base + STM32F7_I2C_PECR);
 	backup_regs->tmgr = readl_relaxed(i2c_dev->base + STM32F7_I2C_TIMINGR);
 	stm32f7_i2c_write_fm_plus_bits(i2c_dev, false);
 
@@ -2229,7 +2226,6 @@ static int stm32f7_i2c_regs_restore(struct stm32f7_i2c_dev *i2c_dev)
 	writel_relaxed(backup_regs->cr2, i2c_dev->base + STM32F7_I2C_CR2);
 	writel_relaxed(backup_regs->oar1, i2c_dev->base + STM32F7_I2C_OAR1);
 	writel_relaxed(backup_regs->oar2, i2c_dev->base + STM32F7_I2C_OAR2);
-	writel_relaxed(backup_regs->pecr, i2c_dev->base + STM32F7_I2C_PECR);
 	stm32f7_i2c_write_fm_plus_bits(i2c_dev, true);
 
 	pm_runtime_put_sync(i2c_dev->dev);
-- 
2.7.4
