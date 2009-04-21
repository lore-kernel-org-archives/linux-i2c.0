From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [Patch] MPC Adapter: read class attribute from device tree
Date: Tue, 21 Apr 2009 11:51:12 +0200
Message-ID: <20090421095112.GB3100@pengutronix.de>
References: <49ED6AD3.2060808@gmx.de> <49ED6F03.5050107@grandegger.com> <49ED9132.9050806@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <49ED9132.9050806-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Delvare, Jean " <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> mailing list. Nevertheless loading modules at runtime is legal and
> generally supported by LINUX.

Ack. And it does so...

> Defining all possible (I2C-)devices in DTS would give a mess. E.g. on
> one board there will be ~30 temperature sensors, on the other none.
> As every DTS entry will force a sysFs subdirectory there would be a
> bunch of functionless directories - rather ugly.

Well, you should have a DTS for every flavour; that is what DTS are
about. You do know that, do you?

Even if not, there would be a slighty messed directory on one specific
device with how many units? Let's take the latest example of extending
the DTS file with OS-specific information - this one is ugly, too, but
has impact _for everyone using dts_ files. Think about the number of
affected systems and you will hopefully understand why such patches are
handled with extreme caution.

> Because of the situation above I try to keep the ability of dynamic
> instantiation. Jean hesitates, I feel because he sees I2C solely in
> static manner.

He is taking care for every I2C communication on every Linux machine out
there. He can't please everyone. On the other hand, you are free to
modify the kernel as you please. It doesn't really have to be in
mainline, does it?

BTW, I hope you saw that the "linux,i2c-class" property is considered
deprecated. Thus, expect a patch from me removing it entirely as soon
as the old binding model went away (there aren't even any users).

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkntlxAACgkQD27XaX1/VRudPwCfY5IdhTpR8GUQDTfjGt24b7cS
jikAniKbA2OagNjpgqNGaAIoJLIWShBG
=xvQH
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
