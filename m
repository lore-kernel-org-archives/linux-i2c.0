From: Ben Dooks <ben-linuxn-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: current state of bjdooks' i2c-next
Date: Wed, 11 Aug 2010 00:42:10 +0100
Message-ID: <20100810234210.GA17321@ben-laptop.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

These are the current patches queued.

I will look at new driver submissions for post -rc1 to ensure we get
fixes/change in as soon as possible. Anything misisng, please ensure
any reposts are CC'd to ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org

The following changes since commit 45d7f32c7a43cbb9592886d38190e379e2eb2226:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../cmetcalf/linux-tile

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git next-i2c

Ben Dooks (4):
      Merge branch 'davinci-i2c' of git://git.kernel.org/.../khilman/linux-davinci into for-2636/i2c/davinci
      Merge branch 'for-2636/i2c/pxa' into next-i2c
      Merge branch 'for-2636/i2c/nxp' into next-i2c
      Merge branch 'for-2636/i2c/nuc' into next-i2c

Chaithrika U S (4):
      i2c: davinci: misc. cleanups: remove MOD_REG_BIT and IO_ADDRESS usage
      i2c: davinci: Add helper functions for power management
      i2c: davinci: Add suspend/resume support
      i2c: davinci: Add cpufreq support

Dirk Behme (1):
      i2c: davinci: Fix smbus Oops with AIC33 usage

Kevin Wells (1):
      i2c: Enable NXP LPC support in Kconfig

Marc Kleine-Budde (1):
      i2c-pxa: fix compiler warning, due to missing const

Philby John (1):
      i2c: davinci: bus recovery procedure to clear the bus

Wan ZongShun (1):
      i2c/nuc900: add i2c driver support for nuc900

 arch/arm/mach-w90x900/include/mach/i2c.h |    9 +
 drivers/i2c/busses/Kconfig               |   11 +-
 drivers/i2c/busses/Makefile              |    1 +
 drivers/i2c/busses/i2c-davinci.c         |  314 +++++++++++---
 drivers/i2c/busses/i2c-nuc900.c          |  709 ++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-pxa.c             |    2 +-
 6 files changed, 980 insertions(+), 66 deletions(-)
 create mode 100644 arch/arm/mach-w90x900/include/mach/i2c.h
 create mode 100644 drivers/i2c/busses/i2c-nuc900.c
