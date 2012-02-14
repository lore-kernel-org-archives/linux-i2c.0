From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: convert drivers/i2c/* to use module_i2c_driver()
Date: Tue, 14 Feb 2012 10:16:04 +0100
Message-ID: <20120214101604.658cac32@endymion.delvare>
References: <1329123903.13995.1.camel@phoenix>
	<20120213222643.GA22686@pengutronix.de>
	<20120214101013.4133784e@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120214101013.4133784e-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 14 Feb 2012 10:10:13 +0100, Jean Delvare wrote:
> On Mon, 13 Feb 2012 23:26:43 +0100, Wolfram Sang wrote:
> > On Mon, Feb 13, 2012 at 05:05:03PM +0800, Axel Lin wrote:
> > > This patch converts the drivers in drivers/i2c/* to use the
> > > module_i2c_driver() macro which makes the code smaller and a bit simpler.
> > > 
> > > Signed-off-by: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > > Cc: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
> > > Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > > Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
> > > Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> > 
> > Acked-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> 
> Patch applied, thanks.

Hmm, on second thought...

I'm not going to apply the i2c-smbus patch. This is a special module,
it isn't a device driver per se. It happens that right now the only
SMBus extension supported by the i2c-smbus module is SMBus Alert and
it happens that this is implemented as an i2c_driver, but as we add
support for more SMBus extensions to  that driver, the init and exit
functions will likely become more complex, and then we'd have to move
away from module_i2c_driver(). So I'd rather not use it to start with.

I am taking the drivers/i2c/muxes/pca954*.c parts though.

-- 
Jean Delvare
