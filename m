From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: Moving at24 out of i2c/chips?
Date: Thu, 15 Jan 2009 11:03:22 +0100
Message-ID: <20090115100322.GA3148@pengutronix.de>
References: <20090114193521.GB15315@pengutronix.de> <200901141211.20681.david-b@pacbell.net> <20090114214038.3d7fbf57@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090114214038.3d7fbf57-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2009 at 09:40:38PM +0100, Jean Delvare wrote:
> On Wed, 14 Jan 2009 12:11:20 -0800, David Brownell wrote:
> > On Wednesday 14 January 2009, Wolfram Sang wrote:
> > > as drivers/i2c/chips/ is going to go away, I wondered if Jean would be
> > > interested in a patch moving it to drivers/misc/ (best location I cou=
ld
> > > come up with)? David, are you okay with that?
> >=20
> > That seems a reasonable place for it, if that directory is going
> > away.  Might even be worth moving the at25 (SPI eeprom) driver
> > there to keep it company, and adding an EEPROM section to Kconfig
> > for that directory.  (There's some 93x6 support too.  Those are a
> > flavor of SPI eeprom, but that driver doesn't use the SPI stack.)
>=20
> Yes, makes sense to me. The old eeprom driver could go along as well.
> Thanks for taking care of this!

Okay, sounds good. I am just a bit unsure how to proceed. I assume these
changes have to go via gkh's tree. Can I just make a patch series which
moves those drivers, post it to LKML (plus the other needed mailing
lists) and wait for acked-bys to come in? Or is it better to post the
series as [RFC] and collect acked-bys beforehand? Or shall I just move
at24 to the new location and wait for the other eeprom-driver-authors to
follow on their own?

Kind regards,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklvCeoACgkQD27XaX1/VRvzIgCfVfK6VTAukB9EGg4oxWNkUXd+
kQ4Anj4J/48JqhV8OK0YUurd+dlHmp/R
=Z2kM
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
