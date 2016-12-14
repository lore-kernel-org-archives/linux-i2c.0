From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 5/5] mfd: axp20x: Fix axp288 volatile ranges
Date: Wed, 14 Dec 2016 14:52:09 +0100
Message-ID: <20161214135209.16369-5-hdegoede@redhat.com>
References: <20161214135209.16369-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52501 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932356AbcLNNwS (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 14 Dec 2016 08:52:18 -0500
In-Reply-To: <20161214135209.16369-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Chen-Yu Tsai <wens@csie.org>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

The axp288 pmic has a lot more volatile registers then we were
listing in axp288_volatile_ranges, fix this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mfd/axp20x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index a294121..b9c1adf 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -117,7 +117,10 @@ static const struct regmap_range axp288_writeable_ranges[] = {
 };
 
 static const struct regmap_range axp288_volatile_ranges[] = {
+	regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP20X_PWR_OP_MODE),
 	regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IPSOUT_V_HIGH_L),
+	regmap_reg_range(AXP22X_GPIO_STATE, AXP22X_GPIO_STATE),
+	regmap_reg_range(AXP20X_FG_RES, AXP288_FG_CC_CAP_REG),
 };
 
 static const struct regmap_access_table axp288_writeable_table = {
-- 
2.9.3
