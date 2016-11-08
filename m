From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 1/3] i2c: pxa: Add support for the I2C units found in Armada 3700
Date: Tue, 08 Nov 2016 16:44:11 +0100
Message-ID: <87lgwum0xg.fsf@free-electrons.com>
References: <20161108151506.1131-1-romain.perier@free-electrons.com>
        <20161108151506.1131-2-romain.perier@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from up.free-electrons.com ([163.172.77.33]:49734 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751226AbcKHPoO (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 8 Nov 2016 10:44:14 -0500
In-Reply-To: <20161108151506.1131-2-romain.perier@free-electrons.com> (Romain
        Perier's message of "Tue, 8 Nov 2016 16:15:04 +0100")
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Romain Perier <romain.perier@free-electrons.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Omri Itach <omrii@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Yahuda Yitschak <yehuday@marvell.com>, Hanna Hawa <hannah@marvell.com>, Neta Zur Hershkovits <neta@marvell.com>, Igal Liberman <igall@marvell.com>, Marcin Wojtas <mw@semihalf.com>

Hi Romain,
 
 On mar., nov. 08 2016, Romain Perier <romain.perier@free-electrons.com> wrote:

> The Armada 3700 has two I2C controllers that is compliant with the I2C
> Bus Specificiation 2.1, supports multi-master and different bus speed:
> Standard mode (up to 100 KHz), Fast mode (up to 400 KHz),
> High speed mode (up to 3.4 Mhz).
>
> This IP block has a lot of similarity with the PXA, except some register
> offsets and bitfield. This commits adds a basic support for this I2C
> unit.

On the Armada 3720 DB board I manged to run i2cdetect and did some
i2cdump successfully.

Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

During the kernel init I got a:
pxa2xx-i2c d0011000.i2c: failed to get the clk: -517

Maybe an improvement of the driver could be to not output this message
in case of EPROBE_DEFER. Or at least an other message less scary.

Thanks,

Gregory

>
> Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
> ---
>  drivers/i2c/busses/Kconfig   |  2 +-
>  drivers/i2c/busses/i2c-pxa.c | 25 +++++++++++++++++++++++--
>  2 files changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index d252276..2f56a26 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -763,7 +763,7 @@ config I2C_PUV3
>  
>  config I2C_PXA
>  	tristate "Intel PXA2XX I2C adapter"
> -	depends on ARCH_PXA || ARCH_MMP || (X86_32 && PCI && OF)
> +	depends on ARCH_PXA || ARCH_MMP || ARCH_MVEBU || (X86_32 && PCI && OF)
>  	help
>  	  If you have devices in the PXA I2C bus, say yes to this option.
>  	  This driver can also be built as a module.  If so, the module
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index e28b825..34ea830 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -55,6 +55,7 @@ enum pxa_i2c_types {
>  	REGS_PXA3XX,
>  	REGS_CE4100,
>  	REGS_PXA910,
> +	REGS_A3700,
>  };
>  
>  /*
> @@ -91,6 +92,13 @@ static struct pxa_reg_layout pxa_reg_layout[] = {
>  		.ilcr = 0x28,
>  		.iwcr = 0x30,
>  	},
> +	[REGS_A3700] = {
> +		.ibmr = 0x00,
> +		.idbr = 0x04,
> +		.icr =	0x08,
> +		.isr =	0x0c,
> +		.isar = 0x10,
> +	},
>  };
>  
>  static const struct platform_device_id i2c_pxa_id_table[] = {
> @@ -98,6 +106,7 @@ static const struct platform_device_id i2c_pxa_id_table[] = {
>  	{ "pxa3xx-pwri2c",	REGS_PXA3XX },
>  	{ "ce4100-i2c",		REGS_CE4100 },
>  	{ "pxa910-i2c",		REGS_PXA910 },
> +	{ "armada-3700-i2c",	REGS_A3700  },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(platform, i2c_pxa_id_table);
> @@ -122,7 +131,9 @@ MODULE_DEVICE_TABLE(platform, i2c_pxa_id_table);
>  #define ICR_SADIE	(1 << 13)	   /* slave address detected int enable */
>  #define ICR_UR		(1 << 14)	   /* unit reset */
>  #define ICR_FM		(1 << 15)	   /* fast mode */
> +#define ICR_BUSMODE_FM	(1 << 16)	   /* shifted fast mode for armada-3700 */
>  #define ICR_HS		(1 << 16)	   /* High Speed mode */
> +#define ICR_BUSMODE_HS	(1 << 17)	   /* shifted high speed mode for armada-3700 */
>  #define ICR_GPIOEN	(1 << 19)	   /* enable GPIO mode for SCL in HS */
>  
>  #define ISR_RWM		(1 << 0)	   /* read/write mode */
> @@ -193,6 +204,8 @@ struct pxa_i2c {
>  	unsigned char		master_code;
>  	unsigned long		rate;
>  	bool			highmode_enter;
> +	unsigned long		fm_mask;
> +	unsigned long		hs_mask;
>  };
>  
>  #define _IBMR(i2c)	((i2c)->reg_ibmr)
> @@ -503,8 +516,8 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
>  		writel(i2c->slave_addr, _ISAR(i2c));
>  
>  	/* set control register values */
> -	writel(I2C_ICR_INIT | (i2c->fast_mode ? ICR_FM : 0), _ICR(i2c));
> -	writel(readl(_ICR(i2c)) | (i2c->high_mode ? ICR_HS : 0), _ICR(i2c));
> +	writel(I2C_ICR_INIT | (i2c->fast_mode ? i2c->fm_mask : 0), _ICR(i2c));
> +	writel(readl(_ICR(i2c)) | (i2c->high_mode ? i2c->hs_mask : 0), _ICR(i2c));
>  
>  #ifdef CONFIG_I2C_PXA_SLAVE
>  	dev_info(&i2c->adap.dev, "Enabling slave mode\n");
> @@ -1137,6 +1150,7 @@ static const struct of_device_id i2c_pxa_dt_ids[] = {
>  	{ .compatible = "mrvl,pxa-i2c", .data = (void *)REGS_PXA2XX },
>  	{ .compatible = "mrvl,pwri2c", .data = (void *)REGS_PXA3XX },
>  	{ .compatible = "mrvl,mmp-twsi", .data = (void *)REGS_PXA910 },
> +	{ .compatible = "marvell,armada-3700-i2c", .data = (void *)REGS_A3700 },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, i2c_pxa_dt_ids);
> @@ -1158,6 +1172,13 @@ static int i2c_pxa_probe_dt(struct platform_device *pdev, struct pxa_i2c *i2c,
>  		i2c->use_pio = 1;
>  	if (of_get_property(np, "mrvl,i2c-fast-mode", NULL))
>  		i2c->fast_mode = 1;
> +	if (of_device_is_compatible(np, "marvell,armada-3700-i2c")) {
> +		i2c->fm_mask = ICR_BUSMODE_FM;
> +		i2c->hs_mask = ICR_BUSMODE_HS;
> +	} else {
> +		i2c->fm_mask = ICR_FM;
> +		i2c->hs_mask = ICR_HS;
> +	}
>  
>  	*i2c_types = (enum pxa_i2c_types)(of_id->data);
>  
> -- 
> 2.9.3
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
