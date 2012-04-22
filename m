From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V2] i2c: designware: Add clk_{un}prepare() support
Date: Sun, 22 Apr 2012 19:26:11 +0200
Message-ID: <20120422172611.GA15041@pengutronix.de>
References: <caa4a0645f80f199b31ec16de37a5c4c9c67a6fa.1334652570.git.viresh.kumar@st.com>
 <b562073871c8c3c13a1f59698f69cfdf65db3b5a.1334662366.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b562073871c8c3c13a1f59698f69cfdf65db3b5a.1334662366.git.viresh.kumar@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: ben-linux@fluff.org, spear-devel@list.st.com, viresh.linux@gmail.com, khali@linux-fr.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2012 at 05:04:31PM +0530, Viresh Kumar wrote:
> clk_{un}prepare is mandatory for platforms using common clock framework. =
Since
> this driver is used by SPEAr platform, which supports common clock framew=
ork,
> add clk_{un}prepare() support for designware i2c.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

? Can't apply, which version is this against? Looks good otherwise.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+UPzMACgkQD27XaX1/VRub3wCfevLeEGhwxQ0b0s6DKF5yKz5f
QxwAnj7fqilV4GTgmsNj19JeKdka5TYh
=tksO
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
