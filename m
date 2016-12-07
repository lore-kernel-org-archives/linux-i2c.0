From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4 4/5] i2c: designware: Add slave mode as separated
 driver
Date: Wed, 7 Dec 2016 19:07:15 +0000
Message-ID: <20161207190520.GA8658@leverpostej>
References: <cover.1481131072.git.lolivei@synopsys.com>
 <a7ca5014ad1c3f4905349a02ebe5294fe64c318e.1481131072.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <a7ca5014ad1c3f4905349a02ebe5294fe64c318e.1481131072.git.lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Dec 07, 2016 at 05:55:51PM +0000, Luis Oliveira wrote:
> +#ifndef CONFIG_ACPI
> +	if (!device_property_match_string(&pdev->dev, "mode", "slave"))
> +		i2c_dw_configure_slave(pdev);
> +	else
> +#endif

This kind of ifdeffery doesn't make sense. A single kernel binary may
support both ACPI and DT (but only one is used at runtime). Note that
this is the case for arm64 (our Kconfig has select OF, and our defconfig
has CONFIG_ACPI=y), so this logic is broken for DT arm64 platforms.

If you're trying to ensure that this *only* works in the DT case,
explicitly check for an of_node, or use the of_* accessors.

That applies for all instances of this pattern in this driver.

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
