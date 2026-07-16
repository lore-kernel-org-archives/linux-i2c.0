Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD909248867
	for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 08:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784189713; cv=none; b=fX43vKs/bip2UI3ytnWC8mhyE9EikwoTsyQZ/U8FTCCs1fewgxplCphh4w0b7AukFIAzTuX5U0OvirJtJk38uHiyZzURTt0NnKF5nZCxCvMGA8laM2vhr5Np84okR+0Bmg3uv6FlEPgSHHXohlJKMeBJx6QGxen7kPNdcq7hHpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784189713; c=relaxed/simple;
	bh=XDd/+K1zkY4FTWnThxNADCvpfXb2R+7V2D39IHLWg9E=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i5fMM2/67d1MGNVS87uqLmM5K6NcdkHacVqxDTZavACpCoxAgIkCKxBsNEhek8zTvafYvpBaRFcTvjiw3YF1EKlXfuOy7nfDpt08zDT/HK4cWt2zsX/9RQi/mgqHsBS5n6iD3uX80tyOiRh4sxHh4fsIGQy1xtRxeC/iW4GJkDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkkypRup; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkkypRup"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EA91F00ACF
	for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 08:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784189711;
	bh=0e+2foSrfB089LQxMuUAQFzuyTGSAoL1QCbe9PtC7oc=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=OkkypRupH9CKZtHqUPclf3Dnj+VRoB7vpwwlQ0RSJiHR9R/s6Ybjljfzn1vgeGirS
	 mtU9U0l41Y+ZmK6UNZnGCfZbKNyg4OV6IIMmUQqDFg/iIqKl/fBMX+/MHjGJ8UGrpr
	 HEY1eWmKyj0lYpaBi0G7AAQbg8d+FR5eKU6Af6UF5PODST9Ct1zl6ANwht7Dhxpqm8
	 E1OS3lQ+mKH12tmB8qSdqlsayt3INCZOHnKDuMzYOodcKGVgzaZYLSHpOCjPS4BCEj
	 fNa5CYOStgmrE3wPpotyhFFkforsYaXDZf36yv0ocxNHVoJSzBhuMehOCNNDJOuit9
	 EcX/QUSzYOE2A==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39b22d0e488so69976731fa.3
        for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 01:15:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqWz10RJk6jkTs6q4vf2Opox5TrtB+XHN6VS2dqQTXOr1efIb1SEVkZhyF7ssLGlm+UjBKaWghiILY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzF/NoYP+ez9ID56QFqsPZDpUzqdoYlR08hkQ3RBsIj+zfSuyb
	lUEHa6E+A/t55Qv7v+rBarG3hHrojDM16+81+UzVz3zyjf1o4itSUDTJtnUPDIH4AjIUK/OQQIP
	ZPVZ74nB4Bc/Q6NElaWQ+bRGUEc9UJcu1/QJcfzIdJw==
X-Received: by 2002:a2e:be8f:0:b0:39b:1272:25d3 with SMTP id
 38308e7fff4ca-39db6d52233mr13287271fa.27.1784189710108; Thu, 16 Jul 2026
 01:15:10 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Jul 2026 01:15:08 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Jul 2026 01:15:08 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260714162915.3018703-2-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714162915.3018703-1-markus.stockhausen@gmx.de> <20260714162915.3018703-2-markus.stockhausen@gmx.de>
Date: Thu, 16 Jul 2026 01:15:08 -0700
X-Gmail-Original-Message-ID: <CAMRc=McE=mW8OLXRrSRCEUoQsheXgW2TtspF7VaC4wX_8-qvfg@mail.gmail.com>
X-Gm-Features: AUfX_mzOxzY--a9P9xlg7SeH5TFj3Zw505PiKCa5vVVRxhQ0FS1n4gwtMNi9M-8
Message-ID: <CAMRc=McE=mW8OLXRrSRCEUoQsheXgW2TtspF7VaC4wX_8-qvfg@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] i2c: algo: bit: Allow to skip bit test
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: wsa+renesas@sang-engineering.com, andi.shyti@kernel.org, linusw@kernel.org, 
	brgl@kernel.org, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Jul 2026 18:29:14 +0200, Markus Stockhausen
<markus.stockhausen@gmx.de> said:
> An I2C bus can make use of shared resources. E.g. two GPIO based buses
> that share a single SCL line. To synchronize access to the bus the driver
> might use locking with the help of i2c_lock_operations(). While this
> works for normal transfers it is not available during initialization.
>
> Especially if i2c-algo-bit module is loaded with parameter bit_test
> it will issue some basic sanity checks that will access the bus without
> locking. This might interfere badly with concurrent transfers. Even
> if these are well synchronized via locks.
>
> Allow the consumer of an algorithm to override if the bit_test is allowed
> or not. For this add a new boolean attribute named skip_bit_test to
> i2c_algo_bit_data. If set the test is not run.
>
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
> ---
>  drivers/i2c/algos/i2c-algo-bit.c | 2 +-
>  include/linux/i2c-algo-bit.h     | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
> index d1d9a6c1a1e2..7ca565cbff5b 100644
> --- a/drivers/i2c/algos/i2c-algo-bit.c
> +++ b/drivers/i2c/algos/i2c-algo-bit.c
> @@ -639,7 +639,7 @@ static int __i2c_bit_add_bus(struct i2c_adapter *adap,
>  	struct i2c_algo_bit_data *bit_adap = adap->algo_data;
>  	int ret;
>
> -	if (bit_test) {
> +	if (bit_test && !bit_adap->skip_bit_test) {
>  		ret = test_bus(adap);
>  		if (bit_test >= 2 && ret < 0)
>  			return -ENODEV;
> diff --git a/include/linux/i2c-algo-bit.h b/include/linux/i2c-algo-bit.h
> index 7fd5575a368f..c4c43aec1e67 100644
> --- a/include/linux/i2c-algo-bit.h
> +++ b/include/linux/i2c-algo-bit.h
> @@ -34,6 +34,7 @@ struct i2c_algo_bit_data {
>  				   maximum 50 us for SMBus */
>  	int timeout;		/* in jiffies */
>  	bool can_do_atomic;	/* callbacks don't sleep, we can be atomic */
> +	bool skip_bit_test;	/* override bit_test module parameter */
>  };
>
>  int i2c_bit_add_bus(struct i2c_adapter *);
> --
> 2.54.0
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
