Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257293D0912;
	Wed, 25 Mar 2026 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774438930; cv=none; b=ggfIw2yKVHf/9vyjAInqgB7C48X4HkCjII2MzCjOG+r2jskWbrY/CYuxX7Oe/VAOa8aqLjsQijTIhHWjwEczMn7RoHGbGWCppsz/+Wpy6dS/xe13i3lELJiU0kbw+M15LpQHZmc/0RJ/fwd0aM8qcRsx59Znxu5s5BetBBEahIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774438930; c=relaxed/simple;
	bh=kh/jN1CdwNi69t1+cwpmuuAb4JNtpOguKFh6kGpw2Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOp0WyZhlnzaTmcsslp7EhHAoyYEX7iT2kvFl1oupQww659X7pxfOFQ530Y3r92bRJikEoszWr9FrHNGRhRiNRdb7c52g8nPvoU3uK5tk/E+tO9Q8/aQF01ZXdPTdc5A5cG2+ctUjr7ohyDjC9gGUQHq9k9dcfcEN1+aY1o3ck0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJcFw+Jv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJcFw+Jv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A515C2BC9E;
	Wed, 25 Mar 2026 11:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774438929;
	bh=kh/jN1CdwNi69t1+cwpmuuAb4JNtpOguKFh6kGpw2Uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HJcFw+JvdsUBf0RVDXtcG5Y6yVzGc3mFiYDZXTiyu2rmomGVGatjk8TOdhfZpxVVy
	 AKcah/k9lznxdVfZ8G1itUwWMCPLzrPHKaNj+FxPdcfpbsJEAs0fY/2N5gdaBUO/On
	 8aRyzkIuZW5/RfTBhnMOEpBI6YO8Tpp4sbzBKHqfD5Y0yXLG9k12jHUj6VtXGJtdp2
	 QIwFhmyqCLMQ1cFFR0A93j1JkO2kzOi8GUsqZ6c/rKZ0QesWOm0liC48Cq1piVGDtG
	 DCUQ+0T96fgGNhtEa24bPgoaTzfNfjAgRjwZ+3y+vY9pxPXIoKfvguZt0ugAMuA1l5
	 x6qtw0SslL60A==
Date: Wed, 25 Mar 2026 12:42:06 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Hongliang Wang <wanghongliang@loongson.cn>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, loongarch@lists.linux.dev
Subject: Re: [PATCH v1 1/2] dt-bindings: i2c: ls2x-i2c: Add clock- related
 properties
Message-ID: <20260325-qualified-hairy-rattlesnake-b1ffe1@quoll>
References: <20260325011852.19079-1-wanghongliang@loongson.cn>
 <20260325011852.19079-2-wanghongliang@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260325011852.19079-2-wanghongliang@loongson.cn>

On Wed, Mar 25, 2026 at 09:18:51AM +0800, Hongliang Wang wrote:
> From: wanghongliang <wanghongliang@loongson.cn>
> 
> Add clock-input and clock-div properties.
> 
> clock-input describes the input clock of i2c controller.

No, it does not.


> clock-div describes the clock divisor of the input clock
> of i2c controller.

No, it does not.

Write proper explanations, instead of justyfing your code with
tautology.

> 
> Prcescale = (clock-input * 10) / (clock-div * t->bus_freq_hz) - 1
> 
> Signed-off-by: wanghongliang <wanghongliang@loongson.cn>
> ---
>  .../devicetree/bindings/i2c/loongson,ls2x-i2c.yaml  | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml b/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
> index 67882ec6e06a..4659d7012bce 100644
> --- a/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
> @@ -24,6 +24,16 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  clock-input:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Describes the input clock of i2c controller in HZ.

"clocks" property describes the clock input. And it is not in Hz (not
HZ! It is coming from a person's name) but phandle already defined.

> +
> +  clock-div:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Describes the divisor of the input clock of i2c controller.

Use clock framework.

> +
>  required:
>    - compatible
>    - reg
> @@ -40,6 +50,9 @@ examples:
>          reg = <0x1fe21000 0x8>;
>          interrupt-parent = <&extioiic>;
>          interrupts = <22 IRQ_TYPE_LEVEL_LOW>;
> +        clock-frequency = <100000>;
> +        clock-input = <100000000>;
> +        clock-div = <40>;
>          #address-cells = <1>;
>          #size-cells = <0>;
>  
> -- 
> 2.47.2
> 
