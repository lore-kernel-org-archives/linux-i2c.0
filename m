From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/2] platform: convert to use new I2C API
Date: Thu, 26 Mar 2020 22:09:50 +0100
Message-ID: <20200326210952.12857-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

We are deprecating calls which return NULL in favor of new variants which
return an ERR_PTR. Only build tested.


Wolfram Sang (2):
  platform/chrome: chromeos_laptop: make I2C API conversion complete
  platform/mellanox: mlxreg-hotplug: convert to use
    i2c_new_client_device()

 drivers/platform/chrome/chromeos_laptop.c  |  2 +-
 drivers/platform/mellanox/mlxreg-hotplug.c | 11 +++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

-- 
2.20.1
