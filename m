From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6 3/3] i2c: add param sanity check to i2c_transfer()
Date: Tue, 3 Apr 2018 17:03:11 +0200
Message-ID: <20180403150311.7gpvcga33eivlyms@ninjato>
References: <20180325110747.8852-1-ard.biesheuvel@linaro.org>
 <20180325110747.8852-4-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2882548356858760168=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180325110747.8852-4-ard.biesheuvel@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: andy.shevchenko@gmail.com, jassisinghbrar@gmail.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============2882548356858760168==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ut2qzodcgzk5o5az"
Content-Disposition: inline


--ut2qzodcgzk5o5az
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> +	if (!msgs || num < 1)
> +		return -EINVAL;

I think this case justifies WARN (or WARN_ON, I always mix them up).


--ut2qzodcgzk5o5az
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrDl68ACgkQFA3kzBSg
Kbak3w//aFK+W6GBWFFJ56MT10C+BWjYTSIbEbIEfzqXWVAAgLJlLuBZWc5VsmWT
8lAyOpDjWTLZJG9cWFfn/j66j18Iozky7JlywsuUxhm3OqkfhUdd/WWo4Zopjkgp
ZdHzM8Vmx6GHpX9ApUzon/hwG1ktepyQLpJLxEd1khbpdaHQQDePA5cUf6sQn9dq
gU2dnt0twI85E8YklHeddJGIou1F9MXuisDmb4zkGiuDnbe3d/4sRnOV9/43l0k3
VvFJQKDQcptLGGeaacVa4slykW8pytOKynKeffg0Ub3VY3n6qBozrH1kfHwYuXW8
SMO48zMONCxRP8/Rjg0zCTRZKSHfSe32nqG2tiGyi6VfR6Z1XJl/A78VMnSaPkvO
B2Z2PnA7lTLBeGENawJhj3whw+8fhlc5LjIHzgSmhKYRgwvXddL/Yd21+nCNyZT5
dDALQ5TGMTzVzPptbQUoJjkiRgvniX8Vk2KnCeKEjeXmub+Vyl20wWrPPdGghf2F
4A82VNNgcFGlIdRl0doJ/JWnb5bMTjLh5HNrniN7l7+d9L3q+3yyKkXn/m6a+eT0
KUN0Tfiqhu/ADl3G+Hd1Bp1VKtRh4Eeu1BEq9VtHoVF9C92vd1+EQwJhlhhIy/ub
j7msSTq2pEPRqVcQ6rsZvhYx1yupSSeUZ8qY0MCvxrQGBS4v5nQ=
=g/GO
-----END PGP SIGNATURE-----

--ut2qzodcgzk5o5az--


--===============2882548356858760168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2882548356858760168==--
