From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 2/6] drm/gma500: convert to use i2c_new_client_device()
Date: Thu, 26 Mar 2020 22:10:00 +0100
Message-ID: <20200326211005.13301-3-wsa+renesas@sang-engineering.com>
References: <20200326211005.13301-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200326211005.13301-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move away from the deprecated API and return the shiny new ERRPTR where
useful.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/gpu/drm/gma500/tc35876x-dsi-lvds.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/gma500/tc35876x-dsi-lvds.c b/drivers/gpu/drm/gma500/tc35876x-dsi-lvds.c
index 9e8224456ea2..71574063c63e 100644
--- a/drivers/gpu/drm/gma500/tc35876x-dsi-lvds.c
+++ b/drivers/gpu/drm/gma500/tc35876x-dsi-lvds.c
@@ -747,11 +747,11 @@ static int cmi_lcd_hack_create_device(void)
 		return -EINVAL;
 	}
 
-	client = i2c_new_device(adapter, &info);
-	if (!client) {
-		pr_err("%s: i2c_new_device() failed\n", __func__);
+	client = i2c_new_client_device(adapter, &info);
+	if (IS_ERR(client)) {
+		pr_err("%s: creating I2C device failed\n", __func__);
 		i2c_put_adapter(adapter);
-		return -EINVAL;
+		return PTR_ERR(client);
 	}
 
 	return 0;
-- 
2.20.1
