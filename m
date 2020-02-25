From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 2/3] watchdog: iTCO_wdt: Make ICH_RES_IO_SMI optional
Date: Tue, 25 Feb 2020 16:42:57 +0200
Message-ID: <20200225144257.GD2667@lahna.fi.intel.com>
References: <20200225123802.88984-1-mika.westerberg@linux.intel.com>
 <20200225123802.88984-3-mika.westerberg@linux.intel.com>
 <20200225143709.GA450@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200225143709.GA450-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Wim Van Sebroeck <wim-Q8PRGTgFL9WUCWQAtAn6Ix2eb7JE58TQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Martin Volf <martin.volf.42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 25, 2020 at 06:37:09AM -0800, Guenter Roeck wrote:
> On Tue, Feb 25, 2020 at 03:38:01PM +0300, Mika Westerberg wrote:
> > The iTCO_wdt driver only needs ICH_RES_IO_SMI I/O resource when either
> > turn_SMI_watchdog_clear_off module parameter is set to match ->iTCO_version
> > (or higher), and when legacy iTCO_vendorsupport is set. Modify the driver
> > so that ICH_RES_IO_SMI is optional if the two conditions are not met.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---
> >  drivers/watchdog/iTCO_wdt.c | 22 +++++++++++++---------
> >  1 file changed, 13 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
> > index 156360e37714..f1692452bc25 100644
> > --- a/drivers/watchdog/iTCO_wdt.c
> > +++ b/drivers/watchdog/iTCO_wdt.c
> > @@ -460,7 +460,7 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
> >  		return -ENODEV;
> >  
> >  	p->smi_res = platform_get_resource(pdev, IORESOURCE_IO, ICH_RES_IO_SMI);
> > -	if (!p->smi_res)
> > +	if (!p->smi_res && iTCO_vendorsupport)
> >  		return -ENODEV;
> >  
> >  	p->iTCO_version = pdata->version;
> > @@ -492,15 +492,19 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
> >  	/* Set the NO_REBOOT bit to prevent later reboots, just for sure */
> >  	p->update_no_reboot_bit(p->no_reboot_priv, true);
> >  
> > -	/* The TCO logic uses the TCO_EN bit in the SMI_EN register */
> > -	if (!devm_request_region(dev, p->smi_res->start,
> > -				 resource_size(p->smi_res),
> > -				 pdev->name)) {
> > -		pr_err("I/O address 0x%04llx already in use, device disabled\n",
> > -		       (u64)SMI_EN(p));
> > -		return -EBUSY;
> > -	}
> >  	if (turn_SMI_watchdog_clear_off >= p->iTCO_version) {
> > +		if (!p->smi_res) {
> > +			pr_err("SMI I/O resource is missing\n");
> > +			return -EINVAL;
> > +		}
> > +		/* The TCO logic uses the TCO_EN bit in the SMI_EN register */
> > +		if (!devm_request_region(dev, p->smi_res->start,
> > +					 resource_size(p->smi_res),
> > +					 pdev->name)) {
> > +			pr_err("I/O address 0x%04llx already in use, device disabled\n",
> > +			       (u64)SMI_EN(p));
> > +			return -EBUSY;
> > +		}
> 
> The request_region call is also needed if iTCO_vendorsupport is true.
> Well, not strictly speaking, I guess, but then one could argue that
> it isn't needed at all.

Indeed, this is good point as well. Will be fixed in v2.

> In this context - looking into the vendorsupport code, I wonder if
> it is time to retire it. Separate patch, of course, but still.
> Any thoughts ?

No objections from me ;-)
