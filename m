Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795613120;
	b=HYnxfZW1wNhkgBRloRzgTlqT8YtTXjbUJH2WMOVpEi/uVQz5+N6js+kX76pFK7a4vMti
	 4X5nEz1TkCWLmP2JH0tB8tFYjEuZ7GABtW9KJ/MoJ35aJLpTTbZOvWbcVmvvRArVYQfrT
	 P5fd+mVqHeno0ctM9hnoRbwWMGfydpeqqKdZ4XC0hzm8oflaqS7qU3dnpUDZbSTMiOmgC
	 cv/Zi5OeiovIZkPyf8gnPZ3RR6UKQPWJbcpHj2gaUInHb+uXJKoK1ugnUWGlde0Z5NlZ9
	 /AkKevgM23AxnrETeI1aKRIyurGXfkthfYJcWMy0KQSjIazgoPjri7UjovnCWyVT4bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795613120;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=NQLOwLKmQWGXVjYzEC+v5DF5B/Ubjo80CMy8M7QDT2k=;
	b=2XDVuz7hQ9zljrE9TAUDOouykqTE2+k7eXPcoU3JmuBW9pMCDOczdPC60q5I5+Ize1wg
	 ogVkO9b5g2vwLI9ROPlWFMs1mGWPvQUzBvAqqyr/Q2aMH0uvMJMa4fnhspLf4Ruwv9ZH4
	 9itQMVRdxsV3WlxB/UezrRzeNO3CbAxULviClfsATRT0Ym9lDLdHwHy6V3qZ7HDYiPJyc
	 qCEdg5Rz4nKY+irmBv5v2GnyI61hSLo5k9/RswwKERvRnlsL4v5c+1GFHVyHj/LO/8uPc
	 kMtsK0vvy6ym7TNeVEccJomX+ZMDl4onN2NNcRBW//BCR/TjhadnrrWFdWpEADlir8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=n8vilfMw;
	arc=none smtp.remote-ip=209.85.208.171
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A53606A68E
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 13:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61A53606A68E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=n8vilfMw
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3adef2bf7acso4742721fa.1
        for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 05:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795613116; x=1796217916; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NQLOwLKmQWGXVjYzEC+v5DF5B/Ubjo80CMy8M7QDT2k=;
        b=n8vilfMw95U7RGGQTrQ18OiIGt4lPTBlaA0eJ+bgBAaZd3duyIsAIQt3bBnTX2AY9h
         x0BN648T4J359K6PAuYa3+NgtWG9EHGCut3jPu373XwMaFpFYdPV2sNsAwsnKCjAwnMC
         fZLZsQmHOeVePSzrfQ4Az99IGPip7gEseXI+oExdXmqSsFXjoVOCMUVu3zN+EUiJ3k7t
         0Ly4a70yYEiU0TPD31hTC0MbXvg0yZmGbLU4enOfgaO+c0wpQSz+33nibOR2MgehRzh9
         odoMW8R2Sry5YZZzbfoUlv/anMH74EVSx252be9Len7WudNnOjJq+wCLSOOoWYf3ZTIa
         Jsgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795613116; x=1796217916;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NQLOwLKmQWGXVjYzEC+v5DF5B/Ubjo80CMy8M7QDT2k=;
        b=NwvffdWkN1NkxNsYjur2AWCIaqFnf4fvOx5XFrCe6C/odrtvB55myWurphV4dt3tO3
         +nytIw6NMnW9hmUEVPlyoGua2bs+uo+o9WdPZ2JqW8wCCsa7N7SSsTqRe1dNPsD5Axea
         Ybxctfli1XdoM/fVV18WIgMnZH+FayiaGdjZ0uyfD32Toz1dTcwhq4YydTuR65CWbltg
         DggbpsCB0XZVfRIa/ypBMQjcKqFlbJ6YYEZtSeVJqTaC5jQaZtj9fA/x/TikWdH0D8ms
         PKH3ujmhnd7Dr3d/CksYXZnXeb9EOucviCTZ8twWe5zUXv5p3ELgfngnYu/gXTRNQTMM
         31RQ==
X-Forwarded-Encrypted: i=1; AL+hErHwD+c1KGeKqCEbfVRDrv6B6zC2YJOz+PAgFVCWoZdlwVFhVDSHQV60ofY5qqRwckohmPUfnNISTBA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+R+gROh86RGpwfvY9ZUkNs2DPN6ANgCg89UfrDaeKpfKOavEDc
	bMQYfQkqk4jNJAZRsemDbb8dYXTqhJpZqJm45BNRNYPtZakGgTfX0oecYdTpatKhuXM=
X-Gm-Gg: AZFdTZfKaCOErkkIpW279ai3IFW3UUOg53LvjGjmwv0v4fq4CT7umH0tnJEydiShj2O
	DbTw8h0pYjCNFOcgbfd2XC9J4pUl/FdecfzWTInQ5s5UKcmDsi8ZIxtb+N0/Gk6ZNFU30TQNE4H
	UqQwYKfYyykRFwKpMEVD1SglnyFma7NpL3NhO65sjCS9g6vzSIkq/OV1mhocBio3jYiemjzdK4Z
	llPeWMIfggWaZ9frx6AunH99+mVMEbEOIIGTEjNalRqEQx/Su6aAqN5J/pC4PTpSYgsSIZi6/Bx
	L3r2tEnpQrai/xEC3S5U6Dafhbt2s0qEsg4jRxzWHYpzkZpGV+R1ufVSjDNOQOxAXJX1B/gINrf
	9kMJaoHY2Gqzk70gW6gGY9oApOX3OYPPyU2kYIEH83F9aJVGx3enS5FvKW/MK/mgOfh3kbsWP0w
	QDcv3rJEoNA+UEGqz02uD/iwZDOWgJ8uQpjLBQz3F40cQddd/M4tXBnyk8Auzl1inZmNSjXn4fk
	yCiEhlVjM6T+3oIpWFl+nL4KGGaVfnywrngXHSzFx0SXH4e/fyrpu+CruteFHztoLY1gDXog8q4
	scFVQhdxj+LxxcUU+wFZ0aexA4ykbKJ+XDsUoXRmgX4r659GjTpvddbpy0FehAIhVLULgAdIt54
	K6cI2tZ8=
X-Received: by 2002:a05:651c:a110:20b0:3ac:e540:987a with SMTP id 38308e7fff4ca-3ae7f7ccbccmr42034731fa.0.1795613116510;
        Wed, 25 Nov 2026 05:25:16 -0800 (PST)
Received: from [192.168.1.101] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae8044e3c4sm47116791fa.4.2026.11.25.05.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 05:25:16 -0800 (PST)
Message-ID: <38bdcad3-2c2f-4e55-9a3e-17047b9f486f@linaro.org>
Date: Wed, 25 Nov 2026 15:25:15 +0200
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 23/23] arm64: dts: qcom: eliza-evk-imx577-camera: Add
 DT overlay
To: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>,
 Bryan O'Donoghue <bod@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Frank Li <Frank.Li@nxp.com>
Cc: linux-phy@lists.infradead.org, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20261114-add-support-for-camss-on-sm8750-v7-0-8ff2a11835f6@oss.qualcomm.com>
 <20261114-add-support-for-camss-on-sm8750-v7-23-8ff2a11835f6@oss.qualcomm.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20261114-add-support-for-camss-on-sm8750-v7-23-8ff2a11835f6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/14/26 13:29, Wenmeng Liu wrote:
> Add an overlay for optional IMX577 integration on the Eliza CQS EVK,
> shared by the eMMC and UFS variants. The sensor is on CCI0 I2C bus 0,
> uses MCLK0 with its reset on GPIO8 and connects to CSIPHY0 over CSI-2.
> The overlay enables CAMSS, CSIPHY0 and CCI0.
> 
> Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
> ---
>   arch/arm64/boot/dts/qcom/Makefile                  |  4 +
>   .../boot/dts/qcom/eliza-evk-imx577-camera.dtso     | 85 ++++++++++++++++++++++
>   2 files changed, 89 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 64d2cfdb89c89f1c6eb0085e2bf5877ff980dbc4..a9374c54dd514f53b7aa97f5581c99cb6e75697d 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -16,6 +16,10 @@ dtb-$(CONFIG_ARCH_QCOM)	+= apq8096sg-db820c.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= eliza-cqs-evk-emmc.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= eliza-cqs-evk-ufs.dtb
> +eliza-cqs-evk-emmc-imx577-camera-dtbs := eliza-cqs-evk-emmc.dtb eliza-evk-imx577-camera.dtbo
> +eliza-cqs-evk-ufs-imx577-camera-dtbs := eliza-cqs-evk-ufs.dtb eliza-evk-imx577-camera.dtbo
> +dtb-$(CONFIG_ARCH_QCOM)	+= eliza-cqs-evk-emmc-imx577-camera.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= eliza-cqs-evk-ufs-imx577-camera.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= eliza-mtp.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= glymur-asus-zenbook-a14-ux3407na.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= glymur-asus-zenbook-a16-ux3607oa.dtb
> diff --git a/arch/arm64/boot/dts/qcom/eliza-evk-imx577-camera.dtso b/arch/arm64/boot/dts/qcom/eliza-evk-imx577-camera.dtso
> new file mode 100644
> index 0000000000000000000000000000000000000000..08f2e3c62dbdaf23a2f6ca69a5c392054cb1c225
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/eliza-evk-imx577-camera.dtso
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/clock/qcom,eliza-cambistmclkcc.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/media/video-interfaces.h>
> +
> +&camss {
> +	status = "okay";
> +};
> +
> +&camss_csiphy0_in_port {
> +	camss_csiphy0_inep: endpoint {
> +		data-lanes = <1 2 3 4>;
> +		remote-endpoint = <&csiphy0_out_ep>;
> +	};
> +};
> +
> +&cci0 {
> +	status = "okay";
> +};
> +
> +&cci0_i2c0 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	camera@1a {
> +		compatible = "sony,imx577";
> +		reg = <0x1a>;
> +
> +		reset-gpios = <&tlmm 8 GPIO_ACTIVE_LOW>;
> +		pinctrl-0 = <&cam_mclk0_default &cam0_reset_default>;
> +		pinctrl-names = "default";
> +
> +		clocks = <&cambistmclkcc CAM_BIST_MCLK_CC_MCLK0_CLK>;
> +		assigned-clocks = <&cambistmclkcc CAM_BIST_MCLK_CC_MCLK0_CLK>;
> +		assigned-clock-rates = <24000000>;
> +
> +		dovdd-supply = <&vreg_l7b>;
> +
> +		port {
> +			imx577_out_ep: endpoint {
> +				data-lanes = <1 2 3 4>;
> +				link-frequencies = /bits/ 64 <600000000>;
> +				remote-endpoint = <&csiphy0_in_ep>;
> +			};
> +		};
> +	};
> +};
> +
> +&csiphy0 {
> +	vdda-0p9-supply = <&vreg_l2b>;
> +	vdda-1p2-supply = <&vreg_l4b>;
> +
> +	status = "okay";
> +};
> +
> +&csiphy0_in_port {
> +	csiphy0_in_ep: endpoint {
> +		bus-type = <MEDIA_BUS_TYPE_CSI2_DPHY>;
> +		clock-lanes = <0>;

Here 'clock-lanes' should be dropped, it shall be implied, and I belive
it is.

> +		data-lanes = <1 2 3 4>;
> +		remote-endpoint = <&imx577_out_ep>;
> +	};
> +};
> +
> +&csiphy0_out_port {
> +	csiphy0_out_ep: endpoint {
> +		remote-endpoint = <&camss_csiphy0_inep>;
> +	};
> +};
> +
> +&tlmm {
> +	cam0_reset_default: cam0-reset-default-state {
> +		pins = "gpio8";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +};
> 

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

-- 
Best wishes,
Vladimir
