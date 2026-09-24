Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BCE223DC6;
	Thu, 24 Sep 2026 17:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269285; cv=none; b=egFAA+5SV9cC7BNepp57DwPmNVMo0qwoAZd6OnXj/rwnIPvJP6CXhKrQ+CHPLlIhozXF1dWaaBbKilSMA2MehyZpQvZqoglhBCG6PeQHr64OZOr4qAalkmaUEZCgYcFJEiDiVjuEtKNSJMHmc+IscObs7r7YPo9r5hcFso7Vuw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269285; c=relaxed/simple;
	bh=HoiZ1dOgaiWoXjsmkLXohzLMB9R80yFujkHl4ErAofo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPUj1UmTjAFWI7KGcljbJOg85zolVKy6kxgolGk9Rmx5LQUNGIVm+f/rh9S8LYTXtyHVKJonBy+07Lk3NWycOiop7JaN3Tnn6T7IRNTLIBmxj0zJBfBmBSDCvNMWWNCiGuOK4MWaAyqDcEotR5a+UoOA3GHMjGvZHU0JLhASEYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+cHBIAz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+cHBIAz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3044D1F00893;
	Thu, 24 Sep 2026 17:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269283;
	bh=nQm2TSsOFmCL75Ew2X2Ml8+Y1hxvqV0VYttpBX+ucy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W+cHBIAz4in40QufQgPnl6guc10fk/nKNFwovmn27Hn+FaoIpEPFdc5yE3AwgTwN9
	 8L00pVPfG69smeuGgutlyNuAk3wfOPA3BwzoH+EU/jrEASrrdmn6oD+BwGzBh4a1mn
	 OYxgH1XzECdZ5VQ82B2/g/rUZpYQ8FDlSRjBuBUaY4HjIBIMS8XzF4Cwcw0//xclVE
	 S2nhuYKt9zeI6zhzemyAQ63SI0PfJ/9YrrJGAkGnsD8RgYvZPE2Jpd+y0Zh4jqxSMc
	 C85+HE/uXDHOjjNizh40QzNePtLV4AvsyOcvvE+is9T1gSFRBd0rZqFfeffSUwHWHX
	 SAx7zSgXrZIhA==
Date: Thu, 24 Sep 2026 18:01:19 +0100
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
Subject: Re: [PATCH 1/3] dt-bindings: i2c: add Amlogic A9 I2C controller
Message-ID: <20260924-primarily-harmonica-fe3455834a4d@spud>
References: <20260924-a9-i2c-v1-0-b8ad9b46f4a8@amlogic.com>
 <20260924-a9-i2c-v1-1-b8ad9b46f4a8@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bItvP1XPExBUqZoU"
Content-Disposition: inline
In-Reply-To: <20260924-a9-i2c-v1-1-b8ad9b46f4a8@amlogic.com>

--bItvP1XPExBUqZoU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 08:39:34AM +0000, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>=20
> Add a Device Tree binding for the I2C controller found on the
> Amlogic A9 SoC.
>=20
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>

Since this is not in the existing meson file, does that mean that
there's a substantial change in the IP design, other than the addition
of dma support?

> ---
>  .../devicetree/bindings/i2c/amlogic,a9-i2c.yaml    | 61 ++++++++++++++++=
++++++
>  1 file changed, 61 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/amlogic,a9-i2c.yaml b/=
Documentation/devicetree/bindings/i2c/amlogic,a9-i2c.yaml
> new file mode 100644
> index 000000000000..681241a52680
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/amlogic,a9-i2c.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/amlogic,a9-i2c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic A9 I2C Controller
> +
> +maintainers:
> +  - Xianwei Zhao <xianwei.zhaol@amlogic.com>
> +  - Junyi Zhao <junyi.zhaol@amlogic.com>
> +
> +allOf:
> +  - $ref: /schemas/i2c/i2c-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: amlogic,a9-i2c
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  dmas:
> +    items:
> +      - description: DMA controller phandle and request line for RX
> +      - description: DMA controller phandle and request line for TX
> +
> +  dma-names:
> +    items:
> +      - const: rx
> +      - const: tx
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c@3a4400 {
> +        compatible =3D "amlogic,a9-i2c";
> +        reg =3D <0x3a4400 0x3c>;
> +        interrupts =3D <1 164 1>;
> +        clocks =3D <&clkc_periphs 11>;
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +

> +        eeprom@52 {
> +            compatible =3D "atmel,24c32";
> +            reg =3D <0x52>;
> +        };

Remove this from your example please.
pw-bot: changes-requested

Thanks,
Conor.

> +    };
>=20
> --=20
> 2.52.0
>=20
>=20

--bItvP1XPExBUqZoU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCarVXXwAKCRB4tDGHoIJi
0jmbAQD1+PWjoCf58ZsShK3wOnr3jQBCWLxJWedfv/9RCZ8hLgEAvsMsA+s7U7IE
/rNJ549B02Ub9QvF/P2SlcaHzmzGRgk=
=qjV7
-----END PGP SIGNATURE-----

--bItvP1XPExBUqZoU--
