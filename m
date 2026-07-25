Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C2B19D07A
	for <linux-i2c@vger.kernel.org>; Sat, 25 Jul 2026 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784989182; cv=none; b=mDSlMpqxwW7ENIBcm11JZTsopXP97oIaJjJ8lozHa/7cREPOhjTak866TyUjYLruBXd3cPgGy6powyE6ESAcklpJ7ZIaAin+SPpJLR51viqGwrf495rrm4Yzrh6RbjivJ1TMXmAQLI3xGRk1q+C2jYI59Et58sOQ2p9eSHw2SRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784989182; c=relaxed/simple;
	bh=cc2QAS7AmJQYin06oY3u5By9NlAK3ZC+dJCh52nbJew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GeVwpJGm9JcSSZ60/mHMuRAYIbq5bcyZcwnt0Z1ouWTsmp+kIJKJg4VEAkuB1OIJksN0Df3O06VRBDvktYaH/Y4IjFo55lvtSnxLV6rTcWohCd+lJy2996iI6sGkLSiZHyesuBi5uJ9VBcGPEzFfWjqOFds1GyE6rhXv92wdTp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J6kg0kRk; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J6kg0kRk"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aebe49b227so329345e87.2
        for <linux-i2c@vger.kernel.org>; Sat, 25 Jul 2026 07:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784989179; x=1785593979; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qakNqoswZBGD97uQf4jL75REPWcF8Z3ba+lxKiFGD+o=;
        b=J6kg0kRkqCAfKR2XsyG1orrnebZ0epfomLWj3K7iytlWCU1fWFWdCbtULd/qKFdPQh
         /qP0iRYPyFO1TGs+rA2E6d1bOEdWHY9mEER36zoq2Sl3IM3ZKhJzibsiW6+WEbms1TCW
         yRNUEOVjYD0KheNLovR+Ilmglv0KMctacpzGBwgf6pjJXcYIK/oKqDbvOaHhVm9z10FQ
         9c3dzSxVlr2ELk1JBXheVFqK+Pi18OneLUtPRdEoOybitAV3v5HGXJ9+3xFCHqM9qBkE
         /fJ4t+J2a9CU8oDwsglHUsdGAB7tzqqMXS3BIa6LiVEzxPZwocJdj9zmZReFK1q4MR76
         ZALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784989179; x=1785593979;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qakNqoswZBGD97uQf4jL75REPWcF8Z3ba+lxKiFGD+o=;
        b=KHB/BZ0yV3nGdlhOHmJAf5pMh2QKsyspH77sdBW2zKkggUNjEtZemQxa+YDRftmp4B
         HT/kr1bhjAWv7YLsqq1LRp2H/ULm2sB02r9uChRZKL/JgFhyh6PAHz/ZTOTQuIfgbXhC
         vhXKzqszkQeUgmGv9xlsbstGbKMqoGewLq+SyDIa5N6TmNV3+ROkmpO4IiqWZvNZCzmk
         dokAc7KOVYCa4T6I6VvZPvxt5J/nPAY+eG2zFxHkl2sYhDcnVjD14umdWqdyDJ/QCRUo
         Im757pquuUfcnRVd5oD+Dyk2cfjx396oacVODZflhTZX1okIiB48EqXxL58j/q5T64XV
         rdLw==
X-Forwarded-Encrypted: i=1; AHgh+RrMF1e1OH8swL9oCGmLCF9O01i4WdfLYYjMXyhuHHVhQy/AiU1HGDLPKHfiOUTEnI3sbk/VoNA8myw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ0j79LBoiFuQrdJbaNYE6BTqAuchz88CkwWkolV03bDS6Gs0I
	HM6NMeVJXiG1zQSYoldSn66224QxA3Fc3xLRze7WzUK2JvI1z0XBo5FdkPseQSL53QrCVKPq7+Y
	HFGvyb8w=
X-Gm-Gg: AR+sD13ARTqKagxRZKuoMvoseqGf8hFyGb9tibnB43FyLAPa/aSSJoyIgFZf4jRTQiD
	clej7+0M5FoaOHL+yhPsRl798W6x/pE92eGOi8NUI4KNJr94dzeaF6+1tOGOLr5V7SoJCgppX5O
	15LwaujQBhYLLBZhJmi9MBM6wzPiC5gL/Mol+uosIm1j8Kyq5gbGcr3waY5Iy+85Ry4Ot/uAaNe
	XRZIzvasLAvyCUm/TrGBLbSPmBtJh1cBuX1iPisVbbfME79muGvNz2VCcuXmVFaCQP4kCiiO3fv
	o7bgFx4xMjqiuxLz6vLWvcpMGrJ9XB0HAAGb7PvRiGpz6DoDQallhNxI3gCxErmGcdxVwGegyB7
	WtB8XQId3vaYMixkHhv2NA+oEVUCEC/7nd9Zo0igGdR+e2MHhb9KDY/C1UMnY7tOKf+ZdFFn03s
	vOMR3cRIMGIFWe4LdvJWk2T5z09w4VkOkpuqnrSYtm94YX8DNWst4B2KbQ
X-Received: by 2002:a2e:b8c2:0:b0:39c:74ef:1a87 with SMTP id 38308e7fff4ca-39f28776116mr2153271fa.2.1784989179110;
        Sat, 25 Jul 2026 07:19:39 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39f222364d9sm4354551fa.27.2026.07.25.07.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jul 2026 07:19:38 -0700 (PDT)
Message-ID: <1f64e023-e5f4-4620-a01f-1cd98faa4ca1@linaro.org>
Date: Sat, 25 Jul 2026 17:19:37 +0300
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] i2c: qcom-cci: Add missing cci_clk_rate for msm8953
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Luca Weiss <luca@lucaweiss.eu>, linux-i2c@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260721-cci-clk-fix-v1-0-5eae78700da8@oss.qualcomm.com>
 <20260721-cci-clk-fix-v1-2-5eae78700da8@oss.qualcomm.com>
 <8d20f3ab-696e-40a4-a05a-688779299071@linaro.org>
 <CAFEp6-3OKp0XhpNmp-yYwf4r16A=CD5eA-Ts1kk+mFjdCA38RQ@mail.gmail.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <CAFEp6-3OKp0XhpNmp-yYwf4r16A=CD5eA-Ts1kk+mFjdCA38RQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Loic,

On 7/25/26 16:06, Loic Poulain wrote:
> Hi Vladimir,
> 
> On Sat, Jul 25, 2026 at 10:36 AM Vladimir Zapolskiy
> <vladimir.zapolskiy@linaro.org> wrote:
>>
>> Hi Loic, Luca,
>>
>> On 7/21/26 17:58, Loic Poulain wrote:
>>> The msm8953 CCI data was added after cci_clk_rate was removed from the
>>> driver, so it never got a clock rate entry. The DT assigns 19.2 MHz to
>>> GCC_CAMSS_CCI_CLK and the hw_params values match those of v1/v1.5 which
>>> were also calibrated for 19.2 MHz.
>>>
>>> Fixes: d202341d9b0c ("i2c: qcom-cci: Add msm8953 compatible")
>>> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>>> ---
>>>    drivers/i2c/busses/i2c-qcom-cci.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
>>> index 19e4719f13b29b2cf60e113565b1b63f19d0e669..5f74edde8558382e63e2c3d0fbe19489f325e8ce 100644
>>> --- a/drivers/i2c/busses/i2c-qcom-cci.c
>>> +++ b/drivers/i2c/busses/i2c-qcom-cci.c
>>> @@ -783,6 +783,7 @@ static const struct cci_data cci_msm8953_data = {
>>>                .max_write_len = 11,
>>>                .max_read_len = 12,
>>>        },
>>> +     .cci_clk_rate = 19200000,
>>>        .params[I2C_MODE_STANDARD] = {
>>>                .thigh = 78,
>>>                .tlow = 114,
>>>
>>
>> this simple change is wrong, but commit d202341d9b0c ("i2c: qcom-cci: Add
>> msm8953 compatible") causes it, but please note that the commit d202341d9b0c
>> has no explicit issues per se (if proper frequencies are set in dt), but
>> this particular commit 2/3 breaks the whole picture.
>>
>> Let's see, MSM8953 I2C_MODE_STANDARD/I2C_MODE_FAST settings repeat the ones
>> for v1/v1.5 and 19.2MHz supply clock frequency, but I2C_MODE_FAST_PLUS
>> speed setting very close to v2 parameters and assumes 37.MHz supply clock
>> frequency.
> 
> Good catch, there's a real inconsistency in the table, and it's also
> why configuring the clock rate in DT independently of the timing table
> is fragile (and not even enforced by the bindings).
> 
>> So, at least one clock rate setting for all modes is invalid in this case.
>> Automatically it means the reverted commit 1/3 in the series does not
>> directly lead to the wanted and well-managed data, and the logic in 3/3
>> becomes invalid.
> 
> Agreed on the analysis. To be precise though, this doesn't make things
> worse than they already are upstream, msm8953.dtsi assigns 19.2 MHz,
> and the Standard/Fast rows are identical to v1/v1.5 (calibrated for
> 19.2 MHz), so those two modes are fine today. Only Fast+ is broken
> (without a DT change).
> 
>> I would suggest to grasp the statement above carefully, design a bit
>> better solution, meanwhile postpone applying any commits from the
>> series, especially if a breaking change holds a Fixes tag.
> 
> So if you agree? my short-term plan is submitting a V2 with a
> switching of msm8953 to the CCI v2 params table, so running the CCI
> clock at 37.5 MHz, which is what SDM630/MSM8996 already do (same HW
> version). Moreover 37.5 MHz is supported by the msm8953 CCI RCG, so
> this is a viable single rate that makes all three modes
> self-consistent.

please consider to add .cci_clk_rate property into 'struct hw_params',
since that is its proper and valid place, the rest of the logic can be
build similarly to this series, for instance. Basically that's why
1/3 revert change is not the right step towards a wanted data placement.

Next good (IMO) optimization/improvement might be to describe hardware
programming modes in their own list, and in v1/v1_5/v2/msm8953 cci_data
simply pick the wanted IP programming data up by an index parametrized
by mode speed/clock frequency/hardware revision.

> Longer term, clock scaling (probably OPP-based) could be an elegant
> improvement, but it's a bigger change, also CCI block's masters share
> one clock yet can run in different modes, the per-mode timing/rate
> can't be chosen independently per master.
> 

That's right.

-- 
Best wishes,
Vladimir
