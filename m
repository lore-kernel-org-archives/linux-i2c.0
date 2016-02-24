From: Jan Glauber <jglauber@cavium.com>
Subject: [RFC PATCH 0/2] ThunderX i2c driver
Date: Wed, 24 Feb 2016 15:13:23 +0100
Message-ID: <cover.1456322816.git.jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36684 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754406AbcBXONm (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 24 Feb 2016 09:13:42 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Jan Glauber <jglauber@cavium.com>

Hi,

these two patches add support for the Cavium ThunderX SOC.
The patches are on-top of the previous i2c-octeon series.

Please review, feedback welcome!

Jan

------------------------------------------------

Jan Glauber (2):
  i2c: Split i2c-octeon driver and add ThunderX support
  i2c: thunderx: Add smbus support

 drivers/i2c/busses/Kconfig             |   10 +
 drivers/i2c/busses/Makefile            |    3 +
 drivers/i2c/busses/i2c-cavium.c        |  828 +++++++++++++++++++++
 drivers/i2c/busses/i2c-cavium.h        |  191 +++++
 drivers/i2c/busses/i2c-octeon-core.c   |  302 ++++++++
 drivers/i2c/busses/i2c-octeon.c        | 1283 --------------------------------
 drivers/i2c/busses/i2c-thunderx-core.c |  294 ++++++++
 7 files changed, 1628 insertions(+), 1283 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-cavium.c
 create mode 100644 drivers/i2c/busses/i2c-cavium.h
 create mode 100644 drivers/i2c/busses/i2c-octeon-core.c
 delete mode 100644 drivers/i2c/busses/i2c-octeon.c
 create mode 100644 drivers/i2c/busses/i2c-thunderx-core.c

-- 
1.9.1
