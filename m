From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH] i2c: fix "failed to add mux-adapter" message
Date: Tue, 16 May 2017 12:05:51 +0100
Message-ID: <E1dAaIY-0005jy-Tc@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:45624 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750932AbdEPLF4 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 16 May 2017 07:05:56 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org

i2c-mux always prints the "failed to add mux-adapter" message even when
the mux adapter is successfully registered.  Fix this.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/i2c/i2c-mux.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 26f7237558ba..d5258c13fe57 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -395,14 +395,16 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 	if (force_nr) {
 		priv->adap.nr = force_nr;
 		ret = i2c_add_numbered_adapter(&priv->adap);
-		dev_err(&parent->dev,
-			"failed to add mux-adapter %u as bus %u (error=%d)\n",
-			chan_id, force_nr, ret);
+		if (ret < 0)
+			dev_err(&parent->dev,
+				"failed to add mux-adapter %u as bus %u (error=%d)\n",
+				chan_id, force_nr, ret);
 	} else {
 		ret = i2c_add_adapter(&priv->adap);
-		dev_err(&parent->dev,
-			"failed to add mux-adapter %u (error=%d)\n",
-			chan_id, ret);
+		if (ret < 0)
+			dev_err(&parent->dev,
+				"failed to add mux-adapter %u (error=%d)\n",
+				chan_id, ret);
 	}
 	if (ret < 0) {
 		kfree(priv);
-- 
2.7.4
