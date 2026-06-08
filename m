Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3915618BBAE
	for <linux-i2c@vger.kernel.org>; Mon,  8 Jun 2026 07:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780905088; cv=none; b=eIPPZvBVDTbp73mEvBilCMjL0obcaQC0j86cn45YswkofVd+VhJS9W/1Bh6+lZrfbrBurlwwzZoGvFCfWfJbCjyVOObaBKporfTWBDmATzmPD8eYzABz2x0mkWdhScaCbu1OSEB1feBC7ud+elIpwS/gW3VsCgY1n7WUKyx7V5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780905088; c=relaxed/simple;
	bh=s0zQ/ZKI4I76M/phz41Dp2tQPYGm9vDfyiCpUJFPp9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+SFTxDlaW1l3VcdJRGi1Jc3zpPbdfAo6gcQDJ1IX2ouONbG4j7C6gkCmTfgmGT7uBE9tDIFPd+ZDgupEK9wJ2EnPZxvBu2/f/fUO6YubUYb24RrQsJD0X2bRfiQKicTO8LKxWMEU6OBL53xmQoTPm7Lh9nXdR2ElHaO6pNKKII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=mJgR200L; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="mJgR200L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Z3G9
	kKqABZczffTUrvY1gID80bL08FRqyNLoJ0OF6oE=; b=mJgR200LoKVAYAJS2m/S
	aX/fJmIX1B84R4YWPJ0Yb4iPaZE13DTylBIxYLJDW7O3IVJ3+InC2k/uXZHmCa/e
	39PAeGXwwGowg7YUPMf674uCHVjAS7BOS+7SUESLbSdS5OXTBWRDn5oy0m3jtE7J
	gDy8Jdm9PLqEh6GIRGVUSD6Hbi6Spmxckp/d/SNf1o94MvGcZY3h3siSZf/57Br2
	X+hyMRhXzq2E7hjI/G40+9TCBeMdCh0hX24Vilxf7LeakzpGkXqN8F4/nBFAKxiW
	Wp7vXpTDP/PRZUsKwUBQjLfPOLdb04Ojhdj0CV6ANsL4EqVO/k4fum9b4JT4DrNi
	Mw==
Received: (qmail 751585 invoked from network); 8 Jun 2026 09:51:20 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 Jun 2026 09:51:20 +0200
X-UD-Smtp-Session: l3s3148p1@2F2vRrlTwLsujntX
Date: Mon, 8 Jun 2026 09:51:20 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Igor Korotin <igor.korotin@linux.dev>
Cc: Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] rust-i2c-fixes for 7.1-rc7
Message-ID: <aiZ0eD-A2F8woqTb@shikoro>
References: <9e49b71b-8b60-479e-93e7-5c12e352c78e@linux.dev>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o55AvIIQFORCL+wV"
Content-Disposition: inline
In-Reply-To: <9e49b71b-8b60-479e-93e7-5c12e352c78e@linux.dev>


--o55AvIIQFORCL+wV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 06, 2026 at 06:39:19PM +0100, Igor Korotin wrote:
> The following changes since commit e43ffb69e0438cddd72aaa30898b4dc446f664=
f8:
>=20
>   Linux 7.1-rc6 (2026-05-31 15:14:24 -0700)
>=20
> are available in the Git repository at:
>=20
>   https://github.com/ikrtn/linux.git tags/rust-i2c-7.1-rc7
>=20
> for you to fetch changes up to 4eb422482ca5d924d7212ad2ca1cb7ea6f5b524d:
>=20
>   rust: i2c: fix I2cAdapter refcounts double increment (2026-06-06 15:19:=
27
> +0100)

Thanks, pulled. I was away over the weekend, so it couldn't make it into
rc7. But I will send it out later this week for 7.1 surely.

Please be already aware that from 7.2 on, you will need send pull
requests to Andi who takes over the I2C subsystem. I will write a
seperate mail about the handover later today.


--o55AvIIQFORCL+wV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmomdHQACgkQFA3kzBSg
KbYs0A/8C4YyzMXhi5rRNS6wCXxmT68Kw491j6QPcMjotbLPXMbDqERMMNHNuNVU
vOTlEYT8MhtgEtstep64s22aqNYAg+oTTvGYV4GxLuzqvUwSgQHZHLhJja457R2e
aCSut2tUgUbippywwzJUhksd6+tQBH7V6JMd/XNusklr8NuAXuS+g0D2LkEt1QJ1
ZtbStlzyfc/mEDQsk0i6DtkRyFOT7s3Ra28sl8eJeTMGGo8Z5mLbZRAyNtbU9pI1
0FDl7jtWBp4gZHYq3A6XuGe0eYzfBMfEHH2iIr2GDYkedcjgkUJCMe+ADZpXF9xN
vhwOopSBpUN6V7FoAr54M5hwqFYIs3m0Pu0x5N/v/INc6xm9O1ACHn5JMpHlx2IA
WmFKYmLkICnscETJjGhEGv7I3yvYok/jB9HyAbNUuiQeR3gHM1Y6uCvTGD6bFk01
1NYywpCwb4nnth5YlYKATAU5nZ9zpP8zLw1xdAJklMPb81aoJy+7CHBbOEvkJkYT
fJDcAARxkhSkySS7n9+oIjtllCRPZQjg7qtCVYQ0nuLVHc53CcuMppuEbDa0zYzR
jgyeZ0X0wrT5vZPPvvV5M7/aPQdyEJteqYCU0lPhATNrk92pDvi5/t9Tj971jMOg
pyhPxRzfiC863FJJn/HXbm8rMU/xqDJG3w4k64zlZuyoldaG4Z8=
=Xfmn
-----END PGP SIGNATURE-----

--o55AvIIQFORCL+wV--
