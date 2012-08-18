From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH RESEND 2/2] i2c: pnx: Fix read transactions of >= 2 bytes
Date: Sat, 18 Aug 2012 11:52:12 +0200
Message-ID: <20120818095212.GC24812@pengutronix.de>
References: <1344411752-23469-1-git-send-email-stigge@antcom.de>
 <1344411752-23469-2-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1344411752-23469-2-git-send-email-stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
Cc: vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kevin.wells-3arQi8VN3Tc@public.gmane.org, srinivas.bakki-3arQi8VN3Tc@public.gmane.org, aletes.xgr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 08, 2012 at 09:42:32AM +0200, Roland Stigge wrote:
> On transactions with n>=3D2 bytes, the controller actually wrongly clocks=
 in n+1
> bytes. This is caused by the (wrong) assumption that RFE in the Status Re=
gister
> is 1 iff there is no byte already ordered (via a dummy TX byte). This lea=
d to
> the implementation of synchronized byte ordering, e.g.:
>=20
> Dummy-TX - RX - Dummy-TX - RX - ...
>=20
> But since RFE actually stays high after some Dummy-TX, it rather looks li=
ke:
>=20
> Dummy-TX - Dummy-TX - RX - Dummy-TX - RX - (RX)
>=20
> The last RX byte is clocked in by the bus controller, but ignored by the =
kernel
> when filling the userspace buffer.
>=20
> This patch fixes the issue by asking for RX via Dummy-TX asynchronously.
> Introducing a separate counter for TX bytes.
>=20
> Signed-off-by: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
>=20
> ---
> Applies to v3.6-rc1
>=20
> This patch for i2c-pnx affects PNX4008 and LPC32xx (and LPC31xx, not yet =
in
> mainline). Can you please test?
>=20
> Thanks in advance!

I assume you checked this on LPC32xx? I'll wait a bit more but tend to
take the patch anyhow, even if there is no explicit ACK from PNX.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlAvZcwACgkQD27XaX1/VRvxbQCghFPkAvS7ICRYxWSfNNfDPKNR
yhkAoLY/nVswtaEiUCFrIaUMBDfuh6a4
=Hsg8
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--
