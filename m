From: Michal Marek <mmarek-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: unmet direct dependencies in -next
Date: Mon, 10 Aug 2015 13:12:56 +0200
Message-ID: <55C88738.80400@suse.cz>
References: <55C71FF5.1020902@nod.at> <20150810091004.GC3249@x1>
 <55C86B66.3020601@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55C86B66.3020601-/L3Ra7n9ekc@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, yann.morin.1998-GANU6spQydw@public.gmane.org, linux-kbuild <linux-kbuild-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "open list:I2C SUBSYSTEM" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, user-mode-linux-devel <user-mode-linux-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 2015-08-10 11:14, Richard Weinberger wrote:
> Am 10.08.2015 um 11:10 schrieb Lee Jones:
>> On Sun, 09 Aug 2015, Richard Weinberger wrote:
>>
>>> Hi!
>>>
>>> -next faces some build issues on UML because of unmet direct dependencies.
>>> Mostly due to HAS_IOMEM and I2C.
>>>
>>> warning: (MEDIA_SUBDRV_AUTOSELECT && VIDEO_CX231XX && INV_MPU6050_IIO) selects I2C_MUX which has unmet direct dependencies (I2C && HAS_IOMEM)
>>> warning: (ST_IRQCHIP && HIP04_ETH && STMMAC_PLATFORM && DWMAC_IPQ806X && DWMAC_LPC18XX && DWMAC_ROCKCHIP && DWMAC_SOCFPGA && DWMAC_STI && TI_CPSW && PINCTRL_ROCKCHIP &&
>>> PINCTRL_DOVE && POWER_RESET_KEYSTONE && POWER_RESET_SYSCON && POWER_RESET_SYSCON_POWEROFF && S3C2410_WATCHDOG && VIDEO_OMAP3 && VIDEO_S5P_FIMC && RTC_DRV_AT91SAM9 && VIDEO_OMAP4 &&
>>> HWSPINLOCK_QCOM && ATMEL_ST && QCOM_GSBI) selects MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)
>>> warning: (MEDIA_SUBDRV_AUTOSELECT && VIDEO_CX231XX && INV_MPU6050_IIO) selects I2C_MUX which has unmet direct dependencies (I2C && HAS_IOMEM)
>>> warning: (ST_IRQCHIP && HIP04_ETH && STMMAC_PLATFORM && DWMAC_IPQ806X && DWMAC_LPC18XX && DWMAC_ROCKCHIP && DWMAC_SOCFPGA && DWMAC_STI && TI_CPSW && PINCTRL_ROCKCHIP &&
>>> PINCTRL_DOVE && POWER_RESET_KEYSTONE && POWER_RESET_SYSCON && POWER_RESET_SYSCON_POWEROFF && S3C2410_WATCHDOG && VIDEO_OMAP3 && VIDEO_S5P_FIMC && RTC_DRV_AT91SAM9 && VIDEO_OMAP4 &&
>>> HWSPINLOCK_QCOM && ATMEL_ST && QCOM_GSBI) selects MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)
>>>
>>> For example MFD_SYSCON cannot build on UML as it depends on HAS_IOMEM.
>>> While the symbol MFD_SYSCON has correct dependencies some users of MFD_SYSCON
>>> just issue a "select MFD_SYSCON" and bypass the HAS_IOMEM dependency and causing the build to fail.
>>>
>>> This brings me to a question on kconfig itself, wouldn't it be better to just disable a symbol if it has
>>> unmet direct dependencies?

The result of the given .config does not matter as much. The point of
the warnings is that there are missing select statements in the Kconfig
files.

Michal
