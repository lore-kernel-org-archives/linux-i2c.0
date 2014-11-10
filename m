From: Beniamino Galvani <b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/2] i2c: add support for Amlogic Meson I2C controller
Date: Mon, 10 Nov 2014 22:46:58 +0100
Message-ID: <20141110214658.GA15156@gmail.com>
References: <1412540232-26168-1-git-send-email-b.galvani@gmail.com>
 <1412540232-26168-2-git-send-email-b.galvani@gmail.com>
 <20141110144440.GB10422@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141110144440.GB10422@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jerry Cao <jerry.cao-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>, Victor Wan <victor.wan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Nov 10, 2014 at 03:44:41PM +0100, Wolfram Sang wrote:
> On Sun, Oct 05, 2014 at 10:17:11PM +0200, Beniamino Galvani wrote:
> > This is a driver for the I2C controller found in Amlogic Meson SoCs.
> > 
> > Signed-off-by: Beniamino Galvani <b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Thanks. Looking very good already!
> 
> > +static void meson_i2c_prepare_xfer(struct meson_i2c *i2c, bool write)
> 
> Instead of the bool, maybe you could query i2c->state in the function?
> You decide, I am not forcing you to do this.

Seems reasonable, will do.

> 
> > +static u32 meson_i2c_func(struct i2c_adapter *adap)
> > +{
> > +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> > +}
> 
> Have you tested 0-byte transfers, too (i2cdetect -q)? What was your test
> scenario in general?

I did a test with i2cdetect and quick write commands appear to
work.

When I wrote the driver I tested it to communicate with the only I2C
device available on the board, a Ricoh RN5T618 PMIC.

Now I have access to a hardware with a PCF8564 RTC and just realized
that long reads don't work properly, so I'm going to submit a new
version of the patchset in the next days.

Thanks,
Beniamino
