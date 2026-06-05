Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E03B405C25;
	Fri,  5 Jun 2026 10:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780655869; cv=none; b=UZclQiXLQcOcmMZFkbn0855h8jtEQtSciKJ366fMYTqoYRfN5h6YPs56R2iKHCxwpYnDSEddulDto7pD+GjHna34KiEG1+22YYmxwgQHjus4dcEEaSJeHcQtR1pyvs75CiCQqf36XTllwmr3v1STf2Pi8qnSJv61CuI93zboEkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780655869; c=relaxed/simple;
	bh=FIzdTczJRHmOyzHmlid1zzuPA3wHoAdl+dKfG7bIf4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RLFH4Z1Rjo67wLHrKQSEoh66D67yOfOfpLeFknAAjA6Tf4yvDajPqHvhzDKoJG6cquNa1KhirdLX/n6ihdmhwXuf+oAz4foadqgZxLrvt+zcbzyuaF9WepYeaMnZfSpYLYmPIMM5HeUtW7508VXW6dOr1c41lbC+F9sBnYPP19Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXFFssKd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXFFssKd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585D81F00893;
	Fri,  5 Jun 2026 10:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780655867;
	bh=7zKPX2gJZRGl22ScmucAkq8WKAzIuvDi/pQbxdTFxD8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MXFFssKdC98J/AqcEWwQ/KPiXv5VrVNkVItvZt2mpZ4STU7mEMFsIWq/TB1qwWytY
	 yI2Ri0Sjz/J0BoUDmCE6FiFHCQe9BXqr8yMRnvREiXGi9Rf3tZ3Fir2Emc4HDczU8p
	 NM9jRoz6JWS/7IShW4CQWo7dBaT8K37jNRCnoc4dECyBa8Rc9h3S/IypiA8aasTL8n
	 3ABlijYf7N1jsb8w12KYIT3b5UZOc8o8xX40OR+SiOpIIHxnQz85x0XggxW206SJ8L
	 f2u1kogRYzIcoRQhy/nbjsQB3giLVZmxb1Lb+ILKFCgqM8F2NkYzwRbEFRyqbwxf3Q
	 uKql4t3PCcwLA==
Message-ID: <ffb9c16e-5a5a-45c4-8d4b-369b0a4fe314@kernel.org>
Date: Fri, 5 Jun 2026 12:37:40 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: i2c: add Novatek NT726xx SoC i2c
 controller
To: SP_ISW1_AT@novatek.com.tw, andi.shyti@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ben_huang@novatek.com.tw, toby_chui@novatek.com.tw,
 shihpei_hsu@novatek.com.tw
References: <20260605035558.383330-1-SP_ISW1_AT@novatek.com.tw>
 <20260605035614.383387-1-SP_ISW1_AT@novatek.com.tw>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260605035614.383387-1-SP_ISW1_AT@novatek.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/06/2026 05:56, SP_ISW1_AT@novatek.com.tw wrote:
> From: Ben Huang <Ben_Huang@novatek.com.tw>
> 
> Add device tree documentation for Novatek NT726xx SoC i2c controller.
> 
> Signed-off-by: Ben Huang <Ben_Huang@novatek.com.tw>
> Signed-off-by: Novatek i2c <SP_ISW1_AT@novatek.com.tw>

This won't work. Please see submitting patches and explanation of DCO.


> ---
> v2:


Please version your patches correctly, e.g. use b4 or git format-patch
-vX, and add changelog in cover letter or under '---' of individual
patches describing changes from previous version.


Limited review.

> - Add Novatek i2c to Signed-off-by email list.
> - Remove confidential related statements and HTML messages.
> - Fix the potential issues in the device tree document and
>   i2c driver source codes.
> - Fix typos.
> 
> v1:
> https://lore.kernel.org/lkml/20260604060411.355675-1-SP_ISW1_AT@novatek.com.tw/T/#t
> ---
>  .../bindings/i2c/novatek,nt726xx-i2c.yaml     | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/novatek,nt726xx-i2c.yaml
> 
> diff --git a/Documentation/devicetree/bindings/i2c/novatek,nt726xx-i2c.yaml b/Documentation/devicetree/bindings/i2c/novatek,nt726xx-i2c.yaml
> new file mode 100644
> index 000000000000..d9dfdaaec205
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/novatek,nt726xx-i2c.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/novatek,nt726xx-i2c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +maintainers:
> +  - Ben Huang <ben_huang@novatek.com.tw>
> +  - Jason JJ Wu <jason_jj_wu@novatek.com.tw>
> +
> +title: Novatek NT726xx SoC I2C master controller
> +
> +allOf:
> +  - $ref: /schemas/i2c/i2c-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: novatek,nt726xx-i2c
> +
> +  reg:
> +    maxItems: 4

You need to list the items instead.

> +
> +  interrupts:
> +    maxItems: 3

You need to list the items instead.

> +
> +  clock-frequency:
> +    description: Operation clock frequency of i2c in Hz.

Drop

> +    default: 100000
> +    enum: [ 100000, 400000 ]
> +
> +  novatek,hwmods:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: Name of each i2c pin, must be named with "i2cX". (X is
> +                 an integer starting from 0)
> +    minItems: 1

There is no such syntax. Please do not invent own style.

Anyway, I don't understand the property - drop.

> +
> +  novatek,stbc:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Set if this i2c master controlled by stbc.

No clue what does that mean. What is stbc? Acronym of something? Why
would that be a property of a board?

> +    minItems: 1

Please open existing code. Do you see anywhere uint32 with minItems?
Like anywhere? I really wonder what process lead to such code...



> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - novatek,hwmods
> +
> +unevaluatedProperties: false

Missing example. Please open existing bindings and look how it is done.
do you see i2c controllers without examples?

This binding has several trivial issues which means you did not really
use existing code as starting point, did not read the docs or tutorials
from OSS conferences. I encourage to start with these.

Best regards,
Krzysztof
