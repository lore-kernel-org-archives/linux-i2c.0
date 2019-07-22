From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/3] hwmon: convert subsystem to i2c_new_dummy_device()
Date: Mon, 22 Jul 2019 19:26:07 +0200
Message-ID: <20190722172611.3797-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
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


Wolfram Sang (3):
  hwmon: asb100: convert to i2c_new_dummy_device
  hwmon: smm665: convert to i2c_new_dummy_device
  hwmon: w83781d: convert to i2c_new_dummy_device

 drivers/hwmon/asb100.c  | 12 ++++++------
 drivers/hwmon/smm665.c  |  6 +++---
 drivers/hwmon/w83781d.c |  6 +++---
 3 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.20.1
