Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6542DE709;
	Wed, 25 Mar 2026 18:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774462624; cv=none; b=UMpYcuD6uAxhchFEoinkYBdGd7M+hsm2hnxDQzy2dOOmA6ximMDtmzj2EZbbYYz3tIzZoxnC2DewxWMLG2gXHC9YQWTemva3C/ZKgERjGmkYxgLVJw6QNN83/JW76slbnxhc9FinAyPZojP1kw9zlAWPDjm+BkI66iBuxrennRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774462624; c=relaxed/simple;
	bh=dN1owC4wQeRllfjoQmd/3Y8PsVaW/qeYmie9bwIKyis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPRPVodbIDHYMtRLggrpuwioXHdKjI4BsQbNrcHSrM3MYtL/SgECp5Cdr/ckegsnGP6F0JaEXkIzACre8CUU1wzJO6NvFnnlBQVSYvR1FbKx9wN26wD1zNm3ema9cF0HUt72Q0gK+12x3a9LM2UyMY/pNM0OImke7uijvjQf5Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNeKzCkz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNeKzCkz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B263FC19423;
	Wed, 25 Mar 2026 18:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774462624;
	bh=dN1owC4wQeRllfjoQmd/3Y8PsVaW/qeYmie9bwIKyis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rNeKzCkzgWPO4uXanrCyZnmi0efPD0jFWWckAHuAqn3Oek4c0ntR5OimoBj293tJj
	 PqA2p7jbFFR2f9tUi8UmiG511QiGEzh03CsjpgR3pKf2cEb5N30DGvwocExgMqJFjG
	 6mcP2uBMsU5Ue/HN/mCpdJJU13D8aSl6NKt3EQfN6uALqP8QSBduTf7tVRdAilopow
	 vifvhVo9PjbA7W3aYMqeSIWmX9+x2DMwhwRSC5NwVVGB/IP3TPeUMwXonUXbV4ssZH
	 UXwslDJo/r690AUno7HxBSJuqnUzPkFn3j9KNCSE+QGeXqRX5se0ttrsfjsZpjh3Zz
	 yKxKvcOzFyHLQ==
Date: Wed, 25 Mar 2026 18:16:59 +0000
From: Conor Dooley <conor@kernel.org>
To: Yixun Lan <dlan@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: i2c: spacemit: k3: Add compatible
Message-ID: <20260325-entering-grandpa-7bf99307a74c@spud>
References: <20260325-02-k3-i2c-v1-0-78f29c83d9ac@kernel.org>
 <20260325-02-k3-i2c-v1-1-78f29c83d9ac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FMGqwg53RZq43Ijf"
Content-Disposition: inline
In-Reply-To: <20260325-02-k3-i2c-v1-1-78f29c83d9ac@kernel.org>


--FMGqwg53RZq43Ijf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 09:49:24AM +0000, Yixun Lan wrote:
> Add a compatible string for the I2C controller found in SpacemiT K3 SoC
> which use same I2C IP as K1, so make it fallback to K1 compatible.
>=20
> Signed-off-by: Yixun Lan <dlan@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--FMGqwg53RZq43Ijf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCacQmmwAKCRB4tDGHoIJi
0iyeAP4ryfPudFLay6Bnhb2ABJb+xaEVUmItrsc0JPNDccLSsQEAplVuih6J45RG
9z+9Upz415mnSSZhBSHkRcjbrT7oeQs=
=kZAL
-----END PGP SIGNATURE-----

--FMGqwg53RZq43Ijf--
