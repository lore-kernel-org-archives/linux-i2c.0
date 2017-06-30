From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 0/6] i2c: pca-platform: additional improvements
Date: Fri, 30 Jun 2017 12:54:02 +1200
Message-ID: <20170630005408.23968-1-chris.packham@alliedtelesis.co.nz>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:46132 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751567AbdF3AyU (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 29 Jun 2017 20:54:20 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, andy.shevchenko@gmail.com, linux-i2c@vger.kernel.org
Cc: ysato@users.sourceforge.jp, linux-sh@vger.kernel.org, Chris Packham <chris.packham@alliedtelesis.co.nz>

This series addresses some of the points identified by Andy. The series is
based on top of i2c/for-next.

I haven't got a working sh4 toolchain so I haven't been able to compile test
patch 1/1.

Chris Packham (6):
  sh: sh7785lcr: add GPIO lookup table for i2c controller reset
  i2c: pca-platform: correctly set algo_data.reset_chip
  i2c: pca-platform: propagate error from i2c_pca_add_numbered_bus
  i2c: pca-platform: unconditionally use devm_gpiod_get_optional
  i2c: pca-platform: use device_property_read_u32
  i2c: pca-platform: drop gpio from platform data

 arch/blackfin/mach-bf561/boards/acvilon.c |  1 -
 arch/sh/boards/board-sh7785lcr.c          | 11 +++++++-
 drivers/i2c/busses/i2c-pca-platform.c     | 42 +++++++++++--------------------
 include/linux/i2c-pca-platform.h          |  3 ---
 4 files changed, 25 insertions(+), 32 deletions(-)

-- 
2.13.0
