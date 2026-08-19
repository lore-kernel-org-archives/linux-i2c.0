Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D596F285060
	for <linux-i2c@vger.kernel.org>; Wed, 19 Aug 2026 11:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138680; cv=none; b=dsCRymAvhdwEO4ylkgNXwEWlTtX8nT329DWhFrQKqpS6TaOphIJPSWvJStGI64Uf+duVaQUBJ9Fo3hDIj5AOCZapsLvJ4AO43AmeZMpjSArMF9oVlezd/dnDFEtwvB00nk0VSG/rP4MX0D48rtdoWzY2wUekn/Z2HExRFr5TmzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138680; c=relaxed/simple;
	bh=1sfpKPZtvuWNFEL61LYlP3tOtYRbwIF+Shb3KbCktNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iY83hrjjXCysc9V974TT4jrWW8fiv5ne0DlPMWAK/efQON2kfYois8LVnMW8/HWENN+LTJ/aGMdgfERBzP+V3lgI4C5d9iSUb6qLtCHtok3NLyPf+6YJrrF7EsuI0NJQuzRu6lOcT0qnFbUIasa4zWQtjZpbKUUhrT7DzqiY1U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ORYr2HI7; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ORYr2HI7"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3a180d22eb2so385751fa.0
        for <linux-i2c@vger.kernel.org>; Wed, 19 Aug 2026 04:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787138677; x=1787743477; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0G6VuxN53FrfI+XH1oRu2wukNNPe2Cq3ouDUGXs612Y=;
        b=ORYr2HI7r5qnERzmAdANiTvSJY1JEi/I82OfFWkWZxwA3DepG3gHiUcPYgJTj2vUIT
         yzKJGjxIXdgvJ1NKIz1C5S4JsUTNX/PZ51EEscNZhFWmEo/RYuRci5ArIJy74EzMilp+
         rCwVQl2q13sMHH28Sl+YsIdZcM6BlP8JhfKwsXl40xLFvCqZgITGwsWIYEeddNCcmdAj
         xs2LTTL/mgpcg4CVmCSCPSjnseVETNiTv0kPFC5lI50dhHr4bqCW5aP83v8d2qJViJUS
         LDNyXcsOKQ7d3SZ1XurBUBH7jQcq2KbR1fHlTvN1X+vtXyjW04DKdnbpF9mT8rcxCZLT
         Y9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787138677; x=1787743477;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0G6VuxN53FrfI+XH1oRu2wukNNPe2Cq3ouDUGXs612Y=;
        b=atsHDi8RHkPx5R/GmmFIpOoGJ1NRRehTGdzswaAYkeme0z5cYfvf6W71oqlQIF0nNI
         RaN57YIgPrCpXBoaV1ELQzSNXPkUQOETaVWPFuAt1hYsV/6QXNiSYm/XtaL8yK4avlG+
         W0WQQQD09kaF8mS+H5nm1v0J9Plh+4bW2XblkJDm9Pf2GXN0UNeOjbJ0ZkdSNx35ZeTi
         QYhzmCJQavkolnh+SSNK5lhXk22N+5yNN01R0qfs8P7fkpsG/azSONMZwzWuL4zjBqOd
         8YAXKJlE5MU/AbGnDOFR4ARpAKI/7oIFL5Yx3mgxNTivd4bkcsQ5GEeetPSDWnEEZkUk
         MNng==
X-Gm-Message-State: AOJu0YwQOKzwky5DU4lJrXA9MHOr59HMvH/y0zpHGm1uoQBDOMBgD6rf
	PH4f9pMag7JmMwNovoXP1hDJMVSSpjBomF/0tlBX6f+Iis8LbQZC5kJD6vFkbzJO88w=
X-Gm-Gg: AR+sD11Q2Hh7sGVQBRdcibakhzZ9jBmhvAxaivimlhpKHpcN2g5jjfQUn2KmvN17gHx
	RjJCDymU8wz2DwqdtoZNr12INFv7wDTkQhCWzEimY7vYSOhnwh7qDZzwNTE7g9AxP41Q6aWB2w4
	IQo8m+/qxRlvthOqx7v74JwL/qWMtcq4KIQ7uHud7ukb8PH1pndqYBuBPRglQHJ/thdzEnf39Ys
	jfreVtZpNUdiT2uKkfZoFXx3koaPYUvQRpoja2ESnw4j4gbNzL9vnwgbyGk9h9TqNfEFKcoeldL
	ztz4VvdQ+hSticolLHU4JulK2DQs/DKrcpNRqB4OolMlDOTYmaoUMyLqScGOvmQnCIUe8XyzGdK
	v1vqnMznTWRBMfivPWTYdp2IKYICYTC1AGy+tUVtngRFarONERktLNN2XOD7wzkvApUDrUMQlKy
	SAI4xrqwAWNOUuLqgEXRFynTWX4CFM+Yq2jgrqtth1j5UfKr8BrzAxnroNI2KHtSG/7oGCXXhFq
	FoFck1gQpxeFx0SViMQlyjW3Svho1dYGkUFTgQKWA==
X-Received: by 2002:a05:6512:68f:b0:5b4:59a3:c67 with SMTP id 2adb3069b0e04-5b478d15f12mr711510e87.3.1787138676767;
        Wed, 19 Aug 2026 04:24:36 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b4788dafd9sm452822e87.51.2026.08.19.04.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 04:24:36 -0700 (PDT)
Message-ID: <2d1760c2-f368-4d50-b341-f3febb40ccc2@linaro.org>
Date: Wed, 19 Aug 2026 14:24:35 +0300
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] i2c: qcom-cci: Support per-mode CCI clock rates
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Luca Weiss <luca@lucaweiss.eu>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, konradybcio@kernel.org,
 stephan.gerhold@linaro.org
References: <20260801-cci-clk-fix-v4-0-e1d80da54e01@oss.qualcomm.com>
 <20260801-cci-clk-fix-v4-2-e1d80da54e01@oss.qualcomm.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20260801-cci-clk-fix-v4-2-e1d80da54e01@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/26 23:10, Loic Poulain wrote:
> The CCI hw_params timing values (thigh, tlow, etc.) are expressed in
> clock ticks and are only valid at the specific CCI clock rate they were
> calibrated for. Different I2C modes may be calibrated for different
> rates, and the single CCI clock is shared by all masters.
> 
> Turn the timing table into a two-dimensional [rate][mode] matrix so a
> given rate can carry timing sets for each mode, and select the entry
> matching the currently running clock rate at init time. The existing
> per-variant values are moved under their calibrated rate (19.2 MHz for
> v1/v1.5, 37.5 MHz for v2), no timing values are changed.
> 
> At this stage the driver only validates the running rate against the
> table, the timings are only valid at the exact rate they were calibrated
> for, so if the current rate has no matching entry for a master's mode,
> fail initialization rather than program incorrect timings. A following
> patch actively enforces the required rate so this becomes a safety net.
> 
> Suggested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>   drivers/i2c/busses/i2c-qcom-cci.c | 74 +++++++++++++++++++++++++++++++--------
>   1 file changed, 59 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
> index 0a216c4d08114f267c8441925e8811ca64f1a909..1092ce0371429ef64c7cc44cc23a42ba4c135af5 100644
> --- a/drivers/i2c/busses/i2c-qcom-cci.c
> +++ b/drivers/i2c/busses/i2c-qcom-cci.c
> @@ -82,6 +82,13 @@ enum {
>   	I2C_MODE_STANDARD,
>   	I2C_MODE_FAST,
>   	I2C_MODE_FAST_PLUS,
> +	NUM_I2C_MODES,
> +};
> +
> +enum {
> +	CCI_CLK_RATE_19_2MHZ,
> +	CCI_CLK_RATE_37_5MHZ,
> +	NUM_CCI_CLK_RATES,
>   };
>   
>   enum cci_i2c_queue_t {
> @@ -117,7 +124,7 @@ struct cci_data {
>   	unsigned int num_masters;
>   	struct i2c_adapter_quirks quirks;
>   	u16 queue_size[NUM_QUEUES];
> -	struct hw_params params[3];
> +	struct hw_params params[NUM_CCI_CLK_RATES][NUM_I2C_MODES];
>   };
>   
>   struct cci {
> @@ -127,6 +134,7 @@ struct cci {
>   	const struct cci_data *data;
>   	struct clk_bulk_data *clocks;
>   	int nclocks;
> +	struct clk *cci_clk;
>   	struct cci_master master[NUM_MASTERS];
>   };
>   
> @@ -225,7 +233,34 @@ static int cci_halt(struct cci *cci, u8 master_num)
>   	return 0;
>   }
>   
> -static void cci_init(struct cci *cci)
> +static const unsigned long cci_clk_rates[NUM_CCI_CLK_RATES] = {
> +	[CCI_CLK_RATE_19_2MHZ] = 19200000,
> +	[CCI_CLK_RATE_37_5MHZ] = 37500000,
> +};
> +
> +static int cci_clk_rate_idx(unsigned long rate)
> +{
> +	int i;
> +
> +	for (i = 0; i < NUM_CCI_CLK_RATES; i++)
> +		if (cci_clk_rates[i] == rate)
> +			return i;
> +
> +	return -EINVAL;
> +}
> +
> +static const struct hw_params *cci_get_hw_params(struct cci *cci, int mode)
> +{
> +	unsigned long rate = clk_get_rate(cci->cci_clk);
> +	int ri = cci_clk_rate_idx(rate);
> +
> +	if (ri >= 0 && cci->data->params[ri][mode].thigh)
> +		return &cci->data->params[ri][mode];
> +
> +	return NULL;
> +}
> +
> +static int cci_init(struct cci *cci)
>   {
>   	u32 val = CCI_IRQ_MASK_0_I2C_M0_RD_DONE |
>   			CCI_IRQ_MASK_0_I2C_M0_Q0_REPORT |
> @@ -249,7 +284,12 @@ static void cci_init(struct cci *cci)
>   		if (!cci->master[i].cci)
>   			continue;
>   
> -		hw = &cci->data->params[mode];
> +		hw = cci_get_hw_params(cci, mode);
> +		if (!hw) {
> +			dev_err(cci->dev, "no timing for mode %d at CCI clock %lu Hz\n",
> +				mode, clk_get_rate(cci->cci_clk));
> +			return -EOPNOTSUPP;
> +		}
>   
>   		val = hw->thigh << 16 | hw->tlow;
>   		writel(val, cci->base + CCI_I2C_Mm_SCL_CTL(i));
> @@ -266,6 +306,8 @@ static void cci_init(struct cci *cci)
>   		val = hw->scl_stretch_en << 8 | hw->trdhld << 4 | hw->tsp;
>   		writel(val, cci->base + CCI_I2C_Mm_MISC_CTL(i));
>   	}
> +
> +	return 0;
>   }
>   
>   static int cci_reset(struct cci *cci)
> @@ -283,9 +325,7 @@ static int cci_reset(struct cci *cci)
>   		return -ETIMEDOUT;
>   	}
>   
> -	cci_init(cci);
> -
> -	return 0;
> +	return cci_init(cci);
>   }
>   
>   static int cci_run_queue(struct cci *cci, u8 master, u8 queue)
> @@ -488,8 +528,7 @@ static int __maybe_unused cci_resume_runtime(struct device *dev)
>   	if (ret)
>   		return ret;
>   
> -	cci_init(cci);
> -	return 0;
> +	return cci_init(cci);
>   }
>   
>   static const struct dev_pm_ops qcom_cci_pm = {
> @@ -570,6 +609,11 @@ static int cci_probe(struct platform_device *pdev)
>   		return dev_err_probe(dev, -EINVAL, "not enough clocks in DT\n");
>   	cci->nclocks = ret;
>   
> +	cci->cci_clk = devm_clk_get(dev, "cci");
> +	if (IS_ERR(cci->cci_clk))
> +		return dev_err_probe(dev, PTR_ERR(cci->cci_clk),
> +				     "failed to get CCI clock\n");
> +
>   	ret = cci_enable_clocks(cci);
>   	if (ret < 0)
>   		return ret;
> @@ -652,7 +696,7 @@ static const struct cci_data cci_v1_data = {
>   		.max_write_len = 10,
>   		.max_read_len = 12,
>   	},
> -	.params[I2C_MODE_STANDARD] = {
> +	.params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_STANDARD] = {
>   		.thigh = 78,
>   		.tlow = 114,
>   		.tsu_sto = 28,
> @@ -664,7 +708,7 @@ static const struct cci_data cci_v1_data = {
>   		.trdhld = 6,
>   		.tsp = 1
>   	},
> -	.params[I2C_MODE_FAST] = {
> +	.params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_FAST] = {
>   		.thigh = 20,
>   		.tlow = 28,
>   		.tsu_sto = 21,
> @@ -685,7 +729,7 @@ static const struct cci_data cci_v1_5_data = {
>   		.max_write_len = 10,
>   		.max_read_len = 12,
>   	},
> -	.params[I2C_MODE_STANDARD] = {
> +	.params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_STANDARD] = {
>   		.thigh = 78,
>   		.tlow = 114,
>   		.tsu_sto = 28,
> @@ -697,7 +741,7 @@ static const struct cci_data cci_v1_5_data = {
>   		.trdhld = 6,
>   		.tsp = 1
>   	},
> -	.params[I2C_MODE_FAST] = {
> +	.params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_FAST] = {
>   		.thigh = 20,
>   		.tlow = 28,
>   		.tsu_sto = 21,
> @@ -718,7 +762,7 @@ static const struct cci_data cci_v2_data = {
>   		.max_write_len = 11,
>   		.max_read_len = 12,
>   	},
> -	.params[I2C_MODE_STANDARD] = {
> +	.params[CCI_CLK_RATE_37_5MHZ][I2C_MODE_STANDARD] = {
>   		.thigh = 201,
>   		.tlow = 174,
>   		.tsu_sto = 204,
> @@ -730,7 +774,7 @@ static const struct cci_data cci_v2_data = {
>   		.trdhld = 6,
>   		.tsp = 3
>   	},
> -	.params[I2C_MODE_FAST] = {
> +	.params[CCI_CLK_RATE_37_5MHZ][I2C_MODE_FAST] = {
>   		.thigh = 38,
>   		.tlow = 56,
>   		.tsu_sto = 40,
> @@ -742,7 +786,7 @@ static const struct cci_data cci_v2_data = {
>   		.trdhld = 6,
>   		.tsp = 3
>   	},
> -	.params[I2C_MODE_FAST_PLUS] = {
> +	.params[CCI_CLK_RATE_37_5MHZ][I2C_MODE_FAST_PLUS] = {
>   		.thigh = 16,
>   		.tlow = 22,
>   		.tsu_sto = 17,
> 

To my taste it brings the avoidable complexity in the logic, which
is then rightfully removed in the 4/5 change.

Eventually struct hw_params params should be removed from all
platform data instances, while here its diffusion becomes even
deeper, can you please consider to reorder the changes by popping
4/5 up?..

Apart of this concern, I do not see any technical flaws, to move on

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

-- 
Best wishes,
Vladimir
