Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A0333A9D1
	for <linux-i2c@vger.kernel.org>; Tue, 28 Jul 2026 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254285; cv=none; b=oSSrMtklHjHDVwKp+dnzPHG/YwpAvSHpG9Z8XAmheESOVgxDe3bVBXIn3qJly9UcMuMZq3wCGLoNEZBIrAIIo+IJFxdux3szAf4Cnn0HUGGshgUsG+YB/Czcnz5WY/s4VQ+IhAEutcPVWM+EfRJ4ipwtz83BdvNSWphSfWOK/Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254285; c=relaxed/simple;
	bh=wzrSebO+w9w3kBvI6MwAzB5vFBayEMq0YCoanNZiL5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgZZu8cw3Yetn5azUSPrw1SUseNsRb7SO9E3RwPDM6CHkYRHoMOio8yHtUItarprmFaRSjfn5F8VBFVILn+tsz7pU8MWxanuOc8MXhHjQkbzcWWsurMvbngpp6DPdFowv0GwFp+zzA+4EjL4GTwsRS9BEoX4dhSKNF0bR/aJak4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EQll9DjO; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EQll9DjO"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b2960ea2fbso386517e87.3
        for <linux-i2c@vger.kernel.org>; Tue, 28 Jul 2026 08:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785254281; x=1785859081; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BoQDMsK71P8WdtwDto5BJ9mnOWyzEPnr5SRIuRHG/wE=;
        b=EQll9DjOmX0bLFvEzRKdIaMcEG1NvO0XhJjnUEpJNoOJsPq0x2ke/Kp0HM9EYRe1E/
         lViPQJtf7h+aDPCftN39sYmWMkMdaEzUsKJY0yBDgTg1EXTDcqQxxNxRHszMMAe/PZWE
         iK5b+HBqOHFLjDx/iPBKooyOkWpL67+pI5WfInnJ53KGMkr6C7sU5o4WtEKshWe6txX5
         kdzZhCwlDfNVCogYp4f2CwIBw4QiqnwKXCiyrY35a426X0+/Dbiwu0iUVQNjwvpqP3Ma
         hoqQ+H3k4ScFZn855pFJJq2U7VOPVcg89KYGVANOl406W1Ava6FfslRP767NDF4ViBcc
         z5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785254281; x=1785859081;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BoQDMsK71P8WdtwDto5BJ9mnOWyzEPnr5SRIuRHG/wE=;
        b=Iwfp51XN4IXypZLb9/m/vre8Ian2pq93Owjcc2/Cnj2ygzi0Qv5M4WwlzwFECu8ZIM
         RGQU1PpFYwQyFoE1y/vrK3zNb7nReVx/btqR7gvVAUCKlIjuNm5UCo633h6AUZrKF7Ym
         X5VDP1iZzq2zfsfhhdS4o6bkO6AJIdbnmHFSYBCAlFxI1CTFc43RYgm9B1g3wgt2kM9e
         PjOEQwP4KIPd209/RilPTGTR5glLTp8Epg7BHtAYh57nIB5zhERZ2gJl2QuML/XwyDxU
         hXaKve6FIj1VAplHUIk6juTjVH4G29Jiidnh3w2YHIC+vc9hfQDM8FQdafzDYi68XRWh
         DX9Q==
X-Gm-Message-State: AOJu0Yz54W+qIxZ6z+IMIWQo0S7hRp3v9pt7q+IVLppvF3f0/SXdDeqD
	iMiPbbcQtXiflGTl94foLlX3eB95zzI6uYLobhGLulSRWFzKmxsX4e7GyiOJFWEqxa8=
X-Gm-Gg: AR+sD13PoBXWASu5DUEThbUdV+XU07gGp9rsoPx1rA5YM3vbMiIQ0HMC8la4Gtj1VD3
	37Rbm0QywgnD5fG6VA4x50RsytoEDxEochk6zTs5GB2IKFCC4Bm8WENVMPVleR6BHxgu76/bvX8
	DZ6GqMebqGCZN71WW8ReeIGXsrIEfSJUFiFO8Q3s3XGSBs8slpTWxlN/nPOHVaEuh7T8rY5Hfy9
	KAhjTgCsM7eTOm5lXQc0rTSY/2iTL08jsKZC16mxwYuez8ZLUi+E/0d/SCJ3Qx+R0KJRTxTI3D/
	frcGzFNRlHe+4wMkJuuTdBfAwiGpxvgRliGVSPL77KMbE0NXHq/T0576LYioMuyv/npOv4ktxbz
	LP1XwpE00iOfdSquoBe5vXTgflu1/gBIqOf/6bnwzCH+bSqU3DY7wY15zhv27RayzxDKcxpgtob
	cx+xaUj0gs1HuPkzi4tFni5E3fu9+Lt1z8RVSR8V8UKDQeuECUHc9YoHIw
X-Received: by 2002:a05:651c:1504:b0:39b:302f:feb3 with SMTP id 38308e7fff4ca-39f51eaf43amr3268711fa.5.1785254280452;
        Tue, 28 Jul 2026 08:58:00 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39f2226c208sm19436771fa.41.2026.07.28.08.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 08:57:59 -0700 (PDT)
Message-ID: <9fc0577e-ce2a-43fe-85ac-e382e930d5da@linaro.org>
Date: Tue, 28 Jul 2026 18:57:59 +0300
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] i2c: qcom-cci: Fix CCI clock rate enforcement
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Luca Weiss <luca@lucaweiss.eu>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260727-cci-clk-fix-v2-0-c3958f28b045@oss.qualcomm.com>
 <20260727-cci-clk-fix-v2-3-c3958f28b045@oss.qualcomm.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20260727-cci-clk-fix-v2-3-c3958f28b045@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Loic.

On 7/27/26 12:21, Loic Poulain wrote:
> The hw_params timing values (thigh, tlow, etc.) are in CCI clock ticks
> and were calibrated for a specific clock rate per hardware variant. If
> the clock is running at a different rate the I2C timings will be wrong,
> potentially violating the I2C specification.
> 
> Rather than just warning about a mismatch like before, actively set
> the clock to the expected rate, using the OPP framework so that boards
> which (will) describe an opp table also get the required power-domain and
> regulator votes for that rate. The OPP table is optional, boards without
> one simply fall back to a plain clk_set_rate() behavior, so existing DTs
> keep working.
> 

Can you please share any deficiencies you see, if a regular mechanism
of 'assigned-clock-rates' is used in dt descriptions instead of setting
a supported clock rate from the driver? Or is opps mechanism supposed to
substitute it?

For instance qcom,i2c-cci.yaml example uses 'assigned-clock-rates'
properly, in many .dtsi files (NB, but not all, which means for a number
of platforms CCI hw programming is done incorrectly today) CCI clock
rate is set this way.

It seems to be sufficient to get the clock rate in probe, compare it
against the supported clock rate associated with a wanted mode, return
-EOPNOTSUPP if there is no match.

To get a better idea of my proposal please check this simple commit:

* https://github.com/torvalds/linux/compare/master...vzapolskiy:linux-lpc32xx:cci-speed-modes

> Tested-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
> Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

-- 
Best wishes,
Vladimir
