Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795612892;
	b=no9EPiCEK+nOrbJ1XllzWfxtMB8UwTa1DVvYt2VIkT010ZgWU5ZGcPQpAg1P/CQiJZIj
	 1r/ziPeL3QtEufXMWnq12+Na/avfIBYSqpYa6caFwl2VLHbHDVWbbFUSL3wCc8ICmTguO
	 c58yjPRNY5V5QNbsdj7izPMfqdd1X0c1hSx6UCwtt0Ybb2cvUdc0D58cMDGRnBpTH+Zz5
	 4IUbHDEWqeJEUERvPGBFSkQguckd0Yo14/lNXvfguDZ/4LNFj5ZZ/izX3Uok8oLUxtmnp
	 jQvcPHmauUz8xZr5pCUnZm037W/xCzQBXDpgYdEfmjnAINnjPaMDB3IUyK63MGyAIrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612892;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=bZO8S47yAZzPRZIjGfd7EOC+0a47KkXc3My8VRvZEho=;
	b=1UDDRTgb2pV/3y9nWWgBbwyJN9liELjY8DSbPDEv1lak3rUy/zXeFua+PJe3ibVpzzUz
	 MAHUTxBBgvRyXS7ebV3ATReQxAN+70XOXP1Cdf33c3jQ1lkO7Wl1a7uvt6RaBWA9JnpjL
	 wfm1+URBWx9Cj7S7sgl5TgQtwTMmW/IkpP17KQn5dK38R9BH7bjApJaJyWdu4kbQ+70j3
	 UnW7DETviRLvRxsrN4kaPxkeNUOznwCKyxTdxYzS0l5YElrtp5zEeuGfdGvwQMGLskSWs
	 /ypjJ2Vfntdir+K/7A3SProtDXZttD4a0oiVxok7Hl6grz7b/GZH17lFz5r1KHr0Tkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QVp6mueg;
	arc=none smtp.remote-ip=209.85.208.178
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650BE606A327
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 13:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 650BE606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QVp6mueg
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3ad3ef75223so3854831fa.1
        for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 05:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795612889; x=1796217689; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bZO8S47yAZzPRZIjGfd7EOC+0a47KkXc3My8VRvZEho=;
        b=QVp6muegU5Z6It5m9kYa3Srv4/OZjR98s3uEzmj17g4dG+5YeQ2V/jvzYt7ybUimHl
         diaFpnHrB/Tr2sVTUON782bU6HLeiVyg3zxH3CGn78hp7vQSzl/JVSB715MCEfNLGfGP
         SLOFssV5STRwm3FmAYX4GkFbKWGkG8wEOhbWSq0HmnByA+DTYLgwE+3wdIGQCA3/GBvh
         h1TljZ/Ue7hx6ZWc9frUBXHyPQuEdZtIBuWTduUkRvfF3zTJMd/WCXbBqkFTsHwcnAyV
         6SxiDJrbdz5PwuucLh+6q7M361R8DlTuKSxqhwn3Bzlryhm2rjhltIsdBHKteTfbLz7+
         S1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795612889; x=1796217689;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bZO8S47yAZzPRZIjGfd7EOC+0a47KkXc3My8VRvZEho=;
        b=b64ghB9QfArvUbyGKJduH3p9gBm71uNctbCh+gdWCxbUNRiu+WKQHI29GZ2cQBY9OM
         JIAsStHVWcTVxzuBwBZ/XgOTYbVg3xgkLQC73Objg5onc/iS/kL15Jj0QVlz8VzuZCc2
         nJVvb3nSC/T0Adz1dcM+TXchgoaUTSGfkGaO4WB4su2iOwwSNlvQGqRABXN3iBhwNaHR
         MOkz5aZF5MIrfFyxP6W3S/EOoV2kbXC6TaIXrs9y058uaIWT+YZiXnrtvbwFaDf02Vmz
         5RrZViDS/o0zEneiIB5u7G+xHLbVCaSQaL1EWy54V6u1VeKkvFOExwOzduPeGZacKi1Q
         1Scw==
X-Forwarded-Encrypted: i=1; AL+hErGuVprii2TshGjZ9yosvbEj0VgofH0kPX/3zK4h1NmcN6yB6CtPyTqwOjUrlgnn6xzMwl35bY4WwEc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9U382OG2hCEfSSkbfuFO6UUh9M7jf5MCImUMVhKaJdFev1nhD8
	b1lnWO4fCRRxTYO3p1DfIAq4rb4RuHdG+ZoGC7nFBCs+mYfeVlzRKyod0Z2+kGKHW6w=
X-Gm-Gg: AZFdTZcWkXdVG9AL9tcdmf0b2QLYQGOGKA2rt4riZdwinDDSgc6AEXGSe9qfh+BGphS
	I9h4QKHNrWu8RYPwTTL503kJFvUWzuPtzp6+qTp2cOjXAmUeZNYXGq8WlRr1tYLx5I0wMWkWLBl
	UHpnI8p6ER/ppvrvEULRwPoFmOjO2xTT2rVpyN/MhXnXyTaS36PtVVDNXgv3aW600nuloSJM7aW
	KqLUe2Etdhxwh4mmnDNbrWwDUI39jSN2Ujsf0TTHLll1XHmNSFsx6chE7sJns0pfsG/bLllNZvj
	SBJLfkmtpS3W36LovZmQnDuA+KrBdpFZ0Ed9S8OTssJQ9TszwrT/YqgMwRwGubI29wDIP5n6N8R
	BFzWXSimdG0icflU3wu/ZWbYG2+kjk14K56LmQN+wQbHiBkC/0fsvtPRHXyofBDXY6lLWGuIV1G
	pMoFGh1SEumO+SX+gPpWi+2XVeRjqLYnhkCmkdZ4Y6TJjH/z2T3EZpuDXxlTlNWd7E/CLMRpgDl
	1+6A/5RBog16rckTfLrWVQvXhCHyLm3RcKWoMDulnGg93s4jrZcjaW8XYouDkVY4J/VXeYRFLNG
	ctwnQWnk1p52F0nFCKcbsx8kTlQaEpO/pXjmjqPgONvW6FSLDfDsD4rcDhjpbQFVob/fBkaqWay
	kABbxiv4=
X-Received: by 2002:a05:6512:4481:b0:5c0:ca1:46d3 with SMTP id 2adb3069b0e04-5c1bc7c5ee5mr4971577e87.5.1795612889486;
        Wed, 25 Nov 2026 05:21:29 -0800 (PST)
Received: from [192.168.1.101] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bcff8bd3sm4567229e87.27.2026.11.25.05.21.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 05:21:29 -0800 (PST)
Message-ID: <8dc492bc-2727-4448-855f-caf13d4b2bd6@linaro.org>
Date: Wed, 25 Nov 2026 15:21:28 +0200
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
Subject: Re: [PATCH v7 22/23] arm64: dts: qcom: eliza-mtp: Enable rear camera
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
 <20261114-add-support-for-camss-on-sm8750-v7-22-8ff2a11835f6@oss.qualcomm.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20261114-add-support-for-camss-on-sm8750-v7-22-8ff2a11835f6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/14/26 13:29, Wenmeng Liu wrote:
> Enable the rear camera on the Eliza MTP: a Samsung S5KJN1 on CCI1 I2C
> bus 0, connected to CSIPHY2 over four data lanes. The sensor takes MCLK2
> at 24 MHz, is powered from the PM8010 regulators added in the previous
> patch and is reset through GPIO125.
> 
> Also enable CAMSS, CSIPHY2 and CCI1.
> 
> Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
> ---
>   arch/arm64/boot/dts/qcom/eliza-mtp.dts | 72 ++++++++++++++++++++++++++++++++++
>   1 file changed, 72 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/eliza-mtp.dts b/arch/arm64/boot/dts/qcom/eliza-mtp.dts
> index af7450fa2020d29a4ce98eb958dabd0cd8c61860..cd14b44cf0aef33a7939075949916d054cd77659 100644
> --- a/arch/arm64/boot/dts/qcom/eliza-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/eliza-mtp.dts
> @@ -6,6 +6,7 @@
>   /dts-v1/;
>   
>   #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/media/video-interfaces.h>
>   #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>   #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>   #include "eliza.dtsi"
> @@ -538,6 +539,70 @@ vreg_l7n: ldo7 {
>   	};
>   };
>   
> +&camss {
> +	status = "okay";
> +};
> +
> +&camss_csiphy2_in_port {
> +	camss_csiphy2_inep: endpoint {
> +		data-lanes = <1 2 3 4>;
> +		remote-endpoint = <&csiphy2_out_ep>;
> +	};
> +};
> +
> +&cci1 {
> +	status = "okay";
> +};
> +
> +&cci1_i2c0 {
> +	camera@56 {
> +		compatible = "samsung,s5kjn1";
> +		reg = <0x56>;
> +
> +		reset-gpios = <&tlmm 125 GPIO_ACTIVE_LOW>;
> +		pinctrl-0 = <&cam_mclk2_default &cam2_reset_default>;
> +		pinctrl-names = "default";
> +
> +		clocks = <&cambistmclkcc CAM_BIST_MCLK_CC_MCLK2_CLK>;
> +		assigned-clocks = <&cambistmclkcc CAM_BIST_MCLK_CC_MCLK2_CLK>;
> +		assigned-clock-rates = <24000000>;
> +
> +		vdda-supply = <&vreg_l4m>;
> +		vddd-supply = <&vreg_l2m>;
> +		vddio-supply = <&vreg_l5n>;
> +
> +		port {
> +			s5kjn1_out_ep: endpoint {
> +				data-lanes = <1 2 3 4>;

'data-lanes' property can be dropped from here.

> +				link-frequencies = /bits/ 64 <700000000>;
> +				remote-endpoint = <&csiphy2_in_ep>;
> +			};
> +		};
> +	};
> +};
> +
> +&csiphy2 {
> +	vdda-0p9-supply = <&vreg_l2b>;
> +	vdda-1p2-supply = <&vreg_l4b>;
> +
> +	status = "okay";
> +};
> +
> +&csiphy2_in_port {
> +	csiphy2_in_ep: endpoint {
> +		bus-type = <MEDIA_BUS_TYPE_CSI2_DPHY>;
> +		clock-lanes = <0>;
> +		data-lanes = <1 2 3 4>;
> +		remote-endpoint = <&s5kjn1_out_ep>;
> +	};
> +};
> +
> +&csiphy2_out_port {
> +	csiphy2_out_ep: endpoint {
> +		remote-endpoint = <&camss_csiphy2_inep>;
> +	};
> +};
> +
>   &gpu {
>   	status = "okay";
>   };
> @@ -657,6 +722,13 @@ &tlmm {
>   			       <111 2>,  /* WCN UART1 */
>   			       <118 1>;  /* NFC Secure I/O */
>   
> +	cam2_reset_default: cam2-reset-default-state {
> +		pins = "gpio125";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
>   	disp0_reset_n_active: disp0-reset-n-active-state {
>   		pins = "gpio12";
>   		function = "gpio";
> 

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

-- 
Best wishes,
Vladimir
