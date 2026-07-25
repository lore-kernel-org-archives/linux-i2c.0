Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0B2239E7E
	for <linux-i2c@vger.kernel.org>; Sat, 25 Jul 2026 05:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784958096; cv=none; b=p++pvxStaMZVTt+d9MwOolLpkeviwkvAFH2tVuGJJzMehnvr1DVplJLt1L+gkBGg0VKIb+Sc3if4TN7Ew5Tv/MGIO2wyCfgjVCLVe+58YGwnm28nhVJUa8faj9Wxb0WKESJy4ERQ71mdOBk1ZGINtb6zQdP+z1CHjowaaHOP79Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784958096; c=relaxed/simple;
	bh=/RjlJI1tcU+fQgj2sW2Iofa6fH5Ee2zC3WdA1A2qVFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qCLHv+HAw4cGHosO8oLBopTBYiuW8kNltvpM0ijx9e+x1lM7P3KNZwF4OWab5P0jMWaw8LZC76CIb85G9xTvOvUhjNDEEX4xfiHD6hBYHpIiSncVVMgThyqhatB3tRAPYcRFkwD1JkBSi/Nu3gEkfoH2oxc0tcSdZetxFAboGjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FAUufZML; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FAUufZML"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aebf96bc89so173128e87.0
        for <linux-i2c@vger.kernel.org>; Fri, 24 Jul 2026 22:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784958092; x=1785562892; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=090uL/0+UckPvFSEk0Snf0xihVIwbpOzrvl2u/5Apcc=;
        b=FAUufZMLTDLvln9pl0TWcIQDgO5RxxfYh2ot6Su3DyAx3u8o4aYSleqjSe0RIAXHtv
         otJi8Y30uMMn3i+VXeKknf/4+dRIcN+kLCp9Ez6zb7qWwnduFfR7CyD1rruZq3qfuzrD
         aAdlx3bMnac0UcfEJqZoRajub9iidHzOoBPNOYNDPw5zGK9Fn/6VDbzy73EbYoIAYYXx
         ORRc1/1gKzAltIlC8xTdCs2aMEJlh6pvzQL5yAt/se4+VE88YuhEW8V8SkPQbIHrAQtc
         FV4pwaFLgwFh2PRke0/8o8iGga8w00O5B9rOGDqWMlMg5fbGNSV+KUSeoZKABy/bXyYs
         7TRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784958092; x=1785562892;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=090uL/0+UckPvFSEk0Snf0xihVIwbpOzrvl2u/5Apcc=;
        b=EKsg4q3IKiRsx0YoT0LekzQNk+DjVwdEzsY2mLXR52S+FKsppcbDxg5W3+CLBZ6sCR
         pt7i+3hGj+Cj79OZfXWxs30CvX3OUeoK+K/8a9xHhpnrp2rc+isiu4eoZN7BMHdRq3PS
         sR2/o9sa7Z9uLXjcgESsyWIlRHSDBnea2xmDvDfZq2UZHCzClGfJxOBX6dFNdFX0zUdA
         r6vbeb5gvB6y50jH3rVCOXRl3IrnAbx82ttlvIdmrrMUeecT/rZbHt8f3n7Wv+Ppg8lC
         x8uJB5OE84Lm5PJmHUMTzfv3M+1S8Ez59lQhfqFwPZ82zKAYaLTZsG5S9tNGBIjnFHpj
         FwXA==
X-Forwarded-Encrypted: i=1; AHgh+RqaJwIVsaBq2RcXyzLyXf3YKHGH93kC65p1wB+Io/P5tUSLAQztt1IVTsxz4GNNjs9jCAXDa73qAMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylh4KKxifGyqfk0DpaSTKlrTY7MjK9oI59t5NO7H1qxOSIjBp9
	MQtCw61yFqotRqqt647rNYo9xAe33Bvma6gMxdn+xQPH+R4YoesgsInEKgvYxrwi2OSLU+u82As
	dtx4/+sQ=
X-Gm-Gg: AR+sD10rdFn7qRIhfN+47iyHd9p4xMISHSBSYLifNpBNsqhfJBJNKkVow+CqBp9x1iI
	gOtXMgv932a+Uz1J3eDQHPtAwS8caGo7Au0fAi3EOs/XRhXfVN2OE/0FXaEKjJ34UkhaVcFLnjW
	iATt8gvv3/vCpin/2kut3PTNm6YcNe4juQt0+3FtbUj6yNEAFzn4JNS0TSkusbGB6DEv6nMedOD
	SuYNARtxka+AaxAxuLNCvxwtyDB7ErBJCecHJtWj3s8giWUCy2RcGMy/c/KkHXzh1tGfwjWny7u
	mqZDr/Up4ctP/OuhFrDEeD9juKNkUZ/qhfc411t5c25pbO2zBF0QkCpVtoVstvhNkF7SWXfXvS8
	yyJwpQAAUS1RSp2pdcIwB6bkN0cNGESyc58eTHet556p+vOFoAMd6t8ruXk6tUKbV4xNii3rW+6
	3lzjd6jAEUQggTqQR3f3NzY57Ds2rwyKLKBH0i57dWqP0vG+UOxjx9gQPK
X-Received: by 2002:a05:6512:1591:b0:5b1:5b9e:8de7 with SMTP id 2adb3069b0e04-5b2c1afdec6mr98432e87.2.1784958092471;
        Fri, 24 Jul 2026 22:41:32 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2be1d8b21sm253424e87.44.2026.07.24.22.41.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 22:41:31 -0700 (PDT)
Message-ID: <261a03cd-62f6-4ab8-956e-f5ae8969a978@linaro.org>
Date: Sat, 25 Jul 2026 08:41:30 +0300
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] Revert "i2c: qcom-cci: Remove unused struct member
 cci_clk_rate"
To: Andi Shyti <andi.shyti@kernel.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Robert Foss <rfoss@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Luca Weiss <luca@lucaweiss.eu>, linux-i2c@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260721-cci-clk-fix-v1-0-5eae78700da8@oss.qualcomm.com>
 <20260721-cci-clk-fix-v1-1-5eae78700da8@oss.qualcomm.com>
 <amPtXU_RkseFbpKm@zenone.zhora.eu>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <amPtXU_RkseFbpKm@zenone.zhora.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/26 01:57, Andi Shyti wrote:
> Hi Loic,
> 
> On Tue, Jul 21, 2026 at 04:58:19PM +0200, Loic Poulain wrote:
>> This reverts commit b641af684fc28a07bee9c808eb6c433f9d9bcec6.
>>
>> The cci_clk_rate field is needed to enforce the correct CCI clock rate
>> at probe time. The hw_params timing values are in clock ticks and were
>> calibrated for a specific frequency per hardware variant, so running at
>> the wrong rate would violate I2C timing specifications.
>>
>> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> 
> Does this revert need a Fixes tag? I haven't seen very often
> reverts with Fixes tag, but it makes sense if they need to be
> backported.

This revert commit does not need a Fixes tag, since there is no bug
fixed by the revert commit, I believe. But perhaps a series of commits
may need Fixes tags each, if the series is to be backported.

> I'm going to take patch 1 and 2 already while we discuss patch 3
> separately, but please let me know first if you agree adding the
> Fixes tag.
> 

-- 
Best wishes,
Vladimir
