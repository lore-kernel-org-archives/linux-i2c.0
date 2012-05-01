From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: =?UTF-8?q?=5BPATCH=200/4=5D=20MXS=3A=20I2C=20improvements?=
Date: Tue,  1 May 2012 04:00:17 +0200
Message-ID: <1335837621-14816-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patchset implements support for adjustment of I2C bus speed via pl=
atform
data. Further, it implements support for DMA transfers into the mxs-i2c=
 driver.
Lastly, there is a fix for GCC4.7 warning included.

Marek Vasut (4):
  MXS: Allow passing i2c bus speed via platform data
  MXS: Set I2C timing registers for mxs-i2c
  MXS: Implement DMA support into mxs-i2c
  MXS: Fix GCC4.7 complaint in mxs-i2c

 arch/arm/mach-mxs/devices-mx28.h                |    3 +-
 arch/arm/mach-mxs/devices/platform-mxs-i2c.c    |   14 +-
 arch/arm/mach-mxs/include/mach/devices-common.h |    5 +-
 arch/arm/mach-mxs/mach-apx4devkit.c             |    7 +-
 arch/arm/mach-mxs/mach-m28evk.c                 |    8 +-
 arch/arm/mach-mxs/mach-mx28evk.c                |    7 +-
 arch/arm/mach-mxs/mach-tx28.c                   |    7 +-
 drivers/i2c/busses/i2c-mxs.c                    |  304 +++++++++++++++=
++++++--
 include/linux/i2c/mxs-i2c.h                     |   22 ++
 9 files changed, 343 insertions(+), 34 deletions(-)
 create mode 100644 include/linux/i2c/mxs-i2c.h

Cc: Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>
CC: Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
CC: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
CC: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
CC: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
CC: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

--=20
1.7.10
