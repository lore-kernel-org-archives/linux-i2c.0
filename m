From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 2/2] i2c: New bus driver for the Qualcomm QUP I2C
 controller
Date: Wed, 5 Mar 2014 17:44:41 +0100
Message-ID: <20140305164441.GD9228@katana>
References: <1392943090-30556-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1392943090-30556-3-git-send-email-bjorn.andersson@sonymobile.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fXStkuK2IQBfcDe+"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1392943090-30556-3-git-send-email-bjorn.andersson@sonymobile.com>
Sender: linux-doc-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andy Gross <agross@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>, "Ivan T. Ivanov" <iivanov@mm-sol.com>
List-Id: linux-i2c@vger.kernel.org


--fXStkuK2IQBfcDe+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	qup->adap.nr = pdev->id;
> +	qup->adap.dev.parent = qup->dev;
> +	qup->adap.dev.of_node = pdev->dev.of_node;
> +	strlcpy(qup->adap.name, "QUP I2C adapter", sizeof(qup->adap.name));
> +
> +	ret = i2c_add_numbered_adapter(&qup->adap);

I'd suggest to use just i2c_add_adapter and let the core check the
aliases for you.


--fXStkuK2IQBfcDe+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTF1R5AAoJEBQN5MwUoCm2QJYP+QFFUSdwQZ8S6Aa+5YJiAtRO
jMJ0fltXISwkBYvTsqH6dg1aCH/LWnlKPv9crbez7hYegphmtuaeP0gQW6GTM9MD
P14aSD6aYlpuLPiTD9n37KKiRapIZuu9/h/XMO/ii9W2bvQGLWnp6D68OQE4dcOl
Ggogl0C6szbdR66j+AsHRvUQ+QDTaQH5qrSXHCFXnCVNZI++1VWgMkVKEQaICt5N
NsHgYXgyRwQYYPnhqZ2e3Mb9ditwyOEwdqLkQHuSh1OAuNYIXnRAgTTKGuisj1l6
ERKUVEwnT0evBVPE2hmu92UBSZBITOOh/izqnErB6iURLjujSJGtVHo3fTi0Tcue
2jOU65LZ57C1dq7/HqaSfEF24kE3ihhn7ELDr5m8QvGHUhbziT3rq616qkx5OpAY
R7vf+FOyzI+4VcT4ytJ/AB4/wsaNb0me8vbXzAW0xQSgT2Lf4fNrT9lsEh9HoDSa
o19YvM63yf+p+CRkVdXpaM9oDtP/i1AzGHaSvCxeq/uqJY8dvs2SwQZv8qps0w3e
saPJO4sELF/bzpPfVgrEogurZJUai2KB0vk8mnC4MJZdcENmAOgC+ges8Cv2MtRZ
dlA+NkgKMSxjD/miVaaSdrIRHa4MnHGY6KLStARBV17730GZChRW43YNOLwV7yzq
fAbuZpDUjS7GvLgUUvuF
=bD97
-----END PGP SIGNATURE-----

--fXStkuK2IQBfcDe+--
