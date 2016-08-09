From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: [PATCH 4/5] gpu: drm: radeon: radeon_i2c: don't print error when adding adapter fails
Date: Tue,  9 Aug 2016 13:30:30 +0200
Message-ID: <1470742232-12559-5-git-send-email-wsa-dev@sang-engineering.com>
References: <1470742232-12559-1-git-send-email-wsa-dev@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470742232-12559-1-git-send-email-wsa-dev@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa-dev@sang-engineering.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org
List-Id: linux-i2c@vger.kernel.org

The core will do this for us now.

Signed-off-by: Wolfram Sang <wsa-dev@sang-engineering.com>
---
 drivers/gpu/drm/radeon/radeon_i2c.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_i2c.c b/drivers/gpu/drm/radeon/radeon_i2c.c
index 9590bcd321c09a..021aa005623f80 100644
--- a/drivers/gpu/drm/radeon/radeon_i2c.c
+++ b/drivers/gpu/drm/radeon/radeon_i2c.c
@@ -938,10 +938,8 @@ struct radeon_i2c_chan *radeon_i2c_create(struct drm_device *dev,
 			 "Radeon i2c hw bus %s", name);
 		i2c->adapter.algo = &radeon_i2c_algo;
 		ret = i2c_add_adapter(&i2c->adapter);
-		if (ret) {
-			DRM_ERROR("Failed to register hw i2c %s\n", name);
+		if (ret)
 			goto out_free;
-		}
 	} else if (rec->hw_capable &&
 		   radeon_hw_i2c &&
 		   ASIC_IS_DCE3(rdev)) {
@@ -950,10 +948,8 @@ struct radeon_i2c_chan *radeon_i2c_create(struct drm_device *dev,
 			 "Radeon i2c hw bus %s", name);
 		i2c->adapter.algo = &radeon_atom_i2c_algo;
 		ret = i2c_add_adapter(&i2c->adapter);
-		if (ret) {
-			DRM_ERROR("Failed to register hw i2c %s\n", name);
+		if (ret)
 			goto out_free;
-		}
 	} else {
 		/* set the radeon bit adapter */
 		snprintf(i2c->adapter.name, sizeof(i2c->adapter.name),
-- 
2.8.1
