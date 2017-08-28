From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RESEND PATCH v5 00/16] eeprom: at24: Add OF device ID table
Date: Mon, 28 Aug 2017 18:01:21 +0200
Message-ID: <20170828160121.gu4wf7jqu4ditksc@ninjato>
References: <20170615185418.13980-1-javier@dowhile0.org>
 <20170731153009.xkjknygpmckv2pfp@ninjato>
 <CABxcv=mdbE0QGjoi3aLzxRqM3-MbkQ_Ai6fShcGVUGSNNqqrqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kxl2ldofwcq27yov"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CABxcv=mdbE0QGjoi3aLzxRqM3-MbkQ_Ai6fShcGVUGSNNqqrqw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Cc: Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Florian Larysch <fl-J+Jo6bLUB7M@public.gmane.org>, David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Dinh Nguyen <dinguyen-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Scott Wood <oss-fOR+EgIDQEHk1uMJSBkQmQ@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>li
List-Id: linux-i2c@vger.kernel.org


--kxl2ldofwcq27yov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > But there is a dependency, no? If I apply the driver patch,
> > non-converted device trees will not find their eeproms anymore. So, I
>=20
> I don't think that's correct. If you apply this patch before the DTS
> changes, the driver will still match using the I2C device ID table
> like it has been doing it until today.

My tests do not confirm this. If I add a node with a "renesas,24c01"
compatible to my board, it works before your patch, but not after. If I
change it to "atmel,24c01" it works even after your patch. I haven't
looked into it, though, maybe i2c_of_match_device_sysfs() is stepping on
our foots here?

Did you test and did it work for you?


--kxl2ldofwcq27yov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmkPlEACgkQFA3kzBSg
KbY9mQ//ZYxuivYI37NBqNzvT6LEyeDnhT5YpI+3SDGk88+Ny3uOysJpehIW1zmQ
/o4MmLhMZq0emuNniTUcq6hs1DmPC1YFAHoNPhdcPEJY9BDB5Z28l187ETQ0wtYD
u8DAc11LnQLCGRgBngM9zAVClRI16o07T68hSGlUntK/oEAuqEqtcw3Nt4wAY1nD
1ALzfhgtBsGJ+BSDLTvW7sZ5cqJ1NhjHnEV2rLDIxTQPTTVBc3guI7Zw7+qXuETX
cJ/mIhwyYPpcdlPM7A9mt3CozKhjFEnWG+TZEl3xiQVs/5Gb6hF7c+q06g1t1BBE
OufNGdCTbg3etFN0y//oj2+K2iUqfw4m/33VmGBltVZuKxcrEFCOHBaONdyAJ2ET
tki7C+Vz/JzD5VDl7nUp7Ci95FbRjFGXDy45e8u0Nyb1eQX02Y+owo/Pk5ZuiRQw
fi6c5lJP34KazsrmGpqm9W/wzggxJSoXW1abAOeDTindLZ4DiSH41od6tx2y/nHs
e2i2OygFb3NNccXZ9QL/xmcRiCzwi9hk9Tt71fawGWQ+hLKxrLs7emt8kfpPU4aU
ZpdA4TbozeaOWWDzbOzwV25d0kOe+LiwKx+PTNgW2Uimz1sQBWOpIm0vZGXxqa8y
wSSRx/WWug0tYILnAP5BQmLV9X5N3m8zaJ6u1neWImCTNpCweFU=
=nrOV
-----END PGP SIGNATURE-----

--kxl2ldofwcq27yov--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
