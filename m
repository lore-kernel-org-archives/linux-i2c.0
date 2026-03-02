Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13361D0DEE;
	Mon,  2 Mar 2026 07:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772436008; cv=none; b=Q811JMxmjLD0TKpGItuv6YNY6SIMpYGryZFixYswf6gW3ZgbSSEen4l3BYOhLSPZIF+eqRf8RmqIVRNRdzRVwSECXm6jk64RFuFJPP9LplfoHeUs4BIwLhKnVxSD4gzqAaeWXJXgWicxhXhYEtXXScliR1S7f6e/1ZB0CYlcL9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772436008; c=relaxed/simple;
	bh=aDIYRsp0TpIxZFNgF1g0ihmHMMwniaVYzKfwjHLo04A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bs4QOkCpm36ymxHfcnNqQvfSAVye7JsJdlU62NYQVjEtUoD9rRX+eTxjkr/yd0rntrYzmm2KzxpDccDbvVsA/Csf/aVgfcYQf/3Fj2gaow2+d7RoSrZXzR3g824yR+Y3zXeOajpiFEAaD1oGozMrdaq6Gk0HhrmrdksZgbOOyhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dv0emQky; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dv0emQky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FF9C19423;
	Mon,  2 Mar 2026 07:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772436008;
	bh=aDIYRsp0TpIxZFNgF1g0ihmHMMwniaVYzKfwjHLo04A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dv0emQkyq8MxQqIAz2FtULYOzXKF2eQpsX1pa0SVsqLkuvmb4/R3hu+9FkU6nJiwV
	 P6LPvlHLEXMvXXsyjscyFeIclok5Zm1NVxV7mp5wyWW09uEaIR4JNwThnCeAx1hPei
	 v5qMSWMzpcGvJMRWQZS1DiK8qQ0u5Y4iR1vcs3cvfZ6sdWGthDWKX3JR0QvKgZTq60
	 iis1QtBK/+HNLfFWrnECeZkGueMlUWHLCaRJ1sKIWea8gAs3RD90NMCpcscSW+3jW+
	 MzzrNdKbXKU/iVTSgqVJMPgKVf1CWqUW+0LqQi4PtzN0hnaUI2a7enLZfYLvTFcGL9
	 Jrw5ZTgoGNwfg==
Date: Mon, 2 Mar 2026 08:20:06 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Zi-Yu Chen <zychennvt@gmail.com>
Cc: andi.shyti@kernel.org, ychuang3@nuvoton.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: i2c: nuvoton,ma35d1-i2c: Add MA35D1 I2C
 controller
Message-ID: <20260302-agile-mighty-cassowary-ed972e@quoll>
References: <20260302020822.13936-1-zychennvt@gmail.com>
 <20260302020822.13936-2-zychennvt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260302020822.13936-2-zychennvt@gmail.com>

On Mon, Mar 02, 2026 at 02:08:20AM +0000, Zi-Yu Chen wrote:
> Add device tree binding documentation for the I2C controller
> found in the Nuvoton MA35D1 SoC.
> 
> Signed-off-by: Zi-Yu Chen <zychennvt@gmail.com>
> ---
>  .../bindings/i2c/nuvoton,ma35d1-i2c.yaml      | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/nuvoton,ma35d1-i2c.yaml
> 
> diff --git a/Documentation/devicetree/bindings/i2c/nuvoton,ma35d1-i2c.yaml b/Documentation/devicetree/bindings/i2c/nuvoton,ma35d1-i2c.yaml
> new file mode 100644
> index 000000000000..fa8b01e2c5b1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/nuvoton,ma35d1-i2c.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/nuvoton,ma35d1-i2c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton MA35D1 I2C Controller
> +
> +maintainers:
> +  - Zi-Yu Chen <zychennvt@gmail.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The Nuvoton MA35D1 I2C controller supports master mode and optional
> +  slave mode operation. The controller is configured via Device Tree

Use modern naming, not master/slave.

> +  and supports interrupt-driven I2C transfers.

Drop "The controller is configured via Device Tree", because it is
completely irrelevant. Why telling in DT binding that you use DT? Can
you use ACPI here?

And with dropping this it could be one simple sentence.

With these changes:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

