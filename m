Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF40405C32;
	Wed, 27 May 2026 13:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779887098; cv=none; b=rzlk9Bfpw2RNo8oqslsrYpQrqzHR28flK2VH2w6k9imdD+Na3n+h1zJ4KpyDeZTgb7+SNL8q0e955R1VNy710zkapaLqbrREYLwGeKbwoaKMKDtVT1TOxbAA/2O6LFYESOqOLdQ49JBmwwYgdY4jB2iG+uBx9p7PBBGYxlAq2fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779887098; c=relaxed/simple;
	bh=1LjsNRksH/mflhz9ID8TlU1o7xvE6o65AWD/3kwf1gI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZgyPsHTEjkYnif47G7Bg7RFZwMQ8YouLqcW2p4qFhOtV7DtB+jMG3mm5eBq4M5/nKjVjxrWr1BjSE6vZYIbVZl2EnmsGHNW7XYabnpTf6PV8VuqnHJ0yiE0jWka0OZd4ZLffVH9YXD1Z5+oLmIA3RmiMW2x7x2va0ngTeqHgqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJ5WV3bO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJ5WV3bO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9934D1F00A3A;
	Wed, 27 May 2026 13:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779887097;
	bh=tAoX3gZWUi3Mlje0rmmUIESitxNwJe9AScaxGD77fkY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LJ5WV3bOqmJhbFy1pJTG5XJAF4bOFiD24Hdwb9FXeQr1alNvi8vRj2rFo9Wyimdot
	 coVY1KFihf7TIwS7ouL7bW/ShmshrEu1bu8mvshxLAZTf4wCgUtNkPDfCzycPU/No8
	 mN+cZY90iza1MzFcs02iBHAmDVNgD6Uor71GB5H/4Wyl8fS1ffpYj3jwbkqbYDVFyE
	 AIPbRxUbajOOpJgSZbM9ihL1qBTxR8fGiq38aggwSL1imUMGrnIc8HapEXJO8ppfip
	 dFsToLBbvP2e7QTxLZTIUhcs96sOJ8Nhy/vuhCZEV24ekXIfUpmbHxk/wDuwD3bZcI
	 TM1D3PPz2HOGw==
Message-ID: <0e3bae26-3bc3-43ff-8d66-aba84a6f6677@kernel.org>
Date: Wed, 27 May 2026 15:04:52 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: i2c: Add StarFive JHB100 I2C
To: "lianfeng.ouyang" <lianfeng.ouyang@starfivetech.com>,
 Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260527085039.44435-1-lianfeng.ouyang@starfivetech.com>
 <20260527085039.44435-2-lianfeng.ouyang@starfivetech.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260527085039.44435-2-lianfeng.ouyang@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/05/2026 10:50, lianfeng.ouyang wrote:
> From: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
> 
> Add device tree bindings for the Starfive I2C controller
> and its implementation
> 
> The binding defines two platform-specific compatibles for the StarFive
> JHB100 implementation:
> - "starfive,jhb100-i2c-master"
> - "starfive,jhb100-i2c-slave"

You might get the same questions as v1, till you solve them. Why do you
add device role to the compatible?

Do not explain  WHAT you did here. Explain the background and why you
did that way.

Also, use undeprecated naming, not master/slave.

> 
> The controller supports standard I2C and SMBus protocols, programmable
> FIFO depths, and optional SMBus Alert routing. The binding documents
> the necessary clocks, resets, and timing properties.
> 
> Signed-off-by: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
> ---
>  .../bindings/i2c/starfive,jhb100-i2c.yaml     | 128 ++++++++++++++++++
>  1 file changed, 128 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/starfive,jhb100-i2c.yaml
> 
> diff --git a/Documentation/devicetree/bindings/i2c/starfive,jhb100-i2c.yaml b/Documentation/devicetree/bindings/i2c/starfive,jhb100-i2c.yaml
> new file mode 100644
> index 000000000000..c8631348121c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/starfive,jhb100-i2c.yaml
> @@ -0,0 +1,128 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2024 StarFive Technology Co., Ltd.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/starfive,jhb100-i2c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive jhb100 I2C Controller
> +
> +maintainers:
> +  - Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
> +
> +allOf:
> +  - $ref: /schemas/i2c/i2c-controller.yaml#
> +
> +properties:
> +  compatible:
> +    description: |
> +      Must be one of:
> +      - "starfive,jhb100-i2c-master" for master mode controller
> +      - "starfive,jhb100-i2c-slave" for slave mode controller

Drop description, redundant. Schema tells that.

> +    enum:
> +      - starfive,jhb100-i2c-master
> +      - starfive,jhb100-i2c-slave
> +
> +  reg:
> +    maxItems: 1
> +    description: StarFive I2C controller memory mapped registers

Drop description, redundant.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 2

Drop both, redundant.

> +    items:
> +      - description: I2C controller reference clock source
> +      - description: APB interface clock source
> +
> +  clock-names:
> +    minItems: 2
> +    maxItems: 2

Same. From where did you take such syntax...

> +    items:
> +      - const: ref
> +      - const: pclk
> +
> +  resets:
> +    maxItems: 1
> +    description: Phandle to the reset controller for the I2C controller

Drop description. Or say something useful.

> +
> +  clock-frequency:
> +    description: Desired I2C bus clock frequency in Hz
> +    enum: [100000, 400000, 1000000, 3400000]

Aren't you duplicating constraints from dtschema?

> +    default: 400000
> +
> +  i2c-sda-hold-time-ns:

So you added a generic property - where is it documented? Generic
properties must be in common schema or dtschema.

And please prove that none of the generic properties are suitable.

> +    $ref: /schemas/types.yaml#/definitions/uint32

I don't think you tested it. And this concludes my review. I finished
here. Please do not send untested bindings.


Best regards,
Krzysztof
