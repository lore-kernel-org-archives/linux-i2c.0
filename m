Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4284530D417
	for <linux-i2c@vger.kernel.org>; Sat, 25 Jul 2026 06:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784961738; cv=none; b=oWcS5nIVyxTNZ7kpmL6DWdZKu1REr3rX3jHnIMfoOViLBTVICRJ0yQ7zPIybEznCM7wgKEPemlfL6O8gyFV4Oh6SN7wA0GjMi+KYTzkvVNW1nIvByGlWDLR9swTimn8xifQ0Cdi6L4Ohp0LICqsvNP6KWUxMB1g5YsjQFXsqC+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784961738; c=relaxed/simple;
	bh=zoKbMi978nDgj2HDslbMe1w2uEVfSZWEuUvbMtbMgfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFkGSr+kYdxuCZTiyHbwV2RLVPHz80jnBarMshLReXtz4qrLvoyo3k/lsUcugFf/ZDdQV7djM8LWYjTQ8ClYrHeNfqs+SFndVXISZAq39A4oqE8Z7kH04W/9COy40Gcesu3HPC8RQF6GnvA6n8rAv9yQQhhvPnffroVh9EmDQGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wer8gqfe; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wer8gqfe"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aeb7ccb9f0so114816e87.0
        for <linux-i2c@vger.kernel.org>; Fri, 24 Jul 2026 23:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784961734; x=1785566534; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3rcLlOj89gK3OxZv2MR+AlxF2Au5na5W1MCm2dKXaFM=;
        b=wer8gqfeqtJpHsTiQCQd8MJFHAlF+kQRpAa7vylCBDbyBFFwlSmIo2m0kWyrJ4OIcG
         envWaXZ9cR56DLUwmVRqcuc6Yen7Q5U4hxjeSAxRMcgyNmzeIHGYFuMQIECGDZfluCSZ
         tHOkmgOVA6pgJ416X1imJOCQIsR28O8O3P32v4fMZeZJckDjWfmRXjN55QejjLtvIS+D
         au/qGVZzd+VJgMf9++PdOh4i2sdat+EEzpI37POhrPkiMl3yv9MJ0NblpQEmL5DKSuyB
         afZd760FjPy4LubYRyKLyxVQ/lTDoyhfcA77Rm3VyIrLuoxw2AdAIlpA7JUT/nDzWr8l
         27yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784961734; x=1785566534;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3rcLlOj89gK3OxZv2MR+AlxF2Au5na5W1MCm2dKXaFM=;
        b=ca5ypYxFTwml52vQMjPzB5SFh9fqUyhPefJGesBfXhndfZkYrvrXbuQKXg2v3j25ZW
         4omwQsmmFpYYvg3ars/Rm+bZ2Ty6+HCBNK5wbsrHX2susYpeM+kAb3V/zrXlTutQR1Or
         sFPEuNZmKm09HjwYicbptLaz2O3E+v5dZaHjvfOHl27riMqpdFy251+Mgl2TuNYl2ghB
         XlFGb0Vc7O3hmbLVzekPequhhjpgAp/G0KAbxYVnFGj/D1d0WIi88pwX0lgNU5f00OK9
         m430T6ZtsGCHWWZwPrMqlWRTmqVHTmOZn2jD5F+EKY9MhVu9w0EOps9R7wB93c/Y5efV
         mrfA==
X-Gm-Message-State: AOJu0Yzpn+EbU1mY0jTlM0eINKfHKfGZUS/tH5EfniabFapJg0w6ghIc
	OA0QDzmSrQKr3rjBgI5RDio84VWEojKDYmvyY+EFbZbk7glgZ6cgWRzFll2epufDKAc=
X-Gm-Gg: AR+sD12t3E4E55Wu2VNnJmfsYHf4pqSJ6PXTdhUIplW3EX79WySDmzpM/lsQENkiiR3
	/F+RQlX+Snd6CLULth5iMCexTZe+fbCpoDuXBuFt4lWVjDtZy8W7++iRYxJlHy9vJ1Kr8CrayK+
	ZrqnAasEZlZDR/ukH5ncS4eJOK+9Yp2nZ1PRokYUk30eWyjwV0q3ypwwYU5V3Opj5u8tx4OZEDo
	tjafhPC0CbvmJGPf9QySWjLZMQbgodWAHXc3RKaug5aPi3oJ9Cq5SncL1LXpCm4MxzX+ByJEeSZ
	j22rItVn3A496fscHt39Y0m3phiABrQz9hQvnNUMUtzFNomGkbf2oXHYqhoxy1neemGH1yaQCm+
	AdZX3VaYmgKlsKgAfvWyyKmdG06tsca42ltJYd6xm0rB6lr8mv793X3wic+ylHgp9Y4L2N7IhCB
	cytXAq5MsYM+V9/9ry81BFmQT+c28JTRvkMWjpBKGPFGPRBEhBqLSfaXjr
X-Received: by 2002:a05:6512:2520:b0:5b0:6aea:cdb5 with SMTP id 2adb3069b0e04-5b2c1af7abemr136512e87.1.1784961734099;
        Fri, 24 Jul 2026 23:42:14 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2be1d863bsm291890e87.53.2026.07.24.23.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 23:42:12 -0700 (PDT)
Message-ID: <b0bfb2a9-6918-49b7-a28e-c0c822c6f957@linaro.org>
Date: Sat, 25 Jul 2026 09:42:11 +0300
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] i2c: qcom-cci: Add missing cci_clk_rate for msm8953
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Luca Weiss <luca@lucaweiss.eu>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260721-cci-clk-fix-v1-0-5eae78700da8@oss.qualcomm.com>
 <20260721-cci-clk-fix-v1-2-5eae78700da8@oss.qualcomm.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20260721-cci-clk-fix-v1-2-5eae78700da8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/21/26 17:58, Loic Poulain wrote:
> The msm8953 CCI data was added after cci_clk_rate was removed from the
> driver, so it never got a clock rate entry. The DT assigns 19.2 MHz to
> GCC_CAMSS_CCI_CLK and the hw_params values match those of v1/v1.5 which
> were also calibrated for 19.2 MHz.
> 
> Fixes: d202341d9b0c ("i2c: qcom-cci: Add msm8953 compatible")

By the way this commit also does not fix anything, moreover its backport
won't solve any bugs, but may break the build, if 1/3 is not applied.

I'd ask to consider to remove the Fixes tag here.

> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>   drivers/i2c/busses/i2c-qcom-cci.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
> index 19e4719f13b29b2cf60e113565b1b63f19d0e669..5f74edde8558382e63e2c3d0fbe19489f325e8ce 100644
> --- a/drivers/i2c/busses/i2c-qcom-cci.c
> +++ b/drivers/i2c/busses/i2c-qcom-cci.c
> @@ -783,6 +783,7 @@ static const struct cci_data cci_msm8953_data = {
>   		.max_write_len = 11,
>   		.max_read_len = 12,
>   	},
> +	.cci_clk_rate = 19200000,
>   	.params[I2C_MODE_STANDARD] = {
>   		.thigh = 78,
>   		.tlow = 114,
> 

-- 
Best wishes,
Vladimir
