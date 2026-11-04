Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793834180;
	b=JGKWGCzoSreRgKEznQogfRuGU1AevCSwM96g28TeM1rj9DxUcm8vZc3VTrZ9aAGDkyqO
	 egxLf02dHXAlZVb5AbTIuoEvla0ttWVjsSmvvAVA+fB4Jhonq25xsHwmuSEFu/cUqdOKq
	 21StJUfkm3NHaS30iKwqd3OmTpYHnZNAfcvnXxrBZC5nF5I9hdvZ1VSdEKqSynsLYgb/O
	 lUVJYt5w8vWrX8ultQFyJEh7exS7DKDptbxABJydXce7jlJCq4neuEsdGpaAenQAALj3y
	 IARGu39uUONK9ivdjcaiFT4/ygnQCZOsN/fArnwh9PmYddPylx+Of4xWAAc1LHT/c/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793834180;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=+EXsJAbPRUQUC+z3RwBzOtASBFf3dkWZxelHNp/K+zQ=;
	b=iH7RL7Ah/SyifSix7/TPtum+Tk0H60HKU38LHd7UNEgXjDmcjh+kmjfHY1FDRAySu8W4
	 ozVgpGLoF/dVmLfBb3Rxpy/rvrE/Hcq96iKKSoOS/LDH1QlQG4fcYCIQYWPBlTWtS9hgu
	 dn553L/iA8zFG1pXvflNkjnL5pTpx483xKhrJgt/5rdTJeFrhEcNA8bKFHfW6EthiYOmE
	 PBAo1TCYhyKDQXO48+wrSBIa6WWrC/n/T035XWC6wKYCAqDu7z1LdiXgP0rysBQdI2+gP
	 T6zZLgZQuiSi1ZculpfSMf6OJzqAMirqvvifV1N2AhI31OCsaHFB3mTzAjVcGw5zWhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=MaYfUrSx;
	arc=none smtp.remote-ip=209.85.208.173
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0D3606A32D
	for <linux-i2c@vger.kernel.org>; Wed,  4 Nov 2026 23:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA0D3606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=MaYfUrSx
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3ab30d04674so2244361fa.2
        for <linux-i2c@vger.kernel.org>; Wed, 04 Nov 2026 15:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793834178; x=1794438978; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+EXsJAbPRUQUC+z3RwBzOtASBFf3dkWZxelHNp/K+zQ=;
        b=MaYfUrSxNAlGHW/moCDpL5dx1KkBp8SvB1mgsR5RSl3YCfz5pCNFJbBf95jzougjqY
         3K4uhPqKWhwHat31Ew6snmPNkN226ndz+bHT3x4mViR/RCa0pNpli+Sfj6yN+SeiNjYK
         lpY2CwrLM3kleG8LY9Qehd92WyD0u4NVaFktuJaXrf9FWYkRkUAE9P2A/W5lM95uAEFi
         hrH8ohl5VS2MRP5wz7D6Jq2bWrtcU0u0+xfkSKTFALPKSsH0aZK2BwRVMt2XPQJw8vor
         9icmWQSGsHKjuzumqm+SnEE+qUUbtVXw96HJ+WRwpmlQahi+iSWSCXss5UQ0zNKRhFST
         +3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793834178; x=1794438978;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+EXsJAbPRUQUC+z3RwBzOtASBFf3dkWZxelHNp/K+zQ=;
        b=yOJPnIBfRfwqaNOMJY+kwvCpDXIEQRVfkbxe8wDUPH1huiqdg8USLAe1DWviA1sm0l
         tAJ8JX6dc1JN/XCVXwlwSpDTV0F1Zxxk3d/x3jKIoWlYgPCVkYePb42TNbB+VOTslgid
         r25Eb/6NI2nLDl4IhJEkhNS9qxn9k37YYUjaTcYcFHSiPYRL1XntHX5OxMkkAvWNrz2f
         7LgxsS0AbD13Zp0wALix8kxUDZeixW9Wj9BLaFzvvqqf2Yc1Z7oHf5pA7g4IwRw3tYTv
         w2Pg6zCJmzfyMVdD3CJ7jSjqgs40pEkytjNmCZbn8uR3rGCVvRIs0zpDMCftNx8O7IIl
         i5uQ==
X-Forwarded-Encrypted: i=1; AKwUvByBh8O2h4P7MsfNfbOu5Ub1NZES74TZ3UmRI/KBDcw+SWruDsqNKuO5/dbB+mmkNyket1vRj/uzyz0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/PoHiphwzga4QpoQOvt64Ly/lLO05c9T0L5x+LmQD1nI/XUifR
	OYUmu0GkWE1q37EWKtwnnSsSKqJ/f8nZCPNWDp7H0kQPYY6asvU9vqYGcxFmJzMFyGQ=
X-Gm-Gg: AYBFou10BOeIO+AsdowWLgctbDQu/JFkHRYrptoGoQQimH/ID9Q4zQrPbF/Bh0Vezf2
	47fMNW22bDffRNf/FgV4X0UAaRENBpdbAiJlCwgaDWEw9VUav4cs4XjEWKZg4ys/qR4+sZsCJsM
	KF3FseVruFiJTgsU71f4Xr8fQy4mjnhiXLHO0jUisMt/qUcVRTp9PZ/YAjfkgP/8sH7yXTe4N6y
	IhoPqwMVVjrSl5I5D5dULE24YSiYNulty8ZpTo5hZFKwRXsq4gtjAPvAyuQwviBAAuiY/qOaive
	i0itiVYNGC9iKfaQKMhlac7yMrx27ExyhAqXT5f02w1gvrfPcOSMGGWd4HSe1RBFiGdzZut6uc7
	eADY3q5FlgRoGqs51mGpbbAfQkXPHDtLfEBeKxv9X6sCHRZ2Y8qAYZomIjf6qhZe57q44RHSXtG
	TWlM9kAKkqcVELy5Qm/8oWBJenaxvrf1HQLw3iGRwRWQjHe92tHHMlhf8ExCuybn6k0VRC97HO3
	M1xcyT20BN73YvZPGugjHFY1hdtN7WvUMBBwtoawtjmpJQ4ONh1xz5KexAg5EA0V3y3puALZ561
	SExJUVnu7slL3onmSceXuqEh1TapQ//DKkBjXtzYLA/76bAx/4pCQ4h2qhHzAT0QCulYJAkId7R
	smnJEYA==
X-Received: by 2002:a05:6512:39d1:b0:5bf:d00a:b6c0 with SMTP id 2adb3069b0e04-5bfd95510cdmr7238038e87.3.1793834177876;
        Wed, 04 Nov 2026 15:16:17 -0800 (PST)
Received: from [192.168.1.101] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bff38de44bsm580359e87.84.2026.11.04.15.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 15:16:17 -0800 (PST)
Message-ID: <904675e8-701d-4fd6-b418-6c0dcc9288b9@linaro.org>
Date: Thu, 5 Nov 2026 01:16:16 +0200
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
Subject: Re: [PATCH 2/4] dt-bindings: media: qcom,sm8150-camss: Add SM8150
 CAMSS
To: mail@andrewgigena.dev, Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
References: <20261104-sm8150-v7-4-rc1-camss-v1-0-7a9534a9a22f@andrewgigena.dev>
 <20261104-sm8150-v7-4-rc1-camss-v1-2-7a9534a9a22f@andrewgigena.dev>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20261104-sm8150-v7-4-rc1-camss-v1-2-7a9534a9a22f@andrewgigena.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/26 22:54, Andrew Gigena via B4 Relay wrote:
> From: Andrew Gigena <mail@andrewgigena.dev>
> 
> Document the Qualcomm SM8150 Camera Subsystem. The IP integrates four
> CSIPHY, four CSID (two full and two lite), two VFE and two VFE-Lite
> instances, with 42 clocks, 12 interrupts, eight IOMMU streams, four
> interconnect paths and three power domains.
> 
> SM8150 has a different register layout, clock tree and power domain
> topology from SM8250, so describe it in a dedicated schema instead of
> using qcom,sm8250-camss as a fallback.
> 
> Signed-off-by: Andrew Gigena <mail@andrewgigena.dev>
> ---
>   .../bindings/media/qcom,sm8150-camss.yaml          | 477 +++++++++++++++++++++
>   1 file changed, 477 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,sm8150-camss.yaml b/Documentation/devicetree/bindings/media/qcom,sm8150-camss.yaml
> new file mode 100644
> index 000000000000..a65067352b58
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/qcom,sm8150-camss.yaml
> @@ -0,0 +1,477 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/qcom,sm8150-camss.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SM8150 Camera Subsystem (CAMSS)
> +
> +maintainers:
> +  - Andrew Gigena <mail@andrewgigena.dev>
> +
> +description: |
> +  The CAMSS IP is a CSI decoder and ISP present on Qualcomm platforms.
> +
> +properties:
> +  compatible:
> +    const: qcom,sm8150-camss
> +
> +  clocks:
> +    minItems: 42
> +    maxItems: 42
> +
> +  clock-names:
> +    items:
> +      - const: camnoc_axi
> +      - const: camnoc_axi_src
> +      - const: cpas_ahb
> +      - const: cphy_rx_src
> +      - const: csiphy0
> +      - const: csiphy0_timer
> +      - const: csiphy0_timer_src
> +      - const: csiphy1
> +      - const: csiphy1_timer
> +      - const: csiphy1_timer_src
> +      - const: csiphy2
> +      - const: csiphy2_timer
> +      - const: csiphy2_timer_src
> +      - const: csiphy3
> +      - const: csiphy3_timer
> +      - const: csiphy3_timer_src

Please switch to the new model of describing and exploiting
the stand-alone CSI2 PHY devices.

Any CAMSS drivers based on the legacy description of CSIPHYs
should not be accepted into the upstream.

-- 
Best wishes,
Vladimir
