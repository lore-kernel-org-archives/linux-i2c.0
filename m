From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c updates for 2.6.37
Date: Sun, 24 Oct 2010 20:17:52 +0200
Message-ID: <20101024201752.68cd9404@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull i2c subsystem updates for Linux 2.6.37 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

 MAINTAINERS                           |    6 +
 drivers/gpu/drm/nouveau/nouveau_i2c.h |    1 -
 drivers/gpu/drm/radeon/radeon_mode.h  |    1 -
 drivers/i2c/Kconfig                   |    3 +-
 drivers/i2c/Makefile                  |    4 +-
 drivers/i2c/algos/Kconfig             |   12 +
 drivers/i2c/algos/Makefile            |    4 +-
 drivers/i2c/busses/Makefile           |    4 +-
 drivers/i2c/busses/i2c-amd8111.c      |  163 +++++++++----
 drivers/i2c/busses/i2c-ibm_iic.c      |    1 -
 drivers/i2c/busses/i2c-nuc900.c       |    1 -
 drivers/i2c/busses/i2c-pca-platform.c |    2 +-
 drivers/i2c/busses/i2c-pxa.c          |    1 -
 drivers/i2c/busses/i2c-s3c2410.c      |    1 -
 drivers/i2c/busses/i2c-viapro.c       |    8 +-
 drivers/i2c/i2c-core.c                |   45 ++--
 drivers/i2c/i2c-dev.c                 |   13 +-
 drivers/i2c/muxes/Kconfig             |   10 +
 drivers/i2c/muxes/Makefile            |    5 +-
 drivers/i2c/muxes/pca9541.c           |  411 +++++++++++++++++++++++++++++++++
 drivers/i2c/muxes/pca954x.c           |    8 +-
 drivers/video/aty/radeon_i2c.c        |    1 -
 drivers/video/i810/i810.h             |    1 -
 drivers/video/intelfb/intelfb_i2c.c   |    1 -
 drivers/video/savage/savagefb.h       |    1 -
 include/linux/i2c.h                   |   12 +-
 26 files changed, 603 insertions(+), 117 deletions(-)
 create mode 100644 drivers/i2c/muxes/pca9541.c

---------------

Guenter Roeck (3):
      i2c/mux: Driver for PCA9541 I2C Master Selector
      MAINTAINERS: Add maintainer for PCA9541 I2C bus master selector driver
      i2c/pca954x: Remove __devinit and __devexit from probe and remove functions

Jean Delvare (7):
      i2c: Fix Kconfig dependencies
      i2c: Simplify i2c_parent_is_i2c_adapter
      i2c: Let i2c_parent_is_i2c_adapter return the parent adapter
      i2c: Remove unneeded inclusions of <linux/i2c-id.h>
      i2c: Discard warning message on device instantiation from user-space
      i2c: Optimize function i2c_detect()
      i2c-viapro: Don't log nacks

Julia Lawall (1):
      i2c-amd8111: Add proper error handling

Nobuhiro Iwamatsu (1):
      i2c-pca-platform: Change device name of request_irq

matt mooney (1):
      i2c: Change to new flag variable

Thanks,
-- 
Jean Delvare
