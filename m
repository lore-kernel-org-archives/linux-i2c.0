Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299090;
	b=h3+swn5eI5rmncsMZXhks5cJoq8KDmZz3Hp+Vnl5IQgkdgJytxLG/2IX84++zzjyYzU+
	 B9z7YGrg78umtrBeiCZw6NrBOHt8+M/GmW1AXf2YjBm1NV8FYvJcTZh6xeCTjrjHhXmOY
	 VvwzGCmEjyQTVSE3WvD3vQ1JAvLAiMhx3QpGi6KX3mDsCFU07Z3V1G6D7HA7qPg8wzQxs
	 JTA14g+Mv3jFFDQ2rmZcpDUSh6eoKbPq4nWj5d4qzi5B2DE7sKv9BhopbKRSfPhIprmvJ
	 UdGlcR545M7TE76K2hqTPsadzF/hPnlFJ7Ia6CseP4/RUYdhh05XVso/nb9pGmdBYZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299090;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=b2w+vj8iicPlV6jF/HQkqNrcUN/p+IVy0qQbtmQn7Pc=;
	b=aJpK/A4JhMOrvYIy1dfOVegOP2X/Pzq/ekLig2Ny630RzFaZVu7/WGtTghm4jv5XjVcv
	 bL0uHY2m+zzYI7Y1OSX23MAgN2lh55uy7Fr8tWy7smLx8gsfhxlDocy5emc+LtGOigW7m
	 W6+t+czch+S8hKNoNW/aYGCLbuGRDeqdb6XvFM+pijocvWkDCfewm5E0CE1M23jbbfVYd
	 w3OAwAx75sLbZe6V9HGOvXYICIz1bxalTY56JwNZrblfEr9Xm4DsRL/7lnNvxHp2X389z
	 jUpyOnucmyZCF7lb83AJf7a30T4Ekvd+PrcT/rRVwCrEI+tfA2PhKJQQgm7xuiDGE7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JAkEs8EJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F76B606A324;
	Thu, 29 Oct 2026 18:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JAkEs8EJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B9C1F01824;
	Thu, 29 Oct 2026 18:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793299089;
	bh=b2w+vj8iicPlV6jF/HQkqNrcUN/p+IVy0qQbtmQn7Pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JAkEs8EJN/Bf+qs1JTnsMxvRL/eLDI1l4ogYKabyXSaVDPvfJZ4MEqwwUb9CgTxZ3
	 RyVM2Dn2/3LUABGZIwEtv1WQBw4sx3e6AkGAjuxw06pnMyz8lRpeduz3NSrd4iDeEy
	 /P4Z20NH+ukg4wAuV2eqT65X6irMgULu1xgV69x9BVq2ENh1X0x8S85IwzocdcQpcv
	 1L0wCM/h0RnVMCQ+PyPhgedehge2oEiiFrH9imJBRpGH/9jUVLyadiodkKi6W2CFh2
	 NwoHJZwrjy9L4+5XRXl8AlqPEmFRS3zSIJLmG6Hq5K0OvS3s5LGaM5LF6XJ5R5bL3t
	 PRZNrzaIL+OMg==
Date: Thu, 29 Oct 2026 18:38:05 +0000
From: Conor Dooley <conor@kernel.org>
To: xianwei.zhao@amlogic.com
Cc: Junyi Zhao <junyi.zhao@amlogic.com>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Xianwei Zhao <xianwei.zhaol@amlogic.com>,
	Junyi Zhao <junyi.zhaol@amlogic.com>, linux-i2c@vger.kernel.org,
	linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: i2c: add Amlogic A9 I2C controller
Message-ID: <20261029-survivor-dubbed-16d6567b1a68@spud>
References: <20261029-a9-i2c-v3-0-7b30ccc00533@amlogic.com>
 <20261029-a9-i2c-v3-1-7b30ccc00533@amlogic.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U/zaVfmhbMdnWLNK"
Content-Disposition: inline
In-Reply-To: <20261029-a9-i2c-v3-1-7b30ccc00533@amlogic.com>

--U/zaVfmhbMdnWLNK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--U/zaVfmhbMdnWLNK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauOSjQAKCRB4tDGHoIJi
0jzsAQD6EoqJcpsiitqmxnGDZSuKqITsWNdf9GYZdOEpvBqkegEA9b+UlUZT82iG
bj8rtXcmBXBPFkb2mzUl9lmprEjgNgY=
=NgBQ
-----END PGP SIGNATURE-----

--U/zaVfmhbMdnWLNK--
