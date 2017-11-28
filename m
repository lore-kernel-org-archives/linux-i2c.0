From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: designware: fix building driver as module
Date: Tue, 28 Nov 2017 10:48:39 +0100
Message-ID: <20171128094839.hdresfrxel2lobon@ninjato>
References: <1511838551-4035-1-git-send-email-preid@electromag.com.au>
 <1511838551-4035-3-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sjh7um7h3uplgyro"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:50555 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751716AbdK1Jsk (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 28 Nov 2017 04:48:40 -0500
Content-Disposition: inline
In-Reply-To: <1511838551-4035-3-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, sfr@canb.auug.org.au


--sjh7um7h3uplgyro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2017 at 11:09:11AM +0800, Phil Reid wrote:
> The designware core and platform are built as separate modules.
> Export i2c_dw_prepare_clk() so it can be used by the platform
> driver.
>=20
> Fixes commit a34a0b6da22540d19e57
> ("i2c: designware: move i2c_dw_plat_prepare_clk to common")
>=20
> Signed-off-by: Phil Reid <preid@electromag.com.au>

Applied to for-next, thanks!


--sjh7um7h3uplgyro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlodMPcACgkQFA3kzBSg
Kba0dhAArhppMqSsprhryOKTSdW6pz2FfqWD0j1cJPGZaFCqeogHfvAhdFiuwJYt
WkU2It2BtBa88n9DjhoiKa7i6+Uepy4p4iy54S/CpC/RIduvGnOEXE6d8phSAKMi
LC09eUfZYwjupxT+FtYlPoL2Fvbh/HcDCVr8ssDCH3ZVIa93wjOL4U8eiTLGPsGD
rAUl2vYzYQJzHG89TTi7pMZKFZXcPYnbachgJRXjDw2Jo9WQOYvpRmyXZz/KubMf
R7s8GRqtfp/EyJ1Cv18uCPGq/HvAhkeHijLwQj22zICF03W09kadLUPdoEUS3o8S
PjzSze4wPXrL/UwAY6HIzIOUj2ZwsilBLla7RE8Jk40eH4QoIRET5K+EsxfZfBER
uJ2uH4g4YhRql8BxjP/go3PKtK4tuJgi918aLq7k8Zt72VuS7dZkV9IWw5C84wlz
lzw6J+A030FrnJoK6hlFDXMruEBkCclLlIpa+rTV7QYoiaXEPg/7/Q1ulxZ/n23d
guMXmSUFCRGk+G/h1gSwnq9trnZoSB+jJ51l58u045+cq2Z5zj1xqgNKCMOXUhKF
n7GhyiUa6JH/VCfSF8KEKI8I/HxOzKggKm8Don4lzQhbZ89gKhwH6hy1Sw1+Q0eT
Oojvv0SI/LgZdJrK7zL5vIbbNV6rpRmFJDniICEIJsZeizukcDQ=
=2qSL
-----END PGP SIGNATURE-----

--sjh7um7h3uplgyro--
