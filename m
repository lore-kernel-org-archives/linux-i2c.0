Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE7A36EA9B;
	Tue, 31 Mar 2026 06:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774939627; cv=none; b=VztvST3j42OirTrGIIpbUyMQGZnJYVmmoncbTPdWQWuHyomEdKKuZ1bjBlL1YPgF10sm6UYE72FDv1z+hSwonuO7MK2Myw+3ouyM0NQmE9Z7LjCHwDCN31/IUp6gWwlY7v2XNyNWXAql+Ax6mlKYIyMjcpQ3OTQ7LNL87KHOtfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774939627; c=relaxed/simple;
	bh=9Im09qmYZGWCtbT+mlfJFXb6Hn2kX5UH/o7ZzZP/L1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJOML08kvOopVdp1TOgHvlX0tPVZiAv0dirW/9Y9cF+V5/KOxYBO2I9ExW+lMJEK9G+K0C5+M8SecOwOq0LcxZ0k6fK8bsX8hGEKL4eOp4gu4CDAraWubxH9uhZKGfD7LZZIFLWR7h/jw1Tw646RIpYtbg2PYxvlhnt0xkaqb3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtbBV9lG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtbBV9lG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F053C19424;
	Tue, 31 Mar 2026 06:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774939627;
	bh=9Im09qmYZGWCtbT+mlfJFXb6Hn2kX5UH/o7ZzZP/L1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GtbBV9lGOF8Kq+J0uN0/aq0fHcjswO5NXh1oX/mmeHALzTL8VVJJ2U3XkcddvCK5/
	 2Zvo0pb4scqWdq9bt0PFAmwFSTlMQWAelrJbltpF3veYac79TSmRPJr07KJut3caek
	 UAzHx/T9MW9c3pCEYQUlMQocGKL8kA2Hy4Y2sL5+JG3OLeYhxR6KyqqClA6TfBeH13
	 LUsI70JcLiQbQl6F0EyKiZQnbH8aXtSFuAbYcDzW7ptApDNqJ07dwbZ0jQBAbxzSOV
	 qy8+soVAjjX+hVjRzUAopj0cI8bR3QgL890Kz73gwhJH6vFvwB0zCbCKoo6qzasK+b
	 dIpeH0HNEPLQA==
Date: Tue, 31 Mar 2026 08:47:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: jk@codeconstruct.com.au, andriy.shevchenko@linux.intel.com, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rayn Chen <rayn_chen@aspeedtech.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org
Subject: Re: [PATCH v28 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and enable-dma properties
Message-ID: <20260331-fanatic-certain-bustard-fb13bc@quoll>
References: <20260330-upstream_i2c-v28-0-17bdae39c5cb@aspeedtech.com>
 <20260330-upstream_i2c-v28-2-17bdae39c5cb@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260330-upstream_i2c-v28-2-17bdae39c5cb@aspeedtech.com>

On Mon, Mar 30, 2026 at 04:21:47PM +0800, Ryan Chen wrote:
> Add aspeed,enable-dma boolean property to indicate that DMA is
> available for transfers on this I2C bus.
> 
> Also add the aspeed,global-regs phandle to reference the AST2600
> global registers syscon node, containing the SoC-common I2C register
> set.
> 
> These properties apply only to the AST2600 binding. Legacy DTs remain
> unchanged.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
> Changes in v28:
> - update commit message correspond with aspeed,enable-dma.
> - remove aspeed,transfer-mode and add aspeed,enable-dma property and
>   description.
> - Fix aspeed,enable-dma description to reflect hardware capability rather
>   than software behavior
> Changes in v27:
> - change aspeed,transfer-mode to aspeed,enable-dma.
> ---
>  .../devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml          | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml b/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
> index de2c359037da..67b23d1a4cec 100644
> --- a/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
> @@ -37,6 +37,16 @@ properties:
>    resets:
>      maxItems: 1
>  
> +  aspeed,enable-dma:
> +    type: boolean
> +    description: Indicates this I2C controller instance has DMA capability.

Compatible implies that "I2C controller instance has DMA capability", no?

How two same devices, with exactly the same or compatible programming
model can have difference in the programming model for DMA (one lacks
it)?

Best regards,
Krzysztof

