From: Raul E Rangel <rrangel@chromium.org>
Subject: [PATCH v2 0/2] Convert cros-ec-i2c-tunnel to MFD Cell
Date: Mon, 25 Nov 2019 13:47:28 -0700
Message-ID: <20191125204730.187000-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: enric.balletbo@collabora.com, Wolfram Sang <wsa@the-dreams.de>
Cc: Akshu.Agrawal@amd.com, Raul E Rangel <rrangel@chromium.org>, Akshu Agrawal <akshu.agrawal@amd.com>, Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-i2c@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-i2c@vger.kernel.org

Having the cros-ec-i2c-tunnel behave as a MFD Cell fixes a race condition
that could happen if the cros-ec-i2c-tunnel gets probed before the
cros_ec_lpc init has finished.

Changes in v2:
- Extracted platform_device_info into its own variable.
- Moved i2c tunnel into cros_ec_platform_cells
- Requires https://lkml.org/lkml/2019/11/21/208 to correctly enumerate.

Raul E Rangel (2):
  platform/chrome: cros_ec: Pass firmware node to MFD device
  platform/chrome: i2c: i2c-cros-ec-tunnel: Convert i2c tunnel to MFD
    Cell

 drivers/i2c/busses/i2c-cros-ec-tunnel.c | 36 +++++++++----------------
 drivers/mfd/cros_ec_dev.c               |  9 +++++++
 drivers/platform/chrome/cros_ec.c       | 14 +++++++---
 3 files changed, 33 insertions(+), 26 deletions(-)

-- 
2.24.0.432.g9d3f5f5b63-goog
