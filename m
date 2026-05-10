Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A90332ED0
	for <linux-i2c@vger.kernel.org>; Sun, 10 May 2026 20:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778446760; cv=none; b=FFTOCVCj6Qh74UaKxm1SfKkwMB1KlCzsDQ/nmpw0gI+CpoyfXuGyeMPqB6DM5XWgR0hd1DRT6d73RYUwqTQMvfTK7AZvyQK+JOiv8k48ububhFFhHkl22y2B2/xMdo2eZV7DtBGSuW3Mw5jNBkNTinLuEoXTxVN3vptYtYKY50M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778446760; c=relaxed/simple;
	bh=b54LreJQbh/LiOryVCaRggTjB4exiPbbSbBQu6ZAD+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhdzpdwuWiXrWxpdWRwjD5YnFqIuY+LMONDdnEKLbd2BfRSeoSUvxHgsIJg0wkB5iH5+egpEPku+AnENHMkhGZ6wq4s+HUUMDjhspurOjZ9+ClZ2ZrBOf5qe7kaQHf4OdZhbRDrR8fB1J/6W6KzrVWOcWBFsHq8GhmzbDk+I4Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=GTydepoJ; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="GTydepoJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=b54L
	reJQbh/LiOryVCaRggTjB4exiPbbSbBQu6ZAD+k=; b=GTydepoJPSFlR/T/3U0p
	dPJVrc2WttPooM3pkdRX3/e4/AiL14y030bV2igf2HR/xttsafAHJycxJ3qjrDhW
	Aig1RMQyih7PK/sFEiVO+ltl1UAYlDLc5xCwMvPHQqs0dKuwBhrB+6V177SDlveK
	TX7rvp7yIofNAFFLBTTeiS/VwdpElOSPo96popv77b29wLzj3lK1VooHgo2lXjHX
	Qd6YmH0+MKRDC+jvD4nEcU1bkg/I7vOf3tsXOAjBHfFv6NR95q8uwWG5vHDGxlWM
	UMM9RbatZfSdj/1kbhRJ5ZpjRG+wcjk7aHqU9ILJVyk0s5Duj9Ml/H+r9L57svz+
	hg==
Received: (qmail 2323697 invoked from network); 10 May 2026 22:59:08 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 May 2026 22:59:08 +0200
X-UD-Smtp-Session: l3s3148p1@aJGr5nxRgsAujntN
Date: Sun, 10 May 2026 22:59:07 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	Peter Rosin <peda@axentia.se>, Andi Shyti <andi.shyti@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: i2c: mux-gpio: remove Wolfram Sang as
 maintainer
Message-ID: <agDxmyIA4-tLDKgX@shikoro>
References: <20260509171354.12263-2-wsa+renesas@sang-engineering.com>
 <177835197844.785566.9553774802925952117.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W7BpdNc6fcL8jLyf"
Content-Disposition: inline
In-Reply-To: <177835197844.785566.9553774802925952117.robh@kernel.org>


--W7BpdNc6fcL8jLyf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.yaml: 'maintainers' is a required property

I know. But as I was added as maintainer without my consent, I think it
is okay to remove myself.


--W7BpdNc6fcL8jLyf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoA8ZgACgkQFA3kzBSg
KbY3lQ/+IpbRxoehRKXImbk46ApmouvjRrgVrLl+hWjpf83LTfxkjmJq/u0P0I7w
RTabaRrdmcGT4GeNyg+myMP8KM/5qGZ3GmfXM6J91Ojz36gQ3xYdHvEKmvqLXKup
J9Oa4azVUCbkD9tDJkOj/wIqzICAGChM73d9UOP3LKlTr8iFiC3NyM+fMHK1aDfo
8Wv1C2TSKl74Q60lfo5z9hWrfTDnmRSnLBFTL42h3G20Xx15jONrEZZPvi503lvV
l+cOdZqBOXinYXg+FQWYPgr9qhZqIsp+AvgndYTs4SZoH8o2x7ZACe3aI2Zd20M5
2Z9aIfTIXdlNgDuwE//7izz6nHiHO4cmqk7TNDNOc54Y7gOC4wEch1tiVYghGMVO
EN635DbUiOW3r0AwfvkPIMy7g3yTZFJbq8sbMs9m7GILG00W9T/RHgI/zMOr3cdz
bt1uumNy6t0iMNWYsEWrixb/Qfdv2hbA53H/JPd4VGAW2ip07HPlG95O/SP56QIF
KgeON6PhNjeGBCn/7W23HamzC1znAl4VFhWnST4a7qU1/e6odIQelDBDy5S7EYYC
3bfmUTUzSM/RYeZgFW/CYmn4YvCQDrtOLtZ81rlwJZ29V/EOj1/CLF3Hw0VcS7YF
er8SVhttUYlZEFkm0K/sZXGAj1Nj1j60WXdGLS/QB5V4tKACSLQ=
=uDYH
-----END PGP SIGNATURE-----

--W7BpdNc6fcL8jLyf--
