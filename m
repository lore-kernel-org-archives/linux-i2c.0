Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9D42AE77
	for <linux-i2c@vger.kernel.org>; Mon, 16 Feb 2026 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771233726; cv=none; b=rtosHOYSZLPXr03RvEKQYN85uBpj90cVWalWYQc+/MssRQz2yMDLze81jqkVt+a2NhYYcP53vXunSWXF90BIuFB6MJe/zOL1lst1HTQEZO7i91eKoQy25pL96Pk5+LgwqQLbUYwDDMtNnRNX/YPHpfm9aiYk7TTp7P3rhyHQI9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771233726; c=relaxed/simple;
	bh=9vVt/M8Zf7dfYvjhGcLF+iwb+7V0sMWjCW655yCRpYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTU39kXQouKUxKct/XrI2GlLs6vA1vNlOExjqtDcOJrVJDxovhSNyTVqoG5aiJcX18WYJQQWDjfZjwyvMzjm7Tys+vn0MRVAIivjHjpRWpuEjkKqxiDMNT+A93xXoBnefCdH9mUwrZqKibrFPYRl0EQfxEaGnE4K7Tk8GAEYI4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kARttwNx; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kARttwNx"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3871126dcceso23077151fa.1
        for <linux-i2c@vger.kernel.org>; Mon, 16 Feb 2026 01:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771233723; x=1771838523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UarNnN2KNK2j0++meMQ9ppJ7gBS1qqj3ee9dbEJEimM=;
        b=kARttwNxLimdpbz/dyF1HzLDFr3R+2q++/OwPOfwFWkNzPISkBjkgZz7ROwe9TqM4G
         SMOVBkuExR/90E0+imVBXsAxXjykufOFChfcPRHE7phZ1VZIK9pMKDK+sGeqAi1hwfD7
         FETfJDSTQ2Gs32UI+nloX9rEIVwMewDwFmxNSEnxYv/u0oOTloeiKNedl8Y4zXV3GTSD
         pNP4hV0HjlflONv3orylImmF/OLgSPlz9dWjAJT4e6K0mBwv+qde0AL/YidCAQJP4yEH
         Qw9A/oJntHELb3S/tLKBRaMQwYbztTsyDdqQxHqyr+VFwZbSAjEaNF29uA0rZjvVpHHL
         q93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771233723; x=1771838523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UarNnN2KNK2j0++meMQ9ppJ7gBS1qqj3ee9dbEJEimM=;
        b=Losxf9kFCqSrI0In4qeMNEleGLqhyjeWB8MXVlpPc7FqFOvtqIbUzUYR44HGAJbZEV
         7fmB2Z09UvMvvAceoufddBoDU75Qt4mIvm+RjJh+cbSYcBvDgARGw2ySqGgbmnJnRy2P
         SsGbpiejYwoxatHAfZ8aq8fi4fqbBUn9Si9llDrMz4ecKefgluMaHGPbrzUoE3ERRMdj
         V9o3yZagOU9Ey/9WYOBGVNVlDl/gv98UsWz0R5TfmOD4qRnSHMGLsp5mrjPMaG+/K0XW
         FT9asuOrfVI6YfQD1wLS/XA3dYhP5uqjs7mlD0/IMHPqgVZO7EaKkTJWkB6VAcyh4Efi
         9+ww==
X-Forwarded-Encrypted: i=1; AJvYcCXmffXTkYebOC+izDr3oBjAgjjFIS6nrAzaLyJeDSWepUZEKaocyg9q9B9dy4Uc5tWMz7uzR+6mJwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YziOv/hHJ8FYbknh2Di1sxk6nkmxXVisSftAl2IR4BeWkDXztTG
	Ro/NbRhvjunKwl9jTNbRImpnsgln+ziBVZUhdDtJ+cZTVoHnnPVr3nip
X-Gm-Gg: AZuq6aJbwoAI4tTWmCWxLAstW8MuYWZ/dTIL3kDtoRWO5G28Im5anbbI8iAFsqYwllE
	wUZfcjrGHUb2JS7PijqCBj7drrmjwS6WdJfHGh33hWEgDf97fKN0xWOIeMaiNdTyh7waW83F63M
	/+Yq82i9LvQrUATGD+bt4GOr09sXT13sD96/Zulb3EZvQrK7EAzOqaIV2zJ7dw1KIW8aj28ZWhC
	AAEkLBtbcD4wNTYxxPlsVbDQ3ycYGQsYoKKCmPw/INCZuLJZbFRQ/xy/0D9fo07tykMwb5nUrqi
	AhCB+ErHAcrR5hmx0CO84VaMoUui6nyzHQJMwn+L+buLWxrLlZEbZquw+CxDF8f1W+PbG0nUKxs
	srDAlXdYYEc7CUXmswVsh/8LjABJqC4blIPD4vRgNnqtDPGFnlrnUReymlux05BaquRSXYx5e9w
	/MixPVL08u06KGJspQWAtcLx/5JNenbq2jWZF0D7x5xzZY919VbY3EE4UtQQgIGIrLT8U2hDY=
X-Received: by 2002:a05:6512:ad0:b0:598:8f91:6d0f with SMTP id 2adb3069b0e04-59f02837b34mr3533006e87.50.1771233723135;
        Mon, 16 Feb 2026 01:22:03 -0800 (PST)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f568bb7sm3132045e87.25.2026.02.16.01.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 01:22:02 -0800 (PST)
Date: Mon, 16 Feb 2026 10:22:00 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/5] i2c: core: add callback to change bus frequency
Message-ID: <aZLhuIfP7rh7o3MH@gmail.com>
References: <20260213-i2c-mux-v5-0-fb2cbf9979b3@gmail.com>
 <20260213-i2c-mux-v5-1-fb2cbf9979b3@gmail.com>
 <aY8HfN3c3qcVbOJj@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1s4Vai7zOQ1kU7EG"
Content-Disposition: inline
In-Reply-To: <aY8HfN3c3qcVbOJj@black.igk.intel.com>


--1s4Vai7zOQ1kU7EG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Fri, Feb 13, 2026 at 12:14:04PM +0100, Andy Shevchenko wrote:
> On Fri, Feb 13, 2026 at 12:06:50PM +0100, Marcus Folkesson wrote:
> > All devices on the same I2C bus share the same clock line and the bus
> > frequency has therefor be chosen so that all attached devices are able
> > to tolarate that clock rate. IOW, the bus speed must be set for the
> > slowest attached device.
> >=20
> > With I2C multiplexers/switches on the other hand, it would be possible
> > to have different "domains" that runs with different speeds.
> >=20
> > Prepare for such a feature by provide an optional callback function to
> > change bus frequency.
>=20
> ...
>=20
> > struct i2c_adapter {
>=20
> > +	int clock_hz;
>=20
> Why signed? Even inconsistent with the parameter of the below.
>=20
> > +	int (*set_clk_freq)(struct i2c_adapter *adap, u32 clock_hz); /* Optio=
nal */
>=20
> It's already a huge struct, can we make this compile-time chosen
> (when I=B2C muxes are not required, for example)?

Hrm, many bus drivers (k1, jz4780, stm32 to mention a few) already have
the clock value stored in their private data, so maybe it is better to
have this value in a uniform place in the i2c_adapter struct and make
those drivers use it instead?

Best regards,
Marcus Folkesson

--1s4Vai7zOQ1kU7EG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmmS4bMACgkQiIBOb1ld
UjIochAAzvzsvYXR0NOI143dfUe5xvJqZCtvPGYgopBVydOd6J6rG4V/WRA2vqJU
JOO2f9+Ry9gQEGYKKhbUNMftM8mUqS3ePmOBe1CWKf064HPGOYENXEBTl1yHzHWT
qzMXoi58M3OMDxiJEysPSVG07ivJjwd8FOdCLOjCK6u9o+PKJ8vOP04ii85YGoF1
vFg8Xv1GlrNC+tCYojbzng7ItEhrkDhHjDsJfRzLwcK4xQV+eMqWaufRGxz49Bov
wLhKIDCnltp2EkSBpgHC8MJgwB7VAowwf1JI+fyq0YqEZJj67P2FqX+K8dsJ5Lso
5fva5ROMuqXcR/DNhTQVPpwUtwQ2RTFGmBO9pPSMZEwWzWM3rvtYK1H4KpKMb/go
rtc9x+WeggLeDTPnGcWGTNdQL3TuOfF+X3sJ7VWXhVVsz4x5SmekacvveUmO0QHg
7gdbtURVmqsexkBjX4bfD3TgPipjoHrKIr8MEB0afrOQ4F79U6iPfRgsWJ6FSeGt
9qQdC7JrVjWWlAIRAYHqWl8nsoRaKCYundYeKPCd95+QUUouG/XiluOp6uxIeDbA
2pqA1ALPLsEug11bqjWj5jRWwACBPXS8jtiuMx2OPkTYxq2+AZGmX6Jb26BAZy+b
8vtZNaqteC/g2YcjyNoyQRI+GmVPrzK40GW78RtZ6WrDBj54rAM=
=MC3m
-----END PGP SIGNATURE-----

--1s4Vai7zOQ1kU7EG--
