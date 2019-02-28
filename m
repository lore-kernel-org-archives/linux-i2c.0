From: Robert Shearman <robertshearman@gmail.com>
Subject: [PATCH v4 0/3] i2c: mux: pca954x: allow management of device idle state via sysfs
Date: Thu, 28 Feb 2019 11:43:40 +0000
Message-ID: <20190228114343.36443-1-robertshearman@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Robert Shearman <robert.shearman@att.com>
List-Id: linux-i2c@vger.kernel.org

From: Robert Shearman <robert.shearman@att.com>

The behaviour, by default, to not deselect after each transfer is
unsafe when there is a device with an address that conflicts with
another device on another pca954x mux on the same parent bus, and it
may not be convenient to use devicetree to set the deselect mux,
e.g. when running on x86_64 when ACPI is used to discover most of the
device hierarchy.

Therefore, provide the ability to set the idle state behaviour using a
new sysfs file, idle_state as a complement to the method of
instantiating the device via sysfs.

Changes in v4:
 - also remove variables that are redundant as a result of platform
   data removal
 - improve ABI file description field
Changes in v3:
 - remove use of platform data to simplify the idle state by not
   having per-channel idle states.
 - correct some comments
 - fix a style issue regarding use of READ_ONCE
Changes in v2:
 - change from exposing deselect mask to idle state with more options
   and less implementation specific
 - fix style issues
 - don't fail the create of the mux device if the device attribute
   file in sysfs failed to create

Robert Shearman (3):
  i2c: mux: pca954x: remove support for unused platform data
  i2c: mux: pca9541: remove support for unused platform data
  i2c: mux: pca954x: allow management of device idle state via sysfs

 .../ABI/testing/sysfs-bus-i2c-devices-pca954x |  20 ++++
 drivers/i2c/muxes/i2c-mux-pca9541.c           |   8 +-
 drivers/i2c/muxes/i2c-mux-pca954x.c           | 106 +++++++++++++-----
 include/linux/platform_data/pca954x.h         |  48 --------
 4 files changed, 100 insertions(+), 82 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i2c-devices-pca954x
 delete mode 100644 include/linux/platform_data/pca954x.h

-- 
2.20.1
