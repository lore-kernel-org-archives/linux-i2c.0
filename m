Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C8C3570BA
	for <linux-i2c@vger.kernel.org>; Fri, 13 Feb 2026 13:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770989512; cv=none; b=eslVsPj+UeWgsiuVGrXwqnV+QcSAG0o/OmSwUs3Yh6ffoA5l5Pbvy6EFfItqcWBc7O7XTRmAuo8tWxQzksLTE8TiIw5TChHi/AoS1dWKPh+CI/F9O/5BUzJ6moqiwy7s+4chDJNpsUxa96k97f47bH+6GL7OAREYf21clbm5z4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770989512; c=relaxed/simple;
	bh=9611KZFZ/L1Ph1AhhjwuaMFyxx/hs7k2tOHyJPaZPuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PL56b7Z1FWYXkghUnFrbeFs3xhkxQzgGAU9dsmIYWcPv+0RpQsCOPoF6dfTEbUGN9zsMEKXVJdVlrZqWBJGyRHvm+XCruZnPiN4Uu3+OKbWQ2BtBYDSpGn7eRjuK02iCbqotKJfyKtdrDAyW0IBcKvQpFDv41iX3wmj57XEfFqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aztyqmkJ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aztyqmkJ"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59e5b591d27so37680e87.0
        for <linux-i2c@vger.kernel.org>; Fri, 13 Feb 2026 05:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770989508; x=1771594308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muJHKh3a4POX2qeaRW8JB2A7m86DLBucT7+9bUtzEHc=;
        b=aztyqmkJG6DaVlUHaoAwBO75bQcfAk7DZ/fMF6cxFgiHMIr0TubMHNMx8AvxUE2/16
         JPd4HlMMFcpSxHEG34frqjglS1mG2I/xpj2fwOMMq0kqTrM/HVw0P4Gk0E6RrxorI1MD
         HDdMMRl9wI/kicZTb2KAg4uaDU062Hh+X+DdLJug3PDJOFNJvpMHTAN6unpDaYYyNjbj
         aICEjBhaxZ2B76Swyn9wAm7uX9nJt1Rt+LojMYCrccQk3+cJpBQXHgxoEJEmu9QNYA3v
         sQiSkYdwvzLspdXor7oQx34I4cnZbTYHtjVn9Eb6faHCtlyrRKATf+y/4aYLSn8bI7pP
         gMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770989508; x=1771594308;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=muJHKh3a4POX2qeaRW8JB2A7m86DLBucT7+9bUtzEHc=;
        b=AZ95oAwkf6njV0IhMxkMjhCXg4DpEtMKT3jd5PfYE66GdDCT0F2mpT9ezPh+LL4m+F
         +HLTZAdCUZxVGOWmOYMHRW/Av61A6Ti+bX7TgWKKppVqy4RjK2NuDv3iro3AH81k6ltm
         Iqy//Ak4mIy4YeU6t2UcI1hJBqrkwvOduaevkjMztr9RCKobGLwSGtRK1gpFftq5Id+K
         bfUQkc25OnbhMA1X4j2i6Cu9VW/NUij0VRByhufkQsy0KQYf/Vn4BpRS1IGW80zoBECE
         evNcC8gDTeDgkwfqp4QTYppjuczmk5h2m0anjd9j3LyunnI0dcfPtUZDPLL67zHHYR+c
         bVpg==
X-Forwarded-Encrypted: i=1; AJvYcCWTgUAesQdMtWshQLMSPDxTTPLry9qwL41drMwv5ect/vLb9C8Hn/UH2S8NsJ4ACzu6AfUeeFLgWyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJj06TpY2P3sA9teEpgaJHEDVSIjKho0aPrV4lJJQhDrKEAUNg
	gZgrbEMhx5Gzko4HGwgqddAz45x3S91fwc8fQv/wiEs04g5hkXatnbAQKgXu4CRTJEE=
X-Gm-Gg: AZuq6aIMJuLacWTiLJQSkAn3necTh35Ld/ehcJnREwZNXLsRfrqmg8/HZ8Ch/7b5ytY
	a8deIFNxv1Sen3TpfPorS6WTDnWLSQ+gZhgGnRNHA8jVt/yq9FXa79ZDTnrxwH2xEqLWw0v97DC
	mE6OvdjUI6KQVIRORijjPrRwj/sKP5NEfmZ6/C6/vhVuZyf3mjUstDveR4eUIx9kecwoBGMlzNE
	/c8/Fmh0TyPbVxvEdmZLWmeqJ5uChl7oICeJEQoySPv4EKTFpeFJtN8vT6Js3RuO9jnTD4570H1
	1HxAJYhXzbsskqk10hAGFnryAXx27fJi/uh5wyWs9CRk/hOnWDqCls5s0R4OT/oFUM3Kv5Wyh9e
	1TWyfmJ2h2rASLoURqwD6h3q28ctax2honWOAVkspwZLRFHDaQ22RH/ecVptdzw2m+8+u1aua6O
	sVLMcBl6wk11jfuAJChJ3tOja//2keYhshhWgziKGdkIP8IrbdWLNF7iGlTgiOipGkiqr/NkGwZ
	5H3fw==
X-Received: by 2002:a05:6512:4045:10b0:59e:63b8:62a9 with SMTP id 2adb3069b0e04-59ef3a4f1a2mr308614e87.8.1770989508188;
        Fri, 13 Feb 2026 05:31:48 -0800 (PST)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f568d95sm1557193e87.30.2026.02.13.05.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 05:31:47 -0800 (PST)
Message-ID: <7f31e787-a2a0-4518-8cc7-c012e22859c8@linaro.org>
Date: Fri, 13 Feb 2026 15:31:46 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/5] arm64: dts: qcom: monaco-evk: Add camera AVDD
 regulators
To: Nihal Kumar Gupta <quic_nihalkum@quicinc.com>,
 bryan.odonoghue@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
 hverkuil-cisco@xs4all.nl, loic.poulain@oss.qualcomm.com, rfoss@kernel.org,
 andi.shyti@kernel.org, linux-i2c@vger.kernel.org,
 cros-qcom-dts-watchers@chromium.org
Cc: quic_svankada@quicinc.com, quic_vikramsa@quicinc.com,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260213132058.521474-1-quic_nihalkum@quicinc.com>
 <20260213132058.521474-5-quic_nihalkum@quicinc.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20260213132058.521474-5-quic_nihalkum@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/26 15:20, Nihal Kumar Gupta wrote:
> Define three fixed regulators for camera AVDD rails, each gpio-controlled
> with corresponding pinctrl definitions.
> 
> Signed-off-by: Nihal Kumar Gupta <quic_nihalkum@quicinc.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>   arch/arm64/boot/dts/qcom/monaco-evk.dts | 63 +++++++++++++++++++++++++
>   1 file changed, 63 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/monaco-evk.dts b/arch/arm64/boot/dts/qcom/monaco-evk.dts
> index 565418b86b2a..bfd727c745c6 100644
> --- a/arch/arm64/boot/dts/qcom/monaco-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/monaco-evk.dts
> @@ -77,6 +77,48 @@ platform {
>   			};
>   		};
>   	};
> +
> +	vreg_cam0_2p8: vreg-cam0-2p8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vreg_cam0_2p8";
> +		regulator-min-microvolt = <2800000>;
> +		regulator-max-microvolt = <2800000>;
> +		startup-delay-us = <10000>;
> +
> +		gpio = <&tlmm 73 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&cam0_avdd_2v8_en_default>;
> +		pinctrl-names = "default";
> +	};
> +
> +	vreg_cam1_2p8: vreg-cam1-2p8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vreg_cam1_2p8";
> +		regulator-min-microvolt = <2800000>;
> +		regulator-max-microvolt = <2800000>;
> +		startup-delay-us = <10000>;
> +
> +		gpio = <&tlmm 74 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&cam1_avdd_2v8_en_default>;
> +		pinctrl-names = "default";
> +	};
> +
> +	vreg_cam2_2p8: vreg-cam2-2p8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vreg_cam2_2p8";
> +		regulator-min-microvolt = <2800000>;
> +		regulator-max-microvolt = <2800000>;
> +		startup-delay-us = <10000>;
> +
> +		gpio = <&tlmm 75 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&cam2_avdd_2v8_en_default>;
> +		pinctrl-names = "default";
> +	};
>   };
>   
>   &apps_rsc {
> @@ -564,6 +606,27 @@ perst-pins {
>   		};
>   	};
>   
> +	cam0_avdd_2v8_en_default: cam0-avdd-2v8-en-state {
> +		pins = "gpio73";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	cam1_avdd_2v8_en_default: cam1-avdd-2v8-en-state {
> +		pins = "gpio74";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	cam2_avdd_2v8_en_default: cam2-avdd-2v8-en-state {
> +		pins = "gpio75";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
>   	qup_i2c15_default: qup-i2c15-state {
>   		pins = "gpio91", "gpio92";
>   		function = "qup1_se7";

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

-- 
Best wishes,
Vladimir
