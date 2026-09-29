Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023563D9531
	for <linux-i2c@vger.kernel.org>; Tue, 29 Sep 2026 15:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696097; cv=none; b=BesJNx/bXiM4GapmldjpzwJm2Fj6V4Uo62/2uUmeJDEOJsTwu0YJFlJ/vlHJNrE9HSEQqJY9eu+oc09HbpFytG3T+laRoJgf9YSLcH2S8hIK6EhmMcY8XlRCRaS7IZqSpRHUPMoSQjGovIPwl5ZdL0LmIERIJR0IOeunZP6KvEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696097; c=relaxed/simple;
	bh=CSu1cXiqbY/jfZtGsZTi+5MN622ll/b5t0C05YWaEAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcKIZMzQD75J4/6V1RGyurY0mo7N16kaKehJu28yN99WiRsjSIKIAA7p3a2/z5NxvU/pRrXMsOL0nfMllJUzBYsP51qbRLusw+IvXsYMQL8lUZOY7dQSuI5aAQQ1n1heu1EZMXvrXk06/IgiueDuUauJrldGmOwtpFJ0MjpGYLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=TNanFD3t; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="TNanFD3t"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49fff72474fso16889205e9.3
        for <linux-i2c@vger.kernel.org>; Tue, 29 Sep 2026 08:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790696094; x=1791300894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bK1kRsPsOXdZFtj24JVUR5GYlNpzvwaq05tohnScRrQ=;
        b=TNanFD3tMdr3qxAyG/YamAhZSglLIl5FKaJrSDYj3abZDaBc0mrzSec56Jxqg9ozyi
         1UAtNVpfVKKpeOLRJ1ihZ/7COJaHHi1xI9wObDFnW7xk/pWit6WnXByryLHp24hGNnr0
         omrUzZKQjLvnrbe2S2hmegXU0vtK3pJlR6AicRXo6OhFH/Ur3OYgHRHgIGFzb5Nde13q
         E0pSLXG4nZ2FopCw4gMiMyVtHML0ZKiRpC2rGuJXTdopgVdSHANKP4QxPWJlUruSKASF
         wjpNv9/928m0/QJE9r78PF2k4B8gIi8MnOrgtXNhnefcdJB73fFJ9J7EagfDZ8vGGkM9
         OOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790696094; x=1791300894;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bK1kRsPsOXdZFtj24JVUR5GYlNpzvwaq05tohnScRrQ=;
        b=pP8eUIZP+f1xuyMV5h/7y/M38k39wbMNTMBt/79NwrGd/dZeP5d5VBYZI4UemO4DGI
         4ORKH8uPhY8hSRp3e8I6cekbMxBTp4X9DXkgPh+0P5VcotpszIY15xgdVv3MRC1ZQ1ye
         aYwrI5WgeL3XPuRGMCQJWYxj/rU6fEBkcqnj8oK+0voGeVa529R0RDQ1ixsP4suZuu0L
         KkG6oaPry7/ugKMf+1n27wOnj1EE6qIYuX8T/S40kWKOLGhAaMa1tgwM+MAsIbS92vQM
         nRXbyPXeTUsOH8p19n0W9C68p3sjXc8ef+/RKGRzDd8vWY3R/Hahdsdtwy+yPbfNWgi/
         GMYQ==
X-Forwarded-Encrypted: i=1; AKwUvBzNH4qxk7zIiQPoEEsPqh8b+eWprfViox7KLrzQD6+Du8Kw9pVN/frUCiQlMYEDG/qQbJO9tbMGr20=@vger.kernel.org
X-Gm-Message-State: AFuF++l6Cao9/6jkup13hMuh8+FVASeDlRqVsG/030Y86evLGuDTSIkh
	k76+HfEf4KmicT/Mgniecn3kw4Oh8UrFDWNZoTqRG5f/aaZFpiSh/EXYrhOqNJsBAL8=
X-Gm-Gg: AYBFou2SwLAzYSt3/kCTh2pB8IVvAVW2n0DsUUlMUBZMjbJeXADG6vhQfeoLXTuFohj
	EVwOSBIkdPWTwe7lvgqCR735Rgi56C7PaJYssktzeqtBIrXZBqmChYpJ2TL7dLb/J5Q0bVO++XA
	rgklsM/ZfOlQyfgSBNzlDitdW8joiSRoGGcrKSW8/UB1g6fCkFrB0o83EGsU4TnzlcyULY6y8b1
	4yANmev9b5BCmQTwJuCfQsmM5vKYWsOLW0kkTMUtV6hTTgr3PbQ4aFvw/MhLbi13gghwwUrkM5T
	PsNnRl9pPQZ2jBvUX4a4a/R0ONZr1OblQIa27Zsmig+Hw2MafrArUq6AqSI4JTlkRebxwUByl6F
	KclJtcS31nCrYX1r3c4HgZwBjUJafSEzeWSTZuswuYgg1g62MshBV3U+AeZpVU/Ju13i6lwx38z
	ih+jepI0uqIIggx+PYNHA7sBGVTNKZMM1IGLl7IQkDZA1afhbhlkTU6SweDvtJQfMMByVc6759r
	2KJXA1HszePe0whuzBGR1N8mien7uxTorXG5+VqvaYMoIhmWx+3K6nqaNc48e5BKPO5eHQ1
X-Received: by 2002:a05:600c:8b6c:b0:49f:ffd0:9a9a with SMTP id 5b1f17b1804b1-49fffd09b09mr145822235e9.25.1790696094266;
        Tue, 29 Sep 2026 08:34:54 -0700 (PDT)
Received: from localhost (p200300f65f19a904123cb16e9a8bb736.dip0.t-ipconnect.de. [2003:f6:5f19:a904:123c:b16e:9a8b:b736])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a00d0f442dsm81897025e9.13.2026.09.29.08.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 08:34:53 -0700 (PDT)
Date: Tue, 29 Sep 2026 17:34:52 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Frank Li <Frank.Li@nxp.com>, Lee Jones <lee@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org, linux-i3c@lists.infradead.org, 
	mfd@lists.linux.dev, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 14/20] pinctrl: berlin: support Synaptics SL261X SoCs
Message-ID: <arvZnEsAdJ5R9mBi@monoceros>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-15-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qdr5pu2vmyb2k4sk"
Content-Disposition: inline
In-Reply-To: <20260929061417.20733-15-jszhang@kernel.org>


--qdr5pu2vmyb2k4sk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 14/20] pinctrl: berlin: support Synaptics SL261X SoCs
MIME-Version: 1.0

Hello,

On Tue, Sep 29, 2026 at 02:14:11PM +0800, Jisheng Zhang wrote:
> +#include <linux/mod_devicetable.h>

Please rely on <linux/platform_device.h> to pull in the definition of
of_device_id and drop the inclusion of <linux/mod_devicetable.h>.=20

Including <linux/mod_devicetable.h> creates a bunch of unneeded
dependencies on subsystems you will never need in this driver.

> [...]
> +static const struct of_device_id sl261x_pinctrl_match[] =3D {
> +	{
> +		.compatible =3D "syna,sl261x-soc-pinctrl",
> +		.data =3D &sl261x_soc_pinctrl_data,
> +	},
> +	{
> +		.compatible =3D "syna,sl261x-system-pinctrl",
> +		.data =3D &sl261x_sysmgr_pinctrl_data,
> +	},
> +	{}

Please use { } (with a space) to match the most common style for these
arrays.

> +};
> +MODULE_DEVICE_TABLE(of, sl261x_pinctrl_match);
> +
> +static int sl261x_pinctrl_probe(struct platform_device *pdev)
> +{
> +	return berlin_pinctrl_probe(pdev, device_get_match_data(&pdev->dev));
> +}
> +
> +static struct platform_driver sl261x_pinctrl_driver =3D {
> +	.probe	=3D sl261x_pinctrl_probe,

Not a fan on aligning the =3D, still more if it's done inconsistently in a
single struct. If you ask me, just use a single space before the =3D.

> +	.driver	=3D {
> +		.name =3D "sl261x-pinctrl",
> +		.of_match_table =3D sl261x_pinctrl_match,
> +	},
> +};
> +module_platform_driver(sl261x_pinctrl_driver);

Best regards
Uwe

--qdr5pu2vmyb2k4sk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmq72pkACgkQj4D7WH0S
/k6pzAf+PhNU58V7LTtOu13Q7FpXZuGYfITE5o06ZTODsXEE48OgW8ZdwP7VY1Rr
OASvkk8I0b2igulZlmDQF6y/Uo8vr7BFFtBnDNLOlskSrwtGlRdlA+OxtblggT3/
ZtDs4aXeswkygIA/WvR5ypgSrpFZbf3ulmLpJxoG7wyWd2z20AE0RMgHMxWnRRRK
u1HPQWxqFS3vW0NsDLIGQ8yxAhuvL3DkQrfMVQONTNlqb9YbbJ5Ei9pHPDcYiggC
2NvAR0+Iczq3x7p1plWpq1ism4qNBPatzP3vOw+KMQXMHzNrOEICQ0lR54jlGDtd
U3aErEDsuZZpCY/HwikxQiabfzr3uA==
=ieOW
-----END PGP SIGNATURE-----

--qdr5pu2vmyb2k4sk--
