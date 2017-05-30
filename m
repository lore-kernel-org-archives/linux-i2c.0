From: Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [PATCH] i2c: i2c-mux: Fix channel parent node assignment
Date: Tue, 30 May 2017 17:13:26 +0900
Message-ID: <1496132006-20329-1-git-send-email-jacopo+renesas@jmondi.org>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: peda@axentia.se, laurent.pinchart@ideasonboard.com, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

I2c-mux channels are created with the mux parent device as their own
parent, while they should be siblings of the mux itself.
Fix this.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

---

Hello,
   while inspecting child nodes of an i2c adapter it has been noted that
child devices of an i2c-mux are listed as children of the i2c adapter itself,
and not of the i2c-mux.

The hierarchy of devices looked like

-- i2c-04
--- eeprom@57
--- video_receiver@70
--- video_receiver@34
--- gmsl-deserializer@0		<-- MUX
--- gmsl-deserializer@0/i2c@0	<-- MUX CHANNEL

It now looks like

-- i2c-04
--- eeprom@57
--- video_receiver@70
--- video_receiver@34
--- gmsl-deserializer@0
---- gmsl-deserializer@0/i2c@0

 drivers/i2c/i2c-mux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 83768e8..37b7804 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -324,7 +324,7 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 	priv->adap.owner = THIS_MODULE;
 	priv->adap.algo = &priv->algo;
 	priv->adap.algo_data = priv;
-	priv->adap.dev.parent = &parent->dev;
+	priv->adap.dev.parent = muxc->dev;
 	priv->adap.retries = parent->retries;
 	priv->adap.timeout = parent->timeout;
 	priv->adap.quirks = parent->quirks;
--
2.7.4
