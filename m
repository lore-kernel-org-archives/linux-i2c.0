Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3575431A4A;
	Tue, 21 Jul 2026 07:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784617824; cv=none; b=X8wal9FjqxKqGuqS4ZlW2Gyder0NOKQlDZD8Lo05t43KmW3mMfoSbFkUYJ+cht92oAmEMfySrBT1VelN1qcBFRZ7+cr2p0jAd+v/nxr2FMoaNQFLoqVBKeZ+AHtgcNlcuyItvsuQH1vDuCieQZS/SBmNPMjfIzuVaE7eKVqJ5As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784617824; c=relaxed/simple;
	bh=ycEHmlBmFlbGg/OD7w/JY18OEOVeBzV8qNCEV33lyrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkZsgYlNaYGXlqzv6W9oaM0cl1CPpRxRiiqkWhVBlGV+ldMlNE6fQhe1gUIxypzb5j4wCRgHDDOd5GE5MNU0g8HmyeiZfJUmM1qnW4szmZKBCuS8WTmaV9IM7YKpcKcBn89UWnorgSpHraIDAv2KaKhhLbmunewb5IbSrZoRkVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZZxP4Uk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZZxP4Uk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B0C1F000E9;
	Tue, 21 Jul 2026 07:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784617822;
	bh=yIGkGQ7+1uRZgNjM7NPhwIGZ9Ea2jPnWaCNwrejgXGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XZZxP4Uk2KpocxVT5WQeb7P6/6RwAU//TxsAAvPCKDW8p9sLMlzCsus1uHBe67BRK
	 XbwBoSILF5O8xZqJLLlqnDSRG8AHoRheGxG2c15xPhrB2YJc977dtg7ivTpgD2iyur
	 I4GlBW3Sw/fd/eNq2RPpxmhzzm0ekxsl1K2SWkpe3dqcqHS1vOZWbB77lzNL8ex9CZ
	 EJbtvqc/YIU/CYble/WdX/HxtIPhlrZ0VdabXey60jui3BYD8aPTlo1Oen0+pz0gaL
	 3BkNyXpFubzuzsjNvmSx592ow5Wdf+uYX0/G/W4p3rajnXwvQ68zXZwrp/qDmpkwic
	 /rFP5zDDbeSdg==
Date: Tue, 21 Jul 2026 09:10:18 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nina_Kuo@novatek.com.tw
Cc: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ben_huang@novatek.com.tw, toby_chui@novatek.com.tw, 
	shihpei_hsu@novatek.com.tw
Subject: Re: [PATCH v3 2/3] dt-bindings: i2c: Add Novatek NT726xx SoC I2C
 controller
Message-ID: <20260721-notorious-flexible-uakari-ba8e0c@quoll>
References: <20260715073503.147552-1-Nina_Kuo@novatek.com.tw>
 <20260715073521.147610-1-Nina_Kuo@novatek.com.tw>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260715073521.147610-1-Nina_Kuo@novatek.com.tw>

On Wed, Jul 15, 2026 at 03:35:21PM +0800, Nina_Kuo@novatek.com.tw wrote:
> From: Ben Huang <Ben_Huang@novatek.com.tw>
> 
> Add device tree documentation for Novatek NT726xx SoC I2C controller.
> 
> Signed-off-by: Ben Huang <Ben_Huang@novatek.com.tw>
> Signed-off-by: Nina Kuo <Nina_Kuo@novatek.com.tw>
> ---
>  .../bindings/i2c/novatek,nt726xx-i2c.yaml     | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/novatek,nt726xx-i2c.yaml
> 
> diff --git a/Documentation/devicetree/bindings/i2c/novatek,nt726xx-i2c.yaml b/Documentation/devicetree/bindings/i2c/novatek,nt726xx-i2c.yaml
> new file mode 100644
> index 000000000000..866589c5ae51
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/novatek,nt726xx-i2c.yaml

Filename must match compatible.

> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/novatek,nt726xx-i2c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +maintainers:
> +  - Ben Huang <ben_huang@novatek.com.tw>
> +  - Jason JJ Wu <jason_jj_wu@novatek.com.tw>

Why are you changing the order of entries in the schema file? Do not
come with own style. Please read and follow writing-bindings and
example-schema.

> +
> +title: Novatek NT726xx Series SoC I2C master controller

So 726xx or 72600? Confusing.

> +
> +allOf:
> +  - $ref: /schemas/i2c/i2c-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: novatek,nt72600-i2c
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clock-frequency:
> +    default: 100000
> +    enum: [ 100000, 400000 ]
> +
> +  novatek,hwmods:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: Name of each i2c pin, must be named with "i2cX". (X is
> +                 an integer starting from 0, must be unique)

I do not understand the purpose of this property. How in one string can
you name each pin? And why would even need to name each pin - why would
that be a board setup? Pins have FIXED names.

Drop property.

> +
> +  novatek,stbc-controllable:
> +    type: boolean
> +    description: Set if this i2c master, named as `stbc-i2c`, is
> +      controllable by stbc (Standby controller, actually is an 8051
> +      micro-processor) on Novatek NT726xx SoCs.
> +      For these `stbc-i2c`s, the driven clock is only 12 MHz and the
> +      authentication to stbc must be executed before controlling the
> +      registers.

Compatible implies that, drop.

> +
> +    default: 0

Don't vibe code stuff.



> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - novatek,hwmods
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c0: i2c@10000000 {

Drop label

> +      compatible = "novatek,nt72600-i2c";
> +      reg = <0x0 0x10000000 0x0 0x100>;
> +      interrupts = <0 67 4>;

Use proper defines.

> +      clock-frequency = <400000>;
> +      novatek,hwmods = "i2c0";
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +    };
> +
> +    stbc-i2c1: i2c@20000000 {

Drop example, almost the same, so pretty pointless.

Best regards,
Krzysztof

