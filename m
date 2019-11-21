From: Raul E Rangel <rrangel@chromium.org>
Subject: [PATCH 0/4] Convert cros-ec-i2c-tunnel to MFD Cell
Date: Thu, 21 Nov 2019 14:10:49 -0700
Message-ID: <20191121211053.48861-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: enric.balletbo@collabora.com, Wolfram Sang <wsa@the-dreams.de>
Cc: Akshu.Agrawal@amd.com, Raul E Rangel <rrangel@chromium.org>, Akshu Agrawal <akshu.agrawal@amd.com>, Guenter Roeck <groeck@chromium.org>, Lee Jones <lee.jones@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-i2c@vger.kernel.org, Benson Leung <bleung@chromium.org>, dlaurie@chromium.org
List-Id: linux-i2c@vger.kernel.org

Having the cros-ec-i2c-tunnel behave as a MFD Cell fixes a race condition
that could happen if the cros-ec-i2c-tunnel gets probed before the
cros_ec_lpc init has finished.

There were also some bugs in the original cros-ec-i2c-tunnel ACPI patch.

Raul E Rangel (4):
  i2c: i2c-cros-ec-tunnel: Pass ACPI node to i2c adapter
  i2c: i2c-cros-ec-tunnel: Fix ACPI identifier
  platform/chrome: cros_ec: Pass firmware node to MFD device
  platform/chrome: i2c: i2c-cros-ec-tunnel: Convert i2c tunnel to MFD
    Cell

 drivers/i2c/busses/i2c-cros-ec-tunnel.c | 37 ++++++++++---------------
 drivers/mfd/cros_ec_dev.c               | 19 +++++++++++++
 drivers/platform/chrome/cros_ec.c       | 13 +++++++--
 3 files changed, 43 insertions(+), 26 deletions(-)

-- 
2.24.0.432.g9d3f5f5b63-goog
