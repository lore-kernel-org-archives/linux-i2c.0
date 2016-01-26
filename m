From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] power/mpc85xx: Add delay after enabling I2C master
Date: Tue, 26 Jan 2016 06:58:27 +0100
Message-ID: <20160126055826.GD1533@katana>
References: <1453190225-37736-1-git-send-email-ying.zhang22455@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51163 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785AbcAZF6b (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 26 Jan 2016 00:58:31 -0500
Content-Disposition: inline
In-Reply-To: <1453190225-37736-1-git-send-email-ying.zhang22455@nxp.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: ying.zhang22455@nxp.com
Cc: linux-i2c@vger.kernel.org, xiaobo.xie@nxp.com, york.sun@nxp.com, Ying Zhang <b40530@freescale.com>


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> +#ifdef CONFIG_PPC_85xx
> +	delay_val = 65536 / (fsl_get_sys_freq() / 2000000);
> +#else
> +	delay_val = 1000000 / i2c->real_clk + 1;
> +#endif

Please don't add #ifdef for such things. You can make use of
struct mpc_i2c_data and put a flag there.


--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWpwsCAAoJEBQN5MwUoCm2vjUP/1Hx4tG0KMFB/CA/Gg+FwNWX
rRq2KH6nCtkDZnAFA1jnnRT0ClezqymysJRo9cinNJoRhBndLEJDz61I+Dr1EaRY
e3YH+/IPAf3VPlEf3+9V4NKdQg31tgap0Qt3iTUPPi+mrsl7uAtmzhZJQErdll9s
+VFdNJG/0fYAsrc3+gSd/dSD53OVaBAaB9c2eveXoGI9QJQyyOeyiFIUi7bI4OPO
NdGxhZmIZOIjuj48xd8dv6vYZLgMq8Mmb5/nBUSnWDmjst/Eod/FnnQF42GmAzSK
e3Euz8YP5E8DFHZlGcNSsCPQHVcjaAXRevt4FVt5Hr6tqgNJdSfK4Su10ZurOHc6
UAZQ4pPevwVO5X+Igu3liNFDv55W1RWVFsCoZrY22KzxoPEdLJOX2LeRGM8YwTs1
hdSCrMqLY5v7V4Dsockm0eWq0reeyMnIATCZFun+gyzdTYw9RcETmO/C8JULf9Ia
d8L4aM3+ask2mN1etVtvSktSQkZ8TjeCEcIk/KGC9lTFSj1SeKIkKkB1YE1REK/j
r/jvPfTcvMeUTEs9iinTnbR2AvjhuHyYsPHw43xKrz1T9OXkpD6q33ytnVP9a4Ax
RLgi8GkhnGsVVFw3oPTlCNNZ6Keas14ePMfE/C4WIlrYO7cv7DimxGTKZiK7+O+4
FduW8lvwjYE0wTAN0S6S
=Zhxl
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--
