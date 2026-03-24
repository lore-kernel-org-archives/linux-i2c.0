Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D5F3876C0;
	Tue, 24 Mar 2026 03:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774321909; cv=none; b=BJJezb7vyrStSROURVXJDGkwIfGT8gRXTBGLK+HHrBDroT+6bBoy7L4dWBrRDVXnwIVNO1VJRAfhMfGmBbEz2UPc1f/ji2wC997kN4vZ57s8+TCTPzp7nwpVvQjsLPeiVaZCZqOyUbAYdxC/ny6t+k11cyKgDtSC8aI0OMFN6FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774321909; c=relaxed/simple;
	bh=40hYrgHMhL5Y3sgIvyGDHr2DSh4JcFjI1IXGpM/589E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cxNxNtuQ9EYfggt7WNgmOtgE4SiFr63ZIHq0iJ7qBdh3o7+TCR8o//5tlq6p/b1TP8jEx8siyZ9EJd3iuByIbbKJq/l24qW5bqp1+nCgNwZx1mUU6fLRr3NU2Vip5tDulTatxRheKvJ5iJ7g5yM1orjE/YhVq6NcIfWYf6+/Sc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=E8hVtBNg; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="E8hVtBNg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1774321899;
	bh=40hYrgHMhL5Y3sgIvyGDHr2DSh4JcFjI1IXGpM/589E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=E8hVtBNgBrNdvLlWQvKdjHzlxebKnv8/HKVeiS/DFd3RTyaMLM8i+lnyTJLUyqnr1
	 5oRE0irl1i5UBIeJ+/lz6onh2hv1Mg4d4Cj1xC8RNAAChpl7eoCItUni3F0TUoG7pT
	 brHVXfEIUCGD0f//XMqUytT4jc2dqB+rDmmnVmDTyrmHzYtoDbiu3sZBR2mXO1HPIv
	 vhuugmBNZWegkcJlc0y6P5gnPNRLuEbzAhlbYrORsfXNnOY1wetPJ3LqYkgse9r/On
	 c2JhmK/wPo2fBHKDGUjamOc/QPN5gwwp46CruZ/qVp5cVLwt2eEgG8Z1CQCe1jIElO
	 WFCplhl1kCfgw==
Received: from [192.168.72.167] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 605EF602C2;
	Tue, 24 Mar 2026 11:11:38 +0800 (AWST)
Message-ID: <405f6b1b4081ffb379a21bcdb5d2a8e81d2e2e3e.camel@codeconstruct.com.au>
Subject: Re: [PATCH v27 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and transfer-mode properties
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Ryan Chen <ryan_chen@aspeedtech.com>, andriy.shevchenko@linux.intel.com,
  Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Rayn Chen <rayn_chen@aspeedtech.com>, Philipp
 Zabel <p.zabel@pengutronix.de>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Date: Tue, 24 Mar 2026 11:11:38 +0800
In-Reply-To: <20260324-upstream_i2c-v27-2-f19b511c8c28@aspeedtech.com>
References: <20260324-upstream_i2c-v27-0-f19b511c8c28@aspeedtech.com>
	 <20260324-upstream_i2c-v27-2-f19b511c8c28@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Ryan,

> The AST2600 I2C controller supports three transfer modes (byte, buffer,
> DMA). Add "aspeed,transfer-mode" so DT can select the preferred transfer
> method per controller instance.

This patch does not add an aspeed,transfer-mode property.

> Also add the "aspeed,global-regs"
> phandle to reference the AST2600 global registers syscon/regmap used by
> the controller.
>=20
> These properties apply only to the AST2600 binding and are not part of
> the legacy binding, which uses a mixed controller/target register layout
> and does not have the split register blocks or these new configuration
> registers. Legacy DTs remain unchanged.
>=20
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
> Changes in v27:
> - change aspeed,transfer-mode to aspeed,enable-dma.

What about all the previous changes?

> ---
> =C2=A0.../devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml=C2=A0=C2=A0=C2=
=A0=C2=A0 | 17 +++++++++++++++++
> =C2=A01 file changed, 17 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yam=
l b/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
> index de2c359037da..38da6fc6424f 100644
> --- a/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
> @@ -37,6 +37,21 @@ properties:
> =C2=A0=C2=A0 resets:
> =C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> =C2=A0
> +=C2=A0 aspeed,enable-dma:
> +=C2=A0=C2=A0=C2=A0 type: boolean
> +=C2=A0=C2=A0=C2=A0 description: |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I2C bus enable dma mode transfer.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASPEED ast2600 platform equipped with 16 =
I2C controllers that share a
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 single DMA engine. DTS files can specify =
the data transfer mode to/from
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the device, either DMA or programmed I/O.

As we had discussed: this does not define the transfer mode, only
whether DMA is available to the peripheral.

Why mention the 16 i2c controllers here?

Please keep this description simple and relevant to the specific purpose
of the property.

> +
> +=C2=A0 aspeed,global-regs:
> +=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#/definitions/phandle
> +=C2=A0=C2=A0=C2=A0 description:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Phandle reference to the i2c global sysco=
n node, containing the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SoC-common i2c register set.
> +
> =C2=A0required:
> =C2=A0=C2=A0 - reg
> =C2=A0=C2=A0 - compatible
> @@ -59,4 +74,6 @@ examples:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resets =3D <&syscon ASPE=
ED_RESET_I2C>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock-frequency =3D <100=
000>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interrupts =3D <GIC_SPI =
110 IRQ_TYPE_LEVEL_HIGH>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aspeed,global-regs =3D <&i2c_=
global>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aspeed,transfer-mode =3D "buf=
fer";

This example does not match the binding.

Cheers,


Jeremy
