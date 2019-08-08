From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH RFT 0/3] hwmon: convert remaining drivers to i2c_new_dummy_device()
Date: Thu,  8 Aug 2019 17:35:55 +0200
Message-ID: <20190808153558.2362-1-wsa+renesas@sang-engineering.com>
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

This series fixes the remaining hwmon drivers which could not be
converted by my cocci script. So, I did it manually, yet all drivers
still follow the same pattern. Build tested by me and by buildbot. No
tests on HW have been performed, so testing is appreciated.

The branch is based on v5.3-rc2. A branch (with some more stuff included) can
be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c/new_dummy


Wolfram Sang (3):
  hwmon: w83791d: convert to use devm_i2c_new_dummy_device
  hwmon: w83792d: convert to use devm_i2c_new_dummy_device
  hwmon: w83793d: convert to use devm_i2c_new_dummy_device

 drivers/hwmon/w83791d.c | 32 +++++++++-----------------------
 drivers/hwmon/w83792d.c | 32 +++++++++-----------------------
 drivers/hwmon/w83793.c  | 30 ++++++++----------------------
 3 files changed, 26 insertions(+), 68 deletions(-)

-- 
2.20.1
