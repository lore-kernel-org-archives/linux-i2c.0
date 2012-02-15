From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c: Add Congatec CGEB I2C driver
Date: Wed, 15 Feb 2012 14:54:13 +0100
Message-ID: <20120215135413.GD3852@pengutronix.de>
References: <1328102793-4313-1-git-send-email-s.hauer@pengutronix.de>
 <1328102793-4313-3-git-send-email-s.hauer@pengutronix.de>
 <20120207101016.GB2539@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120207101016.GB2539-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 07, 2012 at 11:10:16AM +0100, Wolfram Sang wrote:
> Hi Sascha,
> 
> > +config I2C_CONGATEC_CGEB
> > +	tristate "Congatec CGEB I2C driver"
> > +	depends on MFD_CONGATEC_CGEB
> > +	help
> > +	  This driver provides support for the I2C busses accssable via
> > +	  the Congatec CGEB interface found on Congatec boards.
> > +
> 
> Please keep the sorting (eg20t is wrong and will be fixed).
> 
> > +		ret = cgeb_call(priv->board, &fps, CgebI2CTransfer);
> > +		if (ret) {
> > +			ret = -EREMOTEIO;
> > +			goto out;
> > +		}
> 
> -EREMOTEIO is not present in Documentation/i2c/fault-codes. Please use
> one from that file.

-EIO?

> 
> > +	ret = cgeb_i2c_set_speed(priv, 400000);
> > +	if (ret)
> > +		/*
> > +		 * not a critical error, we can continue with the default speed.
> > +		 */
> > +		dev_warn(&pdev->dev, "Could not set speed to 400KHz\n");
> 
> Is it possible to make this configurable? Not all I2C devices support
> 400KHz, 100KHz is OK.

Yes, it is. The problem is more *how* it should be configurable.
Exposing it via sysfs is the only reasonable option I can think
of.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
