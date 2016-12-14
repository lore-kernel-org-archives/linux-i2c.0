From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/5] mfd: axp20x: Use IRQF_TRIGGER_LOW on the axp288
Date: Wed, 14 Dec 2016 14:52:05 +0100
Message-ID: <20161214135209.16369-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35028 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932356AbcLNNwM (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 14 Dec 2016 08:52:12 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Chen-Yu Tsai <wens@csie.org>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

The interrupt line of the entire family of axp2xx pmics is active-low,
for devicetree enumerated irqs, this is dealt with in the devicetree.

ACPI irq resources have a flag field for this too, I tried using this
on my CUBE iwork8 Air tablet, but it does not contain the right data.

The dstd shows the irq listed as either ActiveLow or ActiveHigh,
depending on the OSID variable, which seems to be set by the
"OS IMAGE ID" in the BIOS/EFI setup screen.

Since the acpi-resource info is no good, simply pass in IRQF_TRIGGER_LOW
on the axp288.

Together with the other axp288 fixes in this series, this fixes the axp288
irq contineously triggering.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mfd/axp20x.c       | 6 +++---
 include/linux/mfd/axp20x.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index ba130be..3d76941 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -800,6 +800,7 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
 		axp20x->nr_cells = ARRAY_SIZE(axp288_cells);
 		axp20x->regmap_cfg = &axp288_regmap_config;
 		axp20x->regmap_irq_chip = &axp288_regmap_irq_chip;
+		axp20x->irq_flags = IRQF_TRIGGER_LOW;
 		break;
 	case AXP806_ID:
 		axp20x->nr_cells = ARRAY_SIZE(axp806_cells);
@@ -829,9 +830,8 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
 	int ret;
 
 	ret = regmap_add_irq_chip(axp20x->regmap, axp20x->irq,
-				  IRQF_ONESHOT | IRQF_SHARED, -1,
-				  axp20x->regmap_irq_chip,
-				  &axp20x->regmap_irqc);
+			  IRQF_ONESHOT | IRQF_SHARED | axp20x->irq_flags,
+			   -1, axp20x->regmap_irq_chip, &axp20x->regmap_irqc);
 	if (ret) {
 		dev_err(axp20x->dev, "failed to add irq chip: %d\n", ret);
 		return ret;
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index fec597f..199cce3 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -517,6 +517,7 @@ enum axp809_irqs {
 struct axp20x_dev {
 	struct device			*dev;
 	int				irq;
+	unsigned long			irq_flags;
 	struct regmap			*regmap;
 	struct regmap_irq_chip_data	*regmap_irqc;
 	long				variant;
-- 
2.9.3
