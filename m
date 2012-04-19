From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v4] i2c: Add device tree support to i2c-pnx.c
Date: Thu, 19 Apr 2012 22:39:15 +0200
Message-ID: <20120419203915.GB28005@pengutronix.de>
References: <1334850612-24151-1-git-send-email-stigge@antcom.de>
 <20120419160715.GD24987@pengutronix.de>
 <4F903E0C.6010604@antcom.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4F903E0C.6010604-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kevin.wells-3arQi8VN3Tc@public.gmane.org, srinivas.bakki-3arQi8VN3Tc@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2012 at 06:32:12PM +0200, Roland Stigge wrote:
> Hi,
>=20
> On 04/19/2012 06:07 PM, Wolfram Sang wrote:
> >> + - clock-frequency: desired I2C bus clock frequency in Hz,
> >> Default: 100000 Hz + - pnx,timeout: I2C bus timeout in
> >> milliseconds, Default: 10 ms
> >=20
> > I'd like to repeat my question to the devicetree folks here: Can we
> > have timeout generic? It doesn't make sense to me to have that per
> > vendor again and again.
>=20
> Sounds completely reasonable.
>=20
> To help make the devicetree conversion into 3.5, I would prefer to
> integrate the "vendor,timeout" as-is if a longish standardization
> process would block this, considering that we luckily only have 2-3 of
> such timeout definitions currently.

The "blocking" argument will be true for most dt-conversions. Only thing
that might change is that the argument will then be "we already have
9-10 of such timeouts, so we can have another one" ;)

I've been there before, if you make one exception once, other people
will nail you on that. I'd like to avoid that.

Let's just hope we can agree on "timeout" quickly and all will be fine.

> I'd volunteer to clean up later by preparing a patch when there is a
> standard timeout defined.

The problem with bindings is that you must support them forever once
introduced. Old device-trees should still work with newer kernels.
=20
> If we have a solution soon, I will prepare a new version of the patch,
> of course, in the next days.

Thanks. One question, though: Will it really block dt-conversion? The
whole conversion should not be depending on the i2c-driver?

> > Did you change this, too? Timeouts are better readable in dec :)
>=20
> Right. But even when removing the "0x" in the timeout line above, it's
> still hex, see Documentation/devicetree/booting-without-of.txt
>=20
> Or did I get sth. wrong?

I think the document is probably outdated :( "clock-frequency" is also
without 0x and dec.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+Qd/MACgkQD27XaX1/VRv68wCfSlP1dTj/oNt9iMmleHyCHsL6
crMAnjv0xGzqCNgsyufi6nkcftUxbfpm
=16eA
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
