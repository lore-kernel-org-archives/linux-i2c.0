From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 0/4] i2c: i2c-mv64xxx: misc small improvements
Date: Fri, 22 Apr 2016 15:19:50 +0200
Message-ID: <1461331194-27637-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:39002 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752177AbcDVNUA (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 22 Apr 2016 09:20:00 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Hanna Hawa <hannah@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Hello,

Here are four small patches doing misc improvements to the i2c-mv64xxx
I2C controller driver. The first two patches are really needed in
order to be able to use this I2C controller driver on the ARM64
Marvell Armada 7K/8K platforms. The last two patches are additional
cleanups/improvements made along the way.

Thanks!

Thomas

Thomas Petazzoni (4):
  i2c: i2c-mv64xxx: enable the driver on ARCH_MVEBU
  i2c: i2c-mv64xxx: handle probe deferral for the clock
  i2c: i2c-mv64xxx: use clk_{prepare_enable,disable_unprepare}
  i2c: i2c-mv64xxx: remove CONFIG_HAVE_CLK conditionals

 drivers/i2c/busses/Kconfig       |  2 +-
 drivers/i2c/busses/i2c-mv64xxx.c | 45 +++++++++++++---------------------------
 2 files changed, 15 insertions(+), 32 deletions(-)

-- 
2.6.4
