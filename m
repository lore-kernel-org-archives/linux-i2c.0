Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5A33EF0C9
	for <linux-i2c@vger.kernel.org>; Tue,  9 Jun 2026 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995357; cv=none; b=PNsegnLLLP3bQldgE4Imk9voui5n8D7oIP6N5VanORnTM6tNBx9Fsn2V+raWhTlIPrEkwQ+ldSsgC1MjS5yPe1+8ZAAX3RCnehklt2rAtf7sNSUqvs7xSc8pyWOmKvScOOW4XLfSTChytaxG5sfqmGfeD+dtub28WSCtDUULyck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995357; c=relaxed/simple;
	bh=WEUJDi01qfK1lYTO7fit5r3i6qyzMDV+kRJKNjn0A1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=keuPZPP1PgYFysfc6y8Y+oVpKfPirhFoe32hRmqusulk1c2ZfJPXu3p5E+08tbk8pDnKiQlRDY/neBwnhn9Y6aDnyCDUPdgyDe3tZg+I5nJ9r9iJuK3Ag01aJSuppUmcL+bJPEx6IYDaohMbmpFDClUJLselsvmqUcaJ7ahyv0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EAXPPhpf; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EAXPPhpf"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bec405a6ea5so756289166b.0
        for <linux-i2c@vger.kernel.org>; Tue, 09 Jun 2026 01:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780995353; x=1781600153; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fGHDi/EgG5Cp56Yn719wGUCuyzVWJDzp1Ho86cPqGa4=;
        b=EAXPPhpfT/uPQhu7ER+9ec6FCgY6ydkKiDK+PlVdQO/nC77X0lp/KoAiDA6joJWrmW
         tHwM0+HBiP17QHQ5+nmFyCQacpEZBVzVT7k8HWud+nHssLbidQNSBeddFi8pdpUr5cxy
         Gm7Ci2IXLevLVGn53/fol3BLTu+6ViR8oP5UkUlSmZe2Yc29/jplwbwL9sDBpVLcfHqF
         GinmR4Pt56229uWrYjgKtux7Hm4QGOaXtj/P7IO9PsFWqh3L879PKdjNA4Rvq+bOHiUA
         03VfmlPfdDATMZL3dz3RsbYdqCvnqLbEdlYwPGuTu6++eIgNIptoHEYNPfY/BUhINcCh
         PFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780995353; x=1781600153;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fGHDi/EgG5Cp56Yn719wGUCuyzVWJDzp1Ho86cPqGa4=;
        b=bFUvOlXrGVYqroUKZgaZXoObr7+CXgopsMkaqk/P3uJI2ODnn+13gFEL01R2zgh4fV
         rEQidFzxcDeYtqZjV/CbuWOEK/AZ7YAQ1x3qQk9GWOHnRsYhIFQevejEMxfzB/d7VIzF
         ScvGTjM7/0QmYKP68U/GrA9u+SySV3xMdhSmcyEbEo1UTpQgeFUtvsGF6nIdCTQ2I1hB
         knGg7TBlkNNKZVzh/LrKnoSF6S+hJI4xmE95tUk/6QwiUfa7+2VMVHJ7Rm+aoitiseL+
         B/3+3gmHyGCPlo5/OOzYyr7yfhGvaERiwtwEGsMQk01ezvVLS0NfMxmo3pttkNrMZ8FH
         02dg==
X-Forwarded-Encrypted: i=1; AFNElJ+tvB844EEPbgwDDqnTm7qkFpYTXLmi2+UeRzi80lGNjbjXY0X9gZaO/3jnjCMSgNBAGZVSqqf2V2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhbNsxPNhlFQy2qjUvtQ4w8hdxXZ2RlJWVl7TnX+vtDgNkFzQJ
	5pTM0tKas0QIZUE3KmbUx3oCxnfSN8vVEL6+ORAsmCHd1mkwdtUyxhL/TI4F18BXlWs=
X-Gm-Gg: Acq92OHSqV9X6l7GzzaWrXZJTGCfqUBQHCzCYRlje3qmYO44CtvgV1M62m1tt3c6vnD
	cC7Ok6SMdGeetemSyWPNn48Lvifg6MqZa1yZHMlRoB6g6EGQVrvrFOurckDBXgKY56xVkKYOivD
	Fqgcp/ValsCsYDtXrtFRK8M+jMiI563myr0hdLoI6w9xox7LjvbC6c+OI7hPqUNfGfl0pCFeSn4
	n4wILmQcmVJGwoNrmbNABE6B7yYBS6K7Q8hyHZJD56l7R0979NDFxDiQKSBzENMXW78GHytuW1k
	VQmyRxXHiW2+Ys+jNbelIevmqnfPXFxpX5w/5vfl+yVuY6t1HuPLjppzUsB0WV59pUsC5NCKOQU
	7h3WzdLL1q02u7TafEfDxzUow18d5xsWvQQgSdRKlr0GcOTA7Btb2sy+a29TtULHj3mWwE9Pgch
	19++PZKoYqIm8sFoUf41LodwQevBnhcMHDEPmViMHjXwWwwm0nQT06oB8=
X-Received: by 2002:a17:907:da9:b0:bed:8f7e:d84b with SMTP id a640c23a62f3a-bf373902d8bmr939406866b.43.1780995352597;
        Tue, 09 Jun 2026 01:55:52 -0700 (PDT)
Received: from [192.168.0.167] ([109.77.72.26])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0517714c5sm1012233266b.2.2026.06.09.01.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 01:55:52 -0700 (PDT)
Message-ID: <20ea3aef-99af-4185-88c4-0b0d96c865f0@linaro.org>
Date: Tue, 9 Jun 2026 09:55:50 +0100
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
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
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
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20260608-shikra-camss-review-v2-7-ca1936bf1219@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/06/2026 15:06, Nihal Kumar Gupta wrote:
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


Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

---
bod
