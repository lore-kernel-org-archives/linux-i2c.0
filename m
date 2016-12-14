From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4/5] mfd: axp20x: Drop wrong AXP288_PMIC_ADC_EN define
Date: Wed, 14 Dec 2016 14:52:08 +0100
Message-ID: <20161214135209.16369-4-hdegoede@redhat.com>
References: <20161214135209.16369-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932356AbcLNNwR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 14 Dec 2016 08:52:17 -0500
In-Reply-To: <20161214135209.16369-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Chen-Yu Tsai <wens@csie.org>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

The adc-enable register for the axp288 is 0x82, not 0x84.
0x82 is already defined as AXP20X_ADC_EN1 and that is what the
axp288_adc driver is actually using, so simply drop the wrong
AXP288_PMIC_ADC_EN define.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 include/linux/mfd/axp20x.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index 199cce3..fe93e00 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -232,7 +232,6 @@ enum {
 #define AXP288_PMIC_ADC_H               0x56
 #define AXP288_PMIC_ADC_L               0x57
 #define AXP288_ADC_TS_PIN_CTRL          0x84
-#define AXP288_PMIC_ADC_EN              0x84
 
 /* Fuel Gauge */
 #define AXP288_FG_RDC1_REG          0xba
-- 
2.9.3
