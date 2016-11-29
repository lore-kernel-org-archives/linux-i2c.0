From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [PATCH v5 1/3] i2c: pxa: Add support for the I2C units found in
 Armada 3700
Date: Tue, 29 Nov 2016 22:17:16 +0100
Message-ID: <20161129211716.GA15594@katana>
References: <20161121133247.29889-1-romain.perier@free-electrons.com>
 <20161121133247.29889-2-romain.perier@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:34936 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752270AbcK2VRW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 29 Nov 2016 16:17:22 -0500
Content-Disposition: inline
In-Reply-To: <20161121133247.29889-2-romain.perier@free-electrons.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Romain Perier <romain.perier@free-electrons.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Omri Itach <omrii@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Yahuda Yitschak <yehuday@marvell.com>, Hanna Hawa <hannah@marvell.com>, Neta Zur Hershkovits <neta@marvell.com>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> +	if (of_device_is_compatible(np, "marvell,armada-3700-i2c")) {
> +		i2c->fm_mask =3D ICR_BUSMODE_FM;
> +		i2c->hs_mask =3D ICR_BUSMODE_HS;
> +	} else {
> +		i2c->fm_mask =3D ICR_FM;
> +		i2c->hs_mask =3D ICR_HS;
> +	}
> =20
>  	*i2c_types =3D (enum pxa_i2c_types)(of_id->data);
> =20
> @@ -1181,6 +1194,13 @@ static int i2c_pxa_probe_pdata(struct platform_dev=
ice *pdev,
>  			i2c->master_code =3D 0xe;
>  		i2c->rate =3D plat->rate;
>  	}
> +	if (!strcmp(id->name, "armada-3700-i2c")) {
> +		i2c->fm_mask =3D ICR_BUSMODE_FM;
> +		i2c->hs_mask =3D ICR_BUSMODE_HS;
> +	} else {
> +		i2c->fm_mask =3D ICR_FM;
> +		i2c->hs_mask =3D ICR_HS;
> +	}

Okay, having the same code twice is not nice as well.

Sorry for missing this in the first review and going a step back, but I
think now the best solution is to have again a REGS_A3700 struct, but we
should extend it with new entries for the shifted bits. Then in the init
code, you can do something like:

	i2c->fm_mask =3D pxa_reg_layout[i2c_type].fm_mask ?: ICR_FM;

Makes sense?

Thanks,

   Wolfram


--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYPfBcAAoJEBQN5MwUoCm2zMYP/2zZPBjuw4m9kSms/yU1/i4v
bkSKOLUk+DK5ZTGFOHCvsJSmmQNQkeRFudYtqU/tZLFeQwha5MRbn+4piBIc9Pc+
YiaAQzB8zQkJug5/50yU4YiMvpy7r2Kz4jFHIN/r+SlVNrWbOjL6ugJ53SxZfi7G
wEHK4qFfzse11unrvqg8caA7Hp8skmuExvTI7DIWEyJIu91bjYnMakI30e0tUa5f
6DFKrISc6FrhbZmKv7/odJLivWws32qbb096WMoCinsAj5KLupW8PHfYaCTrXa+d
GE4Ym7vO15PYYFRWopBnUzCwyfp+AeejsWc6lS0I6PCQy2W3yLdSV4XovoHIqMGK
/CbkzWvBRaczXvHUvfjalwaMBmJXj2wymOBnhhI1+nMT5tJuGr7B4gDeH5IoP0Ot
1uYWO8KDePoHmDbnTwObtR+ZtU3HNTvA7uRlFN14mLzfehB25aRuSP7dbVTKnoAI
j8iJPyLTBL0TOosURUcwmkS0qi/W6JIv6C2mMW1YBmdDykpc/KOswElgVZn4EXLj
wAe7z3PjWJ8NMa0AseaGZWU/H3D1EM+5oa7lOqIr/9kca6p/RaV4gcLfGJk+LKE1
9RQKKZV4WDVqIEV4uAuLzlJCs1IqUXugaMTWAy34RjKH+KxyLeQy11fgY9UCg/iR
2BBsZNew+3A9ZKH+b98D
=WuGT
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
