From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [RFC PATCH] i2c: new bus driver for efm32
Date: Fri, 14 Mar 2014 00:19:25 +0100
Message-ID: <20140313231925.GC15674@pengutronix.de>
References: <1392027598-29015-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140310075558.GD2571@katana>
 <20140313212613.GB15674@pengutronix.de>
 <20140313221433.GI2696@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140313221433.GI2696@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Thu, Mar 13, 2014 at 11:14:33PM +0100, Wolfram Sang wrote:
> > > Huh? Is this an accepted binding? Doesn't look like it because of=
 a
> > > generic name and IMO a specific use-case. BTW the binding documen=
tation
> > > for this driver is missing.
> > Regarding the generic name: I don't care much, but I don't have a
> > problem with it. IMHO it's implicitly name-spaced by the compatible
> > string which starts with "efm32," and so is fine. I'd like to have =
the
> > same property name for all efm32 device drivers and "location" matc=
hes
> > the hardware reference manual (apart from capitalization).
>=20
> I would in deed have expected a binding like "efm32,location" to
> emphasize this is an efm32 specific thing. I know vendor-specific
> "setup" bindings from elsewhere. Since it has been accepted already i=
n
> other places, we should keep it likes this.
Assuming you know the dt stuff better than me (and noone objects) I'd
fix the intree drivers to use efm32,location, too.

> > > > +	if (resource_size(res) < 0x42) {
> > > > +		dev_err(&pdev->dev, "memory resource too small\n");
> > > > +		return -EINVAL;
> > > > +	}
> > >=20
> > > I'd drop this check since, but I won't force you to.
> > I'd understand your sentence with s/since//, not sure about it as i=
s.
> > Anyhow, I like this check.
>=20
> A leftover. I was about to write "since the check is somewhat heurist=
ic
> and does not proof much". But then I decided it is not worth spending
> too much discussion on it :)
I'd say it's heuristic to *not* check the boundary. It doesn't apply
here, but consider a driver using a register space > PAGE_SIZE on an MM=
U
platform. It accesses base + PAGE_SIZE + 0x42 even if dt only gave a
register range of PAGE_SIZE / 2. It's like gets(3).

> > > > +	clkdiv =3D DIV_ROUND_UP(rate, 8 * ddata->pdata.frequency) - 1=
;
> > > > +	if (clkdiv >=3D 0x200) {
> > > > +		dev_err(&pdev->dev,
> > > > +				"input clock too fast (%lu) to divide down to bus freq (%l=
u)",
> > > > +				rate, ddata->pdata.frequency);
> > > > +		ret =3D -EIO;
> > > > +		goto err_disable_clk;
> > > > +	}
> > >=20
> > > -EIO for clocks errors? Is this common?
> > Changed to ENODEV. Ok?
>=20
> Nope, then the driver core will silent drop the error. -EINVAL?
agreed

Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
