From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH RESEND 3/3] i2c/ibm-iic: drop NO_IRQ
Date: Tue, 27 Apr 2010 09:12:22 +0200
Message-ID: <20100427071222.GB22743@pengutronix.de>
References: <1270167421-5205-1-git-send-email-w.sang@pengutronix.de> <1270167421-5205-4-git-send-email-w.sang@pengutronix.de> <1272351974.24542.9.camel@pasglop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1272351974.24542.9.camel@pasglop>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Sean MacLennan <smaclennan-Qtffpm9i2AVWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 27, 2010 at 05:06:14PM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2010-04-02 at 02:17 +0200, Wolfram Sang wrote:
> > Drop NO_IRQ as 0 is the preferred way to describe 'no irq'
> > (http://lkml.org/lkml/2005/11/21/221). This change is safe, as the driv=
er is
> > only used on powerpc, where NO_IRQ is 0 anyhow.
>=20
> Oops... forgot those. Applied, will show up in -next soon.

Ah, thanks. I also asked Ben Dooks to pick them up, but better twice than n=
ever
;)

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkvWjlYACgkQD27XaX1/VRvb4gCfac8AEkOcE0nKPmbeprc4Uhg+
g4QAn2MpshayIMtohOk4S1jiT+Z8QS6B
=xJuH
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
