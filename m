Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB5A379973;
	Thu,  9 Apr 2026 08:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775723205; cv=none; b=KgHewfTPeoDdv96Tj70dACzAjaawVoypMKvYrEdmRHu2yifHcDuA3Mnk5Q0q0MyjP4rPQjRc10UmB9cIYi3rUF5EJsyDfyEPxjgtGctKw/LvWY0ybdNAQfyO4CmNTl6J3+KNQY6F/DxSi+e7Sm74lcNqa+DBFlHQWo59WJXE2pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775723205; c=relaxed/simple;
	bh=8/p0/JoX4mpTggNx+ro1HSf4ExybGVw4dbDv5SxQ9Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2C2AjMhANePeNiunWsJqtMibhdL5fsJxnzx+KgALUpCzsDZscRqjy0F254fITD0dakziw5zFOSVW9RZklP007KWZTV9PSmhbe9wC6+3LdDbF8vk9H1HE+c7VVjm6qQlYJtHzzLmGh0VCee3cOX7Xf5KEyvHQkPjiIKuZcCXess=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=un86jXMh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="un86jXMh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A38C4CEF7;
	Thu,  9 Apr 2026 08:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775723205;
	bh=8/p0/JoX4mpTggNx+ro1HSf4ExybGVw4dbDv5SxQ9Ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=un86jXMhKEIvgpyIsyN99nNalun0WzvLnGha2x0PTCUIBVuVzgqe9Haipvw4PQHti
	 omCjMy99Vw8H9lGokllG/ucElDP9bVQxUKn3Yjpussz830+dSG+87j3Q91R/F5On6N
	 J1UFEfxiu+E/KSkHc82ii0xGVYzAE7tbpbLbQGIN/N6ZFKo98z/8lI2zaMhoZJeipq
	 4ji0KKAu0cD3Yf3VBNePoFwp8sF9upHuGuUqpMp6D/OP1rpE59xxz78QAhkajMg/6E
	 5Q/YkrLitZo/mbZ7WJDTEtIkQbTyFuSySk/891tGkivTW9k/Jl0Hl2PYGPog2uWy3I
	 HYvH3oDX0gVYw==
Date: Thu, 9 Apr 2026 10:26:42 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Akhila YS <akhilayalmati@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: nxp,pca9564: convert to DT schema
Message-ID: <20260409-rampant-swinging-wolf-51ab4e@quoll>
References: <20260408-i2c-nxp-v1-1-8276ccbd95fb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260408-i2c-nxp-v1-1-8276ccbd95fb@gmail.com>

On Wed, Apr 08, 2026 at 08:23:31AM +0000, Akhila YS wrote:
> Convert NXP PCA PCA9564/PCA9665 I2C controller to YAML format.

DT schema, not YAML format. Look at your subject.

...

> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  clock-frequency:
> +    default: 100000
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false

And if you tested any DTS with this, you would see this cannot work.
Look at other bindings - you miss ref to i2c-controller and
unevaluatedProps. But the problem is that you are doing something which
would never work, so I have doubts that you know what you are doing. One
thing is to make a mistake, other thing is to post something can never
work thus putting quite noticeable requirements on review.

Please first learn how DTS and DT bindings work, before you post new
patches.

Best regards,
Krzysztof

