Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003093B14D4
	for <linux-i2c@vger.kernel.org>; Tue,  9 Jun 2026 08:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995195; cv=none; b=gC477NxbKyjSaL0+cPsoQ2B+aytB5By6nU3/RjJRtk82mMT0k6qZVKCCflyiYeDHt5cv9217wBslbZOi3BW0W5XFkl6Kf+TqpLL9mk2zIEq7m2Dn38DtbZAIh4MMfnoZ3XUZchNA5sJWnP4K+qPA0C85G7REN6xG/Qpdy9Xmnqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995195; c=relaxed/simple;
	bh=hO/azaYVEfXjB6ij8N/yUOBnpCCFhFhBm81VvQU7s44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kPiujgxrEIbStESvI7emcS7hKvbFyl5GupSVeUS88JsReBjP8F5Ua+DjvLQLWtwNs1TO7B8r3s4UL2y+VlEvWL6SiQoA9zBMTIPDllNHh1G8kESJJT4GgmLRm6gAb3VaxdeHhNf1hJSRmbAMhH9tx7gD8jsX1NBVvJxMBRRm2XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mx46d0J6; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mx46d0J6"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6914a658115so4039270a12.0
        for <linux-i2c@vger.kernel.org>; Tue, 09 Jun 2026 01:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780995192; x=1781599992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N1J30wpRr/zoxFVY10vvN98wpm4s2FZR/qZwrLhfn4I=;
        b=mx46d0J6AJ1751fVgfKsmyRULlgl7ZNWXoFlySMWRtrYq40PeoQJ8t3EqHxIjJkQym
         JhypGRH/2mhfovyf5+N9xS51RqRX8r0dmvL0WQThPeoGD99mM9ovYoXgizAy7qLU8O8B
         NE1Q2hpv0YAqdfT69fZ3ktb6PQonoIGqH02R6f7asVB0ztJXjgLJMW/sQOTyqz+ruWBi
         xrei1vWRKf3pL2LJ7+Ysk/7H/TbXTXjSD/cGZFbZVTPkzIFMwhXx9h+QJaWZE5+acpbo
         OFT4UnCzFrXrAtjNX8rQL4hE6xU/ND2kifqmMRtkNvjYwAVECJ3aBf7kvWiG0T79abAl
         ttXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780995192; x=1781599992;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N1J30wpRr/zoxFVY10vvN98wpm4s2FZR/qZwrLhfn4I=;
        b=SCGybZz0AOsd5p4NuIgKBDGobwirXEsNHuKF5t5zpDjcS+VZjmRmx1J3PEtgddeJXv
         7VwiiZeVlnCwq2fBaeJJebV93fKLNU5HosLSmB1h8dAdNJqZC18WoilSeYhUHnklvrc9
         x8EoyQS/o54y7EU+UIox5iUNP4pbsn1w7fP7MocV9fupOXOKpjSTQNqLrbgmW1Ed2UAp
         R4LguTpgF0DjePhktbXWnuLxSieywgGnAdUQImBznv6hKE6NwHHD6Pg05U/lXlhUeRkG
         mfFkxDu39MUBVVbHXTYb4Dcdv9QuJyZD6Ye4Rvmmy6e6oHxAJvCax6T+5O7mLvqqGkjC
         LuFw==
X-Forwarded-Encrypted: i=1; AFNElJ+7ZUl6k508gyBzixrHQvudVGIGlIzKLMaoXibJIFr51/O18Vj50eDZ3sslTmYVxn14oXc3Lfvpbf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbAPajwU5My2F81PnuR9JQM+5EG7yDJQH49eKZ30KdnCU0q71A
	gvCkuGNbQzUzB4W9wSiQqigffsUVDnAw+ez2MpkhT2buXkAtui1WcEezCynjNMjkIsg=
X-Gm-Gg: Acq92OHtPbprgUbPMhgf5C6qwmVz989b5NSQ3wh0fuaq0oEWRmMAIJykwDpAu0ciCmP
	hLZcxSZW/9PZPJRsx9YzvtpQuv9QcDULsPuR12DczfWSA/ZagLn1WXzTkzFdj5nUIEtwiPUYWqq
	53fXhU9GvxaAulwNxZO92mpcRot1KZQI4pKPA/jDqRTg85cOKB9pNn415K2cjv5XiFMD3eGR96V
	34S0PIf7Mzx4tMEBOT1ZiWMyja2eK5K6x8amNyr9xqtTx/f2h6tEPkBS4Ho9dT76KFQHb3qqF3h
	rjjfkJ9rwAJouSOoDolEbQUrpswK3k39IE2DxSZDDcwrdJ788FCptyfBh2hwhVzC7nKAtarzrZ6
	Gk1Q0JW306roPEY5NrwV2nbCeJiNKAvgoW3N/z6aZ/n3eQL7GvajJOwMxP1SSvnAszIvweyZYAv
	PUOQ+4sAO9fdPz13pMwP2UjW2mglbQclaHX1TLidFBmWhO
X-Received: by 2002:a05:6402:4506:b0:68a:88cd:eb22 with SMTP id 4fb4d7f45d1cf-68fa535d734mr8754916a12.26.1780995192260;
        Tue, 09 Jun 2026 01:53:12 -0700 (PDT)
Received: from [192.168.0.167] ([109.77.72.26])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e6595c722sm8240110a12.22.2026.06.09.01.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 01:53:11 -0700 (PDT)
Message-ID: <11db2b96-975d-40df-b902-c1772f83a1fd@linaro.org>
Date: Tue, 9 Jun 2026 09:53:09 +0100
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
 <20260608-shikra-camss-review-v2-1-ca1936bf1219@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20260608-shikra-camss-review-v2-1-ca1936bf1219@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/06/2026 15:06, Nihal Kumar Gupta wrote:
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

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

---
bod
