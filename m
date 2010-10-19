From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2] i2c/mux: Driver for PCA9541 I2C Master Selector
Date: Tue, 19 Oct 2010 23:49:29 +0200
Message-ID: <20101019234929.3d4d14f4@endymion.delvare>
References: <1286932516-20689-1-git-send-email-guenter.roeck@ericsson.com>
	<20101019190647.314302e7@endymion.delvare>
	<1287521453.9690.299.camel@groeck-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1287521453.9690.299.camel@groeck-laptop>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 19 Oct 2010 13:50:53 -0700, Guenter Roeck wrote:
> Hi Jean,
> 
> On Tue, 2010-10-19 at 13:06 -0400, Jean Delvare wrote:
> [ ... ]
> > > +
> > > +/*
> > > + * I2C init/probing/exit functions
> > > + */
> > > +static int __devinit pca9541_probe(struct i2c_client *client,
> > > +                                const struct i2c_device_id *id)
> > 
> > The use of __devinit and __devexit isn't recommended for i2c drivers.
> > If your driver is built into the kernel but the underlying i2c bus
> > driver is build as a module, you're in trouble.
> > 
> I don't mind changing this, but ... the code is copied from pca954x.c,
> which also uses __devinit and __devexit for the same functions. Wouldn't
> that be a problem there as well ? Or am I missing something ?

You're right, this should be fixed. I take patches ;)

-- 
Jean Delvare
