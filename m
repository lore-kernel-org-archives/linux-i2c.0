From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: unmet direct dependencies in -next
Date: Mon, 10 Aug 2015 10:10:04 +0100
Message-ID: <20150810091004.GC3249@x1>
References: <55C71FF5.1020902@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55C71FF5.1020902-/L3Ra7n9ekc@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>
Cc: linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, yann.morin.1998-GANU6spQydw@public.gmane.org, linux-kbuild <linux-kbuild-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "open list:I2C SUBSYSTEM" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, user-mode-linux-devel <user-mode-linux-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, 09 Aug 2015, Richard Weinberger wrote:

> Hi!
>=20
> -next faces some build issues on UML because of unmet direct dependen=
cies.
> Mostly due to HAS_IOMEM and I2C.
>=20
> warning: (MEDIA_SUBDRV_AUTOSELECT && VIDEO_CX231XX && INV_MPU6050_IIO=
) selects I2C_MUX which has unmet direct dependencies (I2C && HAS_IOMEM=
)
> warning: (ST_IRQCHIP && HIP04_ETH && STMMAC_PLATFORM && DWMAC_IPQ806X=
 && DWMAC_LPC18XX && DWMAC_ROCKCHIP && DWMAC_SOCFPGA && DWMAC_STI && TI=
_CPSW && PINCTRL_ROCKCHIP &&
> PINCTRL_DOVE && POWER_RESET_KEYSTONE && POWER_RESET_SYSCON && POWER_R=
ESET_SYSCON_POWEROFF && S3C2410_WATCHDOG && VIDEO_OMAP3 && VIDEO_S5P_FI=
MC && RTC_DRV_AT91SAM9 && VIDEO_OMAP4 &&
> HWSPINLOCK_QCOM && ATMEL_ST && QCOM_GSBI) selects MFD_SYSCON which ha=
s unmet direct dependencies (HAS_IOMEM)
> warning: (MEDIA_SUBDRV_AUTOSELECT && VIDEO_CX231XX && INV_MPU6050_IIO=
) selects I2C_MUX which has unmet direct dependencies (I2C && HAS_IOMEM=
)
> warning: (ST_IRQCHIP && HIP04_ETH && STMMAC_PLATFORM && DWMAC_IPQ806X=
 && DWMAC_LPC18XX && DWMAC_ROCKCHIP && DWMAC_SOCFPGA && DWMAC_STI && TI=
_CPSW && PINCTRL_ROCKCHIP &&
> PINCTRL_DOVE && POWER_RESET_KEYSTONE && POWER_RESET_SYSCON && POWER_R=
ESET_SYSCON_POWEROFF && S3C2410_WATCHDOG && VIDEO_OMAP3 && VIDEO_S5P_FI=
MC && RTC_DRV_AT91SAM9 && VIDEO_OMAP4 &&
> HWSPINLOCK_QCOM && ATMEL_ST && QCOM_GSBI) selects MFD_SYSCON which ha=
s unmet direct dependencies (HAS_IOMEM)
>=20
> For example MFD_SYSCON cannot build on UML as it depends on HAS_IOMEM=
=2E
> While the symbol MFD_SYSCON has correct dependencies some users of MF=
D_SYSCON
> just issue a "select MFD_SYSCON" and bypass the HAS_IOMEM dependency =
and causing the build to fail.
>=20
> This brings me to a question on kconfig itself, wouldn't it be better=
 to just disable a symbol if it has
> unmet direct dependencies?

If this is a question about "kconfig itself", you should probably have
included the correct ML and Maintainer:

KCONFIG
M:      Michal Marek <mmarek-AlSwsSmVLrQ@public.gmane.org>
L:      linux-kbuild-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
S:      Odd Fixes
=46:      Documentation/kbuild/kconfig-language.txt
=46:      scripts/kconfig/

There are also quite a few interested parties on LKML who might be
inclined to submit a fix for you.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
