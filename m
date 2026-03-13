Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB1F2DC321;
	Fri, 13 Mar 2026 23:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773444087; cv=none; b=UXZ+rGtGp9PvSMm0ewxmlRpemSqrfODs+3OpCgMjXYS8aWPXB7OtvqzpybKbyoQSe3NV99Wumj22aa0CsMqPOc5QoLrEE1fXkx2S55DiIglZAyRHN+yZxPub8Me5wgXH4ErXNXBdyjbFsZ3ydEc/ye5Baz4szbIUmKhqL0v72u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773444087; c=relaxed/simple;
	bh=K0MwS09dQ1FesouGXSEQMZwoJn+bXck8mb7B9eGY9PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIqp24Zy/AKa03tMDK048xVZyhfTHs2z5PYtmKqsBbKcT7N717OifFxw39tQyelgHAZ8hZVvm6yhW2UTT28G+S4KBNOE4oiMQN7h3P5A8uF73F7k5RAmXLCqWqHjIbVoVwpvUf4dS5UCORol2jOcdVkZEgVp1z/x0QYfVyUsXe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUA3BHEN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUA3BHEN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0F5C19421;
	Fri, 13 Mar 2026 23:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773444087;
	bh=K0MwS09dQ1FesouGXSEQMZwoJn+bXck8mb7B9eGY9PE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CUA3BHENTCO2/8OpmA3fhIz4IpKY34WfNmtQuCpCcMZWtzNE54vhGCjTdx9AX+zFl
	 a0rjFZG33yC1qgp80l/Gb4AQodxRLwDMV7gu1kfjvdu916/jGRmk81bll8octDidUm
	 PqPhCWBmsgpmzNgHa3oVOvA4ZYLuEVkXhJb9MNS6dv8k0KHb/Ygiit1OP72nEVch85
	 pzh7f2mZ7r6SKN6qPAxubHSs9pwxpYQjdH2wWxfNMgPm5xTUVMUEFielRF6yktLTGk
	 6KYpxSlliMHhj6Zu0bD9/0ftA5JF0RbNE2s7n59C2iFSJoQLXW3APjj+J8FuIRvx50
	 gMbzlcF6SwfyQ==
Date: Fri, 13 Mar 2026 18:21:25 -0500
From: Rob Herring <robh@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: jk@codeconstruct.com.au, andriy.shevchenko@linux.intel.com,
	Andi Shyti <andi.shyti@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Rayn Chen <rayn_chen@aspeedtech.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org
Subject: Re: [PATCH v26 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and transfer-mode properties
Message-ID: <20260313232125.GA3618633-robh@kernel.org>
References: <20260309-upstream_i2c-v26-0-5fedcff8ffe8@aspeedtech.com>
 <20260309-upstream_i2c-v26-2-5fedcff8ffe8@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309-upstream_i2c-v26-2-5fedcff8ffe8@aspeedtech.com>

On Mon, Mar 09, 2026 at 02:53:53PM +0800, Ryan Chen wrote:
> The AST2600 I2C controller supports three transfer modes (byte, buffer,
> DMA). Add "aspeed,transfer-mode" so DT can select the preferred transfer
> method per controller instance. Also add the "aspeed,global-regs"
> phandle to reference the AST2600 global registers syscon/regmap used by
> the controller.
> 
> These properties apply only to the AST2600 binding and are not part of
> the legacy binding, which uses a mixed controller/target register layout
> and does not have the split register blocks or these new configuration
> registers. Legacy DTs remain unchanged.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../bindings/i2c/aspeed,ast2600-i2c.yaml           | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml b/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
> index de2c359037da..323e4f9b290a 100644
> --- a/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
> @@ -37,6 +37,33 @@ properties:
>    resets:
>      maxItems: 1
>  
> +  aspeed,transfer-mode:
> +    description: |
> +      ASPEED ast2600 platform equipped with 16 I2C controllers each i2c controller
> +      have 1 byte transfer buffer(byte mode), 32 bytes buffer(buffer mode), and
> +      share a DMA engine.
> +      Select I2C transfer mode for this controller. Supported values are:
> +        - "byte": Use 1 byte for i2c transmit (1-byte buffer).
> +        - "buffer": Use buffer (32-byte buffer) for i2c transmit. (default)
> +                    Better performance then byte mode.

Good, I like worse performance so I can use byte mode.

> +        - "dma": Each controller DMA mode is shared DMA engine. The AST2600 SoC
> +                 provides a single DMA engine shared for 16 I2C controllers,
> +                 so only a limited number of controllers can use DMA simultaneously.
> +                 Therefore, the DTS must explicitly assign which controllers are
> +                 configured to use DMA.
> +      On AST2600, each controller supports all three modes.
> +      If not specified, buffer mode is used by default.
> +    enum:
> +      - byte
> +      - buffer
> +      - dma

This is not required, so what is the default mode? If there's a default, 
you don't need the default value in the first place as the default is 
the property omitted.

> +
> +  aspeed,global-regs:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle reference to the i2c global syscon node, containing the
> +      SoC-common i2c register set.
> +
>  required:
>    - reg
>    - compatible
> @@ -59,4 +86,6 @@ examples:
>          resets = <&syscon ASPEED_RESET_I2C>;
>          clock-frequency = <100000>;
>          interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> +        aspeed,global-regs = <&i2c_global>;
> +        aspeed,transfer-mode = "buffer";
>      };
> 
> -- 
> 2.34.1
> 
