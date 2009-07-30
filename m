From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Please pull bjdooks' i2c-fixes
Date: Thu, 30 Jul 2009 01:06:48 +0100
Message-ID: <E1MWJAW-0002kW-Ul@kira.home.fluff.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit f5886c7f96f2542382d3a983c5f13e03d7fc5259:
  Catalin Marinas (1):
        kmemleak: Protect the seq start/next/stop sequence by rcu_read_lock()

are available in the git repository at:

  git://aeryn.fluff.org.uk/bjdooks/linux.git i2c-fixes-rc4

Magnus Damm (1):
      i2c-sh_mobile: change module_init() to subsys_initcall()

Peter Korsgaard (1):
      i2c-s3c2410: s3c24xx_i2c_init: don't clobber IICLC value

Roel Kluin (1):
      i2c: strncpy does not null terminate string

Sonasath, Moiz (3):
      i2c-omap: Bug in reading the RXSTAT/TXSTAT values from the I2C_BUFFSTAT register
      i2c-omap: In case of a NACK|ARDY|AL return from the ISR
      i2c-omap: OMAP3430 Silicon Errata 1.153

 drivers/i2c/busses/i2c-omap.c      |   42 +++++++++++++++++++++++++++++------
 drivers/i2c/busses/i2c-s3c2410.c   |    5 ----
 drivers/i2c/busses/i2c-sh_mobile.c |    2 +-
 3 files changed, 35 insertions(+), 14 deletions(-)
