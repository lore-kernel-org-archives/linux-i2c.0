From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v4 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
Date: Thu, 15 Jan 2015 13:07:05 +0100
Message-ID: <20150115120704.GB2549@katana>
References: <rjui@broadcom.com>
 <1421274213-3544-1-git-send-email-rjui@broadcom.com>
 <1421274213-3544-3-git-send-email-rjui@broadcom.com>
 <20150115084119.GN22880@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150115084119.GN22880-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> > +	iproc_i2c->msg = msg;
> Can it happen that iproc_i2c->msg still holds an uncompleted message
> here or is this serialized by the core? Wolfram? Either here something

We have per-adapter locks serializing transfers, if you mean that?

> > +static int bcm_iproc_i2c_cfg_speed(struct bcm_iproc_i2c_dev *iproc_i2c)
> > +{
> > +	unsigned int bus_speed, speed_bit;
> > +	u32 val;
> > +	int ret = of_property_read_u32(iproc_i2c->device->of_node,
> > +				       "clock-frequency", &bus_speed);
> > +	if (ret < 0) {
> > +		dev_err(iproc_i2c->device,
> > +			"missing clock-frequency property\n");
> > +		return -ENODEV;
> Is a missing property the only situation where of_property_read_u32
> returns an error? Would it be sane to default to 100 kHz?

Default of 100kHz instead of -ENODEV sounds very reasonable.

> > +static int bcm_iproc_i2c_remove(struct platform_device *pdev)
> > +{
> > +	struct bcm_iproc_i2c_dev *iproc_i2c = platform_get_drvdata(pdev);
> > +
> > +	i2c_del_adapter(&iproc_i2c->adapter);
> You need to free the irq before i2c_del_adapter.

One could also keep using devm_request_irq and disable all interrupts
sources here?

Thanks for the reviews, Uwe!

   Wolfram


--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUt61oAAoJEBQN5MwUoCm2NBUP/0gGYZRq83QMbPHm5H9LPpmj
uRvfNtoFlZGa4ZlwfmfPs4HseBOme3ppPc4/QMl283S3QcZufrpq/bP3l2H6cmXi
2WtirS/IYL2PvdzbRgVTR5SeCnmBhPEndA0K4J9+HejGUhOf7Q6PonrfAjP1jG8v
cBbC0PgUXSkPFQszp4th2cax4nS9Bjz8hPqrG1uKqS7siv0niGLV+CKuXnc3a59Q
udJGCsCZhvfqND5Dl+nOgxyR/teOguL9pCaQ8s8hX21FGuAIiUlPBk5/wB2UJVln
EPkl9+GevP9oQK/9ZyXLF0RoSaeeeX2yDRrmx4aRDnoSH+RBUL833f3K+JnW3kSP
v0MiiDo7YSp1W6t4g+kUn+AplH9PDbkH9QRy1ssmJ2tSuGxhUsL+SEf+fAMXtp64
CkF4wqn6Q092ZE0qmBM7X13hoIkRTvWaqDNW5U8+zakqR+8WfxubXMBAfU1U+ZLc
NdVrhy0dx4xcTSa82w19E7yx8G0J5Zdhe7xxqcx3ct0PJbMcnHMRuIhtkNXgAUSp
ybTjqmrkF1gNU9+MCmhrNo8fnWObK0U5CrTDYh6Acdi2Nqs1tBIlUOEHOSCVmLPn
uoD/5CTrRJkV1HppxxwC1jGGxxMXTFzbffnCTTya1XqP2yyTdPntXSUsHQfE458s
mgImHzp7eZfC/fVBtiVT
=C66l
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
