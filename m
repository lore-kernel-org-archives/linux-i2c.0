Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420671;
	b=syMlqGyArOS6cil0t07yhhxFcgAXtsq7Kjs9H7wwepmh5CojNFqsg3xybqhsTOLG5LSZ
	 zHVvKqX9gnCAZdA2mg2pn7SGrvcUPVmERQ8dqLYaT5TDnRdMPLN/uiInSNCLJt8QCFYTF
	 lPZDEl8yUNzFBAjCeQi7XGjJNlvSQ6qrwcc/zBLnVjitf/mOxoC2+SJJqWpIAC/lXcNC7
	 a1r36YTrO27bt/WkNot/Ud9vWM76fmR6uEfwB+/gWeu+sCZz8a0WkK526boLTtlpedQzA
	 ez5pEysqoUWaP7FTaynBLxou/4rz1ogvZnJMOUW1xRu66ifu57nGDp7Y/vTwdvgiwNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420671;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=yMBHhxbvHmek25iNNzt/fSW9M/YAXtODnCUwnhn31Yw=;
	b=R0n0jZuq4qoGjYztT5iv6uJzyXU2U6yd0yEDwtLLjyOznH5A4oFKANVo2HkNAumSRdhn
	 hR0pS934EO566WYT6Vv6Ll4e0WkiagpBQw6Zt2an7RaAMxp7qmO3/6fBDQ8ItTlYb+RQ1
	 9NX/xb2JjWW3xl2SQWcz5rSv0H/rdaFzrF0moX23IKXNbT3RSnbm+CQGk1sg8EPnefHSA
	 pTUDdlSR8h0gyB4dgK87n4QeZctN5MMwdBGaVxWD5GIfpe+17XWfGNbxY0NF7CVFLJN6P
	 PEWecALaH7Kis2BFp2KyHUfGCfEGtCsP7YF3I/YIt1Rtv2jeFwTyz/3p/KgXJroariA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hla1Zo5f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AF0606A8B6;
	Wed, 11 Nov 2026 18:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hla1Zo5f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44EC31F00AC8;
	Wed, 11 Nov 2026 18:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794420670;
	bh=yMBHhxbvHmek25iNNzt/fSW9M/YAXtODnCUwnhn31Yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hla1Zo5f8KHVEC2e6ZsF8gZqra+uYUowhu6Eu/gSJ2vXpqE2Q5bYCTJlwBBJf2lgQ
	 ETuuVgjzc+C5tDTcVWvAe9w+N7G51+gwaMCUw7Q67qohNsMZPf3XKr2razL2HxcHM1
	 gA5futdg0YSFb26D3qbD2OwYa3pIiyoA2Qehw1nBYQMidrEWNGMemoeHcHBmXAM+3r
	 7zWnpX7OJbKzCJt5nM1GHKncWIio18r9H+X/PwyDG04GF5hFjpgo1dT3GxZE5YGTt8
	 D5iKF+QJ0SHIuLPdLAVztasxRVvnvvmv5lpv8GAfnlKRLdxlkFms5nnmXdXcELFvf5
	 CXZpFymY8TLMw==
Date: Wed, 11 Nov 2026 18:11:05 +0000
From: Conor Dooley <conor@kernel.org>
To: John Crispin <john@phrozen.org>
Cc: Stefan Roese <sr@denx.de>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	devicetree@vger.kernel.org, lei.dong@airoha.com,
	Linqi.zhang@airoha.com, linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org, Rajeev.kumar@airoha.com,
	upstream@airoha.com, Weifeng.xu@airoha.com,
	zhengping.zhang@airoha.com
Subject: Re: [PATCH 1/2] dt-bindings: i2c: mt7621: add Airoha AN7589
Message-ID: <20261111-federal-pleat-191852ed2822@spud>
References: <20261111093941.691801-1-john@phrozen.org>
 <20261111093941.691801-2-john@phrozen.org>
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
	protocol="application/pgp-signature"; boundary="PMGK6tzsdZTya8NZ"
Content-Disposition: inline
In-Reply-To: <20261111093941.691801-2-john@phrozen.org>

--PMGK6tzsdZTya8NZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 10:39:40AM +0100, John Crispin wrote:
> The Airoha AN7589 carries the MT7621 I2C controller with a second
> control register holding a wider clock divider. Give it a compatible of
> its own so the driver can tell the variants apart.

I assume a fallback is not suitable here because setting this wider
divider is a requirement?

>=20
> Signed-off-by: John Crispin <john@phrozen.org>
> ---
>  .../devicetree/bindings/i2c/mediatek,mt7621-i2c.yaml      | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/mediatek,mt7621-i2c.ya=
ml b/Documentation/devicetree/bindings/i2c/mediatek,mt7621-i2c.yaml
> index 118ec00fc190..28659bdd72f5 100644
> --- a/Documentation/devicetree/bindings/i2c/mediatek,mt7621-i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/mediatek,mt7621-i2c.yaml
> @@ -9,12 +9,18 @@ maintainers:
> =20
>  title: Mediatek MT7621/MT7628 I2C master controller
> =20
> +description:
> +  The same controller is used on Airoha SoCs. The AN7589 variant adds a
> +  second control register with a wider clock divider.
> +
>  allOf:
>    - $ref: /schemas/i2c/i2c-controller.yaml#
> =20
>  properties:
>    compatible:
> -    const: mediatek,mt7621-i2c
> +    enum:
> +      - airoha,an7589-i2c
> +      - mediatek,mt7621-i2c
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.34.1
>=20

--PMGK6tzsdZTya8NZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavSvuQAKCRB4tDGHoIJi
0iz2APoC+/pL38Hhk9ni7vQnB5Jy70F+PVBfryx7CexSJbVGKQEA33Dx/8Km+2K1
X4AQByWlXEYYC/jmyQC/C8Qz3rjeRgw=
=Pjb8
-----END PGP SIGNATURE-----

--PMGK6tzsdZTya8NZ--
