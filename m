From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/2] misc: convert subsystem to i2c_new_dummy_device()
Date: Mon, 22 Jul 2019 19:26:14 +0200
Message-ID: <20190722172616.3982-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

This series is part of a tree-wide movement to replace the I2C API call
'i2c_new_dummy' which returns NULL with its new counterpart returning an
ERRPTR.

The series was generated with coccinelle (audited afterwards, of course) and
build tested by me and by buildbot. No tests on HW have been performed.

The branch is based on v5.3-rc1. A branch (with some more stuff included) can
be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c/new_dummy

Some drivers still need to be manually converted. Patches for those will be
sent out individually.


Wolfram Sang (2):
  misc: eeprom: ee1004: convert to i2c_new_dummy_device
  misc: eeprom: max6875: convert to i2c_new_dummy_device

 drivers/misc/eeprom/ee1004.c  | 6 +++---
 drivers/misc/eeprom/max6875.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.20.1
