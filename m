From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH RESEND] i2c/nomadik: runtime PM support
Date: Thu, 3 May 2012 12:15:37 +0100
Message-ID: <20120503111537.GD3955@opensource.wolfsonmicro.com>
References: <1331213407-10135-1-git-send-email-linus.walleij@stericsson.com>
 <CACRpkdbQRB37kYfCwn6+xUxBkVVo9f3RwUk5pstVPcfK8bivZw@mail.gmail.com>
 <CACRpkdafU2Awaxx-2dXT_Z8S+dySx6YoV174rxJvdix81TBBpg@mail.gmail.com>
 <20120417143901.GA22406@pengutronix.de>
 <CANqRtoTbW2ew9ZwYmdJAaiD5qujZ-43eCfT=myDQdeYScwiBzQ@mail.gmail.com>
 <CACRpkdbj+cF7d_=QmqtXTGS4s3Jrr7vxnrt5VbHMDO=an_cVow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eheScQNz3K90DVRs"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdbj+cF7d_=QmqtXTGS4s3Jrr7vxnrt5VbHMDO=an_cVow-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonas Aaberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Rickard ANDERSSON <rickard.andersson-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Rabin VINCENT <rabin.vincent-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--eheScQNz3K90DVRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 03, 2012 at 11:03:12AM +0200, Linus Walleij wrote:
> On Wed, Apr 18, 2012 at 8:39 AM, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> > Our drivers assume that the ->runtime_suspend() and ->runtime_resume()
> > callbacks are executed before/after the power is turned off/on for a
> > certain power domain. The way they are used in this patch more seems
> > like they are expected to be called regardless of the state of the
> > rest of the devices sharing the underlying power domain.

...

> On systems where we know the driver is always used with
> power domains the world is easier, but this is not the case
> here. This piece of code in rumtime PM is the source of the
> confusion:

One thing that the regulator framework has which might be useful here is
that it can notify drivers when power is actually removed.  This allows
drivers to reduce the amount of work they need to do to bring the device
back up if they know power was retained while they were suspended.

It feels like some of the confusion is over the difference between
quiescing the device when idle and actually removing power from the
device.

--eheScQNz3K90DVRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPomjPAAoJEBus8iNuMP3dk80P/jDuLc6ISjzUKurZ1go11JWc
9l5hPa4vnN/2TWnfqoFy454xkcMgSf1DEBNdrIpd73ZoXNPKtFm1iDHQ0ee2Upvp
K3LV1P1dElGNEBBPjBdPsOYEmqCpsuOC2O6QEOqdrj419EoEkTx1zvVC61q7oWuQ
9/PtTaw3U78IkvcvtA0WPyEkSlwmMaMeAVFGL3CtPSAVlNKqDxqm7ixerIDI6BGq
e8qjaUavYCiX08dbuX5FBYlCegZLKH0hMShPPBRtuHfLszKsyhwpe+L6Tc4AoEo5
Vc27yyc3ZXdcU5Ju6oXtMlQ+JgMLxmaEnlRYl1qK4w5rm0lO643Cw18sFTH92vY9
txQl5gXh/AdIBI097Fwj88L09P68/IoM5Du3+9KVndJknQmCRJumnyos3eowJ4NN
GJJKfrCHToMbQXsAf0GJ0C3mfIcwvK7qPYdJuHU/zdthXT9akksz/hNLGjfBFdk3
wWjmwXCKJIyZZnWMKghi5Nqch7ka0S164fXR5fZHH4qyQQUUb9vvRt02QTTAYRrG
QlJy+BxgxGlhhAV3jdYtFjPeRO8gsx4I+jrSOCXxWVjUmltf4rLzSerP3nzc5lD5
ONh6xeZ/uOURZl5jtAbd+8wq/xfbz9oS46iYmnuv1jQ6alMjWBhaDF1SX2ohrB0M
hkEhzUGwtoU2R6qrgXta
=FjAb
-----END PGP SIGNATURE-----

--eheScQNz3K90DVRs--
