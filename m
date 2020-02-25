From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 3/3] i2c: i801: Do not add ICH_RES_IO_SMI if PMC device
 is not present
Date: Tue, 25 Feb 2020 16:35:45 +0200
Message-ID: <20200225143545.GM10400@smile.fi.intel.com>
References: <20200225123802.88984-1-mika.westerberg@linux.intel.com>
 <20200225123802.88984-4-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200225123802.88984-4-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Wim Van Sebroeck <wim-Q8PRGTgFL9WUCWQAtAn6Ix2eb7JE58TQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Martin Volf <martin.volf.42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 25, 2020 at 03:38:02PM +0300, Mika Westerberg wrote:
> Martin noticed that nct6775 driver does not load properly on his system
> in v5.4+ kernels. The issue was bisected to commit b84398d6d7f9 ("i2c:
> i801: Use iTCO version 6 in Cannon Lake PCH and beyond") but it is
> likely not the culprit because the faulty code has been in the driver
> already since commit 9424693035a5 ("i2c: i801: Create iTCO device on
> newer Intel PCHs"). So more likely some commit that added PCI IDs of
> recent chipsets made the driver to create the iTCO_wdt device on Martins
> system.
> 
> The issue was debugged to be PCI configuration access to the PMC device
> that is not present. This returns all 1's when read and this caused the
> iTCO_wdt driver to accidentally request resourses used by nct6775.
> 
> Fix this by checking that the PMC device is there and only then populate
> the iTCO_wdt ICH_RES_IO_SMI resource. Since the resource is now optional
> the iTCO_wdt driver should continue to work on recent systems without it.

...

>  	return platform_device_register_resndata(&pci_dev->dev, "iTCO_wdt", -1,
> -					tco_res, 3, &spt_tco_platform_data,
> +					tco_res, nres + 1, &spt_tco_platform_data,
>  					sizeof(spt_tco_platform_data));

Perhaps use the same pattern as below, i.e.

	nres++;
	return ...(..., nres, ...);

?

...

>  	return platform_device_register_resndata(&pci_dev->dev, "iTCO_wdt", -1,
> -					tco_res, 2, &cnl_tco_platform_data,
> +					tco_res, nres, &cnl_tco_platform_data,
>  					sizeof(cnl_tco_platform_data));

Ditto.

...

> +	nres++;

-- 
With Best Regards,
Andy Shevchenko
