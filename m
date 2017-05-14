From: Peter Rosin <peda@axentia.se>
Subject: [PATCH] i2c: mux: only print failure message on error
Date: Sun, 14 May 2017 18:41:13 +0200
Message-ID: <1494780073-13713-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ve1eur01on0116.outbound.protection.outlook.com ([104.47.1.116]:17942
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753765AbdENQif (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 14 May 2017 12:38:35 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

As is, a failure message is printed unconditionally, which is confusing.
And noisy.

Fixes: 8d4d159f25a7 ("i2c: mux: provide more info on failure in i2c_mux_add_adapter")
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/i2c-mux.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 26f7237558ba..ccf2ce1836c8 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -395,18 +395,22 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 	if (force_nr) {
 		priv->adap.nr = force_nr;
 		ret = i2c_add_numbered_adapter(&priv->adap);
-		dev_err(&parent->dev,
-			"failed to add mux-adapter %u as bus %u (error=%d)\n",
-			chan_id, force_nr, ret);
+		if (ret < 0) {
+			dev_err(&parent->dev,
+				"failed to add mux-adapter %u as bus %u (error=%d)\n",
+				chan_id, force_nr, ret);
+			kfree(priv);
+			return ret;
+		}
 	} else {
 		ret = i2c_add_adapter(&priv->adap);
-		dev_err(&parent->dev,
-			"failed to add mux-adapter %u (error=%d)\n",
-			chan_id, ret);
-	}
-	if (ret < 0) {
-		kfree(priv);
-		return ret;
+		if (ret < 0) {
+			dev_err(&parent->dev,
+				"failed to add mux-adapter %u (error=%d)\n",
+				chan_id, ret);
+			kfree(priv);
+			return ret;
+		}
 	}
 
 	WARN(sysfs_create_link(&priv->adap.dev.kobj, &muxc->dev->kobj,
-- 
2.1.4
