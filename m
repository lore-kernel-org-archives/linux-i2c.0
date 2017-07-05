From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 0/4] i2c: pca-platform: additional improvements
Date: Wed,  5 Jul 2017 22:13:54 +1200
Message-ID: <20170705101358.17458-1-chris.packham@alliedtelesis.co.nz>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:56627 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752658AbdGEKOR (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 5 Jul 2017 06:14:17 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, ysato@users.sourceforge.jp, linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Chris Packham <chris.packham@alliedtelesis.co.nz>

This series addresses some of the points identified by Andy. The series is
based on top of i2c/for-next. 2 of the patches from v1 have already been
applied so I've dropped them from this version.

I have compile tested patch 1/1 but I don't have access to sh hardware
to actually test the changes on.

Chris Packham (4):
  sh: sh7785lcr: add GPIO lookup table for i2c controller reset
  i2c: pca-platform: unconditionally use devm_gpiod_get_optional
  i2c: pca-platform: use device_property_read_u32
  i2c: pca-platform: drop gpio from platform data

 arch/blackfin/mach-bf561/boards/acvilon.c |  1 -
 arch/sh/boards/board-sh7785lcr.c          | 11 +++++++++-
 drivers/i2c/busses/i2c-pca-platform.c     | 34 +++++++++----------------------
 include/linux/i2c-pca-platform.h          |  3 ---
 4 files changed, 20 insertions(+), 29 deletions(-)

-- 
2.13.0
