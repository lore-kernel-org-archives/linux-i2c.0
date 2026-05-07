Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0482478E5F;
	Thu,  7 May 2026 19:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778182165; cv=none; b=VMTsgrooBfYNZDdoaEhC1gy8967AOJJ/zIyGi9VgbVxbu0iie3Bu+aF7ah+0sIYZEpduBK2oOp5Vji3e4zo8CZRLlwsT1IioanyoOynaMSGPGRVAYtsDEA/igxa3ZO6wDuzB6EFX2gaX2MHRK8RqEDrVkLt9oUBrSKrvprPc49k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778182165; c=relaxed/simple;
	bh=t92rjFQschU+1mCZJqpZKRsKz21B+aWL+bBKtix8Z2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geGLnGZ0U4hEYjamcs7OpV29be3ylV+HZc4LP1aG0cOYm2Hwi4sjyVc4vlW0CeqcMBa3smfBb7kilIBodf8+Cs9CgiYmejLdfL8AQtgPJ9ZzTUDNWeUu2t4Dcd2vMjlwu0YEvwSx0Hr2hrEqbl4mgkl3YFXDUuS9vVSmo6SgEIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMkxevdp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMkxevdp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283FEC2BCB8;
	Thu,  7 May 2026 19:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778182165;
	bh=t92rjFQschU+1mCZJqpZKRsKz21B+aWL+bBKtix8Z2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iMkxevdpkOz1lm1EZHfKKqvUK4nUzD2n96cS7l+ikYW1cNPo8kpe+anFKiSAaBUci
	 pNqF3jVlWblTrMLRjSEsZqu1vroSCpEiTGXKY9rF2gELNOqxGXzzPe11RCc1BlnRqi
	 O/DaMddzE9BRCj41kSWXlgU7ki7HRP4TGwL743ODiF3mQfR8V/ClKQTMmECqlKhGbR
	 Q4aLxgA19n82xVHHL8OP7QcIuGlBtJaXPSZ+7/cNdxSEXmThaeKXKxXON45ZYiQLOJ
	 veIkbSioeYIjqhVQVYc9ILJStprohvEh3s6Fys33uPehzNPJhFRWS9UffnCW16a+/4
	 I6LI5MnXSl9aQ==
Date: Thu, 7 May 2026 14:29:23 -0500
From: Rob Herring <robh@kernel.org>
To: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
Cc: andi.shyti@kernel.org, wsa@kernel.org, anders.berg@lsi.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: convert axxia i2c to dt-schema
Message-ID: <20260507192923.GA2429305-robh@kernel.org>
References: <20260505100854.5258-1-chaitanya.msabnis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505100854.5258-1-chaitanya.msabnis@gmail.com>

On Tue, May 05, 2026 at 03:38:54PM +0530, Chaitanya Sabnis wrote:
> Convert the LSI Axxia I2C Controller bindings from legacy text
> format to modern dt-schema (YAML).
> 
> During the conversion, the obsolete `device_type = "i2c"` property
> was dropped from the example, as it is deprecated and not utilized
> by the driver. The `clock-names` property is enforced as required
> matching the driver probe behavior. The example node address was
> also updated to a standard 32-bit address.
> 
> Signed-off-by: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
> ---
>  .../devicetree/bindings/i2c/i2c-axxia.txt     | 30 -----------
>  .../devicetree/bindings/i2c/lsi,api2c.yaml    | 52 +++++++++++++++++++
>  2 files changed, 52 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-axxia.txt
>  create mode 100644 Documentation/devicetree/bindings/i2c/lsi,api2c.yaml
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-axxia.txt b/Documentation/devicetree/bindings/i2c/i2c-axxia.txt
> deleted file mode 100644
> index 7d53a2b79553..000000000000
> --- a/Documentation/devicetree/bindings/i2c/i2c-axxia.txt
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -LSI Axxia I2C
> -
> -Required properties :
> -- compatible : Must be "lsi,api2c"
> -- reg : Offset and length of the register set for the device
> -- interrupts : the interrupt specifier
> -- #address-cells : Must be <1>;
> -- #size-cells : Must be <0>;
> -- clock-names : Must contain "i2c".
> -- clocks: Must contain an entry for each name in clock-names. See the common
> -  clock bindings.
> -
> -Optional properties :
> -- clock-frequency : Desired I2C bus clock frequency in Hz. If not specified,
> -  the default 100 kHz frequency will be used. As only Normal and Fast modes
> -  are supported, possible values are 100000 and 400000.
> -
> -Example :
> -
> -i2c@2010084000 {
> -	compatible = "lsi,api2c";
> -	device_type = "i2c";
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -	reg = <0x20 0x10084000 0x00 0x1000>;
> -	interrupts = <0 19 4>;
> -	clocks = <&clk_per>;
> -	clock-names = "i2c";
> -	clock-frequency = <400000>;
> -};
> diff --git a/Documentation/devicetree/bindings/i2c/lsi,api2c.yaml b/Documentation/devicetree/bindings/i2c/lsi,api2c.yaml
> new file mode 100644
> index 000000000000..2d1c3069c3a3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/lsi,api2c.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/lsi,api2c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LSI Axxia I2C Controller
> +
> +maintainers:
> +  - Anders Berg <anders.berg@lsi.com>

I don't think lsi.com is valid any more. We'll see if it bounces. 
Otherwise,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
