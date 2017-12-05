From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/2] i2c: introduce devm_i2c_new_dummy and use it in at24
 driver
Date: Tue, 5 Dec 2017 20:40:16 +0100
Message-ID: <e70df557-3f71-9de2-6b1a-de566b47eb33@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

i2c_new_dummy is typically called from the probe function of the
driver for the primary i2c client. It requires calls to
i2c_unregister_device in the error path of the probe function and
in the remove function.
This can be simplified by introducing a device-managed version.

Make at24 driver the first user of the new function.

Patch 1 has been submitted and reviewed some time ago, however it
was waiting for a first user until now.

Heiner Kallweit (2):
  i2c: core: add device-managed version of i2c_new_dummy
  eeprom: at24: switch to device-managed version of i2c_new_dummy

 Documentation/driver-model/devres.txt |  3 +++
 drivers/i2c/i2c-core-base.c           | 39 +++++++++++++++++++++++++++++++++++
 drivers/misc/eeprom/at24.c            |  7 +------
 include/linux/i2c.h                   |  3 +++
 4 files changed, 46 insertions(+), 6 deletions(-)

-- 
2.15.1
