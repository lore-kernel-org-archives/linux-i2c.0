From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v3 0/5] eeprom: at24: device tree support fixes
Date: Wed, 27 Dec 2017 14:50:49 +0100
Message-ID: <20171227135054.29690-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Javier Martinez Canillas <javier@dowhile0.org>, David Lechner <david@lechnology.com>, Divagar Mohandass <divagar.mohandass@intel.com>, Peter Rosin <peda@axentia.se>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

The first three patches fix certain issues with the DT binding
document.

The last two extend the device tree support in the driver with more
at24 EEPROM variants.

v1 -> v2:
- remove any implementation details from patch 1/5

v2 -> v3:
- reword patch 1/5: allow any "<manufacturer>,<vendor>" pair as long
  as a supported fallback is used

Bartosz Golaszewski (5):
  dt-bindings: at24: consistently document the compatible property
  dt-bindings: at24: add a missing compatible
  dt-bindings: at24: fix formatting and style
  dt-bindings: at24: extend the list of supported chips
  eeprom: at24: extend the list of chips supported in DT

 Documentation/devicetree/bindings/eeprom/at24.txt | 71 ++++++++++++-----------
 drivers/misc/eeprom/at24.c                        |  9 +++
 2 files changed, 46 insertions(+), 34 deletions(-)

-- 
2.15.1
