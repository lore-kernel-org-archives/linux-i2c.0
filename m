Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793126203;
	b=uzk24KmGN4oBEbR6jQSG1CI+VRz/yanfaMmGxPJgV7wKheXUAtKihknt3kWacFys0Nyq
	 r41oWyKGPlsv/Fza1cv6Yg8Xx7S21tgdZ8IT9KlCYYRlZOQbvv4ZH6SpWGzUnD5Cu1rn5
	 MEQqu8YpI8zbPhk6vPNwAop4vdiaWVg+cFIk9+x1T46Gu0eAhwKGr8tjhkz/8V1BRvVQB
	 ua/P62vKV1dfOs2CQA46s+m/tQJtD1YI7kQP5lNIRSVwOhrPhUGWaIJnyNAQQompsCHrz
	 B7ofcXS1H3h+PZ8SIVSvFbzyExLdjw8bUkviIOwY1zU4MiDE54oYuVyEaUlufLK9ekg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793126203;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZklRgwYh2m/0QNgZqJewCA2TZqp2YQjkYuRuekeI+3Q=;
	b=Q/IC/5hGBhDzU/Eu4RX4Dn0Nxd0d3Kqamm2xr97P9R+o32h01BJATrPx2OLPACAmekTc
	 9R16V7gJ9bH94Q4HPMnhpx720ncaLXASInNJCLODRHAM07NolvgsUmh8UdIZvMX6I8XrS
	 UvLk2S82IkSrB0P50mIgAJ1HJXv5tVu8Xe6uku9pRQMwFSnbq4ildzVUk6kA4vgOjnS79
	 51UZnWWUwGp2k6IJkb6e8ql/Dc6A0eQkJjUjxjVB6xZ/uYiluFH/T/dOXLsen4mJQUheM
	 Iw/91CZY8ry1aJcGZVohiz3pQXRZjMQFI8jxpRJjYpx+dn+cVwGiL6/O2szKoJMARNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ky1HYNW2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C58606A31D;
	Tue, 27 Oct 2026 18:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ky1HYNW2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157351F01825;
	Tue, 27 Oct 2026 18:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793126202;
	bh=ZklRgwYh2m/0QNgZqJewCA2TZqp2YQjkYuRuekeI+3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ky1HYNW2CruhbVybe/rnHs0X6RATwdkRMNG2BuBWtm40/kJ0rqHPZY5l5zpU9qvH3
	 eOofh7Ypl4NKKRR2BcUmFkCcczDbr9JSAtnsKi6PLkE4+buSKTl1z75zenDhGirl35
	 JJwszMx2Nxg6QjFWuzxEa/EhQ37m+LWfA0nc46Hbur0fM+VfNCmm/dkEzN3kaPl8M1
	 sdR3aXKK0dpzAL92kANIFokMqN6rbNxLd7F6QPCWg2KE/McTKl13CzwJwSEzwKgAuy
	 AQBVy+OdOMXCjXi8/dS5TY+TterOkMT3QN7jiJFFpcpgC37YuDKoaGz1NFzYg8Jw5G
	 JeEHXFoPqulew==
Date: Tue, 27 Oct 2026 19:36:38 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aniket Limaye <a-limaye@ti.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lianfeng.ouyang@starfivetech.com
Subject: Re: [PATCH v4 1/2] dt-bindings: i2c: Add Synopsys DWC_i2c controller
Message-ID: <20261027-masked-ultraviolet-kittiwake-7da8ec@quoll>
References: <20261027-tda54-upstream-i2c-v4-0-ebeeaf87d181@ti.com>
 <20261027-tda54-upstream-i2c-v4-1-ebeeaf87d181@ti.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261027-tda54-upstream-i2c-v4-1-ebeeaf87d181@ti.com>

On Tue, Oct 27, 2026 at 05:00:35PM +0530, Aniket Limaye wrote:
> Add documentation for the Synopsys Advanced I2C (DWC_i2c) controller, as
> found on the TI TDA54 SoC.
> 
> The block cannot work on its own and needs SoC integration, e.g. the
> FIFO depths are not discoverable from the IP. Do not add a generic
> compatible and only list SoC specific compatibles. The file is named
> after the IP so that other SoCs integrating it can be added here.
> 
> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
> 
> ---
> 

Here you mention dependency on new dtschema (unreleased), since the
property was added a few days ago.

> Changes in v4:
> - Drop the approach of extending the existing i2c-designware-* driver
>   with a MODEL_TI_TDA54 variant. Instead, add a new standalone driver
>   (i2c-dwc-adv.c) and a new binding (snps,dwc-adv-i2c.yaml), since
>   DWC_i2c is not register compatible with DW_apb_i2c. (Andy Shevchenko)
> - Drop the snps,tx-fifo-depth/snps,rx-fifo-depth DT properties from
>   the new binding; FIFO depth is now tied to the compatible string via
>   driver match data instead. (Conor Dooley)
> - Link to v3: https://lore.kernel.org/all/20260925-tda54-upstream-i2c-v3-1-544d74e992ff@ti.com/
> 
> Changes in v2:
> - Rename snps,dwc-i2c to ti,tda54-i2c
> - Link to v1: https://lore.kernel.org/r/20260919-tda54-upstream-i2c-v1-1-b0b9f77be18b@ti.com/
> ---
>  .../devicetree/bindings/i2c/snps,dwc-adv-i2c.yaml  | 75 ++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/snps,dwc-adv-i2c.yaml b/Documentation/devicetree/bindings/i2c/snps,dwc-adv-i2c.yaml
> new file mode 100644
> index 000000000000..7ad22536825e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/snps,dwc-adv-i2c.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/snps,dwc-adv-i2c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys DesignWare Advanced I2C (DWC_i2c) Controller
> +
> +maintainers:
> +  - Aniket Limaye <a-limaye@ti.com>
> +
> +allOf:
> +  - $ref: /schemas/i2c/i2c-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,tda54-i2c
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: I2C functional clock (ic_clk)
> +      - description: Register interface clock (pclk)
> +
> +  clock-names:
> +    items:
> +      - const: ref
> +      - const: pclk
> +
> +  resets:
> +    maxItems: 1
> +
> +  clock-frequency:
> +    enum: [100000, 400000, 1000000, 3400000]
> +    default: 400000
> +
> +  i2c-sda-hold-time-ns: true

Missing  default, constraints (minimum/maximum)


> +
> +  i2c-scl-falling-time-ns:
> +    default: 300

no min/max?

> +
> +  i2c-sda-falling-time-ns:
> +    default: 300

Best regards,
Krzysztof

