Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAF13A451D
	for <linux-i2c@vger.kernel.org>; Thu, 25 Jun 2026 11:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782385648; cv=none; b=KTVqoPD/EPKaEJCBZPaAJqA2L/LcJJiBFgpqDpJgXnhFl4HMzQoCWkoSu8FEGGor6vi0KStKF38+mJow2Hzt91B/CIdyQxiD6+ODySKxtKnlAJorawQez4UXL+gMSeUotD8RYmy9LFPglprdaoHpRKwphRBUmiCcpN5NEuG0aZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782385648; c=relaxed/simple;
	bh=OKiJirBUH7iURKZcOXps9KVluu4PRaSUvtf5vVbZa+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7ks5yNqkZpkuEAhpIgVc8aTvc0Kb2RbWa2Dy7EFHM6GgzMZJ5v4Uf/Z1Skb/Svz2+OZlTAVlgWJ4fV6Sppin1CCSJ1bKI9QZXo82GANYveNFmnwvL7QsMVfZM5MPuYW3cOuxWcjaAerXFt31moaxDI96n0KGGSq11FlPfMUHH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n6e5b6T3; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n6e5b6T3"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5ad4d1fff66so229564e87.2
        for <linux-i2c@vger.kernel.org>; Thu, 25 Jun 2026 04:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1782385645; x=1782990445; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tkOZ1h3ApBi8l6jNjaETl2uI7tOXqY5UpxR2VkYETGc=;
        b=n6e5b6T3W/PeU6+El58ifHJtoGE3+3nE2CDey1kfyGhQ1psDqyvplu43U+Md/iPuom
         bPhyiSpxrbTAt66s9m4O+ER1uhW8iiqoumUySboM4m3kyeorBBmPTjVJJNiceS+Rt9ku
         A3x06MiHa3cuvGDKFtlfeHu9A/e9zfFGnCdEww21dNgrUtJ2BiUGIN/aQ8AJvk4965Tt
         LAcqm+QtUft3cmKmXzv0pljyfVXAJRkxWGa6tVqJD5GvI3/xmlunYWvY5r4rBouvJHTm
         26PsAGny26oyqk/b0VNhrojj0QsDMd89jwDU4MenhTQXD+C+OFZtsuyFHPR3wOu/4nqR
         ma/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782385645; x=1782990445;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tkOZ1h3ApBi8l6jNjaETl2uI7tOXqY5UpxR2VkYETGc=;
        b=p8BdcSU2cZz2uhxPdWQ4jxxDG295u7D2rw0/WPwy0mqXS5QIsmENqhnkVyLWQZXHkh
         A5Avye6J2UdMTN7okdpf75RAKFpqriqF0n4M4pv7cnt3dTNu8duH+zlz67z7/JTSI+8j
         7cZ/deOYRjWeIgJKyU/VSJirwYTeObyzTKZ8OE5IlnEaZT5zLl4pZFWf5wBjNDOM78UC
         Cv2saqZuR4pNfT7fLWTszWpQwu6a7o63XYzmHzR5y8V7rSVpXHpKOONraMWB4c7lSGJm
         5efVxOoApsCgkIfoN3rHpt/fN6ZyuVjbLctLYxTVskX8eAmt/UGzBPDQ65cOxCBdAQGr
         n7Pw==
X-Gm-Message-State: AOJu0YxBP0b0v4PVpNi9pY8wNt4IuI6Ibt6A5bnjFT9nEaWiLN3UL+8M
	8u3zZ7+0IuDqOky1HtbzbXIm+qbvkZndxu+tYMFBSSs8jh3S1WzCOD/aNyreoshGwII=
X-Gm-Gg: AfdE7cmC1Khg9qZZOVEZV3OIh1Xfan20Kn2AJ8kj8h2slThnZ+CDTSg8ZSK9Qh+irCT
	26XdjIEkl+FE8p2D8B94TneD8y+pcy67KiYqQGw4C4CWYBSKo8OflaSDAhyLlYVyY223LyJU1Vh
	1TogpGtLr3saW98bbwejabhnyHaDcI/XC08HND3YfetmkiUa1mFem3u68ANrmZsF9FX5mb2qp8i
	MQWe+Jxl7FuYlFBK3k7rKRX8svDFtzkNaaY+f+a1O9pG+W+WGJS6Ffiq4vdzvmAXeloZJ1Kqk0N
	sjdJGkJ3F7KyJIdey4gGmauXebeF1y63kWEN09xEFJ90OPq7y7EeD/6jgc5Ox7CR8oUDQyvD2/v
	ZtxU23TqkYmpiXm5qpCfKVnfS3CgygAkaS6gP00/Hz6sUjBwlRcxAP8z0Mq4aa17Q8ct3gWVwn4
	MNOvNX31biTCzQ89ouE8dp3Y+A+6yXUk3WdrNRli4V9oZFMEf7fLuP+NTB04tKFR7MHMU=
X-Received: by 2002:a05:6512:3f0f:b0:5ad:4c0f:644a with SMTP id 2adb3069b0e04-5aea237b169mr336418e87.8.1782385645209;
        Thu, 25 Jun 2026 04:07:25 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad69423d6asm2542956e87.0.2026.06.25.04.07.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 04:07:24 -0700 (PDT)
Message-ID: <bd782dc8-821f-456d-9659-a5ec9d601a2f@linaro.org>
Date: Thu, 25 Jun 2026 14:07:23 +0300
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qcom-cci: drop custom suspend/resume and rely on
 runtime PM helpers
To: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Wolfram Sang <wsa@kernel.org>,
 Todor Tomov <todor.too@gmail.com>, Vinod Koul <vkoul@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260625-cci-v1-1-a100cda673ce@oss.qualcomm.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20260625-cci-v1-1-a100cda673ce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/26 12:42, Wenmeng Liu wrote:
> cci_resume() unconditionally calls cci_resume_runtime() regardless of
> the runtime PM state.
> 
> If the device is already runtime-suspended before system suspend,
> the clock is re-enabled while runtime_status remains RPM_SUSPENDED.
> As a result, pm_request_autosuspend() does not arm the timer,
> leaving the clock permanently enabled.
> 
> Fixes: e517526195de ("i2c: Add Qualcomm CCI I2C driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
> ---
>   drivers/i2c/busses/i2c-qcom-cci.c | 18 +-----------------
>   1 file changed, 1 insertion(+), 17 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
> index 4d64895a9e9e4e0bd5e0ccb5c3cc04b282b1e4d5..bdeda3979c4814b5cdb463734b8361da7fffa879 100644
> --- a/drivers/i2c/busses/i2c-qcom-cci.c
> +++ b/drivers/i2c/busses/i2c-qcom-cci.c
> @@ -492,24 +492,8 @@ static int __maybe_unused cci_resume_runtime(struct device *dev)
>   	return 0;
>   }
>   
> -static int __maybe_unused cci_suspend(struct device *dev)
> -{
> -	if (!pm_runtime_suspended(dev))
> -		return cci_suspend_runtime(dev);
> -
> -	return 0;
> -}
> -
> -static int __maybe_unused cci_resume(struct device *dev)
> -{
> -	cci_resume_runtime(dev);
> -	pm_request_autosuspend(dev);
> -
> -	return 0;
> -}
> -
>   static const struct dev_pm_ops qcom_cci_pm = {
> -	SET_SYSTEM_SLEEP_PM_OPS(cci_suspend, cci_resume)
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
>   	SET_RUNTIME_PM_OPS(cci_suspend_runtime, cci_resume_runtime, NULL)
>   };
>   

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

-- 
Best wishes,
Vladimir
