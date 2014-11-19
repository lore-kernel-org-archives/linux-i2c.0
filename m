From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] Immutable branch between MFD, GPIO and I2C (Second batch)
Date: Wed, 19 Nov 2014 17:34:01 +0000
Message-ID: <20141119173401.GL1875@x1>
References: <1416315480-2053-1-git-send-email-octavian.purdila@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1416315480-2053-1-git-send-email-octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, julia.lawall-L2FTfq7BK8M@public.gmane.org, dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Linus, Wolfram,

Second instalment.  Enjoy!

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c3=
55e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd=
-gpio-i2c-v3.19-1

for you to fetch changes up to 2fc2b4846c14c8c2d2c6e9114b4548f846521cfb=
:

  mfd: dln2: A couple endian fixes (2014-11-19 17:12:59 +0000)

----------------------------------------------------------------
Immutable branch between MFD, GPIO and I2C due for v3.19.

This is the second such tag, due to more patches (fixes) added.

----------------------------------------------------------------
Dan Carpenter (1):
      mfd: dln2: A couple endian fixes

Daniel Baluta (1):
      gpio: add support for the Diolan DLN-2 USB GPIO driver

Johan Hovold (1):
      mfd: core: Add helper function to register hotplug devices

Laurentiu Palcu (1):
      i2c: add support for Diolan DLN-2 USB-I2C adapter

Octavian Purdila (4):
      mfd: Add support for Diolan DLN-2 devices
      mfd: dln2: Fix _dln2_transfer return code
      i2c: dln2: Simplify return flow for dln2_i2c_enable
      mfd: dln2: Add a limit check for invalid echo

 drivers/gpio/Kconfig          |  12 +
 drivers/gpio/Makefile         |   1 +
 drivers/gpio/gpio-dln2.c      | 553 ++++++++++++++++++++++++++++++
 drivers/i2c/busses/Kconfig    |  10 +
 drivers/i2c/busses/Makefile   |   1 +
 drivers/i2c/busses/i2c-dln2.c | 262 ++++++++++++++
 drivers/mfd/Kconfig           |  10 +
 drivers/mfd/Makefile          |   1 +
 drivers/mfd/dln2.c            | 769 ++++++++++++++++++++++++++++++++++=
++++++++
 include/linux/mfd/core.h      |   7 +
 include/linux/mfd/dln2.h      | 103 ++++++
 11 files changed, 1729 insertions(+)
 create mode 100644 drivers/gpio/gpio-dln2.c
 create mode 100644 drivers/i2c/busses/i2c-dln2.c
 create mode 100644 drivers/mfd/dln2.c
 create mode 100644 include/linux/mfd/dln2.h

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
