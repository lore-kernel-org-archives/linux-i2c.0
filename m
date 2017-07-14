From: Boszormenyi Zoltan <zboszor-v1d7l9VOqKc@public.gmane.org>
Subject: Re: [PATCH 5/5 v4] watchdog: sp5100_tco: Use
 request_declared_muxed_region()
Date: Fri, 14 Jul 2017 10:34:53 +0200
Message-ID: <343c2024-78c9-4093-06b1-f017fe8d9043@pr.hu>
References: <20170621035349.4125-1-zboszor@pr.hu>
 <20170622132134.7200-1-zboszor@pr.hu> <20170622132134.7200-6-zboszor@pr.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170622132134.7200-6-zboszor-v1d7l9VOqKc@public.gmane.org>
Content-Language: en-US
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Menzel <paulepanter-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Christian Fetzer <fetzer.ch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Nehal Shah <nehal-bakulchandra.shah-5C7GfCeVMHo@public.gmane.org>, Tim Small <tim-v0yPK6tSSg/10XsdtD+oqA@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, kernel-i2qG/+7/Q79eoWH0uzbU5w@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, jlayton-vpEMnDpepFuMZCB2o+C8xQ@public.gmane.org, marc.2377-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, cshorler-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, regressions-rCxcAJFjeRkk+I/owrrOrA@public.gmane.org, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Toshi Kani <toshi.kani-ZPxbGqLxI0U@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jakub Sitnicki <jsitnicki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Vive
List-Id: linux-i2c@vger.kernel.org

2017-06-22 15:21 keltezéssel, Zoltán Böszörményi írta:
> Use the new request_declared_muxed_region() macro to synchronize
> accesses to the SB800 I/O port pair (0xcd6 / 0xcd7) with the
> PCI quirk for isochronous USB transfers and with the i2c-piix4
> driver.
> 
> At the same time, remove the long lifetime request_region() call
> to reserve these I/O ports, similarly to i2c-piix4 so the code is
> now uniform across the three drivers.
> 
> v1: Started with a common mutex in a C source file.
> 
> v2: Referenced the common mutex from drivers/usb/host/pci-quirks.c
> 
> v3: Switched to using the new request_declared_muxed_region
>      macro.
> 
> v4: Fixed checkpatch.pl warnings and use the new
>      release_declared_region() macro.
> 
> Signed-off-by: Zoltán Böszörményi <zboszor-v1d7l9VOqKc@public.gmane.org>
> ---
>   drivers/watchdog/sp5100_tco.c | 28 +++++++++++++++-------------
>   1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
> index 028618c..cb42b72 100644
> --- a/drivers/watchdog/sp5100_tco.c
> +++ b/drivers/watchdog/sp5100_tco.c
> @@ -48,7 +48,6 @@
>   static u32 tcobase_phys;
>   static u32 tco_wdt_fired;
>   static void __iomem *tcobase;
> -static unsigned int pm_iobase;
>   static DEFINE_SPINLOCK(tco_lock);	/* Guards the hardware */
>   static unsigned long timer_alive;
>   static char tco_expect_close;
> @@ -70,6 +69,11 @@ module_param(nowayout, bool, 0);
>   MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started."
>   		" (default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>   
> +/* synchronized access to the I/O port pair */
> +static struct resource sp5100_res = DEFINE_RES_IO_NAMED(SB800_IO_PM_INDEX_REG,
> +						SP5100_PM_IOPORTS_SIZE,
> +						TCO_MODULE_NAME);
> +
>   /*
>    * Some TCO specific functions
>    */
> @@ -139,6 +143,7 @@ static void tco_timer_enable(void)
>   	if (!tco_has_sp5100_reg_layout(sp5100_tco_pci)) {
>   		/* For SB800 or later */
>   		/* Set the Watchdog timer resolution to 1 sec */
> +		request_declared_muxed_region(&sp5100_res);
>   		outb(SB800_PM_WATCHDOG_CONFIG, SB800_IO_PM_INDEX_REG);
>   		val = inb(SB800_IO_PM_DATA_REG);
>   		val |= SB800_PM_WATCHDOG_SECOND_RES;
> @@ -150,6 +155,7 @@ static void tco_timer_enable(void)
>   		val |= SB800_PCI_WATCHDOG_DECODE_EN;
>   		val &= ~SB800_PM_WATCHDOG_DISABLE;
>   		outb(val, SB800_IO_PM_DATA_REG);
> +		release_declared_region(&sp5100_res);
>   	} else {
>   		/* For SP5100 or SB7x0 */
>   		/* Enable watchdog decode bit */
> @@ -164,11 +170,13 @@ static void tco_timer_enable(void)
>   				       val);
>   
>   		/* Enable Watchdog timer and set the resolution to 1 sec */
> +		request_declared_muxed_region(&sp5100_res);
>   		outb(SP5100_PM_WATCHDOG_CONTROL, SP5100_IO_PM_INDEX_REG);
>   		val = inb(SP5100_IO_PM_DATA_REG);
>   		val |= SP5100_PM_WATCHDOG_SECOND_RES;
>   		val &= ~SP5100_PM_WATCHDOG_DISABLE;
>   		outb(val, SP5100_IO_PM_DATA_REG);
> +		release_declared_region(&sp5100_res);
>   	}
>   }
>   
> @@ -361,16 +369,10 @@ static unsigned char sp5100_tco_setupdevice(void)
>   		base_addr = SB800_PM_WATCHDOG_BASE;
>   	}
>   
> -	/* Request the IO ports used by this driver */
> -	pm_iobase = SP5100_IO_PM_INDEX_REG;
> -	if (!request_region(pm_iobase, SP5100_PM_IOPORTS_SIZE, dev_name)) {
> -		pr_err("I/O address 0x%04x already in use\n", pm_iobase);
> -		goto exit;
> -	}
> -
>   	/*
>   	 * First, Find the watchdog timer MMIO address from indirect I/O.
>   	 */
> +	request_declared_muxed_region(&sp5100_res);
>   	outb(base_addr+3, index_reg);
>   	val = inb(data_reg);
>   	outb(base_addr+2, index_reg);
> @@ -380,6 +382,7 @@ static unsigned char sp5100_tco_setupdevice(void)
>   	outb(base_addr+0, index_reg);
>   	/* Low three bits of BASE are reserved */
>   	val = val << 8 | (inb(data_reg) & 0xf8);
> +	release_declared_region(&sp5100_res);
>   
>   	pr_debug("Got 0x%04x from indirect I/O\n", val);
>   
> @@ -400,6 +403,7 @@ static unsigned char sp5100_tco_setupdevice(void)
>   				      SP5100_SB_RESOURCE_MMIO_BASE, &val);
>   	} else {
>   		/* Read SBResource_MMIO from AcpiMmioEn(PM_Reg: 24h) */
> +		request_declared_muxed_region(&sp5100_res);
>   		outb(SB800_PM_ACPI_MMIO_EN+3, SB800_IO_PM_INDEX_REG);
>   		val = inb(SB800_IO_PM_DATA_REG);
>   		outb(SB800_PM_ACPI_MMIO_EN+2, SB800_IO_PM_INDEX_REG);
> @@ -408,6 +412,7 @@ static unsigned char sp5100_tco_setupdevice(void)
>   		val = val << 8 | inb(SB800_IO_PM_DATA_REG);
>   		outb(SB800_PM_ACPI_MMIO_EN+0, SB800_IO_PM_INDEX_REG);
>   		val = val << 8 | inb(SB800_IO_PM_DATA_REG);
> +		release_declared_region(&sp5100_res);
>   	}
>   
>   	/* The SBResource_MMIO is enabled and mapped memory space? */
> @@ -429,7 +434,7 @@ static unsigned char sp5100_tco_setupdevice(void)
>   		pr_debug("SBResource_MMIO is disabled(0x%04x)\n", val);
>   
>   	pr_notice("failed to find MMIO address, giving up.\n");
> -	goto  unreg_region;
> +	goto  exit;
>   
>   setup_wdt:
>   	tcobase_phys = val;
> @@ -469,8 +474,6 @@ static unsigned char sp5100_tco_setupdevice(void)
>   
>   unreg_mem_region:
>   	release_mem_region(tcobase_phys, SP5100_WDT_MEM_MAP_SIZE);
> -unreg_region:
> -	release_region(pm_iobase, SP5100_PM_IOPORTS_SIZE);
>   exit:
>   	return 0;
>   }
> @@ -517,7 +520,7 @@ static int sp5100_tco_init(struct platform_device *dev)
>   exit:
>   	iounmap(tcobase);
>   	release_mem_region(tcobase_phys, SP5100_WDT_MEM_MAP_SIZE);
> -	release_region(pm_iobase, SP5100_PM_IOPORTS_SIZE);
> +	release_region(SB800_IO_PM_INDEX_REG, SP5100_PM_IOPORTS_SIZE);
>   	return ret;
>   }
>   
> @@ -531,7 +534,6 @@ static void sp5100_tco_cleanup(void)
>   	misc_deregister(&sp5100_tco_miscdev);
>   	iounmap(tcobase);
>   	release_mem_region(tcobase_phys, SP5100_WDT_MEM_MAP_SIZE);
> -	release_region(pm_iobase, SP5100_PM_IOPORTS_SIZE);
>   }
>   
>   static int sp5100_tco_remove(struct platform_device *dev)
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
