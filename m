Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0B444E647
	for <linux-i2c@vger.kernel.org>; Wed, 19 Aug 2026 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138777; cv=none; b=iO6x2Koudsy2WqvYbnXZEYpM1XEGMtAnm44Bj9cGUGqi1Ac/9+mj/h2JN2ptY8qWvcfeF/5PWmDVDqRBJ42eonVN/QCV5IdwSZu9YRQw/BR4vdJL8UnnRM8UJeNIUMf/bFi6Jnrrgz1EhL438Zhb4wYWLCA0iDmGBSiqo8nBdTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138777; c=relaxed/simple;
	bh=2exsr9B1VhH/4+XIcP3p7XB3jhd+x/TzyxxBmfhy5cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0UkQY7YNh2JIpYWiSBj5ToMU6BQwoub95009Yz0YlD88Usq7Hr9pYTSqk8HKtmfTYlMMmX5UjO+55H/PU5tUrjL04sSzBOBWiwa7iFUgcNyEPp4PWhgVS/WCDb6MuEaPOJ5jL6xRuHjVP9jYu1kTbId32e0JVEi5tQN0Bkmsus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hbAQa5Ww; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hbAQa5Ww"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39c93a972b9so505121fa.2
        for <linux-i2c@vger.kernel.org>; Wed, 19 Aug 2026 04:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787138774; x=1787743574; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bx06gBGBnxZIUZCUgLDVahEccXm0GWObp7LT5QC3fPM=;
        b=hbAQa5WwHC0TcCRzILpW1Rrr8x7EwdJCeRm4XNwQ4PIhmKSOkIWKAEMdLbXR8J0dmj
         lN3p82IPiWmrJK7+Qu0/AVBYNtiADEIHOk4oJIFbpWRYeDzP2HXyXKjXRt+TWQZKY5is
         B9mt0/alb78Kklic2hHZJPCVsPShqGofJKO3FJi13XC5r/WLyzEsJOdlfNbYrN5w/bt9
         Iu+rIQk+Jy1Io7/wniy8XHTQ3b79LIYCVhj/xgzFwaiFqNVMnVZApR+jxrNn+5q75Ylp
         bzcB+TkxYfcI+G8Yvl1nOLqkCZ8sDAIHEHYSmOfDLuKW8/oIWYv7XpraoKmXM3IojeN9
         2XrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787138774; x=1787743574;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bx06gBGBnxZIUZCUgLDVahEccXm0GWObp7LT5QC3fPM=;
        b=Dp1f0DSNAzTx/9PlniHy8oQraBnZdIsvUd4ryyD85/Gj+FHrWgI0YpAM2ichGb7fz8
         PfQp7wkzqsxcxIj1OjD7BGFCIZZShajBx/B3YJ9eK80ozUjmHSf4Qiaz8WS0RpQFi1tQ
         r4vT37iT9XoLJuwA/nT/JIXDYSKX/7IVQOCOUFWPVqe3qGgjIhMYD1pTlCa4same8MJI
         4SHk4uOlvxbGIqJUG7NG4L80Ilvtx+3P8wHquE6nSAML/jmN+T69nbjX4j32qD/7M83F
         NI2iKWXylUl7ZIFLkb/v7zhz1+h9yEH570w/hhXHCIB+rjRhAP5Z7ROzyddAA3mdUxeR
         Y2eg==
X-Gm-Message-State: AOJu0Yx7SBGnw5iiMFXPpiOR2uXuPfIweZB6nWPX3BiLHrAEqr1jXMAd
	8V8NMWv1OaeGIl9BSCumAEu9zHyP3rnA9lTk5uJ1f8myzq8Vh8oDTAM+abMsqt+5Bsk=
X-Gm-Gg: AR+sD10GDQ3Mj6xIHvGp2TMeSDeT7C7l54rELsO1d0hPhNcksO8xuP6rZwC2IY5XAVY
	B6KUlkAMMH0xynh1DSRwO2K3MyICiqKPqAQwRv5gm0XCSexJoBwT4o12Ze10eB2E7MdYJnqZN3p
	N/OZjpgwpV+ojpAun/EvqAdLK0Io0WdHeqCNc//Qgj1+woFT6I06pwdBQM1nwZJGvZR+hCMvqmk
	RJYACq+Rn16DZNf3/78TIpoAwHV62akOIFcW1A3EMWhihFRgSGsNyawOv72btVfLuUnXXni7TCe
	BWltXvP9MWNPjgc4jVnjWLAdAEL4BPJFuHCHkwJAwTSzF46VG//xrKLrTL1Iy6AuJOlk7vIo1xP
	Pv1hhfMfUYeTN3J7EfS0qbgsYCP+p2wBd1rXpEl7QdyoTVosachT6G1ufWJVk6yrmMiB4bpMYMp
	t/iwJvCH63kZFG4QzbRwt/gF7NfWxJqwu/8VDnULBQ6UnGJCbuRfGhKQSQX3xsGf1Km9dvC5q1N
	em2eDQ9t8qCxd8K3tXc5dUngOqMqr6CDyTpRlMVUw==
X-Received: by 2002:a2e:b8cf:0:b0:3a1:6357:1a46 with SMTP id 38308e7fff4ca-3a18944db2fmr4630841fa.0.1787138774009;
        Wed, 19 Aug 2026 04:26:14 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a18aadb151sm4149081fa.20.2026.08.19.04.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 04:26:13 -0700 (PDT)
Message-ID: <b3983732-cacf-4b39-b437-d0d6e13fbf8e@linaro.org>
Date: Wed, 19 Aug 2026 14:26:12 +0300
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] i2c: qcom-cci: Add 19.2 MHz timings for the v2 CCI
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Luca Weiss <luca@lucaweiss.eu>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, konradybcio@kernel.org,
 stephan.gerhold@linaro.org
References: <20260801-cci-clk-fix-v4-0-e1d80da54e01@oss.qualcomm.com>
 <20260801-cci-clk-fix-v4-3-e1d80da54e01@oss.qualcomm.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20260801-cci-clk-fix-v4-3-e1d80da54e01@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/26 23:10, Loic Poulain wrote:
> The v2 CCI (msm8996/sdm630/msm8953/...) is normally clocked at 37.5 MHz,
> but its CCI clock can also be configured and run at 19.2 MHz. Add the
> Standard and Fast timing sets calibrated for 19.2 MHz so that a v2
> controller left at that rate still has valid timings for those modes
> (Fast+ requires 37.5 MHz).
> 
> The values mirror the v1/v1.5 19.2 MHz Standard/Fast timings, which
> share the same CCI clock rate.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>   drivers/i2c/busses/i2c-qcom-cci.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
> index 1092ce0371429ef64c7cc44cc23a42ba4c135af5..b6fa37a306758ec33ede6fcc39ce4412b86d9a84 100644
> --- a/drivers/i2c/busses/i2c-qcom-cci.c
> +++ b/drivers/i2c/busses/i2c-qcom-cci.c
> @@ -762,6 +762,30 @@ static const struct cci_data cci_v2_data = {
>   		.max_write_len = 11,
>   		.max_read_len = 12,
>   	},
> +	.params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_STANDARD] = {
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
> +	.params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_FAST] = {
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
>   	.params[CCI_CLK_RATE_37_5MHZ][I2C_MODE_STANDARD] = {
>   		.thigh = 201,
>   		.tlow = 174,
> 

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

-- 
Best wishes,
Vladimir
