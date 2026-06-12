Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0C837CD20
	for <linux-i2c@vger.kernel.org>; Fri, 12 Jun 2026 08:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781251333; cv=none; b=OdBKV/1j05nJXyPtCRnUrIS/Ysey9g1BUS5d7aHGWd311VIADvI7Knj5TWd2vn88+fQQM4CjFMTHKgBHHURa2cAj82lF5X+8N/HbH+IrZ5gezvjTZGQSKQi3uaQGsH4JjBYO1chcE+sIBb/l0G5MsJQ5gtsSeNh2+PTXlo30lmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781251333; c=relaxed/simple;
	bh=4cMssSzC9x3YznfsLASdUieBfszbi2Dc1q0Kfv/ciD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZxPpKd6U5pQmthgRUh+858KoJyu23qewk8KzKh/KEsj6EGdEyNtn481AFiBuXuSFg53C8+T5rgqNn9Dn5N0+csSWruHQ8MyxIvEHC81cw+wYJY3LP7Ndz2vHLbtyXPX968jhwtBa2Gf3NNmtjfAp6fV7i0JdBynh4Y4K0meZ0rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l6qvCOyc; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l6qvCOyc"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-396745b9abfso171111fa.1
        for <linux-i2c@vger.kernel.org>; Fri, 12 Jun 2026 01:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781251329; x=1781856129; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nMhkGFekCaaDNI8Y6IA3kIgQFx/LhDxMuNSn8eII840=;
        b=l6qvCOycLXNfotY4/FVwmVAUOJ4TrnIDsKqm3PcHmIFWpXsyb9VlUMTrOOeCEqLVi8
         +o9tPkdI7rRY3AwCfWqIgPXeUUy43hoCIaQk+yzImdilm2v5s56m5J6Cexo0xZmgUTdF
         tXvi0UpAlMomIxtKds4E5TKqxcr/53T5atx4EDzUHqHYK+IkJNE0MpK96X7JoJ5YG0Vg
         eugc3/b1oGfi6Qr0w5TBSDncUZD6zUu4tBBULE3dz6Fn1Zd7y1HHgVvACmdDqFWkEOKc
         6Wp4nmImnGkUtflfdPZLbFbUvkwDIqEOg11MhhdinIQd4jgtJ6ZiMusx9DJUUaZXdSEy
         bUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781251329; x=1781856129;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nMhkGFekCaaDNI8Y6IA3kIgQFx/LhDxMuNSn8eII840=;
        b=pYy5NhjeXl6svQMadL9GJm2c7kmWn/vLJc4cHPS0f1ULcYLYRbXZ7gyctf6YeTbvoq
         KptVnAd4wAHIFIclJ49QUjTGlPEIuNzl/saSBW1ExID0z9Jm19pl8gd0pgITnRjIRoCI
         Z0QoslFq3ZktWYoBcwdzEDIhDUKAUnetXwtOy7P2Yo84K/j1Onp9NJKMYjVj5MSkrmrQ
         C3kIo6HoHquwa/BQ1XKzLmX9C7fkckXBPUtUpzCjb5/GQ3NDtsqYQOdQbZFtcctWhjr/
         AHoAKh/aQ4evZuXWpRWKp2nCZT/+b+qeS5DUYjbMo56qmYzudpnhPuzP5Bemrm/D2YVh
         BdIw==
X-Forwarded-Encrypted: i=1; AFNElJ8Ygj1yo5Dr/BUhd54ph8dl4QjUtXfUuUthUVRa6Jl852WwGhQUhh1xl10b23ETvxZoyERboDGonxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+XWl11SlybiMqhVDUKVLHXZ7va1Fu7EnCkQVD0HY9fuabxrIO
	SPiggbjBcX9++1k0KMCUBy6QDwBcjBZvYKU1/SEhITGrYDOwbOpPsMGlD7B8psm0dbM=
X-Gm-Gg: Acq92OEVG9lIuMDu1nJ2n/C4XJnYSU3+nvN5Py1E+usIxEhhQL3sNZaA32y/fVh8hFF
	Tfh9rY5WEjGD2LH/X1fwdZ66pdlI4yzfcfkQ2YtuLSZqYMFSIH03LEMAtokPDVCsfMIa9ZB7Z3r
	PmJSshtbI9xhx7Ds5CYjlVJFo9iDkRHWh/Q3xgDuVr8tC9O/FMIb375iqqdfb/jlD4D+GaCyQ3T
	3ZgpFEvRi5ux6XM8N2qoih57avtD99W4CjZDZoPc+ANyLup/Lapuad/v1mefftEaGOorhCaGQkJ
	XVJ1bFmhMBPgqy0HTr7qAN/nJKYe0mOGav+dsFc8bE/D4v/Zo6oSBjnQ9hvhifTkPIhgswJULF7
	UQ8Zh5ExlHEJ/ik5BxnFC4FbmvdYUE+7XpbDJq2CYO0ZdIHiTqsDTIHgPqzYR0r25RXTgwYh35r
	bAea9jPRcN6Mcjzfk/yNRvjgb3aGS1KgupJ+R/g0Ybi4B8RPQTRmAjosOBiTVoNQ9/h7tK7iSUz
	GES+kjpP19105Tx
X-Received: by 2002:a05:6512:3e0a:b0:5a8:bd9c:a2e1 with SMTP id 2adb3069b0e04-5ad2db2fa46mr249662e87.2.1781251328767;
        Fri, 12 Jun 2026 01:02:08 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e17014fsm324975e87.28.2026.06.12.01.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 01:02:07 -0700 (PDT)
Message-ID: <b3a6798f-a7ea-40c9-a9b6-3aaba57c8ce2@linaro.org>
Date: Fri, 12 Jun 2026 11:02:05 +0300
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] arm64: dts: qcom: shikra: Add pin configuration
 for mclks
Content-Language: ru-RU
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
 <20260608-shikra-camss-review-v2-5-ca1936bf1219@oss.qualcomm.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20260608-shikra-camss-review-v2-5-ca1936bf1219@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/8/26 17:06, Nihal Kumar Gupta wrote:
> Add pinctrl configuration for the four available camera master clocks.
> 
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> ---
>   arch/arm64/boot/dts/qcom/shikra.dtsi | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
> index fed71131491ebf6e261bfcd14b5d4a2624837878..2f0f7710c2897e140495afd8d4e8bde50f356096 100644
> --- a/arch/arm64/boot/dts/qcom/shikra.dtsi
> +++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
> @@ -380,6 +380,34 @@ cci_i2c1_sleep: cci-i2c1-sleep-state {
>   				bias-pull-down;
>   			};
>   
> +			cam_mclk0_default: cam-mclk0-default-state {
> +				pins = "gpio34";
> +				function = "cam_mclk";
> +				drive-strength = <2>;
> +				bias-disable;
> +			};
> +
> +			cam_mclk1_default: cam-mclk1-default-state {
> +				pins = "gpio35";
> +				function = "cam_mclk";
> +				drive-strength = <2>;
> +				bias-disable;
> +			};
> +
> +			cam_mclk2_default: cam-mclk2-default-state {
> +				pins = "gpio96";
> +				function = "cam_mclk";
> +				drive-strength = <2>;
> +				bias-disable;
> +			};
> +
> +			cam_mclk3_default: cam-mclk3-default-state {
> +				pins = "gpio98";
> +				function = "cam_mclk";
> +				drive-strength = <2>;
> +				bias-disable;
> +			};
> +
>   			qup_uart0_default: qup-uart0-default-state {
>   				pins = "gpio0", "gpio1";
>   				function = "qup0_se0";
> 

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

-- 
Best wishes,
Vladimir
