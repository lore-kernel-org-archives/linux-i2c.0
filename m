From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 0/4] MXS: I2C improvements
Date: Tue, 1 May 2012 04:05:23 +0200
Message-ID: <201205010405.23362.marex@denx.de>
References: <1335837621-14816-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1335837621-14816-1-git-send-email-marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> This patchset implements support for adjustment of I2C bus speed via
> platform data. Further, it implements support for DMA transfers into =
the
> mxs-i2c driver. Lastly, there is a fix for GCC4.7 warning included.

btw. this patchset is also available here:

http://git.kernel.org/?p=3Dlinux/kernel/git/marex/linux-2.6.git;a=3Dsho=
rtlog;h=3Drefs/heads/mxs-
i2c

>=20
> Marek Vasut (4):
>   MXS: Allow passing i2c bus speed via platform data
>   MXS: Set I2C timing registers for mxs-i2c
>   MXS: Implement DMA support into mxs-i2c
>   MXS: Fix GCC4.7 complaint in mxs-i2c
>=20
>  arch/arm/mach-mxs/devices-mx28.h                |    3 +-
>  arch/arm/mach-mxs/devices/platform-mxs-i2c.c    |   14 +-
>  arch/arm/mach-mxs/include/mach/devices-common.h |    5 +-
>  arch/arm/mach-mxs/mach-apx4devkit.c             |    7 +-
>  arch/arm/mach-mxs/mach-m28evk.c                 |    8 +-
>  arch/arm/mach-mxs/mach-mx28evk.c                |    7 +-
>  arch/arm/mach-mxs/mach-tx28.c                   |    7 +-
>  drivers/i2c/busses/i2c-mxs.c                    |  304
> +++++++++++++++++++++-- include/linux/i2c/mxs-i2c.h                  =
   |=20
>  22 ++
>  9 files changed, 343 insertions(+), 34 deletions(-)
>  create mode 100644 include/linux/i2c/mxs-i2c.h
>=20
> Cc: Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>
> CC: Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> CC: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Cc: Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> CC: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> CC: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
> CC: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
> Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Best regards,
Marek Vasut
