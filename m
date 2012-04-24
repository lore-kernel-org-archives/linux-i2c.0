From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V3 03/12] i2c/i2c-pxa: Remove conditional compilation of
 clk code
Date: Tue, 24 Apr 2012 13:52:02 +0200
Message-ID: <20120424115202.GB4030@pengutronix.de>
References: <cover.1335266056.git.viresh.kumar@st.com>
 <08a0a53dde1958a395a9950d5e910bcb6e3b02b6.1335266056.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <08a0a53dde1958a395a9950d5e910bcb6e3b02b6.1335266056.git.viresh.kumar@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: akpm@linux-foundation.org, spear-devel@list.st.com, viresh.linux@gmail.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mturquette@linaro.org, sshtylyov@mvista.com, jgarzik@redhat.com, linux@arm.linux.org.uk, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2012 at 04:51:25PM +0530, Viresh Kumar wrote:
> From: Viresh Kumar <viresh.linux@gmail.com>
>=20
> With addition of dummy clk_*() calls for non CONFIG_HAVE_CLK cases in clk=
=2Eh,
> there is no need to have clk code enclosed in #ifdef CONFIG_HAVE_CLK, #en=
dif
> macros.
>=20
> pxa i2c also has these dummy macros defined locally. Remove them as they =
aren't
> required anymore.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> Cc: linux-i2c@vger.kernel.org

Shall probably not go in via I2C-tree, so:

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+Wk+IACgkQD27XaX1/VRs8hACfYH8ozEhmJJw/R20q9c61RpKT
9DAAnRNyWKUS2NUoYsJwFG4dnMKLBTiM
=R4kO
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
