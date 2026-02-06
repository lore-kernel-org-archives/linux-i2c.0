Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C2C322A13
	for <linux-i2c@vger.kernel.org>; Fri,  6 Feb 2026 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770394517; cv=none; b=Wg/Suz+xqYW7Fs6trEcT+6i1vFab1CLv6PWTpXc0/rop5cGfhMCQjdSaT3X6+GNCR3teaMjzW5sxJWM/a+qdicPp2g6g+ZNwsTrM7Nfjn59pU0fMlKAGKRXwCwS/FwQohdhQWVGv33fYIq87trPoV1gKAs4858Kdwpt9d0qALBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770394517; c=relaxed/simple;
	bh=PgHh9sO6g1i1ICu0i5WHmFr2GjxMXiWnxdDbOdqYd2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=duh+dmABKnWDJHCnJcDpUaz71JMsEvZnkNjC7JWN4T0hqFGI9MXt6ztxcH53dsCRuAsu04dHmKG0/lhd+dzMGUAM2He8Dc9M5SRx7JkvmyWziwK96KYoHab6BPmsm8enu2jn04oG5mNGsbqF9zgvw9lR1GxUXGnnGQ40em5e95Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y+/mUjRz; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y+/mUjRz"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59de45b5580so237093e87.3
        for <linux-i2c@vger.kernel.org>; Fri, 06 Feb 2026 08:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770394515; x=1770999315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7YltPymBDZDAXQzrrunk/e6Y1HtLsHo+KDRbCcly/E=;
        b=y+/mUjRzihDm2JixE9p6rIb3fSOUWLS8I9ZP1yfw4volOB7qr/iIg9DcfjpoqVrOOY
         l493LZzuOq30hGV4lZOTWgXvcSpaDjJq3yKBxzUwu86qPouYsVX1x+CbLaYeAnJ/fvT1
         n7IbLT7s6zSuRFCcScHtVOsMXsVu83M0H6vgNqmloSVPN1UpptdM+A3mLN1z3pv8LvMT
         7j8rjkw9ECOuHjZaM1FofiNDVgf2iYNs8+pxbs1/9tw3GT6o2b9VKgnKYZChOzbYF97b
         Pgg3glu5WIT8xCepjlfJPom5TXcldwixBbcWs2YWa6axr8H6EYd4nkTilWBSep+ph0NZ
         eDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770394515; x=1770999315;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j7YltPymBDZDAXQzrrunk/e6Y1HtLsHo+KDRbCcly/E=;
        b=f/9m2DvamEh2gARUZ8l9a4t1dp/JmDfuOv6kEL2XIxEod1v3oep9EjM3ScZ+qo4yXG
         7EbEEEzWl/pB9RB7xx4ZtfytezSL5QUwvlj+oNVwPZb5zJZW8HP9wD/4W1KOZaihozlk
         miSAHyxj1V0ftQlsFuhTgTWn/QKhoIpiEi4Ks5JjPeUmDi80lH8SE0dXmK6LTBhxDX4K
         kHFH1PqPsmrbDrDPtqtrhvhr6H0ikOpUAccHUEvOm0AqcqxI+FN3B6QINqC8M/+uiL/L
         m09N5lL7UlsbWXvS08sDEQjR4FCCN5TQNT+Jz/p2wacTqZyuebJXfxMs/HHkDj0v3aMx
         UBPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkiKh2JWXv2pWrqsdnwwPW1sNwHjuaFfZrxQynbK9I7zQMhMzm5omLFdNXWLfYoUtumhdD8VdfgO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWBB6bREnam9AAXIUfpcXdPZ5ndXHYiXVeL2Afb+9SJffcd8ZU
	ljCo6987bjYyuZRYz/waDNPkORM3I/ITD1Nxs7UsWwlelXEFYELR3wPGPROhc8xkxgY=
X-Gm-Gg: AZuq6aLvEk6v99bMYhvXGdrabLx0wZPwjcfsW52SkA7Wr50/bO/Cx9JmYXPDCkYI/VP
	yvFahZLD6kW8tm2MZQHA9Jcxk8IVlw0Ha8cBqkjrVR6d77xayg4MgGqi+O0SveZUS73+1+Gcq3l
	FOBc58Ca0rKO2LlVC6rsT7qb6sTKqBpaMJg/jCsIU+4H0xe4+GQKx2KNvnKU9ibTBkxJuH6q7L0
	BZBO0eTUzvRzCxaKVphQyqJIihMn/wPR7YsL8qSHEM3UBYz/MOQ6tIbjvqjv1s9omECRX7qK95E
	DyKFPx6qZ2HlrjXO1QCWNqmbUOACSrpAHBVjeesvE+AKjn562oTxxBkLZgdQoGyPbbnWyfQSyhW
	n1US+BcCoB2zEBT6H2IKTixjQFqwA1QcKOiDSi5yWm3xwqYzKxBZqRikg/mHXOL1bn0lmFqysVj
	n25L5qaxba6wodruTRuPrc+J9iy8f0qYPwP3/cOIZoeTnf7rIy8iZq6JGTfIVrKcg7AQ==
X-Received: by 2002:a05:6512:24d7:10b0:59e:3e87:1a with SMTP id 2adb3069b0e04-59e4518da53mr385299e87.7.1770394515297;
        Fri, 06 Feb 2026 08:15:15 -0800 (PST)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e44cf713fsm698812e87.1.2026.02.06.08.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 08:15:14 -0800 (PST)
Message-ID: <9de74828-85bf-408c-8f64-2a8694f71563@linaro.org>
Date: Fri, 6 Feb 2026 18:15:01 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/5] arm64: dts: qcom: monaco-evk: Add camera AVDD
 regulators
To: Nihal Kumar Gupta <quic_nihalkum@quicinc.com>,
 bryan.odonoghue@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
 hverkuil-cisco@xs4all.nl, loic.poulain@oss.qualcomm.com, rfoss@kernel.org,
 andi.shyti@kernel.org, linux-i2c@vger.kernel.org,
 cros-qcom-dts-watchers@chromium.org
Cc: quic_svankada@quicinc.com, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260121183142.1867199-1-quic_nihalkum@quicinc.com>
 <20260121183142.1867199-5-quic_nihalkum@quicinc.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20260121183142.1867199-5-quic_nihalkum@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/21/26 20:31, Nihal Kumar Gupta wrote:
> Define three fixed regulators for camera AVDD rails, each gpio-controlled
> with corresponding pinctrl definitions.
> 
> Signed-off-by: Nihal Kumar Gupta <quic_nihalkum@quicinc.com>
> Signed-off-by: Vikram Sharma <quic_vikramsa@quicinc.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>   arch/arm64/boot/dts/qcom/monaco-evk.dts | 51 +++++++++++++++++++++++++
>   1 file changed, 51 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/monaco-evk.dts b/arch/arm64/boot/dts/qcom/monaco-evk.dts
> index 565418b86b2a..65c1b49c6dfb 100644
> --- a/arch/arm64/boot/dts/qcom/monaco-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/monaco-evk.dts
> @@ -77,6 +77,36 @@ platform {
>   			};
>   		};
>   	};
> +
> +	vreg_cam0_2p8: vreg-cam0-2p8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vreg_cam0_2p8";
> +		startup-delay-us = <10000>;
> +		enable-active-high;
> +		gpio = <&tlmm 73 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&cam0_avdd_2v8_en_default>;
> +		pinctrl-names = "default";
> +	};
> +
> +	vreg_cam1_2p8: vreg-cam1-2p8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vreg_cam1_2p8";
> +		startup-delay-us = <10000>;
> +		enable-active-high;
> +		gpio = <&tlmm 74 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&cam1_avdd_2v8_en_default>;
> +		pinctrl-names = "default";
> +	};
> +
> +	vreg_cam2_2p8: vreg-cam2-2p8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vreg_cam2_2p8";
> +		startup-delay-us = <10000>;
> +		enable-active-high;
> +		gpio = <&tlmm 75 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&cam2_avdd_2v8_en_default>;
> +		pinctrl-names = "default";

Since voltage level is known for all three regulators, why not to add

     regulator-min-microvolt = <2800000>;
     regulator-max-microvolt = <2800000>;

properties?

> +	}
>   };
>   
>   &apps_rsc {
> @@ -564,6 +594,27 @@ perst-pins {
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

-- 
Best wishes,
Vladimir
