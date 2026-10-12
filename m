Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142CF3815FD;
	Mon, 12 Oct 2026 21:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791839027; cv=none; b=BKhP0+5DkuXOoizrK7h9vMlSj0mShCdgC6IkOKacXVwQLdF8ncvFRzb24D/hUUYl0e50C2uztrpMHsCMz5tj+0Gu2Pt9j+SXOX91KlnK0unfgpbff+nqpsFajp7jkYhXXYiICtCUDqxsajEIv6cThpNLuwRBKu/CcrSP/oGbafo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791839027; c=relaxed/simple;
	bh=EwMGVgTNEK4R+Zv4M8dbzQj53ZV2d4fLogchwzB0MQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceNKwEJ3fOYHKHN80DI0DoU8bAbg1gXjodC+kc4pakzHcxlWrtIJ/XRzdVJecEHl5x3iswm6qRyk4qctWc5oJOMaeIhe0h2o/uHLYjPV4aMlHl5shM31SpdPVsEz6Xl2S60Z/hIZqFalLPQWPY7lN+UmHKLhbZ6AeZ0FWWvke0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ca0QkasZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ca0QkasZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042F21F0089B;
	Mon, 12 Oct 2026 21:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791839027;
	bh=EwMGVgTNEK4R+Zv4M8dbzQj53ZV2d4fLogchwzB0MQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ca0QkasZ5C6Q7+RAeyBXag3Jd7o6ikwAXseSJf3bhFkBbvxV5Hy+iO0Smma1wRb8K
	 NEd0sZeHjIrno2/s803giwG0LaZNVKAlsfbgoScJ21T5qOFBZRD63jHYFCuz80lziH
	 +9vJDDNaWZYCl+wOYk1xrx5MJ7kVHZZxUKExAPxdOGNNSMy3vqXb1Dzi1aymH4RF77
	 DS8t5Oatl83doqcmcSB68bwEs4nQR4aKX62KggFAnqZATYHr83oGLX8dMerBxvIXz9
	 +qK1+ij+rBAqBbt7i5Mlf85xAKxpl+mf0OP6OWoq7qafYiAtcSchHuuCQ2Z7AXwivU
	 nt63bnbWEo4/g==
Date: Mon, 12 Oct 2026 22:03:43 +0100
From: Conor Dooley <conor@kernel.org>
To: Michael Zavertkin <misha.zavertkin@mail.ru>
Cc: linux-i2c@vger.kernel.org, Rustam Adilov <adilov@disroot.org>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: i2c: rtl9300: add 'rtl9607c-i2c'
Message-ID: <20261012-engross-fruit-8dc95612fc8d@spud>
References: <cover.1791611999.git.misha.zavertkin@mail.ru>
 <9a95cfb2f09ec69af02d51d6a71e4f1a7e42cc4e.1791611999.git.misha.zavertkin@mail.ru>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VB2Oh6bwRIdotiQT"
Content-Disposition: inline
In-Reply-To: <9a95cfb2f09ec69af02d51d6a71e4f1a7e42cc4e.1791611999.git.misha.zavertkin@mail.ru>

--VB2Oh6bwRIdotiQT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--VB2Oh6bwRIdotiQT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCas1LLgAKCRB4tDGHoIJi
0llqAQDdRdCBQSzkB0ss4UuvURxL8WJrWzlSAvUSujOsXm3E/wEA2dop0a7Kj8fm
s/Fjr6x/7RESDV2CIltANhyXKpILxwI=
=+L8z
-----END PGP SIGNATURE-----

--VB2Oh6bwRIdotiQT--
