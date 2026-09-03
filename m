Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C533905E6;
	Thu,  3 Sep 2026 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788451476; cv=none; b=H21NBRf3sXYlcb+aB56iG/632M8nqUj96D2gzp2K2+bYeCWwaHjtLHu5D4NyhhlxvzaNEr2NsPTJTO5dqAhbhEeQxYsdTLXSESspkN4Mk0nWwBxjLMLd7t3Vn3YkUXMOl7arGbyYuAmrJIKIks0kIbHUhT2mL3bbJrzV66mGnrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788451476; c=relaxed/simple;
	bh=2MW0ioEujQOVp+f6nImFFrNzy9eO4Ugm7SBTzWAnWRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQLLnqwgQqu309JEAELxb0Tu3KtsDv4tT10G2VyXdPOkGQIzFM7LC4+n1ZhnBBWh50ufgcIOmFze8MKOKK3w4yeCxGZwkOXKgEXQx0HoWBEyvc+F514o4niQdgYAZHPP5/4imUbEeNmBEPqt6b5tiiYAoHUtjbQknMboW8kylPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKqG+aEI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKqG+aEI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2721F000E9;
	Thu,  3 Sep 2026 16:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788451475;
	bh=MqiA1DbIYJPMLgQHe4nNH7TIRbzNlFXGKVyGexU5CfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GKqG+aEIh0Jk91REyGYtC17TzM9rFxFOdERdyH3b8F8HIe5Qia02dqubwarFjsCVz
	 i0xZgOm0KU43vhW5IIdZIQWgKYXWEaJVPRRSt8pnCgAnmMhKVcj14GBrzNwGxZPn2A
	 tFFfwT96p0TqLMDbxJeehrmHSySZkXPr4GLGVTFd1XwdGYqIl+iQ4PlVxKoNfToN9f
	 QRDILVZOmgCiHeYs8RfABsT54sXu7FvWE2Ttg8BEoYgjkpZ1V5dDvXYNld6b8wgJbZ
	 qXJYN5rwp0VconzghxQcs19mFL/aBLCr7MKBztexrVt2Rk39jOs6b5eFZHzaSdXox3
	 piIwRDE5XJixg==
Date: Thu, 3 Sep 2026 11:04:34 -0500
From: Rob Herring <robh@kernel.org>
To: nina_kuo@novatek.com.tw
Cc: andi.shyti@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, ben_huang@novatek.com.tw,
	toby_chui@novatek.com.tw, shihpei_hsu@novatek.com.tw
Subject: Re: [PATCH v8 1/3] dt-bindings: i2c: Add Novatek NT72676 I2C
 controller
Message-ID: <20260903160434.GA3629759-robh@kernel.org>
References: <20260902091318.208074-1-nina_kuo@novatek.com.tw>
 <20260902091318.208074-2-nina_kuo@novatek.com.tw>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902091318.208074-2-nina_kuo@novatek.com.tw>

On Wed, Sep 02, 2026 at 05:13:16PM +0800, nina_kuo@novatek.com.tw wrote:
> From: Ben Huang <Ben_Huang@novatek.com.tw>
> 
> Add Devicetree binding documentation for Novatek NT72676 I2C
> controller.
> 
> Signed-off-by: Ben Huang <Ben_Huang@novatek.com.tw>
> Signed-off-by: Nina Kuo <Nina_Kuo@novatek.com.tw>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  .../bindings/i2c/novatek,nt72676-i2c.yaml     | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/novatek,nt72676-i2c.yaml
> 
> diff --git a/Documentation/devicetree/bindings/i2c/novatek,nt72676-i2c.yaml b/Documentation/devicetree/bindings/i2c/novatek,nt72676-i2c.yaml
> new file mode 100644
> index 000000000000..c9dd1c0d7957
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/novatek,nt72676-i2c.yaml
> @@ -0,0 +1,90 @@
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
> +description:
> +  Novatek NT72676 SoC provides two I2C controller variants, generic I2C and
> +  STBC I2C.

blank line between paragraphs and you need a '>' modifier on 
'description'.

> +  The generic I2C controllers are accessible only by the host CPU and driven
> +  by a 96 MHz AHB clock.
> +  On the other hand, the STBC I2C controllers can be controlled by either the
> +  host CPU or STBC (Standby Controller, an 8051-based microcontroller) and
> +  driven by a 12 MHz STBC clock. Authentication with STBC is required before
> +  the host CPU can access the STBC I2C controller registers.

Is the programming model of the I2C controller different? If not, the 
compatible should be the same.

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
> +  clocks:
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

Sounds like this could be modelled as a hwlock? That's other platforms 
mediate access to shared h/w. We really only want to have these syscon 
phandles as a last resort.

Rob
