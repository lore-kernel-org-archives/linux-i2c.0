From: Alain Volmat <alain.volmat@st.com>
Subject: [PATCHv2 3/5] i2c: i2c-stm32f7: add a new st, stm32mp15-i2c compatible
Date: Mon, 2 Mar 2020 12:33:16 +0100
Message-ID: <1583148796-24285-1-git-send-email-alain.volmat@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: wsa@the-dreams.de, pierre-yves.mordret@st.com
Cc: alexandre.torgue@st.com, linux-kernel@vger.kernel.org, alain.volmat@st.com, linux-i2c@vger.kernel.org, fabrice.gasnier@st.com, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Add a new stm32mp15 specific compatible to handle FastMode+
registers handling which is different on the stm32mp15 compared
to the stm32f7 or stm32h7.
Indeed, on the stm32mp15, the FastMode+ set and clear registers
are separated while on the other platforms (F7 or H7) the control
is done in a unique register.

Signed-off-by: Alain Volmat <alain.volmat@st.com>
Reviewed-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
----
v2: adapt struct stm32f7_i2c_dev fmp register variable naming (regmap_ -> fmp_)
---
 drivers/i2c/busses/i2c-stm32f7.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index cfe6d790a8fc..8fe7f8caf91b 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -223,6 +223,7 @@ struct stm32f7_i2c_spec {
  * @fall_time: Fall time (ns)
  * @dnf: Digital filter coefficient (0-16)
  * @analog_filter: Analog filter delay (On/Off)
+ * @fmp_clr_offset: Fast Mode Plus clear register offset from set register
  */
 struct stm32f7_i2c_setup {
 	enum stm32_i2c_speed speed;
@@ -232,6 +233,7 @@ struct stm32f7_i2c_setup {
 	u32 fall_time;
 	u8 dnf;
 	bool analog_filter;
+	u32 fmp_clr_offset;
 };
 
 /**
@@ -303,7 +305,8 @@ struct stm32f7_i2c_msg {
  * @dma: dma data
  * @use_dma: boolean to know if dma is used in the current transfer
  * @regmap: holds SYSCFG phandle for Fast Mode Plus bits
- * @fmp_reg: register address for setting Fast Mode Plus bits
+ * @fmp_sreg: register address for setting Fast Mode Plus bits
+ * @fmp_creg: register address for clearing Fast Mode Plus bits
  * @fmp_mask: mask for Fast Mode Plus bits in set register
  * @wakeup_src: boolean to know if the device is a wakeup source
  */
@@ -328,7 +331,8 @@ struct stm32f7_i2c_dev {
 	struct stm32_i2c_dma *dma;
 	bool use_dma;
 	struct regmap *regmap;
-	u32 fmp_reg;
+	u32 fmp_sreg;
+	u32 fmp_creg;
 	u32 fmp_mask;
 	bool wakeup_src;
 };
@@ -386,6 +390,14 @@ static const struct stm32f7_i2c_setup stm32f7_setup = {
 	.analog_filter = STM32F7_I2C_ANALOG_FILTER_ENABLE,
 };
 
+static const struct stm32f7_i2c_setup stm32mp15_setup = {
+	.rise_time = STM32F7_I2C_RISE_TIME_DEFAULT,
+	.fall_time = STM32F7_I2C_FALL_TIME_DEFAULT,
+	.dnf = STM32F7_I2C_DNF_DEFAULT,
+	.analog_filter = STM32F7_I2C_ANALOG_FILTER_ENABLE,
+	.fmp_clr_offset = 0x40,
+};
+
 static inline void stm32f7_i2c_set_bits(void __iomem *reg, u32 mask)
 {
 	writel_relaxed(readl_relaxed(reg) | mask, reg);
@@ -1837,14 +1849,25 @@ static int stm32f7_i2c_unreg_slave(struct i2c_client *slave)
 static int stm32f7_i2c_write_fm_plus_bits(struct stm32f7_i2c_dev *i2c_dev,
 					  bool enable)
 {
+	int ret;
+
 	if (i2c_dev->speed != STM32_I2C_SPEED_FAST_PLUS ||
 	    IS_ERR_OR_NULL(i2c_dev->regmap))
 		/* Optional */
 		return 0;
 
-	return regmap_update_bits(i2c_dev->regmap, i2c_dev->fmp_reg,
-				  i2c_dev->fmp_mask,
-				  enable ? i2c_dev->fmp_mask : 0);
+	if (i2c_dev->fmp_sreg == i2c_dev->fmp_creg)
+		ret = regmap_update_bits(i2c_dev->regmap,
+					 i2c_dev->fmp_sreg,
+					 i2c_dev->fmp_mask,
+					 enable ? i2c_dev->fmp_mask : 0);
+	else
+		ret = regmap_write(i2c_dev->regmap,
+				   enable ? i2c_dev->fmp_sreg :
+					    i2c_dev->fmp_creg,
+				   i2c_dev->fmp_mask);
+
+	return ret;
 }
 
 static int stm32f7_i2c_setup_fm_plus_bits(struct platform_device *pdev,
@@ -1859,10 +1882,13 @@ static int stm32f7_i2c_setup_fm_plus_bits(struct platform_device *pdev,
 		return 0;
 
 	ret = of_property_read_u32_index(np, "st,syscfg-fmp", 1,
-					 &i2c_dev->fmp_reg);
+					 &i2c_dev->fmp_sreg);
 	if (ret)
 		return ret;
 
+	i2c_dev->fmp_creg = i2c_dev->fmp_sreg +
+			       i2c_dev->setup.fmp_clr_offset;
+
 	return of_property_read_u32_index(np, "st,syscfg-fmp", 2,
 					  &i2c_dev->fmp_mask);
 }
@@ -2262,6 +2288,7 @@ static const struct dev_pm_ops stm32f7_i2c_pm_ops = {
 
 static const struct of_device_id stm32f7_i2c_match[] = {
 	{ .compatible = "st,stm32f7-i2c", .data = &stm32f7_setup},
+	{ .compatible = "st,stm32mp15-i2c", .data = &stm32mp15_setup},
 	{},
 };
 MODULE_DEVICE_TABLE(of, stm32f7_i2c_match);
-- 
2.7.4
-
