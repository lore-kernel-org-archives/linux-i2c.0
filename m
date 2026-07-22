Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65A72D8391
	for <linux-i2c@vger.kernel.org>; Wed, 22 Jul 2026 12:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784722806; cv=none; b=UTiTSzQxyNFP/2xHRLQgo+8tQMHqPIM81GMWbSubh/uQpMigc4a4fcIO2OiqTBuwXVOsFjtNgFYFSdQYF4pfVfzPOuvEbNHGFQjlkLkT2SdNWzfa6FVOh0kSVOmfIQs1TQn5WPmlv5Thfj1IFKSPOuPeJ7utaMzVyeyz8/Bak7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784722806; c=relaxed/simple;
	bh=AgSIsFIB5hJk9F7GwArLvCsxDs8srGNqiUbKoqtKay4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tkE9qw/01rdGAJrbW0EN9ofT+HLh0syN6KjuG1tIp9qY4T8oNBurxQboxnaVaJkKxss+AceW5aBxOi5ONC+Kn7jrYR40+2anzlG2kf35DYS+Krva+iByo2JW7j6M6bdkIdBd8SZkAW4uP3ryGq4ZH+E2EcvNLrO/CVBxFp8adLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=y/zDo6hD; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="y/zDo6hD"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e7c6ec9dbso673156685a.0
        for <linux-i2c@vger.kernel.org>; Wed, 22 Jul 2026 05:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1784722803; x=1785327603; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5qvzOJZC5dLwV+0rw2sHYPHDnXSJxTaB22HkTCSR960=;
        b=y/zDo6hDu4vOETYNzk1FPBZ9JiyCBbzON0DOtnGFspPZLqQVHDUrPwSQ7k+iEfWtI7
         bYfjbigDggzKwsd68jGxv0zUi870PVr4kmRdIy5AVSbQXeni8aI0gPlffAB62GDPhvDb
         iVPONW1BLwYxJ9ev0MmoY71KjmpSr+e3gTQofhfHxaxm4/RW4uR2/myGnYfjcXBi6S2+
         A3S1Mt2mp0bfbdY4JrIQeLFIUIuqfmnOIE+5h0K/oaiQ4aBm9T8Xss1tJ/BWIEako7hn
         yF3FmimiRpF5ASDpEYcqFKvMH2VYiz1+urSEmQwls7cI+5SFdbP5zR6jkJWp9+DoeOHz
         tmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784722803; x=1785327603;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5qvzOJZC5dLwV+0rw2sHYPHDnXSJxTaB22HkTCSR960=;
        b=QfhesxZvEsRFsxV7WWCmHJr1aPiaKaaXlm/XZFADaFLetEUDsZLFQ1m8hmylneu6fF
         g9XpugTThFIJsNdBRu3tlMWLoQt7yMA882RradipaImTWLADxT8xhiiQOz7T0ocw8rTc
         akTDxGjSBftcz42VdBCGt2paotfrAnY/sheh6CcU++5W+mH4l89BAj2tP1E7vdSfArTh
         +riyZAbxhdstu2vvjede4cQvKGGAhe5xL+5ecZTFDunITc4LPxWRJm+au/pexeNF8rMQ
         UY6AOEozXZuwixGrCs6O8FTGGa5vbzKroYvCDL4ac5vEPN9K7D0Swlwe2JPDreBENo8e
         YliA==
X-Forwarded-Encrypted: i=1; AHgh+Rps83c0obqsA0zop6hPAbR/h9YQgGcEOMBtER6EsdsPbPKlpTj5O+1gLeBgD7WV4kplZLGZ21k0u1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjdvAQbvIF4NCUowXeGHZJ6d6ixePv17QXglUCIuhs084GRrAi
	qfYE/cqACETYLZtLWFEwgbFMZVaQL8ScKn6nsKAG55J9xCL8c3C2fXOGXiaeH/8h630=
X-Gm-Gg: AR+sD123alpZ+Tnz+d4/YrOpOOWsqZEnLLf+VuVcuH084AbjKDReBwl0yiO6qsL/rXX
	5bmTo1L6DC2/x3hKoVMKV4u5chJzXRaGcz0K9SGmGtNDsAuKvvDXtR1yYiBAWmKq1PMroabQ8Ac
	cpowXUnR8c9oECTvk9/983QztPWI++EYsJcMkLYb+xI3GNCTb2C2UM7Pfeqc97Lqu5m9a2RhiEf
	qDDBHzkKKWMVx7LA/0bllNJdqHjvjnyGdlVhn+TynUGY7UxNu49NCYZgypg3Ceg+fdOd/9mHvjs
	O5tJJPlKw64dREbpMyVZmWWr/OeYvU8AtEMqujNJ3mG9p9SQ7poqzO11NuzQOWA6cfH9pjSogOM
	nRF7AHkl5Uzr9avxFLfumShu9g5RIpq7zyngjnkKTR8OQyql9AYb3wIDDZ5BzZyKNP9joE/kaKo
	zVqA==
X-Received: by 2002:a05:620a:2989:b0:930:f306:8275 with SMTP id af79cd13be357-930f30682bemr389512085a.9.1784722803506;
        Wed, 22 Jul 2026 05:20:03 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f68d323asm151978385a.19.2026.07.22.05.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 05:20:03 -0700 (PDT)
Message-ID: <7d7938cd-80bb-448b-89d0-6ac6d2717e98@riscstar.com>
Date: Wed, 22 Jul 2026 07:20:01 -0500
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: spacemit: request IRQ after controller
 initialization
To: Linmao Li <lilinmao@kylinos.cn>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Andi Shyti <andi.shyti@kernel.org>
Cc: Yixun Lan <dlan@kernel.org>, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev
References: <20260722094302.2284191-1-lilinmao@kylinos.cn>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260722094302.2284191-1-lilinmao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/26 4:43 AM, Linmao Li wrote:
> spacemit_i2c_probe() requests the IRQ before it enables the clocks, resets
> the controller and runs init_completion(). If an interrupt is already
> pending, the handler runs too early: it reads registers while the clocks
> are still off and calls complete() on an uninitialized completion. Request
> the IRQ after the controller and completion are initialized, but still
> before the adapter is registered.
> 
> Fixes: 5ea558473fa3 ("i2c: spacemit: add support for SpacemiT K1 SoC")
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>

This looks correct.

Reviewed-by: Alex Elder <elder@riscstar.com>

> ---
>   drivers/i2c/busses/i2c-k1.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-k1.c b/drivers/i2c/busses/i2c-k1.c
> index 51a0c3d80fc9..3fe716cc153d 100644
> --- a/drivers/i2c/busses/i2c-k1.c
> +++ b/drivers/i2c/busses/i2c-k1.c
> @@ -723,11 +723,6 @@ static int spacemit_i2c_probe(struct platform_device *pdev)
>   	if (i2c->irq < 0)
>   		return dev_err_probe(dev, i2c->irq, "failed to get irq resource");
>   
> -	ret = devm_request_irq(i2c->dev, i2c->irq, spacemit_i2c_irq_handler,
> -			       IRQF_NO_SUSPEND, dev_name(i2c->dev), i2c);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "failed to request irq");
> -
>   	clk = devm_clk_get_enabled(dev, "func");
>   	if (IS_ERR(clk))
>   		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable func clock");
> @@ -755,6 +750,11 @@ static int spacemit_i2c_probe(struct platform_device *pdev)
>   
>   	init_completion(&i2c->complete);
>   
> +	ret = devm_request_irq(i2c->dev, i2c->irq, spacemit_i2c_irq_handler,
> +			       IRQF_NO_SUSPEND, dev_name(i2c->dev), i2c);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to request irq");
> +
>   	platform_set_drvdata(pdev, i2c);
>   
>   	ret = i2c_add_numbered_adapter(&i2c->adapt);

