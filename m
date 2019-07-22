From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/8] media: convert subsystem to i2c_new_dummy_device()
Date: Mon, 22 Jul 2019 19:25:54 +0200
Message-ID: <20190722172604.3572-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
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


Wolfram Sang (8):
  media: dvb-frontends: cxd2820r_core: convert to i2c_new_dummy_device
  media: dvb-frontends: mn88443x: convert to i2c_new_dummy_device
  media: dvb-frontends: mn88472: convert to i2c_new_dummy_device
  media: dvb-frontends: mn88473: convert to i2c_new_dummy_device
  media: i2c: ad9389b: convert to i2c_new_dummy_device
  media: i2c: adv7180: convert to i2c_new_dummy_device
  media: i2c: adv7511-v4l2: convert to i2c_new_dummy_device
  media: usb: go7007: s2250-board: convert to i2c_new_dummy_device

 drivers/media/dvb-frontends/cxd2820r_core.c |  6 +++---
 drivers/media/dvb-frontends/mn88443x.c      |  6 +++---
 drivers/media/dvb-frontends/mn88472.c       | 12 ++++++------
 drivers/media/dvb-frontends/mn88473.c       | 12 ++++++------
 drivers/media/i2c/ad9389b.c                 |  6 +++---
 drivers/media/i2c/adv7180.c                 | 12 ++++++------
 drivers/media/i2c/adv7511-v4l2.c            | 18 +++++++++---------
 drivers/media/usb/go7007/s2250-board.c      |  6 +++---
 8 files changed, 39 insertions(+), 39 deletions(-)

-- 
2.20.1
