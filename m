Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794345342;
	b=BAOhSnxAMYOn70BEQstbjQf3qzy1iuzRtJmGN369YmJ5eWovK3EP/0p3YSoPkwvBjnIc
	 nKsL0OQvQkY0R6ud+6EU3QrCBus342AHBpjpmX5jaMP8kGO2ULoAXhRh2f12s9Sz1G7yj
	 sRv/lpTqtcAuCiAtWGvDOAUB5jv5ZtNVuZ+vnbDH9/3myhM0rBjaAPWp7lLqZyAjIsjns
	 cQIurhyOUtSql79z6yfD0BJFuGZT62GwohWSIDeIaIAj/C/q3JxGjfp44oF/WA6lpvZsc
	 5jcqgj1200+EikE+N0s5KuVJD/aEruO4bZtZ/fHwwfZiKS3LpYUaGlvgeVBfxn/+1lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794345342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=OPELBkmgWuDcQIUl+1C2gUiqdih6G+ZfnSfUpv7B6os=;
	b=wqUbuJ/4FFcgNAKKe+AjQOK5HC+ydWUR3EKp4C7eMgIe+C0QvusOdpkImNNM6v7Uk3wD
	 KLLgGRAwaH21zZxNd9bWSEYsEjBH8dx9UDv3/qmyRn39Wy4/XGhMp9z2P5FLtC7UNnw47
	 rlkFw2LQCyVK9nxUcefJkQD/+wnjeCz3EQ2XWRCaCk4AJ/vT4uxsKsWtBo9mb4sPQrFGa
	 Eac3liJ82GBLn8u/tCYS8NptItdXyVulmooITEntCEvIyape2TUSIv/W5aawbgzVCH5J+
	 SQMJfnWstGmhKYF7ZGG4UJSK5vd8OJGxl9YhAY60+2DygC5cFoiPaDuzxGijTLLqabA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=riscstar.com;
	spf=pass smtp.mailfrom=riscstar.com;
	dkim=pass header.d=riscstar.com header.i=@riscstar.com header.a=rsa-sha256 header.s=google header.b=LUTsHQn5;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62347606A325
	for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 21:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62347606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar.com header.i=@riscstar.com header.a=rsa-sha256 header.s=google header.b=LUTsHQn5
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-8490a7d6696so1450459a34.3
        for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 13:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar.com; s=google; t=1794345340; x=1794950140; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OPELBkmgWuDcQIUl+1C2gUiqdih6G+ZfnSfUpv7B6os=;
        b=LUTsHQn5ZJW8mYZW5YfwlOg7lEaXPFJhF1fj1LiLj2ZFzlW3nDis0Q1Tq9El9EWe+y
         OSqB9dXc91gk/BRCUg4mONoadinDdNRHzVJkErEfq4x3gEQR60Ykmvqt8lKVk4h/JtZ7
         Hg17odOVxyiE9w1c1tdfC+nLgHnnpSKZ+xBOK4XcDK9+RaQrhqhaRioOvyoDAOUuh8ZC
         HyFLlwZhg00EOZm7NYVPzxpIgEGhOTb1l5E2JBJzN2uJOoiFmSYdAkT5hMSiMAtMODVa
         oAPsQuw64G40MY1gPEbC6fw6NulPHzpfdv7TjQ0oQ7/BVptrMUdp1jArriJC3eGG6jxN
         NFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794345340; x=1794950140;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OPELBkmgWuDcQIUl+1C2gUiqdih6G+ZfnSfUpv7B6os=;
        b=BQd2VlWTSLxHayhPmFYA3A2yGJjluckEE/umukYjWDI9gEH18t1BN0IC0wd5icacIs
         AW8jk63DZQLnxZ1o/YxvIeFzb7UjQ8msvN0Ng4Xpwm48SLhR+pkr/sD/JK+cD60mpY+y
         8tOFpaWtjWNv4DQtO4BSXEn2eibKRpTDbmsOvav5GKsXdmHGsBKgpEPSrk4xzcCSkWs4
         0M4WWcB40ke29Jk80KVdi4HTf22xFtMSfxWSzA0y2Xl2eVaeyUnhCPQC+7JRtEJJGDvw
         M4SgqejO4U54irXb5mK/DXPlQ4WurxhXk4q6W5Tu9xxERjVMhj8dNF5LXZ20Xpm7x5tL
         WOQg==
X-Forwarded-Encrypted: i=1; AL+hErHTR9FfiRpbp2q06uFcoAL3dmjNUj0ObbCN/uis6CkZOas/xi6vLzKZynjirAyPsMuOejh5pk/1Wok=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Bp6IiaKRNjxvFk9dKlRq6dKvyek9iMtAekEJT5MU1UQmTiv+P
	+K/8DGlXW625gf8hEZm+TXrcRqWhiY7ATqO6HDLWWZsdJ/mBqTfGpqduMAGn+v6geyU=
X-Gm-Gg: AYBFou30RfRimtNGAVmsEUcDBdicHGC87Z9ZXDOynLM6L5Bjub3hZ8z7EumdSdRHbTN
	wg3Svxr69ZKNajckdE7OxFzWiRDPjy/kxK62uZ/wPN76rWY8/J7Ykio0mljQxmHgrORrLecD9Zz
	+xF5oe8VC9WZyMYgOniH4YX9C6lr0QWJOhBeGWCmoyZU3mOrLnP7S7s9EeDBUXjfStDu6W7DFMR
	7Krv9BMpUl9o5NUM8h2bMQS4Ej4VtQH1lw7u6z8DdI+K71kfQLYSPQv2np6xlVywzPtqhVgSd3T
	3fVF12r5EORM6OY4NyxajLi3k18vJZhW4z6kOZBAgW/crZsLTdgvti0VdSDgEy3UIx1foTO03S8
	tCXHFnIXv/vVzTJrLSLdGo4y43Tb+/PfLKI656jHU1d54IQKOtK73jIhHaWKpQks7S9gUg49tXA
	JpsE5jpAE46Jqhj4NLA5laLyAOP2SASWT4fEr+tZZLZVqudDmSVONvUyJVpmqWSTXNcsz0qD8P4
	Qz+GrlcDRJ3pqTrr2+9XxzS/4RO0sDmxuXlJYldJGbR2aLutmAsAALyOXVsWAcPO+IWK9dW2nV4
	uDQnS451F/vk1f8sKC19wDI0DbaDOQ==
X-Received: by 2002:a05:6808:c226:b0:4f0:a3f9:9f89 with SMTP id 5614622812f47-56b96ad0741mr201899b6e.18.1794345340222;
        Tue, 10 Nov 2026 13:15:40 -0800 (PST)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5690573604fsm3142441b6e.9.2026.11.10.13.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 13:15:39 -0800 (PST)
Message-ID: <be330e7a-f37d-4347-b815-22bba165defd@riscstar.com>
Date: Tue, 10 Nov 2026 15:15:38 -0600
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] i2c: spacemit: Avoid sleeping during bus reset in
 atomic context
To: Anand Moon <linux.amoon@gmail.com>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Andi Shyti <andi.shyti@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Yixun Lan <dlan@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 "open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>,
 "open list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>,
 "open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
References: <20261110061429.2036-1-linux.amoon@gmail.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20261110061429.2036-1-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/26 12:14 AM, Anand Moon wrote:
> The spacemit_i2c_conditionally_reset_bus() function uses usleep_range()
> to wait after triggering a bus reset request. However, this function can
> be invoked during atomic I2C transfers (such as power-off or restart
> handlers running in atomic notifier chains), where sleeping is illegal.
> 
> Replace the sleep operation with the driver's internal helper,
> spacemit_i2c_delay(), which conditionally uses udelay() when running in
> an atomic context, avoiding "scheduling while atomic" bugs.
> 
> Assisted-by: LLM
> Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> Cc: Alex Elder <elder@riscstar.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>   drivers/i2c/busses/i2c-k1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-k1.c b/drivers/i2c/busses/i2c-k1.c
> index ff32876e24d3..f4b21d7efaaf 100644
> --- a/drivers/i2c/busses/i2c-k1.c
> +++ b/drivers/i2c/busses/i2c-k1.c
> @@ -332,7 +332,7 @@ static void spacemit_i2c_conditionally_reset_bus(struct spacemit_i2c_dev *i2c)
>   		writel(FIELD_PREP(SPACEMIT_RCR_FIELD_RST_CYC, 1),
>   		       i2c->base + SPACEMIT_IRCR);
>   		writel(SPACEMIT_CR_RSTREQ, i2c->base + SPACEMIT_ICR);
> -		usleep_range(20, 30);
> +		spacemit_i2c_delay(i2c, 20);
>   	}
>   
>   	/* check sda again here */
> 
> base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9

The use_pio flag is set for atomic transfers, so spacemit_i2c_delay()
will use udelay() regardless of the delay period.

Looks good.

Reviewed-by: Alex Elder <elder@riscstar.com>
