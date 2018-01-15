From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND, 2/4] i2c: mpc: unify obtaining the MPC8533/44 I2C clock
 prescaler w/ MPC8xxx
Date: Mon, 15 Jan 2018 19:21:51 +0100
Message-ID: <20180115182151.wvynwprpeev22yhi@ninjato>
References: <20171207102003.23496-3-asolokha@kb.kras.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="krn5gyrssjb76h6f"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171207102003.23496-3-asolokha@kb.kras.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Arseny Solokha <asolokha@kb.kras.ru>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Valentin Longchamp <valentin.longchamp@keymile.com>
List-Id: linux-i2c@vger.kernel.org


--krn5gyrssjb76h6f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2017 at 05:20:01PM +0700, Arseny Solokha wrote:
> Commit 8ce795cb0c6b ("i2c: mpc: assign the correct prescaler from SVR")
> introduced the common helper function for obtaining the actual clock
> prescaler value for MPC85xx. However, getting the prescaler for MPC8544
> which depends on the SEC frequency ratio on this platform, has been always
> performed separately based on the corresponding Device Tree configuration.
>=20
> Move special handling of MPC8544 into that common helper. Make it depende=
nt
> on the SoC version and not on Device Tree compatible node, as is the case
> with all other SoCs. Handle MPC8533 the same way which is similar
> to MPC8544 in this regard, according to AN2919 "Determining the I2C
> Frequency Divider Ratio for SCL".
>=20
> Signed-off-by: Arseny Solokha <asolokha@kb.kras.ru>

Applied to for-next, thanks!


--krn5gyrssjb76h6f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpc8T8ACgkQFA3kzBSg
KbZZ8A//SPo07P/TWqKCoDtUuTEdyef+OrDpiCR46pyf5TTFWku21b3tp2CibGU0
kd5yQq0lyRyUHm06Qc8z14A4YPyt6470K2ac1asVLTAlHb3xzx5KAi+XcbQprKHI
K4tMcDWMB4acz27beoqfowZK17TMJieHe85096BfVOqmf4fiBUEGfbqbqQIlrZtP
FvLre4DSqIKwm7/3HKCauWqQlQdZll5e0xZCcLbxFAPOpjAv/+UZPmSRJigG5+lc
FjuWizavaP3JJLfympWScjABOkEuXq9qPSg3yV9jc0GUMy1db/TuzgrNkWFzs/4y
/6tZf86zcBmAJn0qDmovS+esgAXAZ9iyGdvrweP61GJjBKYXoaj3oydJpF/ZmrHp
49JjTieCkFntRmPr3h+2Pyx/pQyf3aijrVH26WoTxEzzvkP4YzmCWbsN6ZU65TrT
pk89H73rh0JI+QMIZYdh5HZIFfe8ufiqZFQZRhtLGAMNeEjXkTu5LwSSvxZkRRpM
3/9I5OiKyRdgsSL3LW8JxPI1+rBftAOk75FhfJ9GSdGmi8Ff0qPMs8CpvfbG0Sas
+Rge1HKICVtU6JBzShtU9F8zsxR7XSE+Y1X7KOkRjUtivfWKTQpAsHyHE3CFALma
sXP082SvvJi3pktwJnLJP72TBk+bG6JE4YscZDObQQtyEYHLyz0=
=F6Vc
-----END PGP SIGNATURE-----

--krn5gyrssjb76h6f--
