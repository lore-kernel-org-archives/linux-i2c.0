From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/1] gpu: drm: bridge: analogix-anx78xx: convert to i2c_new_dummy_device
Date: Mon, 22 Jul 2019 19:26:09 +0200
Message-ID: <20190722172609.3731-2-wsa+renesas@sang-engineering.com>
References: <20190722172609.3731-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722172609.3731-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Andrzej Hajda <a.hajda@samsung.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
ERRPTR which we use in error handling.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.

 drivers/gpu/drm/bridge/analogix-anx78xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix-anx78xx.c
index 3c7cc5af735c..be7756280e41 100644
--- a/drivers/gpu/drm/bridge/analogix-anx78xx.c
+++ b/drivers/gpu/drm/bridge/analogix-anx78xx.c
@@ -1350,10 +1350,10 @@ static int anx78xx_i2c_probe(struct i2c_client *client,
 
 	/* Map slave addresses of ANX7814 */
 	for (i = 0; i < I2C_NUM_ADDRESSES; i++) {
-		anx78xx->i2c_dummy[i] = i2c_new_dummy(client->adapter,
+		anx78xx->i2c_dummy[i] = i2c_new_dummy_device(client->adapter,
 						anx78xx_i2c_addresses[i] >> 1);
-		if (!anx78xx->i2c_dummy[i]) {
-			err = -ENOMEM;
+		if (IS_ERR(anx78xx->i2c_dummy[i])) {
+			err = PTR_ERR(anx78xx->i2c_dummy[i]);
 			DRM_ERROR("Failed to reserve I2C bus %02x\n",
 				  anx78xx_i2c_addresses[i]);
 			goto err_unregister_i2c;
-- 
2.20.1
