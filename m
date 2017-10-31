From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 08/15] drm/i2c: tda998x: Remove duplicate NULL check
Date: Tue, 31 Oct 2017 16:21:42 +0200
Message-ID: <20171031142149.32512-8-andriy.shevchenko@linux.intel.com>
References: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:41879 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752908AbdJaOW0 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 31 Oct 2017 10:22:26 -0400
In-Reply-To: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Russell King <linux@armlinux.org.uk>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org

Since i2c_unregister_device() became NULL-aware we may remove duplicate
NULL check.

Cc: Russell King <linux@armlinux.org.uk>
Cc: David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 4d1f45acf2cd..7a349e85f964 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1602,8 +1602,7 @@ static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
 	/* if encoder_init fails, the encoder slave is never registered,
 	 * so cleanup here:
 	 */
-	if (priv->cec)
-		i2c_unregister_device(priv->cec);
+	i2c_unregister_device(priv->cec);
 	return -ENXIO;
 }
 
-- 
2.14.2
