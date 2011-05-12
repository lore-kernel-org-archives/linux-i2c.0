From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: bjdooks' current i2c-next
Date: Fri, 13 May 2011 00:10:10 +0100
Message-ID: <20110512231010.GA28162@freya.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is the current state of my -next tree, if there's anything that
people think should be added, replaced or removed then please let me
know.

The following changes since commit ca1376d10810bc2c20c8d0821a9ee04ca2507c01:

  Merge branch 'fix/asoc' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6 (2011-05-12 12:41:30 -0700)

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git next-i2c

Ben Dooks (2):
      Merge branches 'for-2639/i2c-shmobile', 'for-2639/i2c-eg20t' and 'for-2639/i2c-tegra' into next-i2c
      Merge branch 'for-2639/i2c-nomadik' into next-i2c

Erik Gilling (1):
      i2c: tegra: fix repeated start handling

Jay Cheng (1):
      i2c: tegra: Add de-bounce cycles.

Jonas Aberg (1):
      i2c/i2c-nomadik: add regulator support

Kenneth Waters (1):
      i2c: tegra: Enable new slave mode.

Linus Walleij (1):
      i2c/i2c-nomadik: fix speed enumerator

Magnus Damm (2):
      i2c: i2c-sh_mobile clock string removal
      i2c: i2c-sh_mobile bus speed platform data V2

Rabin Vincent (1):
      i2c/i2c-nomadik: use pm_runtime API

Todd Poynor (1):
      i2c: tegra: recover from spurious interrupt storm

Tomoya MORINAGA (1):
      i2c-eg20t: Support new device ML7223 IOH

Virupax Sadashivpetimath (8):
      i2c/i2c-nomadik: make i2c timeout specific per i2c bus
      i2c/i2c-nomadik: corrrect returned error numbers
      i2c/i2c-nomadik: correct adapter timeout initialization
      i2c/i2c-nomadik: print abort cause only on abort tag
      i2c/i2c-nomadik: add code to retry on timeout failure
      i2c/i2c-nomadik: change the TX and RX threshold
      i2c/i2c-nomadik: remove the unnecessary delay
      i2c/i2c-nomadik: reset the hw after status check

srinidhi kasagar (1):
      i2c/i2c-nomadik: remove the redundant error message

 arch/arm/plat-nomadik/include/plat/i2c.h |    8 +-
 drivers/i2c/busses/Kconfig               |   10 +-
 drivers/i2c/busses/i2c-eg20t.c           |    2 +
 drivers/i2c/busses/i2c-nomadik.c         |  272 ++++++++++++++++++++----------
 drivers/i2c/busses/i2c-sh_mobile.c       |   19 ++-
 drivers/i2c/busses/i2c-tegra.c           |   39 ++++-
 include/linux/i2c/i2c-sh_mobile.h        |   10 +
 7 files changed, 252 insertions(+), 108 deletions(-)
 create mode 100644 include/linux/i2c/i2c-sh_mobile.h
