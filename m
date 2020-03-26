From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 5/6] drm/nouveau/therm: convert to use i2c_new_client_device()
Date: Thu, 26 Mar 2020 22:10:03 +0100
Message-ID: <20200326211005.13301-6-wsa+renesas@sang-engineering.com>
References: <20200326211005.13301-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200326211005.13301-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move away from the deprecated API and return the shiny new ERRPTR where
useful.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/ic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/ic.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/ic.c
index 03b355dabab3..abf3eda683f0 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/ic.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/ic.c
@@ -36,8 +36,8 @@ probe_monitoring_device(struct nvkm_i2c_bus *bus,
 
 	request_module("%s%s", I2C_MODULE_PREFIX, info->type);
 
-	client = i2c_new_device(&bus->i2c, info);
-	if (!client)
+	client = i2c_new_client_device(&bus->i2c, info);
+	if (IS_ERR(client))
 		return false;
 
 	if (!client->dev.driver ||
-- 
2.20.1
