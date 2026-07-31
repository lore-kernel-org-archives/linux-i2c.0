Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A460A3AF66E;
	Fri, 31 Jul 2026 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490459; cv=none; b=heOTCf1DBvQNi2aXuDG8paOm0QxgaV+dsiHp2yzQVARRuV3EHW2L0YowLzsg7LXB0SpAUKu+4RjBSV/lhsos3R/bCGwEvoFrOhpzUoAnGAfeKg72MsyAzcG5rUmP0CPMxbd2aya9v10zVTjNBzJppGxMcHdT+a02OapxdcXRyXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490459; c=relaxed/simple;
	bh=vheNsy+CERFXUimzXwqpeyZa+A30Mlv6Cm/Pcvp+AXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2dy5HPEIRuzGGf81QuA98jr5xk3BPiSNGQFD45DOkqDv2qkpybeF1dYLiExcEV3EPa9Wj1HStbU3ZU1kRCmDkPO/U8H8hTbSm/uVLTDxrKA/NA6DRkGfA23Mf5G8FN4NQM+7BPGjQANzH9pCgix4YVLuWZe9/DwhyvyZy8TjKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcZKvz9w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcZKvz9w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0B51F00A3A;
	Fri, 31 Jul 2026 09:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785490458;
	bh=f9EfnrJhSVxK3h3FEufRSE76SqTVyeSgIYY0ZIrWylU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UcZKvz9w2ICo8vdYq2wAdT5Lz65lpCXIamkvbbpGaLQwFPQuuzLUSYw2TkHXX2dhs
	 m5Ph5WFuL/oMdMoTeLxRJ8Z03JenwfRBIXhTBZfBtdLj+E/iaXpdLBNyNZoRpsWA/s
	 2RkPZgOYfpc0jsoaUo1+D9tNZe0nNdvZX37mI+z7JMEFK9PQBFv5UpzbqUVTSl8Rfu
	 jGEU6StWRVSQGZZNMcJtmkqopVmHUsLprNIC2/0bX8FSq1VQbOHDWmW3DXSgfS8b6H
	 oMYkz88sPGh6ajkr56vRpIKBUzPKkGQ2Zp9RMI5OTVOeWIJs/lTdFc4rV7kqDnHPKd
	 bv1H4PX3/Glxw==
Date: Fri, 31 Jul 2026 11:34:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: nina_kuo@novatek.com.tw
Cc: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ben_huang@novatek.com.tw, toby_chui@novatek.com.tw, 
	shihpei_hsu@novatek.com.tw
Subject: Re: [PATCH v4 1/3] dt-bindings: i2c: Add Novatek NT72676 I2C
 controller
Message-ID: <20260731-caped-miraculous-quetzal-1fffb7@quoll>
References: <20260730072529.492398-1-nina_kuo@novatek.com.tw>
 <20260730072529.492398-2-nina_kuo@novatek.com.tw>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260730072529.492398-2-nina_kuo@novatek.com.tw>

On Thu, Jul 30, 2026 at 03:25:27PM +0800, nina_kuo@novatek.com.tw wrote:
> diff --git a/Documentation/devicetree/bindings/i2c/novatek,nt72676-i2c.yaml b/Documentation/devicetree/bindings/i2c/novatek,nt72676-i2c.yaml
> new file mode 100644
> index 000000000000..8e2595f882c4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/novatek,nt72676-i2c.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/novatek,nt72676-i2c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Novatek NT72676 I2C Controller
> +
> +maintainers:
> +  - Ben Huang <ben_huang@novatek.com.tw>
> +  - Jason JJ Wu <jason_jj_wu@novatek.com.tw>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  Novatek NT72676 SoC provides two I2C controller variants: generic I2C and
> +  STBC I2C.
> +  The generic I2C controllers are accessible only by the host CPU and driven
> +  by a 96 MHz AHB clock.
> +  On the other hand, the STBC I2C controllers can be controlled by either the
> +  host CPU or STBC (Standby Controller, an 8051-based microcontroller) and
> +  driven by a 12 MHz STBC clock. Authentication with STBC is required before
> +  the host CPU can access the STBC I2C controller registers.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - novatek,nt72676-i2c
> +      - novatek,nt72676-stbc-i2c
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
> +  novatek,stbc-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the STBC system controller registers used to authenticate
> +      host access and switch ownership of the STBC I2C controller.
> +

You miss clocks.

Best regards,
Krzysztof

