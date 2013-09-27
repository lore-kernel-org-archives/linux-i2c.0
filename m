From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-designware: 10-bit addressing mode enabling if
 I2C_DYNAMIC_TAR_UPDATE is set.
Date: Fri, 27 Sep 2013 04:22:35 +0200
Message-ID: <20130927022234.GA3159@katana>
References: <1380221855-14150-1-git-send-email-chiau.ee.chew@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1380221855-14150-1-git-send-email-chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Chew, Chiau Ee" <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2013 at 02:57:35AM +0800, Chew, Chiau Ee wrote:
> According to Designware I2C spec, if I2C_DYNAMIC_TAR_UPDATE is set to 1,
> the 10-bit addressing mode is controlled by IC_10BITADDR_MASTER bit of
> IC_TAR register instead of IC_CON register. The IC_10BITADDR_MASTER
> in IC_CON register becomes read-only copy. Since I2C_DYNAMIC_TAR_UPDATE
> value can't be detected from hardware register, so we will always set the
> IC_10BITADDR_MASTER bit in both IC_CON and IC_TAR register whenever 10-bit
> addresing mode is requested by user application.
>=20
> Signed-off-by: Chew, Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Reviewed-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Applied to for-current, thanks!


--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSROvqAAoJEBQN5MwUoCm2sUQP/2L7DmE4BzPRPoyOcXsLWYvO
JnkfKc9ngGu3Up/GWe/asNG3qghyY40yoGEBfdfPrAsUkSHK4V7aTqrOgeeNJfCd
JuU7mlKGOr7nosdTI6el/RJptaq5BLBKkeF29dNLrRVwappK0714T1Y1QaVnf5TA
m5Z1XudPHCfGjSEqP1jMWsnYcQ7X+Lz5jWyFyKZhpiS08sV0qQkxGDzoc4ZWqehR
voPMDL3q9g1Y/LBpgM0YWJ24kxM88ZsfwjsRvke0Aytfb48OEcGy/ljGzlJm4p6L
zSyOWPoysChh7IlUsR9RphccVhUEFdHPwqSGH/uptwqLT4dpz2JmXlNmZ56TMssg
UFNkoFQLjO31oDKNTETurSb3l9LaisuCkDJUu58Zd1a0MYu2KdEZFD5T16mV2X/G
pSO96SaBhmdCw4BZUlX5QHyc4ZKevngc0Na9SFYuFll+lSKgWvEeDQugNmxaAaNH
4tAprIu86rXxJ1BRZ5yxPhFgUnoog8oVjo5XaR3G+I5xVqe264to/JXQ4eKafSe1
2rSGNBJvNG5PcRQ3pfBIpFebADqDckhMch16eEMsc+iptJlRpHpNAIzTJwLCV1fT
dQgPvVG1m8U095PA3BaeHyLHUd49DpHmG5oGF6vC2YEIPTqqzL4n9NUnnxhngI4V
gkdue3DmtbfX6NFOMSfp
=Vw8D
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
