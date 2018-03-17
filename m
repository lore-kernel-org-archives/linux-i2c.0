From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND PATCH v1 2/6] i2c: i2c-stm32f7: Add slave support
Date: Sat, 17 Mar 2018 21:51:10 +0100
Message-ID: <20180317205109.gocf5wemtjkyomct@ninjato>
References: <1520852023-27083-1-git-send-email-pierre-yves.mordret@st.com>
 <1520852023-27083-3-git-send-email-pierre-yves.mordret@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="e5tz36ug7d3zplmm"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1520852023-27083-3-git-send-email-pierre-yves.mordret@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--e5tz36ug7d3zplmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> + * @master_mode: boolean to know in which mode the I2C is running (master or
> + * slave)

It can't do both at the same time?


--e5tz36ug7d3zplmm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqtf70ACgkQFA3kzBSg
KbYPKhAAhB/xe4WF6v1z71ABqN3Xhuuxlmmki4CgFyD2FoO6e7mRvdnXREuIXBka
gTAjVdLGUZbq+y7NQ6VC6zJ3dJBCuDQlm2y5zPRMTdvd1l6Dz8sExCt+iV6+lEu+
z1rMTFezUD3lXsmU5BVxEKRdk112i/UWzwZNbqjIcTejSWKxnYgpZAIeOvytZpeC
hSq3ghm/3zmtq+sUd8bClKLbZQewlcZ/sMsR5KtpGz5oWbjk48sdYWOQgGOjPRnP
MZTW3GbYz04+zAsPRjNE4zoVUcSq5OBp5uRup3hSlRGTDvtnmU/nqrETDPHoH/h3
ea1NX0tgNOT0lDpvj1VM+3Xl6ifGaS+fteOIUwdH7E5VzzytWVfyW0K6HDHxPV1x
mEUBHJR++ekeIE0VNYktOFBQScz5MZYPIeibXOSaEWr/oxGaj/Pn6tFcLhEEoX8q
DI/1sNWCRIkvv0k0xjr36xzJfjL0ALuTO5ooDcsYDe/T09qRon9OZp49l2s2fazZ
LPXQQgw7UGTI2tThbczCIJmq1KFe9YFGChWTqmu0sPlL8s71kF5pZCWF8EUcPYP3
beSwcQDNOn6arLVrtdE6j6IRPaHHX/7hfPga+0phZciboQZQfIDnCGsdoLF+svqm
ZipN3SKG6QQQZ1UcJvJT66YaEOzD2fTdr6AKxD77PeEN+Ndmix4=
=6+I8
-----END PGP SIGNATURE-----

--e5tz36ug7d3zplmm--
