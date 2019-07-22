From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/2] media: ir-kbd-i2c: fix potential OOPS & minor cleanup
Date: Mon, 22 Jul 2019 19:26:30 +0200
Message-ID: <20190722172632.4402-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa@the-dreams.de>

This series is part of a tree-wide movement to replace the I2C API call
'i2c_new_dummy' which returns NULL with its new counterpart returning an
ERRPTR.

It was manually converted and only build tested (by me and buildbot). A
small cleanup was added while working on this driver. Looking for
someone to ack/rev/test this series.

The series is based on v5.3-rc1. A branch (with some more stuff included) can
be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c/new_dummy

Thanks!


Wolfram Sang (2):
  media: ir-kbd-i2c: prevent potential NULL pointer access
  media: ir-kbd-i2c: remove outdated comments

 drivers/media/i2c/ir-kbd-i2c.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

-- 
2.20.1
