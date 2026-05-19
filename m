Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A4039659E
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 09:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183642; cv=none; b=uhehmnAhtIJzXr8SW1hnJ6+HibS+DXNP51IgaMCuF72rOkoOCYlF4ryotFf2cQbL7sYMZQe7EY+qi5iQBv+mEX90s1ua6ThS+RYAoiPpBf1n9Lt4IRN+keiypjye1IKLvEg4x7ZYcjzFcNph7trsLwCfkwDXzal+jJpvDcsBhmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183642; c=relaxed/simple;
	bh=pshzHUJkdu3PQ/Kcm6hBV0ZAEQripBF7V7oLytU7FIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jeKCcAH2XiLG1z8RI0jifT9UZqUMBlUAO6rwATFjCwwI7tL3eXFh/krvXhBbtteURWEHDc2ZX/tRr5L1l8Nf0MDukui+ogRRPTogKGiIAuzrMzkI5yM5YSXTGhPhawEDczgwV90nBc+2ZQgpFYqnJoVbJUIC2obZkLdCUic7VVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=KpLjrzIO; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="KpLjrzIO"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-448528f4e69so2179688f8f.3
        for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 02:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779183639; x=1779788439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IuDdNxNDmVcfrFhj6oDMNkmSBwRwdmwiy8LlZ5l7KAU=;
        b=KpLjrzIOB10yEwnaKdYEu+4TMW6mFTYLWk03K/cj8B9QmpvfCv/f99wTHPIilMnVGa
         e5ynNXMI1G5bDsz0ZXMIzUnoT4Xn60o8N16mPzuVfrHrgoMbVXxhyh1CEJoIi7lsjGJ8
         Amx75DQ1NUqbywisibQ2+Reh4ssx5zppl8x35pwhNOxddqoDsbRkFLXZbPPAlqMoo4n1
         cCz8Auf0WB9bF4B7qLWzXbG3SknnWzf4vws/WbxwB8kh7Dv7LVevSRKUszMd5X/GtDZe
         rIkrGcvdYFmqxSbhWM4qv5N136cVhpjhO3Dt3RyH76mnkvqWhAVyJNGfyBYHubRocnPg
         daOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779183639; x=1779788439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IuDdNxNDmVcfrFhj6oDMNkmSBwRwdmwiy8LlZ5l7KAU=;
        b=CLrNgWF52MuyAm0qxwOjA0FXqsg1ySYrf5SfsmuQdxjdqOwdI6S3vohssyX91mY88t
         fhS1m3RLiYeuVP/ZMrUJnxPEhEMn9dtE7cv8XLxkJCjgEnh8qbk5mWc16ZtUAJGcRC+s
         +Js3ohU6B8ljhR9WqbgrH+0+x+kF8irouFWa40mvxKqTWpCbvo3wwXeKfna1WlEGpVFx
         PJvgzPhsIai2JsstYzkhSVA21x7uTaly02UNKGU0FeYz0U5XiY5Q+dEjswOj+zR5raCj
         /Jorfrvi3temw0RNfMc8WoHNUcmBUAsRfSGjIJYb7o64SzSOW8ZERPDwOKhsRvkHWd9H
         Bpqg==
X-Forwarded-Encrypted: i=1; AFNElJ8OaDSAh1e6hi9YVFfCyNOut6wuIsIfko10CN6PUEtLG1MeG9E5LiCvo8Cx/3rXlTjgjPWHVgFawEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaQeqUUioRx7WCQism4zw21VzAeb8t+FohZS4d1yoCDHMIY6fP
	jUuSKY7UGGqUvPZ6g0jGzFDtobtJDBDL2s1kzl8LEGbfxwYGpAIMTnl7mh6qsh6IfVA=
X-Gm-Gg: Acq92OFr+sJnODfpqWpbepRRZHG4WSc4doHqvVHaYEVvCByT44r9AUHsWSfZVFt+MPv
	8K94NQw+9rDc70A7p8yi7TuG3y8IO2ArIJLGS1h+bEKiKzLx2C5TRqacnsP4mwkSLqkrJvKaxRe
	0U8zW7EO5VoxOpVjflz7NHyfar4LtK7RuXe1/EuR4ijYBdoJd00P0jMCcsXi2nFtfnngfQLNHju
	yPojGxx+vaNaZt3XSp2q3vT19MQZ+ZX8gU9CENYS+ta0wyvR99bz+cK4NMmsvli/lYycalGivDI
	vkSSTH7ijK2QJ8ycX/FpHQEdkvqERFXimb7LGQdT1fBVq9JsCbGWZ4wjqeti/GT/kAPprpbBOLY
	rAhAPF9FS+LCcVIXXl/QLIKSq/qg3flQxGbWeGTmFxpLX7K9ODeQbYkNHw9b/K5cGDGIUEWj749
	jyFIUbv2oNRvm/NiGUE5/ynxlKKdxAyFZYH5XiV6jjEwsvgFHq4cR0fHD6vrxAnZIR+QeDTU6uf
	QQZH9JZTFYCUPs=
X-Received: by 2002:a5d:588c:0:b0:441:3144:efc5 with SMTP id ffacd0b85a97d-45e5c5db173mr29703604f8f.42.1779183638649;
        Tue, 19 May 2026 02:40:38 -0700 (PDT)
Received: from localhost (p200300f65f47db0428dec7b135f55767.dip0.t-ipconnect.de. [2003:f6:5f47:db04:28de:c7b1:35f5:5767])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45da0a1a22csm43427008f8f.19.2026.05.19.02.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 02:40:37 -0700 (PDT)
Date: Tue, 19 May 2026 11:40:37 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Eric Piel <eric.piel@tremplin-utc.net>, 
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>, Akshay Gupta <Akshay.Gupta@amd.com>, 
	Guenter Roeck <linux@roeck-us.net>, Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>, 
	Chen Ni <nichen@iscas.ac.cn>, Kees Cook <kees@kernel.org>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v1] misc: Use named initializers for arrays of
 i2c_device_data
Message-ID: <agwvkt_iWF9UUR-t@monoceros>
References: <20260515162734.469327-2-u.kleine-koenig@baylibre.com>
 <CAMRc=MfxgY77TozGqUsWrjsTmBKnZLm0dziAn1JAiTok67RXnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fhzbe26sirahd6ku"
Content-Disposition: inline
In-Reply-To: <CAMRc=MfxgY77TozGqUsWrjsTmBKnZLm0dziAn1JAiTok67RXnw@mail.gmail.com>


--fhzbe26sirahd6ku
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] misc: Use named initializers for arrays of
 i2c_device_data
MIME-Version: 1.0

On Mon, May 18, 2026 at 09:53:08AM +0200, Bartosz Golaszewski wrote:
> On Fri, May 15, 2026 at 6:27=E2=80=AFPM Uwe Kleine-K=C3=B6nig (The Capabl=
e Hub)
> <u.kleine-koenig@baylibre.com> wrote:
> >  drivers/misc/eeprom/at24.c             |  62 +++++++-------
>=20
> This drivers lives under drivers/misc/ but I maintain it separately
> and send PRs to Wolfram so they go through the i2c tree (historical
> reasons really and maybe we should move it under drivers/nvmem/?). Can
> you send this separately?

Done
(https://lore.kernel.org/linux-i2c/20260519093806.1567914-2-u.kleine-koenig=
@baylibre.com).

@Arnd + @Greg: Should I split off still more or is a single patch for
the remainder of drivers/misc fine?

Best regards
Uwe

--fhzbe26sirahd6ku
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoMMBIACgkQj4D7WH0S
/k6hUgf8CgN1Zkr1U07z+QSKAKUhWD9AWAdsw3udxT1/krMtkygb5zMaZLBsT8EU
IeA30XmmJ4jV3ew00Cso7k16fXORcW8itfhlcG59IwxM6h4lYKFXJRBHbSaV9GDw
XypERkINHH0Wp7pcUxEtFxBaoE3Z/nFRmPD9l3JKg8qHfwx7AgxOeLOSlaoqzF1z
BLnOiZgXph/3tkTsSdqaDxOvVBBSIJEtN0jWlfLKzpjd1ygsQCGHdb/edQzU5hwB
JQThWYBTFn1hvFFLMc38scfNfcIhSsAj5oyepkrz1+pflBLkplnTXAG+ldEedVUR
A3blBZ4j2mGZg9RPfYel61lGcMMHLw==
=cfcM
-----END PGP SIGNATURE-----

--fhzbe26sirahd6ku--
