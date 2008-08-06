From: Carlos Aguiar <carlos.aguiar-knKY8vlp0dIIdKJ7tpkyPg@public.gmane.org>
Subject: [PATCH 2/6] I2C: MENELAUS: Using macros instead of some
 constant magic numbers.
Date: Wed, 06 Aug 2008 14:00:53 -0400
Message-ID: <4899E6D5.7060604@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Carlos Eduardo Aguiar <carlos.aguiar-knKY8vlp0dIIdKJ7tpkyPg@public.gmane.org>

This patch makes drivers/i2c/chips/menelaus.c file to use macros
instead of some constant magic numbers.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar-knKY8vlp0dIIdKJ7tpkyPg@public.gmane.org>
---
 drivers/i2c/chips/menelaus.c |   83 +++++++++++++++++++++++++++++-------------
 1 files changed, 58 insertions(+), 25 deletions(-)

diff --git a/drivers/i2c/chips/menelaus.c b/drivers/i2c/chips/menelaus.c
index 18471b6..06387b4 100644
--- a/drivers/i2c/chips/menelaus.c
+++ b/drivers/i2c/chips/menelaus.c
@@ -128,6 +128,39 @@
 #define MENELAUS_RESERVED14_IRQ		14	/* Reserved */
 #define MENELAUS_RESERVED15_IRQ		15	/* Reserved */
 
+/* VCORE_CTRL1 register */
+#define VCORE_CTRL1_BYP_COMP		(1 << 5)
+#define VCORE_CTRL1_HW_NSW		(1 << 7)
+
+/* GPIO_CTRL register */
+#define GPIO_CTRL_SLOTSELEN		(1 << 5)
+#define GPIO_CTRL_SLPCTLEN		(1 << 6)
+#define GPIO1_DIR_INPUT 		(1 << 0)
+#define GPIO2_DIR_INPUT 		(1 << 1)
+#define GPIO3_DIR_INPUT 		(1 << 2)
+
+/* MCT_CTRL1 register */
+#define MCT_CTRL1_S1_CMD_OD		(1 << 2)
+#define MCT_CTRL1_S2_CMD_OD		(1 << 3)
+
+/* MCT_CTRL2 register */
+#define MCT_CTRL2_VS2_SEL_D0		(1 << 0)
+#define MCT_CTRL2_VS2_SEL_D1		(1 << 1)
+#define MCT_CTRL2_S1CD_BUFEN		(1 << 4)
+#define MCT_CTRL2_S2CD_BUFEN		(1 << 5)
+#define MCT_CTRL2_S1CD_DBEN		(1 << 6)
+#define MCT_CTRL2_S2CD_BEN		(1 << 7)
+
+/* MCT_CTRL3 register */
+#define MCT_CTRL3_SLOT1_EN		(1 << 0)
+#define MCT_CTRL3_SLOT2_EN		(1 << 1)
+#define MCT_CTRL3_S1_AUTO_EN		(1 << 2)
+#define MCT_CTRL3_S2_AUTO_EN		(1 << 3)
+
+/* MCT_PIN_ST register */
+#define MCT_PIN_ST_S1_CD_ST		(1 << 0)
+#define MCT_PIN_ST_S2_CD_ST		(1 << 1)
+
 static void menelaus_work(struct work_struct *_menelaus);
 
 struct menelaus_chip {
@@ -249,10 +282,10 @@ static void menelaus_mmc_cd_work(struct menelaus_chip *menelaus_hw)
 		return;
 
 	if (!(reg & 0x1))
-		card_mask |= (1 << 0);
+		card_mask |= MCT_PIN_ST_S1_CD_ST;
 
 	if (!(reg & 0x2))
-		card_mask |= (1 << 1);
+		card_mask |= MCT_PIN_ST_S2_CD_ST;
 
 	if (menelaus_hw->mmc_callback)
 		menelaus_hw->mmc_callback(menelaus_hw->mmc_callback_data,
@@ -277,14 +310,14 @@ int menelaus_set_mmc_opendrain(int slot, int enable)
 	val = ret;
 	if (slot == 1) {
 		if (enable)
-			val |= 1 << 2;
+			val |= MCT_CTRL1_S1_CMD_OD;
 		else
-			val &= ~(1 << 2);
+			val &= ~MCT_CTRL1_S1_CMD_OD;
 	} else {
 		if (enable)
-			val |= 1 << 3;
+			val |= MCT_CTRL1_S2_CMD_OD;
 		else
-			val &= ~(1 << 3);
+			val &= ~MCT_CTRL1_S2_CMD_OD;
 	}
 	ret = menelaus_write_reg(MENELAUS_MCT_CTRL1, val);
 	mutex_unlock(&the_menelaus->lock);
@@ -301,11 +334,11 @@ int menelaus_set_slot_sel(int enable)
 	ret = menelaus_read_reg(MENELAUS_GPIO_CTRL);
 	if (ret < 0)
 		goto out;
-	ret |= 0x02;
+	ret |= GPIO2_DIR_INPUT;
 	if (enable)
-		ret |= 1 << 5;
+		ret |= GPIO_CTRL_SLOTSELEN;
 	else
-		ret &= ~(1 << 5);
+		ret &= ~GPIO_CTRL_SLOTSELEN;
 	ret = menelaus_write_reg(MENELAUS_GPIO_CTRL, ret);
 out:
 	mutex_unlock(&the_menelaus->lock);
@@ -324,14 +357,14 @@ int menelaus_enable_slot(int slot, int enable)
 	val = ret;
 	if (slot == 1) {
 		if (enable)
-			val |= 1 << 0;
+			val |= MCT_CTRL3_SLOT1_EN;
 		else
-			val &= ~(1 << 0);
+			val &= ~MCT_CTRL3_SLOT1_EN;
 	} else {
 		if (enable)
-			val |= 1 << 1;
+			val |= MCT_CTRL3_SLOT2_EN;
 		else
-			val &= ~(1 << 1);
+			val &= MCT_CTRL3_SLOT2_EN;
 	}
 	ret = menelaus_write_reg(MENELAUS_MCT_CTRL3, val);
 
@@ -358,14 +391,14 @@ int menelaus_set_mmc_slot(int slot, int enable, int power, int cd_en)
 	val = ret;
 	if (slot == 1) {
 		if (cd_en)
-			val |= (1 << 4) | (1 << 6);
+			val |= MCT_CTRL2_S1CD_BUFEN | MCT_CTRL2_S1CD_DBEN;
 		else
-			val &= ~((1 << 4) | (1 << 6));
+			val &= ~(MCT_CTRL2_S1CD_BUFEN | MCT_CTRL2_S1CD_DBEN);
 	} else {
 		if (cd_en)
-			val |= (1 << 5) | (1 << 7);
+			val |= MCT_CTRL2_S2CD_BUFEN | MCT_CTRL2_S2CD_BEN;
 		else
-			val &= ~((1 << 5) | (1 << 7));
+			val &= ~(MCT_CTRL2_S2CD_BUFEN | MCT_CTRL2_S2CD_BEN);
 	}
 	ret = menelaus_write_reg(MENELAUS_MCT_CTRL2, val);
 	if (ret < 0)
@@ -377,25 +410,25 @@ int menelaus_set_mmc_slot(int slot, int enable, int power, int cd_en)
 	val = ret;
 	if (slot == 1) {
 		if (enable)
-			val |= 1 << 0;
+			val |= MCT_CTRL3_SLOT1_EN;
 		else
-			val &= ~(1 << 0);
+			val &= ~MCT_CTRL3_SLOT1_EN;
 	} else {
 		int b;
 
 		if (enable)
-			val |= 1 << 1;
+			val |= MCT_CTRL3_SLOT2_EN;
 		else
-			val &= ~(1 << 1);
+			val &= ~MCT_CTRL3_SLOT2_EN;
 		b = menelaus_read_reg(MENELAUS_MCT_CTRL2);
-		b &= ~0x03;
+		b &= ~(MCT_CTRL2_VS2_SEL_D0 | MCT_CTRL2_VS2_SEL_D1);
 		b |= power;
 		ret = menelaus_write_reg(MENELAUS_MCT_CTRL2, b);
 		if (ret < 0)
 			goto out;
 	}
 	/* Disable autonomous shutdown */
-	val &= ~(0x03 << 2);
+	val &= ~(MCT_CTRL3_S1_AUTO_EN | MCT_CTRL3_S2_AUTO_EN);
 	ret = menelaus_write_reg(MENELAUS_MCT_CTRL3, val);
 out:
 	mutex_unlock(&the_menelaus->lock);
@@ -580,7 +613,7 @@ int menelaus_set_vcore_hw(unsigned int roof_mV, unsigned int floor_mV)
 	if (!the_menelaus->vcore_hw_mode) {
 		val = menelaus_read_reg(MENELAUS_VCORE_CTRL1);
 		/* HW mode, turn OFF byte comparator */
-		val |= ((1 << 7) | (1 << 5));
+		val |= (VCORE_CTRL1_HW_NSW | VCORE_CTRL1_BYP_COMP);
 		ret = menelaus_write_reg(MENELAUS_VCORE_CTRL1, val);
 		the_menelaus->vcore_hw_mode = 1;
 	}
@@ -777,7 +810,7 @@ int menelaus_set_regulator_sleep(int enable, u32 val)
 	ret = menelaus_read_reg(MENELAUS_GPIO_CTRL);
 	if (ret < 0)
 		goto out;
-	t = ((1 << 6) | 0x04);
+	t = (GPIO_CTRL_SLPCTLEN | GPIO3_DIR_INPUT);
 	if (enable)
 		ret |= t;
 	else
-- 1.5.5.1


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
