Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944914562A2
	for <linux-i2c@vger.kernel.org>; Wed, 19 Aug 2026 11:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787139066; cv=none; b=EtYSxKKGb7JMHfM2GIGVH89uxwy9nm5eJMkhAAtFXHvD1h2zYeVlBRxQ5T1ChbA94h2GlMINfs8qer87xGmnvyXY4K/rxh8rJrXq2GK+EuZxXUl9cqOPvOVcv7YO4StpZoRMEHKJTZpprgst5Y3ELgn3M2HOEMtmg3qXymF5YQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787139066; c=relaxed/simple;
	bh=YC4kv0mlBE5ejNUrExyi/i9U/g2lwOB5BzNaXOmP2RI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QGkdLSDguei8U6z7wUlC5kt4oZtyGeuQGlOYNL8vDKJIZq9yPhzlCUCcBSfJPwhLEETNmenc0OHA4RJRVgG092ZH67KqmWO/Tjlvqew+WkgU4xMmFb5ygiUS2khhsHd9rZuN4/oYkGkqJiL3Q559I3DRjy4ZIWEKQGIc83v7QBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wTteJQ5v; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wTteJQ5v"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39c618799e4so320941fa.3
        for <linux-i2c@vger.kernel.org>; Wed, 19 Aug 2026 04:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787139059; x=1787743859; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BolECdduUrIxgwZ0Vyd9qyU6HedUFZB6bZAknj7R37o=;
        b=wTteJQ5vMfBEVMj7P7zID+bd7Y82oijrCiqhZbxa9Wzs/4xJd9mvpK1uTdDV7LtiLC
         Dh1M0TUrmtL86b0JqQa8wRLYnRn7MJYeZdgsn4cquCZGKdt4jUeSXCYy/BdyGl673p1E
         NdlST2VPAx4vXlHh7mZcu9ZRb2PSEITgrO/iNhYXGxajITH3ISIh4c9LfdjC2Fi9K8om
         eFFFkAgFE3anRUt+LdOJvIlS+bMrRSui4nT+ZjW9wWJYH67Oboa7OgqgeXJ4Cv2zjTiJ
         5yd2gwDd30Lm8w7nKNo5nq+fM6D/X6GYzw0wpTjbrvAFeEznKnaszwvij0bkbxbxfL7y
         jUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787139059; x=1787743859;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BolECdduUrIxgwZ0Vyd9qyU6HedUFZB6bZAknj7R37o=;
        b=pmH66xQICcJ3ezu8zJ6eS2TeeMgxqajTOggZ6l/Oy14isv9TYaOABEX6tNUTFQvs/0
         2dnEXroytJ3d9JGYY5yJlv8/rD+WTDppAotT7T1/T+bCf1XEofKaLLpTi6zbbSxB0IuZ
         LNTpO38B3Jw8gHsR6bsxUd+sDo95UQcGgY+xS+b9Cm5303fkjl45PU0pTM5BcZJ06jBs
         8JMUpf2j5xNz4MAh9hfTHRt3zAQIyhfbxJCB05XW4ok8Iv9LAHQ0KwA8xdRPpNU2If6Z
         20KT16iuw+xmOrl7lY3Ud453LcyjBaWpCMmGn9p9T0ThKc5eLpbOWPRuXhj6CD5opZgG
         jnWw==
X-Gm-Message-State: AOJu0YxV03IpYkjQJTk5ZoxAj8/lpK59VzdSFLL6Vgju+FPZGXKA0KTE
	XrF0uWZeSEJ/YkTH/Jj8egElbuLh/iMES8gL+34dMBj06vGTs3g4T+Ahyy9NDWYzAYQ=
X-Gm-Gg: AR+sD128xFMLn4F/BQu3r+Hto92/7mIJspmfYyaM8nedUvt0I+1EXEn7CN8IYQpCaSZ
	jrF9D0Kqskg0WWKYs4IZYSc9LsHOhgRp9lmEOJiNCQnPKoDcFznHkRCqEZ7EIAwHjgUMx63ZQA5
	MFLrEmfCzxUqQC9SDHEp+mYzq+VtZCUq2654yMeRBMWKW3n2GACnYbkwQIvS0tlyQGmXlo9xsLQ
	vTWAgWa+84waONqMlv8E86As0k8bwu9NPEhG7BSUMFXYCxAttyrC33tbN3l1163H4CS5lDVdoRX
	KbmU+9dPtHogmK97KKKUz3gblHCoNwlSuc+0N0v+092B47KaC/OC2TT5u2C/JFeWtC0Vnf3S6e4
	IuaeeEneuCkvVu8jVbgf5VAUrAd3E6u+0stvteaqIPVvzXWNJ6gsV/IopsOOE3aL+SpvJkpT0ir
	eTFlwMgtCXMPL/xu26uY4uEFtQNIZAItm9Gf54R3+1J4bCU3iFP9RAFac+MWUk6VOPpBB7RmAux
	KVzxmzNrqW3AoprgizLpzPYE4M9eZsETCF2T4oq1g==
X-Received: by 2002:a2e:bc81:0:b0:396:92eb:36a0 with SMTP id 38308e7fff4ca-3a1894462b6mr6229581fa.0.1787139058902;
        Wed, 19 Aug 2026 04:30:58 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a189dfc18dsm4502421fa.22.2026.08.19.04.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 04:30:49 -0700 (PDT)
Message-ID: <8af313a1-5f7f-431f-91f6-9e22119d456b@linaro.org>
Date: Wed, 19 Aug 2026 14:30:48 +0300
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] i2c: qcom-cci: Share the timing table across CCI
 revisions
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Luca Weiss <luca@lucaweiss.eu>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, konradybcio@kernel.org,
 stephan.gerhold@linaro.org
References: <20260801-cci-clk-fix-v4-0-e1d80da54e01@oss.qualcomm.com>
 <20260801-cci-clk-fix-v4-4-e1d80da54e01@oss.qualcomm.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20260801-cci-clk-fix-v4-4-e1d80da54e01@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/26 23:10, Loic Poulain wrote:
> The hw_params timing values only depend on the CCI clock rate and the
> I2C mode, not on the hardware revision: every per-variant table used
> identical values for a given [rate][mode]. Only the set of supported
> modes differs between revisions.
> 
> Move the timings into a single shared cci_hw_params[rate][mode] table
> and describe each variant's highest supported mode in cci_data with
> max_mode instead of duplicating the timing values. This removes the
> per-variant timing tables without any functional change.
> 
> Suggested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>   drivers/i2c/busses/i2c-qcom-cci.c | 181 +++++++++++++++-----------------------
>   1 file changed, 70 insertions(+), 111 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
> index b6fa37a306758ec33ede6fcc39ce4412b86d9a84..21695c744502f7fb5d333f1272f3771e4d9d5508 100644
> --- a/drivers/i2c/busses/i2c-qcom-cci.c
> +++ b/drivers/i2c/busses/i2c-qcom-cci.c
> @@ -124,7 +124,8 @@ struct cci_data {
>   	unsigned int num_masters;
>   	struct i2c_adapter_quirks quirks;
>   	u16 queue_size[NUM_QUEUES];
> -	struct hw_params params[NUM_CCI_CLK_RATES][NUM_I2C_MODES];
> +	/* Highest I2C mode supported by this variant. */
> +	u8 max_mode;
>   };
>   
>   struct cci {
> @@ -249,13 +250,76 @@ static int cci_clk_rate_idx(unsigned long rate)
>   	return -EINVAL;
>   }
>   
> +static const struct hw_params cci_hw_params[NUM_CCI_CLK_RATES][NUM_I2C_MODES] = {
> +	[CCI_CLK_RATE_19_2MHZ][I2C_MODE_STANDARD] = {
> +		.thigh = 78,
> +		.tlow = 114,
> +		.tsu_sto = 28,
> +		.tsu_sta = 28,
> +		.thd_dat = 10,
> +		.thd_sta = 77,
> +		.tbuf = 118,
> +		.scl_stretch_en = 0,
> +		.trdhld = 6,
> +		.tsp = 1
> +	},
> +	[CCI_CLK_RATE_19_2MHZ][I2C_MODE_FAST] = {
> +		.thigh = 20,
> +		.tlow = 28,
> +		.tsu_sto = 21,
> +		.tsu_sta = 21,
> +		.thd_dat = 13,
> +		.thd_sta = 18,
> +		.tbuf = 32,
> +		.scl_stretch_en = 0,
> +		.trdhld = 6,
> +		.tsp = 3
> +	},
> +	[CCI_CLK_RATE_37_5MHZ][I2C_MODE_STANDARD] = {
> +		.thigh = 201,
> +		.tlow = 174,
> +		.tsu_sto = 204,
> +		.tsu_sta = 231,
> +		.thd_dat = 22,
> +		.thd_sta = 162,
> +		.tbuf = 227,
> +		.scl_stretch_en = 0,
> +		.trdhld = 6,
> +		.tsp = 3
> +	},
> +	[CCI_CLK_RATE_37_5MHZ][I2C_MODE_FAST] = {
> +		.thigh = 38,
> +		.tlow = 56,
> +		.tsu_sto = 40,
> +		.tsu_sta = 40,
> +		.thd_dat = 22,
> +		.thd_sta = 35,
> +		.tbuf = 62,
> +		.scl_stretch_en = 0,
> +		.trdhld = 6,
> +		.tsp = 3
> +	},
> +	[CCI_CLK_RATE_37_5MHZ][I2C_MODE_FAST_PLUS] = {
> +		.thigh = 16,
> +		.tlow = 22,
> +		.tsu_sto = 17,
> +		.tsu_sta = 18,
> +		.thd_dat = 16,
> +		.thd_sta = 15,
> +		.tbuf = 24,
> +		.scl_stretch_en = 0,
> +		.trdhld = 3,
> +		.tsp = 3
> +	},
> +};
> +
>   static const struct hw_params *cci_get_hw_params(struct cci *cci, int mode)
>   {
>   	unsigned long rate = clk_get_rate(cci->cci_clk);
>   	int ri = cci_clk_rate_idx(rate);
>   
> -	if (ri >= 0 && cci->data->params[ri][mode].thigh)
> -		return &cci->data->params[ri][mode];
> +	if (ri >= 0 && mode <= cci->data->max_mode && cci_hw_params[ri][mode].thigh)

This earlier introduced sanity check for non-zero 'cci_hw_params[ri][mode].thigh'
is not needed anymore, right?

> +		return &cci_hw_params[ri][mode];
>   
>   	return NULL;
>   }
> @@ -696,30 +760,7 @@ static const struct cci_data cci_v1_data = {
>   		.max_write_len = 10,
>   		.max_read_len = 12,
>   	},
> -	.params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_STANDARD] = {
> -		.thigh = 78,
> -		.tlow = 114,
> -		.tsu_sto = 28,
> -		.tsu_sta = 28,
> -		.thd_dat = 10,
> -		.thd_sta = 77,
> -		.tbuf = 118,
> -		.scl_stretch_en = 0,
> -		.trdhld = 6,
> -		.tsp = 1
> -	},
> -	.params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_FAST] = {
> -		.thigh = 20,
> -		.tlow = 28,
> -		.tsu_sto = 21,
> -		.tsu_sta = 21,
> -		.thd_dat = 13,
> -		.thd_sta = 18,
> -		.tbuf = 32,
> -		.scl_stretch_en = 0,
> -		.trdhld = 6,
> -		.tsp = 3
> -	},
> +	.max_mode = I2C_MODE_FAST,
>   };
>   
>   static const struct cci_data cci_v1_5_data = {
> @@ -729,30 +770,7 @@ static const struct cci_data cci_v1_5_data = {
>   		.max_write_len = 10,
>   		.max_read_len = 12,
>   	},
> -	.params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_STANDARD] = {
> -		.thigh = 78,
> -		.tlow = 114,
> -		.tsu_sto = 28,
> -		.tsu_sta = 28,
> -		.thd_dat = 10,
> -		.thd_sta = 77,
> -		.tbuf = 118,
> -		.scl_stretch_en = 0,
> -		.trdhld = 6,
> -		.tsp = 1
> -	},
> -	.params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_FAST] = {
> -		.thigh = 20,
> -		.tlow = 28,
> -		.tsu_sto = 21,
> -		.tsu_sta = 21,
> -		.thd_dat = 13,
> -		.thd_sta = 18,
> -		.tbuf = 32,
> -		.scl_stretch_en = 0,
> -		.trdhld = 6,
> -		.tsp = 3
> -	},
> +	.max_mode = I2C_MODE_FAST,
>   };
>   
>   static const struct cci_data cci_v2_data = {
> @@ -762,66 +780,7 @@ static const struct cci_data cci_v2_data = {
>   		.max_write_len = 11,
>   		.max_read_len = 12,
>   	},
> -	.params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_STANDARD] = {
> -		.thigh = 78,
> -		.tlow = 114,
> -		.tsu_sto = 28,
> -		.tsu_sta = 28,
> -		.thd_dat = 10,
> -		.thd_sta = 77,
> -		.tbuf = 118,
> -		.scl_stretch_en = 0,
> -		.trdhld = 6,
> -		.tsp = 1
> -	},
> -	.params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_FAST] = {
> -		.thigh = 20,
> -		.tlow = 28,
> -		.tsu_sto = 21,
> -		.tsu_sta = 21,
> -		.thd_dat = 13,
> -		.thd_sta = 18,
> -		.tbuf = 32,
> -		.scl_stretch_en = 0,
> -		.trdhld = 6,
> -		.tsp = 3
> -	},
> -	.params[CCI_CLK_RATE_37_5MHZ][I2C_MODE_STANDARD] = {
> -		.thigh = 201,
> -		.tlow = 174,
> -		.tsu_sto = 204,
> -		.tsu_sta = 231,
> -		.thd_dat = 22,
> -		.thd_sta = 162,
> -		.tbuf = 227,
> -		.scl_stretch_en = 0,
> -		.trdhld = 6,
> -		.tsp = 3
> -	},
> -	.params[CCI_CLK_RATE_37_5MHZ][I2C_MODE_FAST] = {
> -		.thigh = 38,
> -		.tlow = 56,
> -		.tsu_sto = 40,
> -		.tsu_sta = 40,
> -		.thd_dat = 22,
> -		.thd_sta = 35,
> -		.tbuf = 62,
> -		.scl_stretch_en = 0,
> -		.trdhld = 6,
> -		.tsp = 3
> -	},
> -	.params[CCI_CLK_RATE_37_5MHZ][I2C_MODE_FAST_PLUS] = {
> -		.thigh = 16,
> -		.tlow = 22,
> -		.tsu_sto = 17,
> -		.tsu_sta = 18,
> -		.thd_dat = 16,
> -		.thd_sta = 15,
> -		.tbuf = 24,
> -		.scl_stretch_en = 0,
> -		.trdhld = 3,
> -		.tsp = 3
> -	},
> +	.max_mode = I2C_MODE_FAST_PLUS,
>   };
>   
>   static const struct of_device_id cci_dt_match[] = {
> 

-- 
Best wishes,
Vladimir
