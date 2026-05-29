Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E183F0A84
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067264; cv=none; b=CvPbYj+Pe58TBoFUa9zpBM5nEHJoqkRgv7DOZ8ieRwlda8KO4gfCU8EgfSq99hsFaTg8TPF3ieUPHf3qLiu20bPj1v9OVHlOU99htt7AOeAyGARW3ocm8fK30Ynl1JJQAooIUnowSCeq0DWMDhErop/zu6FYDINyQERjkIwXzok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067264; c=relaxed/simple;
	bh=tF43KjufwHIu80KkfJ7VV26iopIlq2XuutVp9qCHPRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GaRpkqCzoSTwocu/okrEo8DYUOr9wIfNaLZ8rnDktpWAVQbMejVdgs7w1/RH9KHBmNUb2f21R6QcW65oZKzygXItoPXbIHUlYUGHPXnM/dtNzDplKAQeLncdODqVPiGZIpXRt9X8eLJ+umOmxd/GytjBenBncG2taak81Gqp8TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wr9MG4XV; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wr9MG4XV"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so74405085e9.1
        for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 08:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780067260; x=1780672060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oMsYKu0rt98o4CUIj1PMUPtxut+9KNkzkjaeGCrAIPg=;
        b=Wr9MG4XVrb2AlEpJ2OuftCHDddxh00iA/NqJ0CsRzpHi/XPGFame3B5yHnl6IJeYPp
         HWCx0p1d6cp3GYZH5oUyta/eCJA/TaChfDViofKIwI4LrI1wlSCKzPA24Vd4d6c2lMKU
         ADxrfJXu8d4beDprcfkHcPEzkJr0LI92X/PbdIVnekcRK/u87aShycKNDOEgjoebYNt/
         P0G1yhuP5+OP1fLq3HNmvggckV+UNHmq1ASesLiaebrMeUuh79+gc1SHai1UaWngeqO+
         1JS3EgeCHzNnKrWy+VnqxUCdS9KtBnAetNWPMrYv9uVsblLvO3wRgwW2XXz/3avIFk1y
         vZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067260; x=1780672060;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oMsYKu0rt98o4CUIj1PMUPtxut+9KNkzkjaeGCrAIPg=;
        b=IOIsTM17+pfogqcIsqRsjsLeDM7cM6lwr0H1lgETXIk5iOraLc+j69efSdgIyQ99w4
         SIdCZJehEOhq+aUtA4fWkDb2FKcNOjVD+DJRAK+v9INF02AY4xf0N8Mqv0TEvmiMVRL2
         2vBTJkzGY8GcYcG/zza7CtH7WFGNtP0JgHAAq8Yfoia37fAK1yYsEWnwPER9XoXXM3iP
         7yRSuiCVxc+1cAa1t/rB+qidwdnzSLzp6Uq4Yo4nnQ4LhwXx3Ws0IcRwcFsx51vNGAfd
         ze2h4NxoPL8qelEuOvTIlcPo0NyZEtFTQVxWjgDos7DwjGMOKTybNFhKNGb8DwaUZ+yl
         sCMQ==
X-Forwarded-Encrypted: i=1; AFNElJ8SqPEyACgXSNmg+2z7YE0FqgZf9F4i/M1Zk47NSfJ3qCCRGlKkmAgaN0upRMUM9ESIoir81kqJTE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiqWdAuPJpahUvLijFLRryXjCu8ybFEakKRapyUoIaS8U8X73G
	aP1DVdCXKxJPUgQQGPK4+WgWoGVCSxhTQoXx28hOggLI8oGsCyHk02c+8Nw3eMHMkA0=
X-Gm-Gg: Acq92OG53prOwp3gRIThm7Ac8RU8BptvcmogUtjnCEQLyB29U59/JN1zfpr8aLaGoJP
	fgu+/EDx5X7v3VSJPHBaf74mkGoKMcFm1d2S7D3VbOYOCuFYB3kiMZJBqEACDNBaO8kSkxUqqq5
	+yretSOvl42Je0SvkMEWhCQEjw9Z6c76Oc+auhHv32l4rovN4sbEUccyP8L2tf3ihdlqvYS0KTr
	0GZkOlisxSEeW1u33RnNzZZaOqkbuRg5gwsxmUhv0IkfVFIBa82NhjjL2CK8vytb3zlfjsHH4ZM
	+GtTxJmT02qEotNUg/vdnOXTJtZUUaKVRMG9GZAnVH4MJM+rk5oo7aYmcILU5KqRWYC0cOwPLUK
	m2b9GI5wnpLPJJIEi9Q/3FfzZ2Kmp1cgYF2tuaZYDuWPmtMH27qz36DiNZllEDYOoW2BFq1Hu7X
	zSdPre7U5Qezw+RhPvIRZELfTXssgCYjIxvDMLfohBBnw=
X-Received: by 2002:a05:600c:a30f:b0:490:4b89:5372 with SMTP id 5b1f17b1804b1-4909c62603cmr38449265e9.11.1780067260267;
        Fri, 29 May 2026 08:07:40 -0700 (PDT)
Received: from [192.168.0.101] ([64.43.33.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34a04e2sm3789037f8f.1.2026.05.29.08.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 08:07:39 -0700 (PDT)
Message-ID: <8618255e-ecbf-4f55-877d-09cb2faa6f50@linaro.org>
Date: Fri, 29 May 2026 16:07:38 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: media: Add bindings for
 qcom,glymur-camss
To: Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-i2c@vger.kernel.org, Suresh Vankadara <svankada@qti.qualcomm.com>,
 Prashant Shrotriya <pshrotri@qti.qualcomm.com>
References: <20260529-glymur_camss-v1-0-bee535396d22@oss.qualcomm.com>
 <20260529-glymur_camss-v1-1-bee535396d22@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20260529-glymur_camss-v1-1-bee535396d22@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/05/2026 15:37, Vikram Sharma wrote:
> +
> +  vdd-csiphy-0p8-supply:
> +    description:
> +      Phandle to 0.8V regulator supply to CSI PHYs.
> +
> +  vdd-csiphy-1p2-supply:
> +    description:
> +      Phandle to a 1.2V regulator supply to CSI PHYs pll block.
> +

To be brutally honest, I'd rather see effort and buy-in from qcom 
engineers in converting to CSIPHY as a distinct sub-node.

Pushing patches to hit your own internal deadlines to the detriment of 
upstream quality is not OK.

This binding should be predicated on separate CSIPHY nodes. I've 
published... three perhaps four versions of that patch to radio silence 
on your side.

---
bod
