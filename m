From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 0/6] i2c: sh_mobile: cleanups
Date: Thu,  1 May 2014 00:21:04 +0200
Message-ID: <1398896470-24663-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Some cleanups for i2c-sh_mobile. Tested on top of renesas-devel-v3.15-rc3-20140429
and with a lager board. Branch is at

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sh_mobile-cleanup

Wolfram Sang (6):
  i2c: sh_mobile: replace magic hex values with constants
  i2c: sh_mobile: improve error handling
  i2c: sh_mobile: honor DT bus speed settings
  i2c: sh_mobile: add devicetree documentation
  i2c: sh_mobile: devm conversion, low hanging fruits
  i2c: sh_mobile: devm conversion, irq setup

 .../devicetree/bindings/i2c/i2c-sh_mobile.txt      |  26 ++++
 drivers/i2c/busses/i2c-sh_mobile.c                 | 132 +++++++--------------
 2 files changed, 67 insertions(+), 91 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt

-- 
1.9.2

