From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/3] Blackfin I2C updates for 2.6.31
Date: Wed, 27 May 2009 02:20:07 -0400
Message-ID: <1243405210-26227-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Fixes for bugs in the Blackfin on-chip I2C controller.

Frank Shew (1):
  Blackfin I2C/TWI Drivers: fix bug - not work well on BF537

Michael Hennerich (1):
  Blackfin I2C/TWI Driver: make sure we don't end up with a CLKDIV=0

Sonic Zhang (1):
  Blackfin I2C TWI Driver: fix bug - REPEAT START mode doesn't repeat

 drivers/i2c/busses/Kconfig        |    2 +-
 drivers/i2c/busses/i2c-bfin-twi.c |   47 +++++++++++++++++++++++-------------
 2 files changed, 31 insertions(+), 18 deletions(-)
