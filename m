Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A47D46EC64;
	Wed,  7 Oct 2026 13:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791378089; cv=none; b=XI9vld5QKYgziJ3B3hn7MQMAKMH79q/RrDMb12LNmv1yxPN7Pc0OfGVkTBjhdCk8iMOxXOZmzi8hGFzmWMI1uBVWvZRIf87Zr4jzKBetpot3zE+LhyhJqqoyPehRE+k3rXbPy6wd+GvaSt1DyGmt5hFx585Z3jnNWMMyFJzbGHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791378089; c=relaxed/simple;
	bh=QXnr1q7TIAD+EOnMd9hf00MKybge7faPlvZfGtJqgCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3nHMRu+QdVFZ/KT3AHmmW2j0tMaDcvoxr95IUb9c6wdgrb7B9oTEWEGji9as6ZvhOcWJiK15EVxGUqW6AfmzT0a8UHmh5a/uEKnDXZzufjPw845DDrLZNUKsLiCgwQkNrgj2UaZfo2wvv7r9dY2ViYvuvehBzy6PEejnToTDGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWZYXhu6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWZYXhu6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86AD51F0089B;
	Wed,  7 Oct 2026 13:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791378076;
	bh=QXnr1q7TIAD+EOnMd9hf00MKybge7faPlvZfGtJqgCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DWZYXhu6w+oQdPyGtzqZ9yGYs8pKlqPnSp+4Al2muj4pHAcYUdvDxlukZuQMW47Oa
	 lAOwhfh9PdwJc/wHLy7g4RjIsMhkYoZrWafxc/wyiqOMnMC4MMvbk3uf5NNaXLN8ue
	 RzSyk6HKTO9KDACdI0mEJn/Ja6rrqCj/iIs1Hk6ifbVYpcCI31j/dRbg5SmCeZs05o
	 C13/wsS1D8gm+qoqgCZTv9E3kVIfxk03oIYLOYGdNhkixOr2A4mRl8m2hObcJBetip
	 sgpTXJxDv8vVyGsO3pxRMxFuQO0dRgLCg15cBox6Jsu6ukf0W9F4ylAfmA0ysDcv6K
	 ghoUe3C4C2QKA==
Date: Wed, 7 Oct 2026 14:01:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: i2c: dw: Add Synaptics sl2610 i2c
Message-ID: <20261007-34907d3f645ee05b484920db@squawk>
References: <20261005152036.25276-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3GFceZeyREcA7JCz"
Content-Disposition: inline
In-Reply-To: <20261005152036.25276-1-jszhang@kernel.org>

--3GFceZeyREcA7JCz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

Despite your ack Andy, this is yours to take after the split

--3GFceZeyREcA7JCz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasZCmAAKCRB4tDGHoIJi
0kCyAP4raF1ltfNwjbZohQxWZXNNRD4HVrdDkDGt0F5L5ywU2gD/R2NDwcbi5bHB
SN/tvCfNktf72yuN25MkRVAqyUv1+QI=
=k9Lt
-----END PGP SIGNATURE-----

--3GFceZeyREcA7JCz--
