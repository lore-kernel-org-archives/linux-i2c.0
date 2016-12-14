From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/5] mfd: axp20x: Add missing axp288 irqs
Date: Wed, 14 Dec 2016 14:52:06 +0100
Message-ID: <20161214135209.16369-2-hdegoede@redhat.com>
References: <20161214135209.16369-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37414 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932196AbcLNNwO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 14 Dec 2016 08:52:14 -0500
In-Reply-To: <20161214135209.16369-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Chen-Yu Tsai <wens@csie.org>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

The axp288 has the following irqs 2 times: VBUS_FALL, VBUS_RISE,
VBUS_OV. On boot / reset the enable flags for both the normal and alt
version of these irqs is set.

Since we were only listing the normal version in the axp288 regmap_irq
struct, we were never disabling the alt versions of these irqs.

Add the alt versions to the axp288 regmap_irq struct, so that these
get properly disabled.

Together with the other axp288 fixes in this series, this fixes the axp288
irq contineously triggering.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mfd/axp20x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 3d76941..9a81659 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -405,6 +405,9 @@ static const struct regmap_irq axp288_regmap_irqs[] = {
 	INIT_REGMAP_IRQ(AXP288, VBUS_FALL,              0, 2),
 	INIT_REGMAP_IRQ(AXP288, VBUS_RISE,              0, 3),
 	INIT_REGMAP_IRQ(AXP288, OV,                     0, 4),
+	INIT_REGMAP_IRQ(AXP288, FALLING_ALT,            0, 5),
+	INIT_REGMAP_IRQ(AXP288, RISING_ALT,             0, 6),
+	INIT_REGMAP_IRQ(AXP288, OV_ALT,                 0, 7),
 
 	INIT_REGMAP_IRQ(AXP288, DONE,                   1, 2),
 	INIT_REGMAP_IRQ(AXP288, CHARGING,               1, 3),
-- 
2.9.3
