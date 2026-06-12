Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F163DC857
	for <linux-i2c@vger.kernel.org>; Fri, 12 Jun 2026 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250813; cv=none; b=Vzm26OAuBDzMGV4aSNbQSfULvG2HL2RSrCoPqmPcDZ09CxiJdv+hAwECMeDs/GOm+UBS1/nNIdG60NZXOgYrm+QJOcJ9z6LM/IxF0m0JWEwmejJWUBZFpVWIU3xfdph9sUOBJRezEl3QPvbVIeCyuKEJF2U5BJrHCpQADTCBFj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250813; c=relaxed/simple;
	bh=/oZQN6CLyIMffYWm3DYjqjp43iZSlTeBEiYorOde5DY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fEu3vLIfXEIJJcJ1R6T/Z34HNugh+DoHvpiLgTQw7m9YmvM0pEC0ULkeFG+UYdzl2CtF0l73Z9gDFtdO53IaTOUifBT2nelVVEQML3pm9SKv3QlrXC2bjn0JSJARDknQJrc8rB3sYKydkNqGfGZDgsNL9wH57SLRrkxWkqH1kk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ce3gqpem; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ce3gqpem"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-396770b47eeso380731fa.0
        for <linux-i2c@vger.kernel.org>; Fri, 12 Jun 2026 00:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781250809; x=1781855609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=167FyBYxKu2R9OXqpMqI8bsA1a709piqQ4Ou6o89XRk=;
        b=ce3gqpemPOhLIiozeWiDvK4SKSxpcsNzFsE7a0IITQaN1T2Udpx5u9iAKze2XnUTRM
         /a5N1yUrD2q/jXd71nR2YfgvtVqqoxTiApaOoV1zBqDkUNWINhHjirumqSqwTSm9/XcP
         KmRAN6ZYZRK3yeK7470HY3tEWGbKwMu2UmJ6ymSCbN8Vt3X16IiX0FG4539kcAaPBuEe
         wFlWEbvPA9bkM5dD1j6kUko5YdVrbhz4h9WBls3h4GVTtCReDb6/OMmOwyJq8zxSsEfx
         6YUKTlo1gweG/9C8x2Ggdwrc58D6ehVQNqk08IRnfywwGNtkARD9rfWrdyaRAczRWPHO
         R1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781250809; x=1781855609;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=167FyBYxKu2R9OXqpMqI8bsA1a709piqQ4Ou6o89XRk=;
        b=DsKW5YObczPs9bCWqcgGRbjDQWYuZrdhS49SBQGSbJO1Ezz9v93up9ctvoFrlotaz8
         mJ0oJtUMxSztaSM9zkr6NaJTh3JjztnVc93+LvT/5C9+m1m6XhJhodfrkSXvlNLCFgSa
         OqYdu/BuAQGP19tMW+R15Pap9/FuXKNDn4kubOb8n5vcspMm43wq148qWO178xjbSDV2
         qNki7qVA69B0XzrGblz5nNvKg3tdGHl0+32JAo6U/QToFcPRzlMV+A3FowmL6QPmXQG3
         Zk0U0hjN/wGEm9y2W1MwAUKDJ002LTEmnC8kRuo6Vb/Rdh6bt8e695rfPVWi3d6/jFWG
         7XRQ==
X-Forwarded-Encrypted: i=1; AFNElJ/BwlJxLQwjL0jI2za99r5fx06LNOOtZhEJFFE54rtBrcSi4WH4Qa1uPaO3oMP0sF+OyP4P7NnDWhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuESSYnuAH31kKWbLEcLf+7fheXOBab1MY2w60tNOhwTzVFDzN
	sPSMHeMNga2xDd7c1t6lX3fjfAqfu9v3NeQ0faRYxiRsAWRjT33bCi30+TldEwApZR0=
X-Gm-Gg: Acq92OEI6w25q5WA3DlbC6jHdXd3UD5RAkKvvhbsFbgFeIpDVIreI2s2w/0cX4Zbhh7
	Dg33qKkAL+nSUq572u2nLFuRBDXg6X7wsFDT4G4prByKsmkkuPBpPl38ZDvn5rEC7nWScnp8+Rn
	Bdoz3fCMWJPMqpu6fEvM7huVAb+RYgtTYqKzEgB70f0FhmNIYxM4giaSebYFgflwmkr1WIN7ge5
	JaAJNipe7ykR0Px3F2aXrReb3QEs2cEk7D+Rs1duDrXQ8CWxFZV/LbMo0G1tYPSDDSYkg0ExC65
	A/Ie+Z75AADbTGo5dd12mXchoT06tlc1XljXBaM2/TVcrG3HfkQAfJQ70CKJXQGLFTaVS4gm6+3
	hY+2himF8GuijzFi60n6YmVER7GKxYR/QAR7fwYMnbWcMcnVmKi9vudm77ME4LamZ+nkfLxJP58
	y2NmmYXz2vJKcBfn1Bv2dg+d1moTbV/COvKcTRa0FW+yExhzI/Ap4/++I+jODpVLk3xqyT9sknj
	gpgPQ==
X-Received: by 2002:a05:651c:890:b0:396:7fd1:f574 with SMTP id 38308e7fff4ca-3992b03d73emr2255821fa.3.1781250808762;
        Fri, 12 Jun 2026 00:53:28 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39929f1891asm4038351fa.21.2026.06.12.00.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 00:53:27 -0700 (PDT)
Message-ID: <a63182bf-ba40-414b-a630-511e97938529@linaro.org>
Date: Fri, 12 Jun 2026 10:53:26 +0300
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] dt-bindings: media: qcom: Add Shikra CAMSS
 compatible
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
 <20260608-shikra-camss-review-v2-1-ca1936bf1219@oss.qualcomm.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20260608-shikra-camss-review-v2-1-ca1936bf1219@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/8/26 17:06, Nihal Kumar Gupta wrote:
> Shikra contains the same Camera Subsystem IP as QCM2290. Document the
> platform-specific compatible string, using qcom,qcm2290-camss as
> fallback.
> 
> Unlike QCM2290, Shikra omits the CDM and OPE blocks, requiring only a
> single IOMMU context bank instead of four.
> 
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> ---
>   .../devicetree/bindings/media/qcom,qcm2290-camss.yaml    | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,qcm2290-camss.yaml b/Documentation/devicetree/bindings/media/qcom,qcm2290-camss.yaml
> index 391d0f6f67ef5fdfea31dd3683477561516b1556..4f39eefb4898ebc22117407f26cfb4f41deb111b 100644
> --- a/Documentation/devicetree/bindings/media/qcom,qcm2290-camss.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,qcm2290-camss.yaml
> @@ -14,8 +14,11 @@ description:
>   
>   properties:
>     compatible:
> -    const: qcom,qcm2290-camss
> -
> +    oneOf:
> +      - items:
> +          - const: qcom,shikra-camss
> +          - const: qcom,qcm2290-camss
> +      - const: qcom,qcm2290-camss
>     reg:
>       maxItems: 9
>   
> @@ -76,7 +79,14 @@ properties:
>         - const: sf_mnoc
>   
>     iommus:
> -    maxItems: 4
> +    oneOf:
> +      - items:
> +          - description: S1 HLOS VFE non-protected (VFE only)
> +      - items:
> +          - description: S1 HLOS VFE non-protected
> +          - description: S1 HLOS CDM non-protected
> +          - description: S1 HLOS OPE read non-protected
> +          - description: S1 HLOS OPE write non-protected
>   
>     power-domains:
>       items:
> 

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

-- 
Best wishes,
Vladimir
