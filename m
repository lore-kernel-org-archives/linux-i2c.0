Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE15288C3D
	for <linux-i2c@vger.kernel.org>; Fri, 24 Apr 2026 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777043563; cv=none; b=ADGBb7zK8rABx+KPEYkWyGV6EalqdGGzXwRQTqPpCLAheSXIsBi0MFHUwi6/6tJKfYK5CBH8l/Vw28VfOK+BJRWEYdjm9d2THbOfIkNzxWWy0fN2VAh4ULRupFfrj5q7lVOCymWPIQcxzOXjBOHTHVNhO7r/UrB0KsGRC35yqTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777043563; c=relaxed/simple;
	bh=5XDKAxu8Xq1TVY6QbxiDtMURF8o8Sc8i5C25fq9XWJ4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rqPAJG2GM1a1uoxkep1rDO2aNeZgqVSIwy4HMrMn3mI9ELRrbKRUMq1LhW02ek+JGrO4FgN8KkgwnoRuWWAKyHAZ6jy+9qkaHz+r07MpQ1k/wrFcmWRsT6R+VXJfGVmDHT+ovnev3vXuciJ6dttiPzSXb1NIdkE5hFcLy8bsCjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F4qoZJqq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F4qoZJqq"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so130611845e9.2
        for <linux-i2c@vger.kernel.org>; Fri, 24 Apr 2026 08:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777043560; x=1777648360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JlPy3eW0kbNMua8eHVUnVBy11sqyRv1hpFqPENpVf9I=;
        b=F4qoZJqqmUrs2GX+PhdaDhKCnKPgXYiqVW0zFoZLGGcvZ/mjoM0XN8PlXRgzVick2D
         mRMoG7AeM6gF9D2ZBPt2x+6ICp5i7KFR2Zi2d+TT/RER9bOF491cYVuutkZOVx8PUYR0
         dYPmD3ss0MVLnhiQ8h9DhQAo7zP/JZHH/QZMtxc/8sj9zBaR82UVMmhxuC0sdpEVEsAE
         84wl87TiFxlUVlNbfDhJSuo4sw4D0yq09u0KjpFJTh4Uzw+pnHxlzZ0wvuOuN2aKXtRS
         FzDZc6qipjfnN92ZpHbXkHnWDI6uK7FZVjui/NCH6ISK0mTuuAgrCv3S3gKLGnN13FiJ
         ZBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777043560; x=1777648360;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JlPy3eW0kbNMua8eHVUnVBy11sqyRv1hpFqPENpVf9I=;
        b=Si7wbhIKV6x8Lmq3gnn1CC5Sw1iCaplAMp+0PX1EwBaeNGr65U6s/Wqic0L8ETOicg
         x6UzZ3T94/Luoqs+KXO7GTfj0nuQUo8hkMcEUnTzXT33cZ53hqEjsVj0l1ef8TlVkp7N
         OIInD8zsMRtG99vzGcr0M8R8HTV2yQgaknZFWs58vn8x1nFLAuOU2hg/bzpXOMq+R90+
         UCK/qecdBv7flyDkq3MI5qHmaY0QDOgnvi3VvH55YfJV6YMVO91oZK4MWZNkx/AhrroZ
         x5IvZ2bgiWeqk35suYb5q/OTZbE0xln4jUSRi1TYr4nWdmnoYrOjW/wnrPG81zIt0XP0
         2ryA==
X-Forwarded-Encrypted: i=1; AFNElJ+mxl/83X+XvgQA1BnvtfeWf1hDwuawA9TAndg2nEqggI4HT7W69nlXj3QhXU4LjD7gdBiZynpfkbM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3b0qY/ofy3I3kWqV9v3K2e7Cn4PWwE47OOtPD2yMAHnS201WG
	Btzk5u3hquYqIOrqi11LNrvXZCBIR7RN+WsSsjZlImY6dR/tE5dBEvawTl8S9EC3E8o=
X-Gm-Gg: AeBDieuWNwV8Cr85jlmUbFpdV0bCAK8nGz5u2zYxHAC0lofbkG9U3o3wRY46g7oU0aW
	ftguQM++eyBD3OKm9naj56gm8oeSkWkwR80DHvjdtYkLpGHyRzfEXLHNWGATnYjGLe+9F/D915p
	pF3mNgnR2uNIwXWU3lqYjmVTQG7BhgdnenHQITlhGqu6quikyrWHN0EanhVASeuE+vty6LwViWx
	nAcg5yfPuhGpDyFRcDSZ+jGfsGbPWcWYIFf4/C3osDpMatXNae73/oTvy1XhJbAqFiMDCjN8+cZ
	QT5sUr0xZX9P4Ei0g2jvjAsjHq7B6eSKMr34iSIoDDmWBkFW9W8dP97iTfyt7CgGGC+XiK94w6d
	gDZ7escDAlxD3ij7gN+xOv3B03F0ynmPUB0uzjUSks49PkVj29035M7YDUKPn3lKmppH/kmkItf
	D6YGPYXuyqPcNJdvcwO7jw1nooWFTNhm/K/7BjJPZYLYHxVLki3FAgk4CxkLRRf3UDdA/NSnn/P
	uK9t52UKq6bxlvkAA==
X-Received: by 2002:a05:600d:16:b0:489:19e9:b139 with SMTP id 5b1f17b1804b1-48919e9b29fmr249420635e9.1.1777043559595;
        Fri, 24 Apr 2026 08:12:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:608c:c052:cffc:495b? ([2a01:e0a:106d:1080:608c:c052:cffc:495b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4412150a071sm25224946f8f.21.2026.04.24.08.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 08:12:39 -0700 (PDT)
Message-ID: <cfee3aa2-e22b-4868-9ccd-f5016abe84b5@linaro.org>
Date: Fri, 24 Apr 2026 17:12:38 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 5/8] thermal: khadas-mcu-fan: Add fan config from
 platform data Add regulator support
To: linux-kernel-dev@aliel.fr, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <20260424-add-mcu-fan-khadas-vim4-v5-0-afcfa7157b23@aliel.fr>
 <20260424-add-mcu-fan-khadas-vim4-v5-5-afcfa7157b23@aliel.fr>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260424-add-mcu-fan-khadas-vim4-v5-5-afcfa7157b23@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/26 16:17, Ronald Claveau via B4 Relay wrote:
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
> 
> Replace the hardcoded MAX_LEVEL constant and fan register
> with values read from platform_data (fan_reg, max_level),
> as new MCUs need different values.
> 
> Optionally acquire and enable a "fan" regulator supply
> at probe time and on resume,
> so boards that gate fan power through a regulator are handled.
> 
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>   drivers/thermal/khadas_mcu_fan.c | 37 ++++++++++++++++++++++++++++++-------
>   1 file changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/thermal/khadas_mcu_fan.c b/drivers/thermal/khadas_mcu_fan.c
> index d35e5313bea41..5603fa099a858 100644
> --- a/drivers/thermal/khadas_mcu_fan.c
> +++ b/drivers/thermal/khadas_mcu_fan.c
> @@ -13,13 +13,15 @@
>   #include <linux/regmap.h>
>   #include <linux/sysfs.h>
>   #include <linux/thermal.h>
> -
> -#define MAX_LEVEL 3
> +#include <linux/regulator/consumer.h>
>   
>   struct khadas_mcu_fan_ctx {
>   	struct khadas_mcu *mcu;
> +	unsigned int fan_reg;
>   	unsigned int level;
> +	unsigned int max_level;
>   	struct thermal_cooling_device *cdev;
> +	struct regulator *power;
>   };
>   
>   static int khadas_mcu_fan_set_level(struct khadas_mcu_fan_ctx *ctx,
> @@ -27,8 +29,7 @@ static int khadas_mcu_fan_set_level(struct khadas_mcu_fan_ctx *ctx,
>   {
>   	int ret;
>   
> -	ret = regmap_write(ctx->mcu->regmap, KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG,
> -			   level);
> +	ret = regmap_write(ctx->mcu->regmap, ctx->fan_reg, level);
>   	if (ret)
>   		return ret;
>   
> @@ -40,7 +41,9 @@ static int khadas_mcu_fan_set_level(struct khadas_mcu_fan_ctx *ctx,
>   static int khadas_mcu_fan_get_max_state(struct thermal_cooling_device *cdev,
>   					unsigned long *state)
>   {
> -	*state = MAX_LEVEL;
> +	struct khadas_mcu_fan_ctx *ctx = cdev->devdata;
> +
> +	*state = ctx->max_level;
>   
>   	return 0;
>   }
> @@ -61,7 +64,7 @@ khadas_mcu_fan_set_cur_state(struct thermal_cooling_device *cdev,
>   {
>   	struct khadas_mcu_fan_ctx *ctx = cdev->devdata;
>   
> -	if (state > MAX_LEVEL)
> +	if (state > ctx->max_level)
>   		return -EINVAL;
>   
>   	if (state == ctx->level)
> @@ -78,6 +81,7 @@ static const struct thermal_cooling_device_ops khadas_mcu_fan_cooling_ops = {
>   
>   static int khadas_mcu_fan_probe(struct platform_device *pdev)
>   {
> +	const struct khadas_mcu_fan_pdata *pdata = dev_get_platdata(&pdev->dev);
>   	struct khadas_mcu *mcu = dev_get_drvdata(pdev->dev.parent);
>   	struct thermal_cooling_device *cdev;
>   	struct device *dev = &pdev->dev;
> @@ -87,7 +91,21 @@ static int khadas_mcu_fan_probe(struct platform_device *pdev)
>   	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
>   	if (!ctx)
>   		return -ENOMEM;
> +
>   	ctx->mcu = mcu;
> +	ctx->fan_reg   = pdata->fan_reg;
> +	ctx->max_level = pdata->max_level;
> +
> +	ctx->power = devm_regulator_get(dev->parent, "fan");
> +	if (IS_ERR(ctx->power))
> +		return PTR_ERR(ctx->power);
> +
> +	ret = regulator_enable(ctx->power);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable fan power supply: %d\n", ret);
> +		return ret;
> +	}
> +
>   	platform_set_drvdata(pdev, ctx);
>   
>   	cdev = devm_thermal_of_cooling_device_register(dev->parent,
> @@ -124,12 +142,17 @@ static int khadas_mcu_fan_suspend(struct device *dev)
>   
>   	ctx->level = level_save;
>   
> -	return 0;
> +	return regulator_disable(ctx->power);
>   }
>   
>   static int khadas_mcu_fan_resume(struct device *dev)
>   {
>   	struct khadas_mcu_fan_ctx *ctx = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = regulator_enable(ctx->power);
> +	if (ret)
> +		return ret;
>   
>   	return khadas_mcu_fan_set_level(ctx, ctx->level);
>   }
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
