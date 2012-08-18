From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH RESEND 1/2] i2c: pnx: Fix bit definitions
Date: Sat, 18 Aug 2012 11:51:08 +0200
Message-ID: <20120818095108.GB24812@pengutronix.de>
References: <1344411752-23469-1-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1344411752-23469-1-git-send-email-stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
Cc: vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kevin.wells-3arQi8VN3Tc@public.gmane.org, srinivas.bakki-3arQi8VN3Tc@public.gmane.org, aletes.xgr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 08, 2012 at 09:42:31AM +0200, Roland Stigge wrote:
> The I2C Control Register bits RFDAIE and RFFIE were mixed up. In addition=
 to
> this fix, this patch adds the missing bit DRSIE for completeness.
>=20
> Signed-off-by: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
>=20
> ---
> Applies to v3.6-rc1
>=20
> This patch for i2c-pnx affects PNX4008 and LPC32xx (and LPC31xx, not yet =
in
> mainline). Can you please test and double-check the manuals of PNX4008 and
> LPC31xx? I only found this via the manual of LPC32xx but assume it's the =
same
> for the others, also.
>=20
> Thanks in advance!

Kevin, since the other manuals seem to be not easily available, can you
please check?

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlAvZYwACgkQD27XaX1/VRtCJACfSNacfFhoVmX/2n9KeLLDCGb1
SpgAni1seSVbb1sIw9ncoS/fxlWrPb62
=puQb
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
