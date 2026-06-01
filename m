Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1490038AC93
	for <linux-i2c@vger.kernel.org>; Mon,  1 Jun 2026 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780325928; cv=none; b=Ou+GjyPpIX8gwfhxSNDuzhv0kgJSv4tpKKYHBGqe0sdwC+GIHyjnzOMB3uLprYAOWR7uDaI4EtdvHylAbyphvidiBIXc16d1j9acHFkQYVfUpbK7QazkPVGC4qeCOKUy6+vaxDMRIbGYbVYUpT9eRTQ8dwgXe698NhiaVBKZ6zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780325928; c=relaxed/simple;
	bh=rqBnj7fgbdJlTrVFKmmoGA6nL2axLMyCnfR2JX+G2hA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R/x3TvAF63iEKSK3kGjG7VXp2oT2lBM+48L2Rao2z0LcMREso6lG01tG/Z991TCU3NtdX2iChEyJeDkIkq2eaERSxA3BxL/kVeJHs518mKX+goD/B+Uz77I3zbAbrKWhpd/1H4n0+/on49dmPCZjAcY+EKJgXGi8717aZ8snByM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uLSd/+xL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uLSd/+xL"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490686877a1so59929105e9.0
        for <linux-i2c@vger.kernel.org>; Mon, 01 Jun 2026 07:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780325925; x=1780930725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qq6eAfjOAZ4Lfq7LauQf4bjJ3RlF5Fcl+6rJ1tXLLa4=;
        b=uLSd/+xL4an32vfrEaURSqZ5jxrxDf+Je5BlMeEWRtFjYbPTxG3qwo2molySdmCNar
         ySHXibbXz8tiHssk9PIHOyolAOy7OU2eiCfdWIsZImKYw8tjwJsPOMkcYc5SW8psaEXM
         OQ75ak3pmVXlznsgExz+mhv6sxxqgnzcHHkLiWQuRzqvG2X/T/BpGPlMgvWlq8Arl3oe
         rMnHBO3SIkoLsLSTlVjsavPkJOH78fF/VYBvRQJGgLob1NulcMXFXTN9IRhw39sL7ucH
         KOROkYsY1v4+pI3CTdoUJcsn/pewlnaOYjs5MQsu/2ewKhZMzppKraLeS4Rw2U3N8LBf
         R8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780325925; x=1780930725;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qq6eAfjOAZ4Lfq7LauQf4bjJ3RlF5Fcl+6rJ1tXLLa4=;
        b=G3Nc07NI4/7Kt6Sh1ajtyw5jPPyLVp+qSLpz2Efc8g7C6Efhes+MYQ9grqieQI6UZI
         APwN2mij+bxdawjkIm6a/4h7R4r9zqxQ6pUJO48zbbVp4Fiii2BRzWoVzHx9+F4j8PiA
         FRttn+aKl2hqECwm8c9vUdmzZJN13i2ffKUlgdFA/9JkkrO1UCMKWwr0zFSl+Cgw6ytW
         KJd7PT+k7lfzDrFuXi58EDiqUJj1MDL06s4SNcLz6bm/o4ltNngouMtNnBCkZq0L5/fC
         8XfkT8DKIDK7QDDQiBMCuYga2faBWiWB4E1t8xFnL+4SFWaCu8O7oeYNN9zZtGnNb9tZ
         YqYg==
X-Forwarded-Encrypted: i=1; AFNElJ9iLtNUSb72d+aEaT5cZUlDVCVyVFc9bgVZfQDV5sVZoXDkSJ0bKqqKa/kVcEnisHdp3OopvXDjp0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKfnCIE1UtSdghTP56gs2Fqimvb+deKQr4KSbBE/mXxH6vBDtR
	t1OxI5j/CL1p7tQ9oyAykZaqdgyj/s8tb8me5pcWH3D7wKlw+o21D3xlOvBsQFsCKtU=
X-Gm-Gg: Acq92OGuZdE8BDpX/HuWrhKwf/CiRjlSv/xon+x/sUhlwAf+B+vbUabqjJd/ZaGx8St
	di9kLpHBuRHuTD3KSQSbKAqaX+lJSd5l3LcsW3k7Fj1bsTNsloehVVNokt1irK+cXPswqOSczzX
	C6Aa5h164vGcgQDTGRWzSuqP2mm3l0rLwOaqFuyNQ7SSuqaGJH9TnqN4fe+10ACLN7sQ8rEIvRW
	iI42eE2dbb+r4mFyfiQii/00M+SI6tsL8dEBquibcJWXZxtUyvI+iIXCqJ4QRWxd3I5oVBuL4Tn
	yBE8GWKxoeaturF28SfkVgR8K9DvDCf8LdALeLc/bTGoA3qM5PvRJYaWfgvzyEHSOKU5NrNyXmB
	rkQxdg0s0Jj4cctmW4C1+Q7lrWe0SmpQkFe5WjqcVJX/O3aT+acDswL0fLRjuuBV6MGOE1IiznL
	Qho9nthHTeYZtTbXKDoTIXQGpz7lvxGfd5oztGBZqSqtv4nw==
X-Received: by 2002:a05:600c:564a:b0:490:53b0:9e5a with SMTP id 5b1f17b1804b1-4909c11c15cmr174298335e9.5.1780325925446;
        Mon, 01 Jun 2026 07:58:45 -0700 (PDT)
Received: from [192.168.0.101] ([109.76.233.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef32fabcasm25172652f8f.0.2026.06.01.07.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 07:58:45 -0700 (PDT)
Message-ID: <2d7430bc-1bb5-47ff-95c7-c5c4d880cdf2@linaro.org>
Date: Mon, 1 Jun 2026 15:58:43 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] arm64: dts: qcom: shikra: Add CAMSS node
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
 Vikram Sharma <vikram.sharma@oss.qualcomm.com>, bod@kernel.org,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Suresh Vankadara <quic_svankada@quicinc.com>
References: <20260526-shikra-camss-review-v1-0-645d2c8c75a7@qti.qualcomm.com>
 <20260526-shikra-camss-review-v1-4-645d2c8c75a7@qti.qualcomm.com>
 <178000689150.4557.11759359941436928903.b4-reply@b4>
 <df00e8d8-21ab-415f-815e-608eb7ab0967@oss.qualcomm.com>
 <23d2a824-e894-4c26-8bd1-02bbb8a7c6d1@linaro.org>
 <f7403443-3c0c-45d2-8235-46c70883a296@oss.qualcomm.com>
 <203e09db-ba37-4d75-b984-227298f55d80@linaro.org>
 <CAFEp6-3prh88NTK5U1HAARmQr203LVcbW4hoo_zuK4Qof4BAzg@mail.gmail.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEp6-3prh88NTK5U1HAARmQr203LVcbW4hoo_zuK4Qof4BAzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/06/2026 15:27, Loic Poulain wrote:
>> Yes I think CDM should be a standalone block and BTW use standard DMA
>> APIs with its own IOMMU entry.
> Interesting, so CDM should be a dedicated subnode as well, and not
> part of the OPE?
> Then, If we want to use it from OPE at some point we would need some
> 'cdm' phandle in OPE node.

Your question makes me think again.

CAMSS:
- IFE/CDM
- IFE Lite/CDM

HFI/BPS/IPE
- BPS/CDM
- IPE/CDM

OPE:
- OPE/CDM

I believe those are the mappings of the various SIDs too.

Come to think of it there is every reason to model the CDM block as

cdm-ife0@ {
     iommus = <IFE0_SID>;
};

cdm-ope0@ {
     iommus = <etc>;
}

And then do use the dma engine API to shift data. I don't see why the 
IFE, OPE or BPS needs to map the IOMMUs and if you are using the BPS via 
HFI you'd simply leave the cdm-bps@ {} disabled in your dtsi anyway.

We should excise CDM IOMMUs unless/until we come to implement CDMs as 
standalone nodes.

I'm open to being corrected of course :)
---
bod
