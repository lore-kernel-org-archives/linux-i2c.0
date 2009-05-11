From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2.6.29.2] PXA I2C: Define log level for i2c PXA error
	report
Date: Mon, 11 May 2009 16:15:48 +0200
Message-ID: <20090511141548.GB3061@pengutronix.de>
References: <Pine.LNX.4.64.0905060829580.24668@venus.araneidae.co.uk> <20090506102202.73d6045d@hyperion.delvare> <Pine.LNX.4.64.0905081102060.14384@venus.araneidae.co.uk> <fd6b62c10905110311w6350828tf90d9c699b73fe30@mail.gmail.com> <Pine.LNX.4.64.0905111126020.20970@venus.araneidae.co.uk> <20090511112801.GA20283@sirena.org.uk> <fd6b62c10905110629w6c9a641fr878351fb9217a32e@mail.gmail.com> <Pine.LNX.4.64.0905111458290.6308@venus.araneidae.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0905111458290.6308-EMtNTEpPrk39UE2ag0LVtCp2UmYkHbXO@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Abbott <michael-W/Bzo8D1sxa8qtKVGud/9w@public.gmane.org>
Cc: =?utf-8?B?5LyK5rO9?= <wxc200-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Still, I think it would make more sense for these to be one-liners; I=20
> guess routine probing failures ought to be reported in a slightly=20
> different way.  I'll see if I can figure out a sensible patch.

You might want to have a look here as I also noted once that the
pxa-driver is a bit too talkative when writing to eeproms:

http://www.mail-archive.com/linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg00324.html

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoIMxQACgkQD27XaX1/VRuPPQCgtgP964CKO9ddCoSuMZARNDS9
0FQAoINYFGY3iF5BXBLl2BIdklr/kT7o
=U1mc
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
