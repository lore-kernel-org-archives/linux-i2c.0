From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: New home for DS1682 driver
Date: Wed, 7 Oct 2009 12:07:34 +0200
Message-ID: <20091007120734.31a41f33@hyperion.delvare>
References: <20091007115017.6941faa7@hyperion.delvare>
	<20091007095610.GF3177@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091007095610.GF3177-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 7 Oct 2009 11:56:10 +0200, Wolfram Sang wrote:
> On Wed, Oct 07, 2009 at 11:50:17AM +0200, Jean Delvare wrote:
> > Hi Grant,
> > 
> > Driver ds1682 needs a new home, as drivers/i2c/chips will be gone soon.
> > Do you have a preference for where it should go?
> > 
> > As the device includes an EEPROM, the driver could go in
> > drivers/misc/eeprom, but OTOH the EEPROM in question is so small that
> > this can hardly be considered the main feature of the driver. So maybe
> > just drivers/misc?
> 
> I would much prefer drivers/misc.

OK, fine with me. Will you send a patch?

> What about tsl2550.c? I thought the plan back
> then was to wait for IIO becoming mainline? Or shall we also put it to
> drivers/misc until then?

For tsl2550, the plan is indeed to wait for iio to become mainline. Or
the alternative ALS subsystem. I hope we won't have to wait too long.

-- 
Jean Delvare
