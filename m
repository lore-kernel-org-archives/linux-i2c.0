From: Richard Weinberger <richard@nod.at>
Subject: Re: unmet direct dependencies in -next
Date: Sat, 2 Jan 2016 23:01:42 +0100
Message-ID: <568848C6.20308@nod.at>
References: <55C71FF5.1020902@nod.at> <20150810091004.GC3249@x1>
 <55C86B66.3020601@nod.at> <55C88738.80400@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from a.ns.miles-group.at ([95.130.255.143]:11949 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751949AbcABWBq (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 2 Jan 2016 17:01:46 -0500
In-Reply-To: <55C88738.80400@suse.cz>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Michal Marek <mmarek@suse.cz>, Lee Jones <lee.jones@linaro.org>
Cc: linux-next@vger.kernel.org, sameo@linux.intel.com, Arnd Bergmann <arnd@arndb.de>, yann.morin.1998@free.fr, linux-kbuild <linux-kbuild@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

Am 10.08.2015 um 13:12 schrieb Michal Marek:
> On 2015-08-10 11:14, Richard Weinberger wrote:
>> Am 10.08.2015 um 11:10 schrieb Lee Jones:
>>> On Sun, 09 Aug 2015, Richard Weinberger wrote:
>>>
>>>> Hi!
>>>>
>>>> -next faces some build issues on UML because of unmet direct dependencies.
>>>> Mostly due to HAS_IOMEM and I2C.
>>>>
>>>> warning: (MEDIA_SUBDRV_AUTOSELECT && VIDEO_CX231XX && INV_MPU6050_IIO) selects I2C_MUX which has unmet direct dependencies (I2C && HAS_IOMEM)
>>>> warning: (ST_IRQCHIP && HIP04_ETH && STMMAC_PLATFORM && DWMAC_IPQ806X && DWMAC_LPC18XX && DWMAC_ROCKCHIP && DWMAC_SOCFPGA && DWMAC_STI && TI_CPSW && PINCTRL_ROCKCHIP &&
>>>> PINCTRL_DOVE && POWER_RESET_KEYSTONE && POWER_RESET_SYSCON && POWER_RESET_SYSCON_POWEROFF && S3C2410_WATCHDOG && VIDEO_OMAP3 && VIDEO_S5P_FIMC && RTC_DRV_AT91SAM9 && VIDEO_OMAP4 &&
>>>> HWSPINLOCK_QCOM && ATMEL_ST && QCOM_GSBI) selects MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)
>>>> warning: (MEDIA_SUBDRV_AUTOSELECT && VIDEO_CX231XX && INV_MPU6050_IIO) selects I2C_MUX which has unmet direct dependencies (I2C && HAS_IOMEM)
>>>> warning: (ST_IRQCHIP && HIP04_ETH && STMMAC_PLATFORM && DWMAC_IPQ806X && DWMAC_LPC18XX && DWMAC_ROCKCHIP && DWMAC_SOCFPGA && DWMAC_STI && TI_CPSW && PINCTRL_ROCKCHIP &&
>>>> PINCTRL_DOVE && POWER_RESET_KEYSTONE && POWER_RESET_SYSCON && POWER_RESET_SYSCON_POWEROFF && S3C2410_WATCHDOG && VIDEO_OMAP3 && VIDEO_S5P_FIMC && RTC_DRV_AT91SAM9 && VIDEO_OMAP4 &&
>>>> HWSPINLOCK_QCOM && ATMEL_ST && QCOM_GSBI) selects MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)
>>>>
>>>> For example MFD_SYSCON cannot build on UML as it depends on HAS_IOMEM.
>>>> While the symbol MFD_SYSCON has correct dependencies some users of MFD_SYSCON
>>>> just issue a "select MFD_SYSCON" and bypass the HAS_IOMEM dependency and causing the build to fail.
>>>>
>>>> This brings me to a question on kconfig itself, wouldn't it be better to just disable a symbol if it has
>>>> unmet direct dependencies?

FYI, -next is still facing:
warning: (ST_IRQCHIP && HIP04_ETH && STMMAC_PLATFORM && DWMAC_IPQ806X && DWMAC_LPC18XX && DWMAC_ROCKCHIP && DWMAC_SOCFPGA && DWMAC_STI && TI_CPSW && PINCTRL_ROCKCHIP &&
PINCTRL_DOVE && POWER_RESET_KEYSTONE && POWER_RESET_SYSCON && POWER_RESET_SYSCON_POWEROFF && S3C2410_WATCHDOG && VIDEO_OMAP3 && VIDEO_S5P_FIMC && USB_XHCI_MTK && RTC_DRV_AT91SAM9
&& LPC18XX_DMAMUX && VIDEO_OMAP4 && HWSPINLOCK_QCOM && ATMEL_ST && QCOM_GSBI && PHY_HI6220_USB) selects MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)
warning: (MEDIA_SUBDRV_AUTOSELECT && VIDEO_CX231XX && INV_MPU6050_IIO) selects I2C_MUX which has unmet direct dependencies (I2C && HAS_IOMEM)

Thanks,
//richard
