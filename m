Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3433FDBEC
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066215; cv=none; b=FdD9j5ynhrEegLWbyW/70WG2G/XUJtam/WmLExDagxYGQZnz6jlxQCYmp2sxg2Z0F6orHzfAqyfyW+byHmhvT7opidimO7xj0YRYukG+KaB6Q3zh6miAKyfMGvijV4tt94Ef10KJ6Flkkc3Vboxv9DQ6fATA8KCMBmPWbZbn/2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066215; c=relaxed/simple;
	bh=eYKpuyW60WhNBvpKpM0dnVeiP02GhlW+x65D2kkVOS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d62ENYFEaEyviYe+adlZywOPBEOLbEEDWkSMRCSAlv443P7+KS5O1QByfV5FsYN2/SDY0QojGtqVCAKdoNGE4uZE7jzMLn+wcb+w3GLKrfnjzr3e359NKGfwWe6aFfBSXvjC2GA/uKEpxr3WG/i7l4LQYBw+yv/METAZvSA2gc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hfvaQ+kK; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hfvaQ+kK"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4909e3fa4b2so6505635e9.0
        for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 07:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780066209; x=1780671009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=998TnqsmogxF/r6nfGdlWjCmEBwKB7v3lBt+Tn4sLtI=;
        b=hfvaQ+kKPCS/jBYagSjCYJZJZD6hVRHs2eMM99y3616dNraowD1c1+cYpXSc1liAfL
         9edJhFRJ2a6ZtdwsH80ih7wBF8m86MuT1D3VDcsxf6wbtQzyfC1Iu4wNmOJ2uGw/acUi
         OH5TzLE83V9cDYRgkBBwrUEyD6MScdh5J1aeRAMa/yqhVUOXCevGpGZtD3BL98ELi89i
         ctSH+pjpSPQaRsXpoNMfxY87TpfWjcJsbJn1JXsZYcsraAwZ5soDaQRLc8VPjW67DPPo
         pcnvvbe3wdRfCL1U8+VU7tee57RMUe35HoZcSATUOqk+dfZfE8PimFat+CrkptspEClC
         LjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066209; x=1780671009;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=998TnqsmogxF/r6nfGdlWjCmEBwKB7v3lBt+Tn4sLtI=;
        b=Ws346dl8T9cVhTfoM4Og/UCV2vzFqzVcw+WTfTeekYKN+8/Vzjtevs4B06VK25ZZZr
         p/J4YVKp9bOhE4K6M7rFya/cRrMHjNe+VOgUJYkqxpJM/N8BV9mw40IQQ+KeOzcz+Hsk
         FUNl8dgh5BDuvM1WGtqFqR67NDsTuLOpft013mh8/CcDRskBByy8tcKBQ8ZMVAA/JPd4
         XFkUQ9JS60XYSXpCvhS91WokkqFhIAVc4m8Ww+T4er9haZjHly4srwAFmiVu5+dAweCx
         KKY2eHzuiI2dn7socMVtEu491eMkTGYCiDCgHQDtgKdXWsDZFrIVV8swsLdT2CWo+WIE
         gQiQ==
X-Forwarded-Encrypted: i=1; AFNElJ/lfjY+r3OPFUBdjfLzFZAcSAWsyJgfGYSBKrwTTEGXY9mQepd2je8Kuve0+zX/Q34mrnuKiqncG/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5I7x1GV38zKWznrSRWwVuLE+80SPChthLmsICvDEboedSdvoy
	KRfqEcVMJQyecV0CK1MYXjqueL2wC/lj9P7xk4PECiwLLm8Aldb0hFPuHLn7o3OR3+U=
X-Gm-Gg: Acq92OGMwssdtSbxowB1NccNiT9K/35UX1IR2II3dhpdBO2tjQDIjWE5cKtjCo+SNfL
	PprL/Sm+08eEnX5gdRvMGrbb+TukV9vkgL3sYJ7dPSF+Byowk8SW9iiUTqHNeJsuhwquHcLSihQ
	DfOC1LLDvngwUMUh9GOEsVh8TtFgXnfmCk9ZloJLWiROrdKLPUZBg+uqQ2GK87tTdj2rrtgqpTz
	dyA2jeEdrVuH483A2mvBSbprwtRME5Y2CiJR8cLaW0zS0g0MEeCT031QbU9Y2kXOktqeBq1LBeP
	rIBbBwRj6c6D3A0CSk51cH4MZ7ajb5uNjR2qf8va7RfwYh1aLAVmFNLcgtcAXFYlfbUXptISt2q
	Lo2zIWW5zCloIdVOxe7i6YUFI19d0QwwCef0VzM3kTcEnpoQdkZoLXuOiin3gGijiSiCb2Qpv3P
	Px5ENhHxSVgy+dZ39K+kmBzdpvZgOPSeTYSeyjGNL8Y4U=
X-Received: by 2002:a7b:c358:0:b0:490:53b0:9e53 with SMTP id 5b1f17b1804b1-4909c078feamr38969365e9.1.1780066209385;
        Fri, 29 May 2026 07:50:09 -0700 (PDT)
Received: from [192.168.0.101] ([64.43.33.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909ca6e124sm49040165e9.7.2026.05.29.07.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 07:50:08 -0700 (PDT)
Message-ID: <449651a8-18a5-40d2-bc68-59223dc8b69a@linaro.org>
Date: Fri, 29 May 2026 15:50:07 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] media: qcom: camss: enable vfe for Glymur
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
 <20260529-glymur_camss-v1-5-bee535396d22@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20260529-glymur_camss-v1-5-bee535396d22@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/05/2026 15:37, Vikram Sharma wrote:
> From: Prashant Shrotriya <pshrotri@qti.qualcomm.com>
> 
> Extend vfe_src_pad_code() and vfe_bpl_align() for Glymur.
> 
> Signed-off-by: Prashant Shrotriya <pshrotri@qti.qualcomm.com>
> Signed-off-by: Vikram Sharma <vikram.sharma@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/camss/camss-vfe.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
> index 319d19158988..baaecc22a716 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe.c
> @@ -353,6 +353,7 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
>   	case CAMSS_8550:
>   	case CAMSS_8650:
>   	case CAMSS_8775P:
> +	case CAMSS_GLYMUR:
>   	case CAMSS_X1E80100:
>   		switch (sink_code) {
>   		case MEDIA_BUS_FMT_YUYV8_1X16:
> @@ -2013,6 +2014,7 @@ static int vfe_bpl_align_rdi(struct vfe_device *vfe)
>   	case CAMSS_8550:
>   	case CAMSS_8650:
>   	case CAMSS_8775P:
> +	case CAMSS_GLYMUR:
>   	case CAMSS_X1E80100:
>   		ret = 16;
>   		break;
> 

This is a pointless enum add.

NAK.

---
bod
