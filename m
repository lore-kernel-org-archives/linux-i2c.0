Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0AF38A737;
	Tue,  7 Apr 2026 11:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775560414; cv=none; b=Ly4vtAzJbamJpcGUAbWTjLnOECOIVEU1V5wEc/3386LwuYXmhL1YeBxTzfbUaRVpHuMlSTvf0tBB6iPIrgyWK1KDIJxXn2SRBYNBgVxIVjEmzQf9F/hdBCYrJ6Q8mAJaQdepk2keTttuTjBSAIpUD3PvO0KL7E6Lzdk1a47gyiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775560414; c=relaxed/simple;
	bh=AgYFjv/b8/kAM7bYi11atGucAxP/byBUmvlTYf29I1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nemIiuIIkosR13XyrgJuv8vTUEpydwVmr2J35Mjso8aHDLMbgnPhair2du6UUgmxA6shOUBgadChUZ+4KyVKBf8oC3P0brq5QgryLGr2aBsQDS065PzmJWC2GIWzZP+j3mBDd3GxFD0wnjKeeFbiHxNVNBDYlaBSFubqQTpnyVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgthAHsf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgthAHsf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E77BC116C6;
	Tue,  7 Apr 2026 11:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775560413;
	bh=AgYFjv/b8/kAM7bYi11atGucAxP/byBUmvlTYf29I1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZgthAHsflZTX7PQU4IhOn2KovAJVxbLWLvoPdPkg9pOhLFur5UGQtA06JQRaIjc3T
	 YeXR9DkmONFl8B1WFgk2sERv3UmZsrsTwPE2UY4/+YM0oOPPBEUXfbJvxurNNTOLEo
	 kHwloCsdI8jXYHOz1LeHY4NsRtKwNBgSEClK9rxPE8VCuSpL7av8+OwBWXoXHjZrjh
	 jv6yRW8ui2Eli4Z6AQH70/oceKHOgY2hLmrfrhuDuVlHJ3Z846aggYta3RgZDKIsvf
	 GcM1vgqnmBtNtvbkmZWjOWqNxkBYaOU2vOUksOm+fRHGeZ34RS3fjsBe6uBhgDsg5z
	 igf3pU/oZohsg==
Date: Tue, 7 Apr 2026 12:13:29 +0100
From: Mark Brown <broonie@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Nishanth Sampath Kumar <nissampa@cisco.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	arnd@arndb.de, gregkh@linuxfoundation.org
Subject: Re: [PATCH] at24: add SMBus fallback for adapters lacking
 I2C_FUNC_I2C
Message-ID: <c8d3d26e-56e8-4606-b44d-dbd074855846@sirena.org.uk>
References: <20260404021920.359902-1-nissampa@cisco.com>
 <CAMRc=MeViuN_osCsOXZraXJJU82HW01MhdwRT=sHdkYN2BrTRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pEM/sj99eDJDXP78"
Content-Disposition: inline
In-Reply-To: <CAMRc=MeViuN_osCsOXZraXJJU82HW01MhdwRT=sHdkYN2BrTRQ@mail.gmail.com>
X-Cookie: Now, let's SEND OUT for QUICHE!!


--pEM/sj99eDJDXP78
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 07, 2026 at 12:54:49PM +0200, Bartosz Golaszewski wrote:
> On Sat, Apr 4, 2026 at 4:19=E2=80=AFAM Nishanth Sampath Kumar

> > 1. AT24_FLAG_ADDR16 EEPROMs (e.g. 24c64 syseeprom):
> >    regmap_get_i2c_bus() returns -ENOTSUPP (-524) for reg_bits=3D16
> >    because neither I2C_FUNC_I2C nor I2C_FUNC_SMBUS_I2C_BLOCK is set.
> >    The driver probe fails entirely with:
> >      at24 3-0055: probe with driver at24 failed with error -524

If you can implement a fallback for whatever configuration this device
has then you should just implement that in the regmap core.

> > 2. 8-bit addressed EEPROMs (e.g. 24c02 fan EEPROMs) behind a pca9548
> >    mux on a PIIX4 child adapter: regmap selects regmap_i2c_smbus_i2c_bl=
ock
> >    which fails at runtime even though SMBUS_BYTE_DATA is available.

If the device is advertising capabilities that it does not actually
support then the capability advertisment should be fixed.

--pEM/sj99eDJDXP78
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnU5tgACgkQJNaLcl1U
h9BO2wf+MZqvpOqtnWWXwRaaNP0bU4cFWGjC8pHD1m8ft9fipq4sRvy/V60d8Ng7
GUcbQYLQPRVq0L74NZ2bYWMFAK+XjDfBZ37KHwEQA7QqItDD4JJeE/HHj0qtLq6n
ZFXGZsyrgDB0Q4ZO31AZJTXmNR07COh7ayeNRSRKdGacEk3u81YU3Hdc5BB07t0d
B+182XOBLD7pODruteL5IoRJ5FrDaNJfN4kXB7PJg07Ht+8JTQsEbSRJi1SdJdij
SeMjNpDk9dcwdpwySkF5LXe6juwGrON+5vLTafbmPPn/HdZF6g4AjBEhx7MRjPZ4
nwgvzSOLGYMfqB+a/2zrDsR9i7+evQ==
=sB4j
-----END PGP SIGNATURE-----

--pEM/sj99eDJDXP78--
