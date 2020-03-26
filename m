From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 4/6] drm/i2c/tda998x: convert to use i2c_new_client_device()
Date: Thu, 26 Mar 2020 22:10:02 +0100
Message-ID: <20200326211005.13301-5-wsa+renesas@sang-engineering.com>
References: <20200326211005.13301-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200326211005.13301-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Russell King <linux@armlinux.org.uk>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move away from the deprecated API and return the shiny new ERRPTR where
useful.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index c3332209f27a..d9a548d0273c 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1949,9 +1949,9 @@ static int tda998x_create(struct device *dev)
 	cec_info.platform_data = &priv->cec_glue;
 	cec_info.irq = client->irq;
 
-	priv->cec = i2c_new_device(client->adapter, &cec_info);
-	if (!priv->cec) {
-		ret = -ENODEV;
+	priv->cec = i2c_new_client_device(client->adapter, &cec_info);
+	if (IS_ERR(priv->cec)) {
+		ret = PTR_ERR(priv->cec);
 		goto fail;
 	}
 
-- 
2.20.1
