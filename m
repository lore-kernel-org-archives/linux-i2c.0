Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1B142AF84;
	Tue,  4 Aug 2026 07:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785829464; cv=none; b=a0mdy7GZwDpAEM/3mxTtY68MHHXc3IjyZ1xj3QfgfHcheip9AWN0nR03Dz44rb/cppozhwZLd0tInId2EuFoagZU2Iro8bbgSpr5unwOONIROqRjzcxcHMrdd3dwtZibmKKcIk6nGFexhpzJNmjgNZa9jQDWfwrAATeipRZ8P/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785829464; c=relaxed/simple;
	bh=woxzAFK4rGmHYykcqk0oUVS5YeU8Z14WkTA9bJ6vHUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6YJKoOz8IOoOswRon+p/POouIvui1KgtFtiCxxhizHiE1h9vNH3vW8hXhE3y9b9bSKzrS0TCVuexPf2+AWkXKcRvfCrlqgOI0r4XDVcKx9PjHNVsCR6UJpPaMrZsNxYnNTg/bPZmLP6NdsEncnlY0QQW7qYeVg6annSilGFAkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPG+GITw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPG+GITw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CCC1F000E9;
	Tue,  4 Aug 2026 07:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785829462;
	bh=e5AKaJyQ3VcM1xlNOIoeCK1YfocbTCi5WGBcnip5BX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WPG+GITweFhEayZqj2MWkOyhQbgpbQ0cgIwMwvAuDHciQqwJYRwGkuPoKrJZUvGXH
	 f1lBXfkCPvYKAn+k93V2SZrGCjRsRkZ1rLslwixY+mWytdu2kVwQ4YHdRfC/qCv0db
	 BnsIWCX0cQMvxt59QFvXCVrRN9RK9tEQwfHbMHdurNe1CSVufmD0iptNOAWDYEYnsN
	 nNRGIdZbwzFWn5Buc58Ch+/kE/vmUIeWhpLXePlpBC781MMpBGWUGKVjvKr2jSWCFe
	 aRN0mg26PRbI6CTdHA1XzdhNyTacBf7+XoTP2QoB1sgpiuFL9oHGguskCjdtdFpYuF
	 bb27xbYYhNihw==
Date: Tue, 4 Aug 2026 09:44:18 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: i2c: Add Qualcomm I2C target
 controller
Message-ID: <20260804-airborne-impala-of-proficiency-a9a8d9@quoll>
References: <20260802-i2c-qcom-slave-v2-0-27653118fa75@oss.qualcomm.com>
 <20260802-i2c-qcom-slave-v2-1-27653118fa75@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260802-i2c-qcom-slave-v2-1-27653118fa75@oss.qualcomm.com>

On Sun, Aug 02, 2026 at 06:43:30PM +0530, Viken Dadhaniya wrote:
> QDU1000 and related Qualcomm SoCs include a dedicated I2C target
> controller that operates exclusively in target mode. It is a distinct
> IP from the Qualcomm I2C master controllers (GENI, QUP) with a
> different register interface, so it requires its own binding.
> 
> Document the MMIO region, interrupt, XO and AHB clocks, interconnect
> path, and optional pinctrl states for the controller.
> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/i2c/qcom,i2c-target.yaml   | 84 ++++++++++++++++++++++

Filename must match compatible.

>  1 file changed, 84 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-target.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-target.yaml
> new file mode 100644
> index 000000000000..1e34e874cc4c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-target.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/qcom,i2c-target.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm I2C Target Controller
> +
> +maintainers:
> +  - Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
> +  - Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> +
> +description:
> +  Dedicated hardware IP found on Qualcomm SoCs that operates exclusively
> +  as an I2C target (slave) device on the bus. Supports FIFO (PIO) mode
> +  for data transfer.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,qdu1000-i2c-target
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: XO reference clock
> +      - description: AHB bus clock
> +
> +  clock-names:
> +    items:
> +      - const: xo
> +      - const: ahb
> +
> +  interconnects:
> +    maxItems: 1
> +
> +  interconnect-names:
> +    const: i2c

Pretty useless name, drop the interconnect-names.

> +
> +  pinctrl-0: true
> +  pinctrl-1: true
> +
> +  pinctrl-names:
> +    items:
> +      - const: default
> +      - const: sleep
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - interconnects
> +  - interconnect-names
> +
> +allOf:
> +  - $ref: /schemas/i2c/i2c-controller.yaml#

This wasn't here before. Is this a controller or a target? Now I am
confused.

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/qcom,qdu1000-gcc.h>
> +    #include <dt-bindings/interconnect/qcom,qdu1000-rpmh.h>
> +
> +    i2c@88ca000 {
> +        compatible = "qcom,qdu1000-i2c-target";
> +        reg = <0x88ca000 0x64>;
> +        clocks = <&gcc GCC_SM_BUS_XO_CLK>, <&gcc GCC_SM_BUS_AHB_CLK>;
> +        clock-names = "xo", "ahb";
> +        interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;

How is this valid?

What sort of children the target has? What does it do with these
children?

> +        interconnect-names = "i2c";
> +        interconnects = <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SMBUS_CFG 0>;
> +    };
> +...
> 
> -- 
> 2.34.1
> 
