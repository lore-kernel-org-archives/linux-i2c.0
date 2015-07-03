From: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 0/8] Add support for best effort block read emulation
Date: Fri,  3 Jul 2015 12:33:29 +0300
Message-ID: <1435916017-12859-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This is version 3 for adding i2c_smbus_read_i2c_block_data_or_emulated
to i2c-core. The i2c core part is the same as in v2, but I have added
3 more users for iio drivers.

Changes in v2:
 - changed bmc150-accel, kxcjk-1013 and bmg160 drivers to use
i2c_smbus_read_i2c_block_data_or_emulated

Changes in v1:
 - dropped the RFC tag
 - changed at24 to use i2c_smbus_read_i2c_block_data_or_emulated
 - when reading an odd number of bytes using word emulation, read an even
number of bytes and drop the last one
 - add a comment that this might not be suitable for all I2C slaves 

Adriana Reus (2):
  iio: accel: kxcjk-1013: use available_scan_masks
  iio: accel: kxcjk-1013: optimize i2c transfers in trigger handler

Irina Tirdea (6):
  i2c: core: Add support for best effort block read emulation
  eeprom: at24: use i2c_smbus_read_i2c_block_data_or_emulated
  iio: accel: bmc150: use available_scan_masks
  iio: accel: bmc150: optimize i2c transfers in trigger handler
  iio: gyro: bmg160: use available_scan_masks
  iio: gyro: bmg160: optimize i2c transfers in trigger handler

 drivers/i2c/i2c-core.c           | 60 ++++++++++++++++++++++++++++++++++++++++
 drivers/iio/accel/bmc150-accel.c | 23 +++++++--------
 drivers/iio/accel/kxcjk-1013.c   | 24 ++++++++--------
 drivers/iio/gyro/bmg160.c        | 23 +++++++--------
 drivers/misc/eeprom/at24.c       | 40 ++++++---------------------
 include/linux/i2c.h              |  3 ++
 6 files changed, 108 insertions(+), 65 deletions(-)

-- 
1.9.1
