Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF7331D730;
	Wed, 26 Aug 2026 16:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787760530; cv=none; b=oAAr75vl0jlk513D+LtoaMelxQKMqNazgT/6cctuKN+RtrR1q3Yn2hYs1ycD/Ca7g/ajzRH9PEQLYd+3wORq5qt11wWptLgn4n4Bg4GfyIKMhjBmpXfZLXKUL7LgdInDHbxpBUhWBroYVL9ahoO6xU/yCzv/zwg2y2TgEOfd4Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787760530; c=relaxed/simple;
	bh=THZqxWK11ShEbgX37QiYLv2XlYdNMkpDV/ypIDz+vTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfvIS46TPX7Zt1cTDH6873VhBtV2BVQOBLoeLTfa46r2umWCn3sDzP1JexyuvGoLZgTn/a7zIQiSU3NafP9YFEbOBAN7bfoFIVKNhDJuj6HgLrp6zQZFwW8k6F+ps6ia3vq6u/RDgJmmKScCXxYlyytqn06sF4BeNeS4neTNPnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kwo3idfy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kwo3idfy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B401C1F000E9;
	Wed, 26 Aug 2026 16:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787760526;
	bh=THZqxWK11ShEbgX37QiYLv2XlYdNMkpDV/ypIDz+vTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Kwo3idfy8AaZZu5YwtowR68PX7Jbvop1fIjz6lvXeEGwNstclCir2r7i1b/CyFf/U
	 pl6lbz/UUxyNooICtgGeLJzkAZTYDUcXvlnghfzdrWPnRv9SQ1Yvy8AFjNnPCyVTjP
	 MU/XgOOjMuSqyU5DPhjUlZdQkHeZq1e0IwvGIC6pVZysc/70mNc0cYlzfUJWEIIjxD
	 K9jhfTwAwNVD9CJv2eCyu2t/dnG0KPWzm6+U8ogEqZToGt2FG8kUPJA7OSxAf7KDG1
	 3/ceDTyDbl26zPMRrDnu22NLLQbceZUMDqd/8kDClLCNK/Iv0+MjhJtdFor9NkQNq0
	 3gIFCovEya+kQ==
Date: Wed, 26 Aug 2026 17:08:42 +0100
From: Conor Dooley <conor@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: i2c: renesas,rcar-i2c: allow 6 DMA
 channels
Message-ID: <20260826-essential-clang-8e501b1530fb@spud>
References: <20260826083524.6056-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EBbyB7wesRCzdPC0"
Content-Disposition: inline
In-Reply-To: <20260826083524.6056-2-wsa+renesas@sang-engineering.com>

--EBbyB7wesRCzdPC0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--EBbyB7wesRCzdPC0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCao8PigAKCRB4tDGHoIJi
0qIIAP9m+Yseu4YfYcLyumD5LDUllalTIt0067HkAL5R7z6KMAEApN8vKJWGqE0G
mraArg3R+NKG1zrxHGE9dIYg6Q/FOAE=
=qPSY
-----END PGP SIGNATURE-----

--EBbyB7wesRCzdPC0--
