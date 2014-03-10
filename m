From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] drivers: i2c: i2c-st: Fix return in case of arbitration
 lost
Date: Mon, 10 Mar 2014 17:34:35 +0100
Message-ID: <20140310163435.GH11592@katana>
References: <1393591976-10771-1-git-send-email-maxime.coquelin@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAgJxtfIS94j9H4T"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393591976-10771-1-git-send-email-maxime.coquelin-qxv4g6HH51o@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime COQUELIN <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srinivas.kandagatla-qxv4g6HH51o@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--uAgJxtfIS94j9H4T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2014 at 01:52:56PM +0100, Maxime COQUELIN wrote:
> This patch fixes the error returned to the i2c_transfer function
> to -EAGAIN in case of arbitratin lost, so that the retry mechanism
> can be used.
>=20
> Signed-off-by: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>

Applied to for-next, thanks!


--uAgJxtfIS94j9H4T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTHembAAoJEBQN5MwUoCm2KC0P/jExj86oqGhV6DDEA5sUAUyS
NiHePCfaoWOdZpqDdoonjSxtKhJoU5GxAij0UvabmCh/cnMfn5hfviFExwgwA45q
IK2TLjPjVO3SNAu1+O5uyAv57aZRyFtaKCAe95+pvN7IvHOGYCdUMiezrV8sLCVq
oGunhKEQqN5SRHsqMKUjAVq1MgfOrnqD5LKc/KvDEMyy0Fp67J8VlthnlxCXKKTl
x/cGwxz7T8yc74+OXwvS+dhuQtzfEYruPgslXExwMpmOgo86yQD3FpQab2pQ8iTh
1vo3r+qtZYmMph5BgnabG/RheNtAoqUb3HtotVpCK73pCXj22qd5zXnaymVZqzi7
UmIrMPSolpGlwmZzocEweOky5R81CTyKfD78qxARpH0nTMbXyThh8Cf/0YjOm5Wm
0RjhKuvuYI6c3sStywFL2LkMmL8OJEwFaMmEqchMEwZjSLLYYI3xzPs3DTkfqfDd
vfQ3fBfW6EJjYAHV4+bjSuYyokv6RR0of4iN5SLDI0ZtAhSy8oYo6qF2B4b6UU9l
hoHnVohgDeaAR2jOIVCY5Z2H8yqDfH0an13oLehOvNySFm7kiJcE/O/EJD8RKjnJ
7FTVu00HRILafpX9+ghV2kv7WElgQujl8KX4vmuRiwGdmXoPA7IHUuf9rgjD/Cfg
8vDvK8G4OT9gVTh5l+eL
=qF2t
-----END PGP SIGNATURE-----

--uAgJxtfIS94j9H4T--
