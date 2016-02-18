From: Jan Glauber <jglauber@cavium.com>
Subject: [RFC PATCH 0/8] i2c-octeon update
Date: Thu, 18 Feb 2016 09:22:22 +0100
Message-ID: <cover.1455782324.git.jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36752 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425120AbcBRIWs (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 18 Feb 2016 03:22:48 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Jan Glauber <jglauber@cavium.com>

This series for the Octeon i2c driver is an attempt to upstream some
bug fixes and features that accumulated for some time. I tried to
split the cleanup from the other patches and updated the patch
descriptions according to my humble i2c knowledge.

Patches are on top of 4.5-rc4 and were tested on OCTEON and OCTEON-78.

Jan

----------------------------------------------------------------------

David Daney (4):
  i2c-octeon: Support I2C_M_RECV_LEN
  i2c-octeon: Enable high-level controller and improve on bus contention
  i2c-octeon: Add support for cn78XX chips
  i2c-octeon: Add workaround for chips with broken irqs

Jan Glauber (2):
  i2c-octeon: Cleanup i2c-octeon driver
  dt-bindings: i2c: add Octeon cn78xx TWSI

Peter Swain (2):
  i2c-octeon: Flush TWSI writes with readback
  i2c-octeon: Faster operation when IFLG signals late

 .../devicetree/bindings/i2c/i2c-octeon.txt         |    6 +
 drivers/i2c/busses/i2c-octeon.c                    | 1154 +++++++++++++++-----
 2 files changed, 908 insertions(+), 252 deletions(-)

-- 
1.9.1
