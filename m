From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 06/15] drm/bridge: analogix-anx78xx: Remove duplicate NULL check
Date: Tue, 31 Oct 2017 16:21:40 +0200
Message-ID: <20171031142149.32512-6-andriy.shevchenko@linux.intel.com>
References: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:41879 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752209AbdJaOW1 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 31 Oct 2017 10:22:27 -0400
In-Reply-To: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Archit Taneja <architt@codeaurora.org>, Andrzej Hajda <a.hajda@samsung.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org

Since i2c_unregister_device() became NULL-aware we may remove duplicate
NULL check.

Cc: Archit Taneja <architt@codeaurora.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpu/drm/bridge/analogix-anx78xx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix-anx78xx.c
index 9385eb0b1ee4..e2925e425f90 100644
--- a/drivers/gpu/drm/bridge/analogix-anx78xx.c
+++ b/drivers/gpu/drm/bridge/analogix-anx78xx.c
@@ -1303,8 +1303,7 @@ static void unregister_i2c_dummy_clients(struct anx78xx *anx78xx)
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(anx78xx->i2c_dummy); i++)
-		if (anx78xx->i2c_dummy[i])
-			i2c_unregister_device(anx78xx->i2c_dummy[i]);
+		i2c_unregister_device(anx78xx->i2c_dummy[i]);
 }
 
 static const struct regmap_config anx78xx_regmap_config = {
-- 
2.14.2
