From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/4] power: supply: axp288_fuel_gauge: Fix fuel_gauge_reg_readb return on error
Date: Wed, 14 Dec 2016 17:38:50 +0100
Message-ID: <20161214163853.454-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35674 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932436AbcLNQi5 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 14 Dec 2016 11:38:57 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

If reading the register fails, return the actual error code, instead
of the uninitialized val variable;

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 5bdde69..f62f9df 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -169,8 +169,10 @@ static int fuel_gauge_reg_readb(struct axp288_fg_info *info, int reg)
 			break;
 	}
 
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(&info->pdev->dev, "axp288 reg read err:%d\n", ret);
+		return ret;
+	}
 
 	return val;
 }
-- 
2.9.3
