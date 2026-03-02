Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC372430BAC;
	Mon,  2 Mar 2026 07:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772436317; cv=none; b=XzTIH1Q+bHHH4C7FxiqOVcv1gHzJklCAnyGg+Jc5h9+/aslMvmjx/SEsY/GY8wHrUzWruJMGLsUOacTVommebMnmbt838WnLztUKOzukO7287q8kTSSkekJ//uM4kfxuBk03NaUS4oXQGZ0+CXHWtVJQVQ5WhilciKWdCXhGbOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772436317; c=relaxed/simple;
	bh=7gVoKDdC5aVPTpZDUql6knM+f5JpIj34CLV1tjGpOxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsYfMf76aprb/fxlNzS27IdE6R0t2cA+MUFI+fGR0azzmdH1xoH+ejAuhK7lWvzhDfOpMtCasuUooHMZvoR80w30LsNgeaeUjpG1Bx3DZqxWA09Jcaw81L4aGeOJy9UmyYuLRre0IbWAtbeWi2APiZjvhvdUm9C7BZZY8EXhjS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKhkESAV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKhkESAV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B29C19423;
	Mon,  2 Mar 2026 07:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772436317;
	bh=7gVoKDdC5aVPTpZDUql6knM+f5JpIj34CLV1tjGpOxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CKhkESAVIg3bAHWkpKjB9O3rV9eK766cVLOVveUzBuBVA7dfZNKt0z9AFBxGbjwyH
	 YGxJw2U1FI40PLjSl9UdWh/HNYpH9D7zjoysyXjc8Va/zklHypgcWwro6xYZaoXz3Y
	 FfpyNsrbWTCcKabkXLleXMJV3qkwtTdXxGVYqsKLTnAp4MuiRQSPO/7+J9nmj7FUOq
	 1VDOJmHl68M1+j5XV2o32rBv9bZGhaIu38c6MGGVQ2PZgXCMa5GOv9wfAeywoHzIPJ
	 jhv5bhjVIICI/bQAeSVSakv7GlKELOxDtWgAqxMxYqek4LJJwnYKxS5rJ5pNIJLppH
	 nrRiN/Ci7se9A==
Date: Mon, 2 Mar 2026 08:25:15 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Zi-Yu Chen <zychennvt@gmail.com>
Cc: andi.shyti@kernel.org, ychuang3@nuvoton.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] arm64: dts: nuvoton: Add I2C nodes for MA35D1 SoC
Message-ID: <20260302-amiable-rugged-mastiff-ccded3@quoll>
References: <20260302020822.13936-1-zychennvt@gmail.com>
 <20260302020822.13936-4-zychennvt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260302020822.13936-4-zychennvt@gmail.com>

On Mon, Mar 02, 2026 at 02:08:22AM +0000, Zi-Yu Chen wrote:
> Add I2C controller nodes to the MA35D1 SoC dtsi.
> Also enable the I2C interfaces on the MA35D1 SOM board
> to allow communication with onboard peripherals.
> 
> Signed-off-by: Zi-Yu Chen <zychennvt@gmail.com>
> ---
>  .../boot/dts/nuvoton/ma35d1-som-256m.dts      | 14 ++++
>  arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 65 +++++++++++++++++++
>  2 files changed, 79 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
> index f6f20a17e501..2a8f0fd90ded 100644
> --- a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
> +++ b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
> @@ -98,6 +98,14 @@ pinctrl_uart16: uart16-pins {
>  			power-source = <1>;
>  		};
>  	};

Missing blank line

> +	i2c-grp {
> +		pinctrl_i2c1: i2c1-pins {
> +			nuvoton,pins = <1 10 12>,
> +				       <1 11 12>;
> +			bias-disable;
> +		};
> +
> +	};
>  };
>  
>  &uart0 {
> @@ -129,3 +137,9 @@ &uart16 {
>  	pinctrl-0 = <&pinctrl_uart16>;
>  	status = "okay";
>  };
> +
> +&i2c1 {

Why 'i' is after 'u'? Please read DTS coding style.

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
> index e51b98f5bdce..36bd19e37b57 100644
> --- a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
> +++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
> @@ -17,6 +17,10 @@ / {
>  	#address-cells = <2>;
>  	#size-cells = <2>;
>  
> +	aliases {
> +		i2c0 = &i2c2;

Not a property of DTSI, but DTS.

> +	};
> +
>  	cpus {
>  		#address-cells = <2>;
>  		#size-cells = <0>;
> @@ -372,6 +376,66 @@ uart15: serial@407f0000 {
>  			status = "disabled";
>  		};
>  
> +		i2c1: i2c@40810000 {
> +			compatible = "nuvoton,ma35d1-i2c";
> +			reg = <0x0 0x40810000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk I2C1_GATE>;
> +			clock-frequency = <100000>;
> +			resets = <&sys MA35D1_RESET_I2C1>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c2: i2c@40820000 {
> +			compatible = "nuvoton,ma35d1-i2c";
> +			reg = <0x0 0x40820000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk I2C2_GATE>;
> +			clock-frequency = <100000>;
> +			resets = <&sys MA35D1_RESET_I2C2>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c3: i2c@40830000 {
> +			compatible = "nuvoton,ma35d1-i2c";
> +			reg = <0x0 0x40830000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk I2C3_GATE>;
> +			clock-frequency = <100000>;
> +			resets = <&sys MA35D1_RESET_I2C3>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c4: i2c@40840000 {
> +			compatible = "nuvoton,ma35d1-i2c";
> +			reg = <0x0 0x40840000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk I2C4_GATE>;
> +			clock-frequency = <100000>;
> +			resets = <&sys MA35D1_RESET_I2C4>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c5: i2c@40850000 {
> +			compatible = "nuvoton,ma35d1-i2c";
> +			reg = <0x0 0x40850000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk I2C5_GATE>;
> +			clock-frequency = <100000>;
> +			resets = <&sys MA35D1_RESET_I2C5>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
>  		uart16: serial@40880000 {
>  			compatible = "nuvoton,ma35d1-uart";
>  			reg = <0x0 0x40880000 0x0 0x100>;
> @@ -379,5 +443,6 @@ uart16: serial@40880000 {
>  			clocks = <&clk UART16_GATE>;
>  			status = "disabled";
>  		};
> +

Why? Do not introduce random changes.

Best regards,
Krzysztof

