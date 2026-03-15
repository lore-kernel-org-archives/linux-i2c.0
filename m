Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9F742AA9;
	Sun, 15 Mar 2026 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773565014; cv=none; b=r2/rE6XPDOYOJejWNMzOeLInms8VghamfwqVXZ4g63YB3sr3Fh5UnmUY5ytykUeQg53KGpvIlcAKxu2JZyLZFPYcpjbE/y5REXgyLd6oS9VNAi5gkmnmekMhlJoUwIehB2w9Ewn66p7vjVVCWRkIXYT7zlqU4UnpOB9BdaC/oqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773565014; c=relaxed/simple;
	bh=PlFa3Zx/ETGYO2DSKTXs4l2/+CPQZHY0wqnSIzAVRcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNIezPXcqfrHPxM+FHsLYmsrYUPyXlIwdragTRDlnZZxyrZnY1xi3tEBM6qkjm3NSutY6MSmo7ReFQrEYNDYQEoW15HcVfGgKkgyYptVsZNaAZIh64MJhg4uVCvLJ3gSf7MEs7RcRblfDQCwBl3yYRUcR6/0+9SH99Pr6hj4JeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fr29gpYM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fr29gpYM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812D5C4CEF7;
	Sun, 15 Mar 2026 08:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773565013;
	bh=PlFa3Zx/ETGYO2DSKTXs4l2/+CPQZHY0wqnSIzAVRcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fr29gpYMey0KzTV/prMNc9ykPU5EMNsk94/TlEturVfI1gPhTbL+gH9UnBtj0wJcP
	 m4p5cRpBNAWc3dYQj716XRdXrk1N+uRA3qLI05ZFksr4UfSXqz8/jWwz2T4FrggA/v
	 z7c0qVgQBmThqGpWaERLwtQPYbxq4xJrmAKnm1Od8ZEVczDbZb5TshvdFC0zBe3UVq
	 eAuGR7CYBytIdYlwDVvO0D8O8cyI9actVQCBAj6EgS+GFrHXiszxzw7gvpQYSfGAx9
	 YwRZLezYyfdONqPdwdGz+tSXK/2IychbbjqLzQ4i4P1Uzk0NleFFga8wvi11cg5Xc4
	 v6TXH96c/dNww==
Date: Sun, 15 Mar 2026 09:56:51 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rustam Adilov <adilov@disroot.org>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] dt-bindings: i2c: realtek,rtl9301-i2c: extend for
 RTL9607C support
Message-ID: <20260315-invaluable-adamant-urchin-7aaf7e@quoll>
References: <20260314082628.25206-1-adilov@disroot.org>
 <20260314082628.25206-8-adilov@disroot.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260314082628.25206-8-adilov@disroot.org>

On Sat, Mar 14, 2026 at 01:26:27PM +0500, Rustam Adilov wrote:
> Add the "realtek,rtl9607-i2c" compatible for i2c controller on the
> RTL9607C SoC series.
> 
> Add a clocks property to the properties since RTL9607C requires it
> along with the realtek,scl.
> 
> Signed-off-by: Rustam Adilov <adilov@disroot.org>
> ---
>  .../bindings/i2c/realtek,rtl9301-i2c.yaml         | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml b/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
> index f9a449fee2b0..5873cfdc5b3e 100644
> --- a/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
> @@ -15,6 +15,8 @@ description:
>    assigned to either I2C controller.
>    RTL9310 SoCs have equal capabilities but support 12 common SDA lines which
>    can be assigned to either I2C controller.
> +  RTL9607C SoCs have equal capabilities but each controller only supports 1
> +  SCL/SDA line.
>  
>  properties:
>    compatible:
> @@ -34,6 +36,7 @@ properties:
>        - enum:
>            - realtek,rtl9301-i2c
>            - realtek,rtl9310-i2c
> +          - realtek,rtl9607-i2c
>  
>    reg:
>      items:
> @@ -51,6 +54,9 @@ properties:
>        The SCL line number of this I2C controller.
>      enum: [ 0, 1 ]
>  
> +  clocks:
> +    maxItems: 1
> +
>  patternProperties:
>    '^i2c@[0-9ab]$':
>      $ref: /schemas/i2c/i2c-controller.yaml
> @@ -81,6 +87,15 @@ allOf:
>      then:
>        patternProperties:
>          '^i2c@[89ab]$': false

Other devices do not have any clock input? Hard to believe, but if that
was the case then previous "if:then:" should disallow this. But if you
assume they have clock, which is expected, then document this in the
commit msg. Now you just silently add clock to each of existing variant
without any explanation WHY.

Best regards,
Krzysztof

