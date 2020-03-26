From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/6] gpu: convert to use new I2C API
Date: Thu, 26 Mar 2020 22:09:58 +0100
Message-ID: <20200326211005.13301-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org
List-Id: linux-i2c@vger.kernel.org

We are deprecating calls which return NULL in favor of new variants which
return an ERR_PTR. Only build tested.


Wolfram Sang (6):
  drm/amdgpu: convert to use i2c_new_client_device()
  drm/gma500: convert to use i2c_new_client_device()
  drm/i2c/sil164: convert to use i2c_new_client_device()
  drm/i2c/tda998x: convert to use i2c_new_client_device()
  drm/nouveau/therm: convert to use i2c_new_client_device()
  drm/radeon: convert to use i2c_new_client_device()

 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c        | 2 +-
 drivers/gpu/drm/gma500/tc35876x-dsi-lvds.c     | 8 ++++----
 drivers/gpu/drm/i2c/sil164_drv.c               | 7 +++++--
 drivers/gpu/drm/i2c/tda998x_drv.c              | 6 +++---
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/ic.c | 4 ++--
 drivers/gpu/drm/radeon/radeon_atombios.c       | 4 ++--
 drivers/gpu/drm/radeon/radeon_combios.c        | 4 ++--
 7 files changed, 19 insertions(+), 16 deletions(-)

-- 
2.20.1
