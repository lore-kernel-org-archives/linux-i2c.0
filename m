From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 07/15] drm/i2c/sil164: Remove duplicate NULL check
Date: Tue, 31 Oct 2017 16:21:41 +0200
Message-ID: <20171031142149.32512-7-andriy.shevchenko@linux.intel.com>
References: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:61202 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753056AbdJaOW0 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 31 Oct 2017 10:22:26 -0400
In-Reply-To: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org

Since i2c_unregister_device() became NULL-aware we may remove duplicate
NULL check.

Cc: David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpu/drm/i2c/sil164_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i2c/sil164_drv.c b/drivers/gpu/drm/i2c/sil164_drv.c
index ecaa58757529..c52d7a3af786 100644
--- a/drivers/gpu/drm/i2c/sil164_drv.c
+++ b/drivers/gpu/drm/i2c/sil164_drv.c
@@ -326,8 +326,7 @@ sil164_encoder_destroy(struct drm_encoder *encoder)
 {
 	struct sil164_priv *priv = to_sil164_priv(encoder);
 
-	if (priv->duallink_slave)
-		i2c_unregister_device(priv->duallink_slave);
+	i2c_unregister_device(priv->duallink_slave);
 
 	kfree(priv);
 	drm_i2c_encoder_destroy(encoder);
-- 
2.14.2
