From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: st: Implement bus clear
Date: Fri, 13 May 2016 12:41:32 +0200
Message-ID: <20160513104132.GG1778@katana>
References: <1462983719-342-1-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BzCohdixPhurzSK4"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:53266 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752058AbcEMKlh (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 13 May 2016 06:41:37 -0400
Content-Disposition: inline
In-Reply-To: <1462983719-342-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, srinivas.kandagatla@gmail.com, maxime.coquelin@st.com, patrice.chotard@st.com, lee.jones@linaro.org, linux-i2c@vger.kernel.org, Frederic Pillon <frederic.pillon@st.com>


--BzCohdixPhurzSK4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 11, 2016 at 05:21:59PM +0100, Peter Griffin wrote:
> From I2C specifications:
>       http://www.nxp.com/documents/user_manual/UM10204.pdf
>=20
> Chapter 3.1.16, when the i2c device held the SDA line low, the master
> should send 9 clocks pulses to try to recover.
>=20
> Signed-off-by: Frederic Pillon <frederic.pillon@st.com>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

Applied to for-next, thanks! Please us PATCH V<n> next time.


--BzCohdixPhurzSK4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXNa9cAAoJEBQN5MwUoCm2eb0QAJhsTh4s7uXoF+x7rBrCjMse
IjjRphf10LkVnPKtN+mVTOFIKzXOn+XEuDEe4rxeyM9fOWYQ9ISyV7taqqxh7XgN
LUTp2K4GNs1KX89b8SBmk5adSqcXIoHh1xvKuI/C7ggzVHXoyfPWmj7K7xPFVcF2
EgvkMNmbQJDzhwrGZb9juUOAoF8/SiC1+54qHykE3Vg8MbpYl0NwSWZQWOYKaXJD
jOqyzkaEqzkRESKbgJDM/cGiHC0jHGuPesdDnQ34Kjx0fX6CQVjwMNSYVRGhEUbl
S04xz+KKIWi7Q+ryPHfa7rJRN85/yaf0E6UgOPigSrVP+pJRO1wQdXKgnqERhu/Z
EpZYaMnWVxzVI4UHBGkcZFF/y3AGMoSgzcNyOPzN42nDLuXtB6YamwqP22a/Evd6
C6mKNFauoOtOeg9QxRLguVCpiUux06brfdECpYcjSl8fnr/MM1mYIWG0nMtK6Ani
t7j/eLhghZKN3CAuI0ZAZHFWIjIu0mkVHJYDtMu45PwX0lsb1Y6tGDRnL+uWHEG1
aWRmiGutAmna96uDarpLl6+tK5v5AeRVnj0ly4FNceSJvd+IrFXy6yMMfNGo8YlW
JFZlrXa82dlUJs+qH2U0S1xQNT+8ti231tuOVxdxzGsiAfpk3w5Mql0MHK3sc9Gr
H81qmu/dTtvVO58tdfSA
=dYKU
-----END PGP SIGNATURE-----

--BzCohdixPhurzSK4--
