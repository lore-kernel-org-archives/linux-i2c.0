From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH Resend] i2c/designware: dw_i2c_init_driver as subsys
 initcall
Date: Wed, 29 Feb 2012 19:57:48 +0100
Message-ID: <20120229185748.GB30545@pengutronix.de>
References: <0a4676cdd7e81363eab4eb1520b0e74f50e6c5c4.1330498492.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SNIs70sCzqvszXB4"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0a4676cdd7e81363eab4eb1520b0e74f50e6c5c4.1330498492.git.viresh.kumar-qxv4g6HH51o@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, armando.visconti-qxv4g6HH51o@public.gmane.org, shiraz.hashim-qxv4g6HH51o@public.gmane.org, vipin.kumar-qxv4g6HH51o@public.gmane.org, rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org, deepak.sikri-qxv4g6HH51o@public.gmane.org, vipulkumar.samar-qxv4g6HH51o@public.gmane.org, amit.virdi-qxv4g6HH51o@public.gmane.org, pratyush.anand-qxv4g6HH51o@public.gmane.org, bhupesh.sharma-qxv4g6HH51o@public.gmane.org, viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bhavna.yadav-qxv4g6HH51o@public.gmane.org, vincenzo.frascino-qxv4g6HH51o@public.gmane.org, mirko.gardi-qxv4g6HH51o@public.gmane.org, salvatore.dedominicis-qxv4g6HH51o@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--SNIs70sCzqvszXB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 29, 2012 at 12:27:46PM +0530, Viresh Kumar wrote:
> From: Pratyush Anand <pratyush.anand-qxv4g6HH51o@public.gmane.org>
>=20
> There are few drivers which are available on i2c bus but have been initia=
lized
> with subsys_initcall. Also as I2C is also a bus driver, it should be avai=
lable
> as early as possible.
>=20
> Therefore i2c driver must s initialized with subsys initcall in this patc=
h.
>=20
> Signed-off-by: Pratyush Anand <pratyush.anand-qxv4g6HH51o@public.gmane.org>
> Signed-off-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
> ---
> This patch was sent a long time back and was never pushed. Resending it a=
gain.

There is a dangling 's' in the commit message. Please check patches again e=
ven
on resending.

Fixed it up myself and picked the patch.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--SNIs70sCzqvszXB4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk9OdSwACgkQD27XaX1/VRvZzgCggmDAxYY7VkoBcIXhAk5ZkUL6
/5kAoIWP4zpsZ0Ql+/URd5iSq/0Rfzvz
=L6LC
-----END PGP SIGNATURE-----

--SNIs70sCzqvszXB4--
