From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH V2 11/13] ARM: bcm: Add support for BCM2711 SoC
Date: Tue, 10 Sep 2019 16:13:35 +0200
Message-ID: <7d270916-df85-ce75-4330-b446bc637ff1@gmail.com>
References: <1565713248-4906-1-git-send-email-wahrenst@gmx.net>
 <1565713248-4906-12-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1565713248-4906-12-git-send-email-wahrenst@gmx.net>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <wahrenst@gmx.net>, Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org



On 13/08/2019 18:20, Stefan Wahren wrote:
> Add the BCM2711 to ARCH_BCM2835, but use new machine board code
> because of the differences.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  arch/arm/mach-bcm/Kconfig   |  3 ++-
>  arch/arm/mach-bcm/Makefile  |  3 ++-
>  arch/arm/mach-bcm/bcm2711.c | 22 ++++++++++++++++++++++
>  3 files changed, 26 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/mach-bcm/bcm2711.c
> 
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index 5e5f1fa..39bcbea 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -161,6 +161,7 @@ config ARCH_BCM2835
>  	select GPIOLIB
>  	select ARM_AMBA
>  	select ARM_ERRATA_411920 if ARCH_MULTI_V6
> +	select ARM_GIC if ARCH_MULTI_V7
>  	select ARM_TIMER_SP804
>  	select HAVE_ARM_ARCH_TIMER if ARCH_MULTI_V7
>  	select TIMER_OF
> @@ -169,7 +170,7 @@ config ARCH_BCM2835
>  	select PINCTRL_BCM2835
>  	select MFD_CORE
>  	help
> -	  This enables support for the Broadcom BCM2835 and BCM2836 SoCs.
> +	  This enables support for the Broadcom BCM2711 and BCM283x SoCs.
>  	  This SoC is used in the Raspberry Pi and Roku 2 devices.
> 
>  config ARCH_BCM_53573
> diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
> index b59c813..7baa8c9 100644
> --- a/arch/arm/mach-bcm/Makefile
> +++ b/arch/arm/mach-bcm/Makefile
> @@ -42,8 +42,9 @@ obj-$(CONFIG_ARCH_BCM_MOBILE_L2_CACHE) += kona_l2_cache.o
>  obj-$(CONFIG_ARCH_BCM_MOBILE_SMC) += bcm_kona_smc.o
> 
>  # BCM2835
> -obj-$(CONFIG_ARCH_BCM2835)	+= board_bcm2835.o
>  ifeq ($(CONFIG_ARCH_BCM2835),y)
> +obj-y				+= board_bcm2835.o
> +obj-y				+= bcm2711.o
>  ifeq ($(CONFIG_ARM),y)
>  obj-$(CONFIG_SMP)		+= platsmp.o
>  endif
> diff --git a/arch/arm/mach-bcm/bcm2711.c b/arch/arm/mach-bcm/bcm2711.c
> new file mode 100644
> index 0000000..1fa15b4
> --- /dev/null
> +++ b/arch/arm/mach-bcm/bcm2711.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2019 Stefan Wahren
> + */
> +
> +#include <linux/of_address.h>
> +
> +#include <asm/mach/arch.h>
> +
> +#include "platsmp.h"
> +
> +static const char * const bcm2711_compat[] = {
> +#ifdef CONFIG_ARCH_MULTI_V7
> +	"brcm,bcm2711",
> +#endif
> +};
> +
> +DT_MACHINE_START(BCM2711, "BCM2711")
> +	.dma_zone_size	= SZ_1G,

Needs a dependency of ifdef CONFIG_ZONE_DMA.

Regards,
Matthias


> +	.dt_compat = bcm2711_compat,
> +	.smp = smp_ops(bcm2836_smp_ops),
> +MACHINE_END
> --
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
