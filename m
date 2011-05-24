From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [PULL] please pull bjdooks' i2c branch
Date: Wed, 25 May 2011 00:35:27 +0100
Message-ID: <E1QP18J-00083v-DP@freya>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit d762f4383100c2a87b1a3f2d678cd3b5425655b4:

  Merge branch 'sh-latest' of git://git.kernel.org/pub/scm/linux/kernel/git/lethal/sh-2.6 (2011-05-23 21:24:07 -0700)

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-linus/2640/i2c

Ben Dooks (1):
      Merge branches 'for-2639/i2c-eg20t', 'for-2639/i2c-shmobile', 'for-2639/i2c-tegra' and 'for-2639/i2c-nomadik2' into for-linus/2640/i2c

Erik Gilling (1):
      i2c: tegra: fix repeated start handling

Jay Cheng (1):
      i2c: tegra: Add de-bounce cycles.

Jonas Aberg (1):
      i2c-nomadik: add regulator support

Kenneth Waters (1):
      i2c: tegra: Enable new slave mode.

Linus Walleij (3):
      i2c-nomadik: fix speed enumerator
      i2c-nomadik: break out single messsage transmission
      mach-ux500: set proper I2C platform data from MOP500s

Magnus Damm (2):
      i2c: i2c-sh_mobile clock string removal
      i2c: i2c-sh_mobile bus speed platform data V2

Rabin Vincent (1):
      i2c-nomadik: use pm_runtime API

Todd Poynor (1):
      i2c: tegra: recover from spurious interrupt storm

Tomoya MORINAGA (1):
      i2c-eg20t: Support new device ML7223 IOH

Virupax Sadashivpetimath (8):
      i2c-nomadik: make i2c timeout specific per i2c bus
      i2c-nomadik: corrrect returned error numbers
      i2c-nomadik: correct adapter timeout initialization
      i2c-nomadik: print abort cause only on abort tag
      i2c-nomadik: add code to retry on timeout failure
      i2c-nomadik: change the TX and RX threshold
      i2c-nomadik: remove the unnecessary delay
      i2c-nomadik: reset the hw after status check

srinidhi kasagar (1):
      i2c-nomadik: remove the redundant error message

 arch/arm/mach-ux500/board-mop500.c       |   14 +-
 arch/arm/plat-nomadik/include/plat/i2c.h |    8 +-
 drivers/i2c/busses/Kconfig               |   10 +-
 drivers/i2c/busses/i2c-eg20t.c           |    2 +
 drivers/i2c/busses/i2c-nomadik.c         |  276 ++++++++++++++++++++----------
 drivers/i2c/busses/i2c-sh_mobile.c       |   19 ++-
 drivers/i2c/busses/i2c-tegra.c           |   39 ++++-
 include/linux/i2c/i2c-sh_mobile.h        |   10 +
 8 files changed, 263 insertions(+), 115 deletions(-)
 create mode 100644 include/linux/i2c/i2c-sh_mobile.h
