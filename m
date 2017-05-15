From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2] i2c: mux: only print failure message on error
Date: Mon, 15 May 2017 09:40:17 +0200
Message-ID: <1494834017-24678-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0105.outbound.protection.outlook.com ([104.47.2.105]:10419
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756446AbdEOHha (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 15 May 2017 03:37:30 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Leon Romanovsky <leon@leon.nu>, linux-i2c@vger.kernel.org

As is, a failure message is printed unconditionally, which is confusing.
And noisy.

Fixes: 8d4d159f25a7 ("i2c: mux: provide more info on failure in i2c_mux_add_adapter")
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/i2c-mux.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

Wolfram, you can take this one directly if you wish. You can also
take [1] (and optionally [2]) directly if you wish. Or just holler
and I'll send you a pull request with [1] and this patch for-current.

[1] i2c: mux: reg: put away the parent i2c adapter on probe failure
    https://patchwork.ozlabs.org/patch/759487/

[2] i2c: mux: reg: rename label to indicate what it does
    https://patchwork.ozlabs.org/patch/759486/

Changes since v1:
- Use goto instead of having two kfree, as pointed out by Leon Romanovsky.

Cheers,
peda

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 26f7237558ba..9669ca4937b8 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -395,18 +395,20 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
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
+			goto err_free_priv;
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
+			goto err_free_priv;
+		}
 	}
 
 	WARN(sysfs_create_link(&priv->adap.dev.kobj, &muxc->dev->kobj,
@@ -422,6 +424,10 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 
 	muxc->adapter[muxc->num_adapters++] = &priv->adap;
 	return 0;
+
+err_free_priv:
+	kfree(priv);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(i2c_mux_add_adapter);
 
-- 
2.1.4
