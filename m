From: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 0/2] Add support for best effort block read emulation
Date: Fri, 17 Apr 2015 22:17:51 +0300
Message-ID: <1429298273-5108-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This is the second version for adding i2c_smbus_read_i2c_block_data_or_emulated
to i2c-core. It contains mostly fixes suggested by Wolfram.

Changes since v1:
 - dropped the RFC tag
 - changed at24 to use i2c_smbus_read_i2c_block_data_or_emulated
 - when reading an odd number of bytes using word emulation, read an even
number of bytes and drop the last one
 - add a comment that this might not be suitable for all I2C slaves 

Irina Tirdea (2):
  i2c: core: Add support for best effort block read emulation
  eeprom: at24: use i2c_smbus_read_i2c_block_data_or_emulated

 drivers/i2c/i2c-core.c     | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/misc/eeprom/at24.c | 40 +++++++------------------------
 include/linux/i2c.h        |  3 +++
 3 files changed, 72 insertions(+), 31 deletions(-)

-- 
1.9.1
