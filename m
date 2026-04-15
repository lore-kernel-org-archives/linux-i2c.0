Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0C53D4123;
	Wed, 15 Apr 2026 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776266359; cv=none; b=NDiXPW+Dnh1PVRuqGn44BJeYcewhO2RWyWd7CsvfKuEA5+sjNGXp8UtLOfvVuuNjgTE+26WKeX8nf7Tcoi14ZZjqgE2S8RLtD/RI3LtK3jB0OA/iYXX8aLqaG3HENNQRU1PWbHy6SV4FAP1n/SnBwPAZXiusmwfUzsI4VJcV2mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776266359; c=relaxed/simple;
	bh=C2CEKkmCH9aV17LYLLM5/3fFEfH0fiYdFqoFdPLbCN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKyQgs+Y1aVIWR8JN+kv3wHSEx/rM6ns5Bs8d8vKV6qn5I5YgP8hnC4EvLn0iVt4bpCf26SknhYQa9A01N9e8s0cZQ27YfPVNCvJmZU0RbvmVz3sIZS5NaZDXw9+wpelvh1M4LLak1vGbmeFFlwijeP7g9dHPOQ/pADQtucgeXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bS4AIlrT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bS4AIlrT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8CEC19424;
	Wed, 15 Apr 2026 15:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776266358;
	bh=C2CEKkmCH9aV17LYLLM5/3fFEfH0fiYdFqoFdPLbCN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bS4AIlrTVya99sPUUaSqchJnoC6rYci6Xzps/4CQD2kUYYTmQDqXTctvL4FGXcCzN
	 X2IMTtcMBZa1NoBprs5sXGpMnltuGHDSD9onfKIKmRwOLCKIhTrX4VGTkJ9y1Ewjr7
	 jwJXWgWa9sfdD+xI8InH8vG3rho7h10owTtFx/8RPxFFImdgU6Z4lo3RgaPRSMg3S+
	 48jQ4ZE2kL+PI+CEk2JqSXD5+PZ5Rz97yOjVAPANdEA567ruWCca51wpQmDpWBvV9T
	 BEZ0NLRsjjZ0M1/L1Wqjr6NkZDOPzQiKBhADFn+WcQoQpOQ+zMpqCsbbTFDQTQ8p1x
	 6OP7bi0P8k8gg==
Date: Wed, 15 Apr 2026 16:19:13 +0100
From: Conor Dooley <conor@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: jk@codeconstruct.com.au, andriy.shevchenko@linux.intel.com,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Rayn Chen <rayn_chen@aspeedtech.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org
Subject: Re: [PATCH v29 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs properties
Message-ID: <20260415-unrushed-collected-562130070d8b@spud>
References: <20260415-upstream_i2c-v29-0-317c1a905ae1@aspeedtech.com>
 <20260415-upstream_i2c-v29-2-317c1a905ae1@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k6I7hnG3lmH5OCNw"
Content-Disposition: inline
In-Reply-To: <20260415-upstream_i2c-v29-2-317c1a905ae1@aspeedtech.com>


--k6I7hnG3lmH5OCNw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 01:14:03PM +0800, Ryan Chen wrote:
> Add the aspeed,global-regs phandle to reference the AST2600 global
> registers syscon node, containing the SoC-common I2C register set.
>=20
> These properties apply only to the AST2600 binding. Legacy DTs remain
> unchanged.
>=20
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

I hate to do it to you on v29, but can you please explain what this
"soc-common i2c register set" actually is/does in your commit message.
The patch seems fine, so with that
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

> ---
> Changes in v29:
> - remove aspeed,enable-dma properties.
>=20
> Changes in v28:
> - update commit message correspond with aspeed,enable-dma.
> - remove aspeed,transfer-mode and add aspeed,enable-dma property and
>   description.
> - Fix aspeed,enable-dma description to reflect hardware capability rather
>   than software behavior
>=20
> Changes in v27:
> - change aspeed,transfer-mode to aspeed,enable-dma.
> ---
>  Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yam=
l b/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
> index de2c359037da..0c769efb76a5 100644
> --- a/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
> @@ -37,6 +37,12 @@ properties:
>    resets:
>      maxItems: 1
> =20
> +  aspeed,global-regs:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle reference to the i2c global syscon node, containing the
> +      SoC-common i2c register set.
> +
>  required:
>    - reg
>    - compatible
> @@ -59,4 +65,5 @@ examples:
>          resets =3D <&syscon ASPEED_RESET_I2C>;
>          clock-frequency =3D <100000>;
>          interrupts =3D <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> +        aspeed,global-regs =3D <&i2c_global>;
>      };
>=20
> --=20
> 2.34.1
>=20

--k6I7hnG3lmH5OCNw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCad+scQAKCRB4tDGHoIJi
0kJHAQCCIue29Y53DEXwYeyc7bzKCGyQ41fURdeMFKTMRVm7uAD9FboLEsQkGSoy
RW+T31SM4kdnSSbuJvWj/tlGvWC9xQ8=
=8TWM
-----END PGP SIGNATURE-----

--k6I7hnG3lmH5OCNw--
