From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/5] mfd: axp20x: Fix axp288 PEK_DBR and PEK_DBF irqs being swapped
Date: Wed, 14 Dec 2016 14:52:07 +0100
Message-ID: <20161214135209.16369-3-hdegoede@redhat.com>
References: <20161214135209.16369-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44444 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932356AbcLNNwP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 14 Dec 2016 08:52:15 -0500
In-Reply-To: <20161214135209.16369-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Chen-Yu Tsai <wens@csie.org>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

The R in PEK_DBR stands for rising, so it should be mapped to
AXP288_IRQ_POKP where the last P stands for positive edge.

Likewise PEK_DBF should be mapped to the falling edge, aka the
_N_egative edge, so it should be mapped to AXP288_IRQ_POKN.

This fixes the inverted powerbutton status reporting by the
axp20x-pek driver.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mfd/axp20x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 9a81659..a294121 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -205,14 +205,14 @@ static struct resource axp22x_pek_resources[] = {
 static struct resource axp288_power_button_resources[] = {
 	{
 		.name	= "PEK_DBR",
-		.start	= AXP288_IRQ_POKN,
-		.end	= AXP288_IRQ_POKN,
+		.start	= AXP288_IRQ_POKP,
+		.end	= AXP288_IRQ_POKP,
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		.name	= "PEK_DBF",
-		.start	= AXP288_IRQ_POKP,
-		.end	= AXP288_IRQ_POKP,
+		.start	= AXP288_IRQ_POKN,
+		.end	= AXP288_IRQ_POKN,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
-- 
2.9.3
