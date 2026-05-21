Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1151C40DFC6;
	Thu, 21 May 2026 20:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779394967; cv=none; b=dB16vurUpt5PBUWpzLecXGfKuw5GnomRN9lV/UPu+DrgKKKbRpatjhUsesE/EbVNrubu8UeWwN0pEokhfJal/ccy1fGZt6oxMzySA4OF3LVbKFH3+xBSV2OZCfoAm5dyuQZL4S9BRaIM48InEl7KT8Lp2G86tzvmCfpWnNghrZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779394967; c=relaxed/simple;
	bh=vgGrGXlC8B7W+qEX0JsaxybsdkpKyA4CnsAsSut9k9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiz1tBkjXXKMFM3PipIhgCkuSAXnhoNpFdxGMHWDXwBm80xOxOVzNEzNq2LMA9k6seGgYtOYKfgs/ZjUoa2CMJsbubWzmweczCxQediXXZymZZnYsgqMkJV2b9CWzMVrIme9D0wYbsIeDOaAuQwbBJvAP5wp7uhELJlzx6ettvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJE5Bo35; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJE5Bo35"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CEA1F000E9;
	Thu, 21 May 2026 20:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779394965;
	bh=Tik6LxcYQF93n5WZRj36JO4fyVLR22dFV2Ovqk5ipg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YJE5Bo35Y4bAcOKUB4CUD0jfpY5JBQcHCttZzsCM5CPDzodDGI5MgDYiSt7SwuTN9
	 q9CWywyeAPFps7oN7pmeR5PMN5gz+/DRNWSKPE1OodMZCEBqZ2ic4wXjUvDWWESyI/
	 Ku0ljrzb8vl+znn0HuKDAYJahG9tb/3agYfRbkIs09lqiBBlRbIjy4GBRTZAO3DJyp
	 c91iIuT6QuPwla0Wfo0T3O6IdKNnmiPkK8G89pmg16dfNPsq+BXxRjJK8939QovB8X
	 syWpu7NiL4fTFNRQX0KNsjpmJXDKljs5wreSkeGM6DgvpCZaqUUr3r9SSbgoUK7AEK
	 3/xm6TcH2+MwQ==
Date: Thu, 21 May 2026 21:22:41 +0100
From: Conor Dooley <conor@kernel.org>
To: "lianfeng.ouyang" <lianfeng.ouyang@starfivetech.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: i2c: snps,dwc-i2c: Add StarFive
 JHB100 bindings
Message-ID: <20260521-deflected-overhand-47befb9dd5a4@spud>
References: <20260521034340.27837-1-lianfeng.ouyang@starfivetech.com>
 <20260521034340.27837-2-lianfeng.ouyang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KEJkg/M9spC7AjA9"
Content-Disposition: inline
In-Reply-To: <20260521034340.27837-2-lianfeng.ouyang@starfivetech.com>


--KEJkg/M9spC7AjA9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 11:43:38AM +0800, lianfeng.ouyang wrote:
> From: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
>=20
> Add device tree bindings for the Synopsys DesignWare Core (DWC) I2C
> controller and its StarFive JHB100 implementation
>=20
> The binding introduces a new compatible string: "snps,dwc-i2c", intended
> for the generic IP. It also defines two platform-specific compatibles
> for the StarFive JHB100 implementation:
> - "starfive,jhb100-dwc-i2c-master"
> - "starfive,jhb100-dwc-i2c-slave"

Do you have two different i2c controllers on the device, one which
implements only slave mode and one that only implements master?
Or can the same controller be both master or slave depending on how the
user wants to use it?

>=20
> The controller supports standard I2C and SMBus protocols, programmable
> FIFO depths, and optional SMBus Alert routing. The binding documents
> the necessary clocks, resets, and timing properties.
>=20
> Signed-off-by: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
> ---
>  .../devicetree/bindings/i2c/snps,dwc-i2c.yaml | 120 ++++++++++++++++++
>  1 file changed, 120 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/snps,dwc-i2c.ya=
ml
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/snps,dwc-i2c.yaml b/Do=
cumentation/devicetree/bindings/i2c/snps,dwc-i2c.yaml
> new file mode 100644
> index 000000000000..7227f24f7cbe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/snps,dwc-i2c.yaml
> @@ -0,0 +1,120 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2024 StarFive Technology Co., Ltd.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/snps,dwc-i2c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys DWC I2C Controller
> +
> +maintainers:
> +  - Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
> +
> +allOf:
> +  - $ref: /schemas/i2c/i2c-controller.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: Generic Synopsys DWC I2C controller
> +        const: snps,dwc-i2c

I think you should delete this, we don't want to permit avoiding using
soc-specific compatibles.

Why can't this go into the existing designware i2c binding?

> +      - description: StarFive JHB100 I2C master controller
> +        items:
> +          - const: starfive,jhb100-dwc-i2c-master
> +          - const: snps,dwc-i2c

This fallback needs to be a lot more specific about what the revision
is, so that people can figure out which fallback applies to them.

> +      - description: StarFive JHB100 I2C slave controller
> +        items:
> +          - const: starfive,jhb100-dwc-i2c-slave
> +          - const: snps,dwc-i2c
> +
> +  reg:
> +    description: DWC I2C controller memory mapped registers
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    items:
> +      - description: I2C controller reference clock source
> +      - description: APB interface clock source
> +
> +  clock-names:
> +    minItems: 1
> +    items:
> +      - const: ref
> +      - const: pclk

Please add a conditional section that sets the correct number of clocks
for your jhb100.

> +
> +  resets:
> +    maxItems: 1
> +
> +  clock-frequency:
> +    description: Desired I2C bus clock frequency in Hz
> +    enum: [100000, 400000, 1000000, 3400000]
> +    default: 400000
> +
> +  i2c-sda-hold-time-ns:
> +    description: |
> +      The property should contain the SDA hold time in nanoseconds.
> +      This value is used to compute value written into DW_IC_SDA_HOLD re=
gister.

Missing a default here.

> +
> +  i2c-scl-falling-time-ns:
> +    description: |
> +      The property should contain the SCL falling time in nanoseconds.
> +      This value is used to compute the tLOW period.
> +    default: 300
> +
> +  i2c-sda-falling-time-ns:
> +    description: |
> +      The property should contain the SDA falling time in nanoseconds.
> +      This value is used to compute the tHIGH period.
> +    default: 300
> +
> +  starfive,mctp-i2c-ms:
> +    description: |
> +      The property should contain reference to the master node associate=
d with the slave.
> +      This value is only used in slave mode, especially for MCTP applica=
tion.

This property is missing a type, but I also don't understand what it is
for. You shouldn't need to know what the i2c master is.
I assume it is meant to be a phandle? Can you share an example dts
that contains this property in use?

> +
> +  dwc-i2c-tx-fifo-depth:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      The property describes the tx fifo depth.
> +    default: 8
> +
> +  dwc-i2c-rx-fifo-depth:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      The property describes the rx fifo depth.
> +    default: 8
> +
> +unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts

clocks and clock-names too.

Bunch of valid complaints from sashiko on this, so
pw-bot: changes-requested

Thanks,
Conor.
> +
> +examples:
> +  - |
> +    i2c@f0000 {
> +      compatible =3D "snps,dwc-i2c";
> +      reg =3D <0xf0000 0x1000>;
> +      interrupts =3D <11>;
> +      clock-frequency =3D <400000>;
> +    };
> +  - |
> +    i2c@2000 {
> +      compatible =3D "snps,dwc-i2c";
> +      reg =3D <0x2000 0x100>;
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +      clock-frequency =3D <400000>;
> +      clocks =3D <&i2cclk>;
> +      interrupts =3D <0>;
> +
> +      eeprom@64 {
> +        compatible =3D "atmel,24c02";
> +        reg =3D <0x64>;
> +      };
> +    };
> +...
> --=20
> 2.43.0
>=20

--KEJkg/M9spC7AjA9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCag9pkQAKCRB4tDGHoIJi
0kgJAP94z1e7pviwGRZFAeIV+Y37K9/HpKSoHWFvPMa9IVrpdwD/cGxWbe2hUQuf
qTgTSGL/fz/9O6umJmm4wcXG2bSYpwg=
=ZXwL
-----END PGP SIGNATURE-----

--KEJkg/M9spC7AjA9--
