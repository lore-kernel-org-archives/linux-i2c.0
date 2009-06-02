From: Ben Dooks <ben-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Subject: what is in bjdooks' i2c-fixes tree
Date: Tue, 02 Jun 2009 23:45:11 +0100
Message-ID: <E1MBcjH-0003Zr-TI@kira.home.fluff.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit 05ad709d04799125ed85dd816fdb558258102172:
  Alan Cox (1):
        parport: quickfix the proc registration bug

are available in the git repository at:

  git://aeryn.fluff.org.uk/bjdooks/linux.git i2c-fixes-2630-rc7

Aaro Koskinen (2):
      i2c: OMAP2/3: Fix scll/sclh calculations
      i2c: OMAP3: Better noise suppression for fast/standard modes

Frank Shew (1):
      i2c: Blackfin TWI: fix transfer errors with repeat start

Michael Hennerich (2):
      i2c: Blackfin TWI: make sure we don't end up with a CLKDIV=0
      i2c: Blackfin TWI: implement I2C_FUNC_SMBUS_I2C_BLOCK functionality

Sonic Zhang (1):
      i2c: Blackfin TWI: fix REPEAT START mode doesn't repeat

 drivers/i2c/busses/Kconfig        |    2 +-
 drivers/i2c/busses/i2c-bfin-twi.c |   59 +++++++++++++++++++++++++-----------
 drivers/i2c/busses/i2c-omap.c     |   39 +++++++++++++++++++-----
 3 files changed, 72 insertions(+), 28 deletions(-)
