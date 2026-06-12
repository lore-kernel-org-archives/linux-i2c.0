Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C673749F4
	for <linux-i2c@vger.kernel.org>; Fri, 12 Jun 2026 08:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781251923; cv=none; b=pSHLASxwgdB+9RukoDpu7abB+d+TeGytOVrerCi/1cXnqEww044YxAA/HLrrc9IUI0EhzW8myUkRzroBdXojQDw9N88bI9DvXR8Ch2tXJYiT7Yv3D8H3o55KEp09IVf7gD8UzAlXsKi/W7ADPIjWs2Wz5XBk77IKalBbQG9fFgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781251923; c=relaxed/simple;
	bh=w/KMCvTAaLSnkJCY40Gg7KHEFZvGewFVkWrfXQdQo0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+zdp4PhWDh9nq3OsLL8R4Zj9V1lZKITfERq6qMK4vnzMUk5OqRUDDclxaQwahXia0IKkp4fkG7apc443G3huhiiynm7zmAOLASXDq3ppTYEtYrpzhaFNWT9kAgKeT+WhSAa1UtNggNuNzoFJYipJDIFXJcwHROU84vWOpQfc1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Poip8q+F; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Poip8q+F"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aa6091635aso96632e87.1
        for <linux-i2c@vger.kernel.org>; Fri, 12 Jun 2026 01:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781251918; x=1781856718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrRgMzUk2Tnqgkc/wKcgEOgJeLLj9KV+tTDn5EhNFR8=;
        b=Poip8q+F82ckFzVo4AomKTGiFGAL3Z6jV0RrXwe/uzdrEIh2x7AXdzqenay0iuT+Iy
         z5E/Vb0YAuZkpn2QxRWVfCJLgflSlWck9dtY/SLck59166D75HWVGDxIIeMZBI47bKhb
         Q8W/xGZE2OvLJzbt+35LObA5tx9vOSzDBKVbtb5A/RBIjaWDxaEcO/0DcII9hrcNo3JA
         /4ByqYZq8TrGaXp5wV94CC6SiMy5KSVCNM4hBSdYRjwG72wW40izLbIrkYpj3iuHpdYm
         YBOwq1B/Ew/APWxREvh93loWftMHjcO1tOkIl8nHif8ecI8ijTysQcw2LOY64DvqcQt8
         AJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781251918; x=1781856718;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MrRgMzUk2Tnqgkc/wKcgEOgJeLLj9KV+tTDn5EhNFR8=;
        b=LTI99RXm9FP3v2QifFfXNOJH3pyGr1aGKIJ0iWvaFRBtyjq2eCQD/1O4bIUDVocMQp
         qyLskMFtsqUrguChHoP7RwJnXiAucQeCf9dadQ9oZVOEZcZb5S+gRLrIlqtVsWtB8LXW
         mJgo+OjJQBSdOm+naJzadKRE9vriy8hdE5Zj8GUtST3SHsSQZvVWxfJXcTbIQl5YhV/y
         BDV6lbSnuBBKv65YzGV4N90Aj1C0+ZddsBXXkfbM1Ll6lacFjcQvsx6oaalrCMkcr3h0
         cEmdsJOSUwQAhIwqKfHIGhtYxgK0mXDBs7Mb72np0wwgTs3+kbSMN53mmMqbolwSaJyX
         OPRg==
X-Forwarded-Encrypted: i=1; AFNElJ9gdjPWd0vnJaRPaIQuSf044JtaG7bUSn03uSDCVMP0Q0MZxy3G8UXxWrIZTUazWpPv2g/GA5/dQWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBvLeife1WeSQOKb+Y3ggB4xxYeqDX2Lj0lW5ytSa6yZfXGLmm
	NgoJXQdqUxSOdLlULIZQS7DiAFOlkw5p9wA+4ZWg85ago5UGABIcLS02s+DB7rZwOgo=
X-Gm-Gg: Acq92OFuRzTaj8mxvKv85EvC6f0SppYDiQHslnAZvetgeeccJCPHZ3mwVMnmXaIFfPE
	OTk1QhH0t6iCSoTdddwLqVti7Kkt75j8WCOrzJznBATiopCP73Q5OuNSi59rVxO3saLvUC3jRRy
	8Zq3SBRS5c4rh20lnEIQVrzW8VSUqmob1VVEtX8xpD0CDfm16hFU/Sfa1VkLy/b5ay3GiEpxNIW
	KvbGq/Th4PiqheT5Ngkg0qt9cLYwoj3vvMnEd6b29d4bNY1YySVhfNRZNwtzDMtvmEa2c1Yq2Td
	y5q3umXtF1z/vrAHQx1o+pj75LHoRM4D1lEo5dg/63FBry/dChISJjghbEalpMuP2hlbRtGnEe8
	FnfxkHyqd1ghlMB+2vaeNkvryozSdmo9qptnbi3a+1xOv9+GcK7/gJpXXJR4njc67cMIWSMp+Xp
	rI7DYBvRIiqYT2H09Jq+LSRN4B0BwkIn+ZTEDg/+Z7G75qdpFvYgr0PFaznTqJjqXuwzSEKvn5f
	oH0mw==
X-Received: by 2002:ac2:5f19:0:b0:5aa:6ba5:9a58 with SMTP id 2adb3069b0e04-5ad2db30090mr185209e87.1.1781251917979;
        Fri, 12 Jun 2026 01:11:57 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1bb12csm324070e87.84.2026.06.12.01.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 01:11:57 -0700 (PDT)
Message-ID: <6ec25a28-9d0f-4c87-a4e1-85d8e410eaba@linaro.org>
Date: Fri, 12 Jun 2026 11:11:56 +0300
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] arm64: dts: qcom: shikra-iqs-evk-imx577-camera:
 Add DT overlay
To: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
 Bryan O'Donoghue <bod@kernel.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-i2c@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 Suresh Vankadara <quic_svankada@quicinc.com>,
 Vikram Sharma <vikram.sharma@oss.qualcomm.com>
References: <20260608-shikra-camss-review-v2-0-ca1936bf1219@oss.qualcomm.com>
 <20260608-shikra-camss-review-v2-7-ca1936bf1219@oss.qualcomm.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20260608-shikra-camss-review-v2-7-ca1936bf1219@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/8/26 17:06, Nihal Kumar Gupta wrote:
> Shikra IQS is an industrial-grade variant using PM8150 PMIC, requiring
> different CSIPHY and sensor supply rails compared to the retail boards
> (CQM and CQS) which use PM4125.
> 
> Add a dedicated overlay for optional IMX577 integration via CSIPHY1.
> 
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> ---
>   arch/arm64/boot/dts/qcom/Makefile                  |  2 +
>   .../dts/qcom/shikra-iqs-evk-imx577-camera.dtso     | 70 ++++++++++++++++++++++
>   arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts        |  9 +++
>   3 files changed, 81 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 76b8f144983827f4905a72935e8d5291a227dc97..09f2318d1c12c4239a6a7bac4ecbca38eb65ffa2 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -340,9 +340,11 @@ dtb-$(CONFIG_ARCH_QCOM)	+= shikra-iqs-evk.dtb
>   
>   shikra-cqm-evk-imx577-camera-dtbs	:= shikra-cqm-evk.dtb shikra-cqm-cqs-evk-imx577-camera.dtbo
>   shikra-cqs-evk-imx577-camera-dtbs	:= shikra-cqs-evk.dtb shikra-cqm-cqs-evk-imx577-camera.dtbo
> +shikra-iqs-evk-imx577-camera-dtbs	:= shikra-iqs-evk.dtb shikra-iqs-evk-imx577-camera.dtbo
>   
>   dtb-$(CONFIG_ARCH_QCOM)	+= shikra-cqm-evk-imx577-camera.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= shikra-cqs-evk-imx577-camera.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= shikra-iqs-evk-imx577-camera.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sm4450-qrd.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sm6115-fxtec-pro1x.dtb
> diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk-imx577-camera.dtso b/arch/arm64/boot/dts/qcom/shikra-iqs-evk-imx577-camera.dtso
> new file mode 100644
> index 0000000000000000000000000000000000000000..340d6303adc6e1bea55f1bd0598175f0cb269737
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk-imx577-camera.dtso
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/clock/qcom,shikra-gcc.h>
> +#include <dt-bindings/gpio/gpio.h>
> +
> +&camss {
> +	vdd-csiphy-1p2-supply = <&pm8150_l11>;
> +	vdd-csiphy-1p8-supply = <&pm8150_l12>;
> +
> +	status = "okay";
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port@1 {
> +			reg = <1>;
> +
> +			csiphy1_ep: endpoint {
> +				data-lanes = <0 1 2 3>;
> +				remote-endpoint = <&imx577_ep1>;
> +			};
> +		};
> +	};
> +};
> +
> +&cci {
> +	status = "okay";
> +};
> +
> +&cci_i2c1 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	camera@1a {
> +		compatible = "sony,imx577";
> +		reg = <0x1a>;
> +
> +		reset-gpios = <&tlmm 33 GPIO_ACTIVE_LOW>;
> +		pinctrl-0 = <&cam_mclk1_default &cam1_reset_default>;
> +		pinctrl-names = "default";
> +
> +		clocks = <&gcc GCC_CAMSS_MCLK1_CLK>;
> +		assigned-clocks = <&gcc GCC_CAMSS_MCLK1_CLK>;
> +		assigned-clock-rates = <24000000>;
> +
> +		/*
> +		 * avdd and dvdd are supplied by on-board regulators on the
> +		 * IMX577 module from the connector's 3.3 V rail; they are
> +		 * not SoC-controlled. dovdd (1.8 V) powers the carrier board
> +		 * level-shifter that translates CCI I2C and reset lines
> +		 * between the SoC and the connector.
> +		 */
> +		dovdd-supply = <&pm8150_l15>;
> +
> +		port {
> +			imx577_ep1: endpoint {
> +				link-frequencies = /bits/ 64 <600000000>;
> +				data-lanes = <0 1 2 3>;

Same as before, the numeration of data lanes starts from 1.

> +				remote-endpoint = <&csiphy1_ep>;
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
> index 3003a47bd7594206f0ac54957e0af509fa365f54..811fd5da4af7babd412d70fee84434849846dc2f 100644
> --- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
> @@ -38,3 +38,12 @@ &sdhc_1 {
>   
>   	status = "okay";
>   };
> +
> +&tlmm {
> +	cam1_reset_default: cam1-reset-default-state {
> +		pins = "gpio33";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +};
> 

This part goes directly to the mezzanine .dtso file.

After fixing it,

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

-- 
Best wishes,
Vladimir
