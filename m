From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 3/6] drm/i2c/sil164: convert to use i2c_new_client_device()
Date: Thu, 26 Mar 2020 22:10:01 +0100
Message-ID: <20200326211005.13301-4-wsa+renesas@sang-engineering.com>
References: <20200326211005.13301-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200326211005.13301-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move away from the deprecated API and return the shiny new ERRPTR where
useful.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/gpu/drm/i2c/sil164_drv.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i2c/sil164_drv.c b/drivers/gpu/drm/i2c/sil164_drv.c
index a839f78a4c8a..741886b54419 100644
--- a/drivers/gpu/drm/i2c/sil164_drv.c
+++ b/drivers/gpu/drm/i2c/sil164_drv.c
@@ -393,7 +393,7 @@ sil164_detect_slave(struct i2c_client *client)
 		return NULL;
 	}
 
-	return i2c_new_device(adap, &info);
+	return i2c_new_client_device(adap, &info);
 }
 
 static int
@@ -402,6 +402,7 @@ sil164_encoder_init(struct i2c_client *client,
 		    struct drm_encoder_slave *encoder)
 {
 	struct sil164_priv *priv;
+	struct i2c_client *slave_client;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -410,7 +411,9 @@ sil164_encoder_init(struct i2c_client *client,
 	encoder->slave_priv = priv;
 	encoder->slave_funcs = &sil164_encoder_funcs;
 
-	priv->duallink_slave = sil164_detect_slave(client);
+	slave_client = sil164_detect_slave(client);
+	if (!IS_ERR(slave_client))
+		priv->duallink_slave = slave_client;
 
 	return 0;
 }
-- 
2.20.1
