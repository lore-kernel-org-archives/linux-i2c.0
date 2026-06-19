Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3389140E5F
	for <linux-i2c@vger.kernel.org>; Fri, 19 Jun 2026 07:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781854410; cv=none; b=scacQ25Pe8MuxHyo9P3YC7cFrotg5wsIYp03cw+922NV5dfhh3Y8zhdStbyS4Ba9s0keLMwCKtvXUNcLqf0gZCjJQaS0LbGbdbsuEMjHjZAc86p4ly46tO7DTC9U9WeSXkeornvZC5LhgHrMHr5mq+tlj/TzYfJncwCE/78zveo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781854410; c=relaxed/simple;
	bh=gJ4nyj6aMgwZafXvtWjrqirDsSYTtJM8mE4Ma8TAhRM=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YlKdnW/kZzustGaUnA6WlFJ8m40wJPg4+N9mNUruhinfNHNrUBCik5KZMz1JSrlpG31A8TOwoRzSoV7gpJo0aR6rWmUvYbxtfdYPfQupkee2r5POt0PYEZRvFpudlq32J0etPM/jLuHBoUNZgKNdADsul5TFgZdtAqKrvi09Oo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SptuV/1B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SptuV/1B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686881F00A3F
	for <linux-i2c@vger.kernel.org>; Fri, 19 Jun 2026 07:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781854409;
	bh=XofZBRO2g4jbv/LmzqRbA6Qcj0U1+cU7wRC11RI4KvQ=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=SptuV/1BaVGh8H1ggiyAcaDGieNH9lMFYi9lCBxR66r+EYbFgfwcdL9XKfGW1tlKc
	 uAXGY5FpbAbI52t7h1YlHQoXvs+Cif0X+qGlNKmgslNunH4uVIRrOvOgnYl3V9VYMY
	 Du/j0NrZp2WDagDs89lZyE5H+ZPFPYCSRD2SMrLI5zVe46rep9cwR9MVDJ5wf0z6Eu
	 4GydvSSRTPGy86twauVNx1zCkGRvGdG8NEMd6yO+A5h7J+hRhajU9og3XKDWh5+K5N
	 5OMcGlheyF0WreNqMVIA3VjdIK4TbT9852i/5mx0KrKWYf3sgI6JhSyiQaIUYf9llK
	 44h1LOcz2x39Q==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-399735e64d7so22247051fa.0
        for <linux-i2c@vger.kernel.org>; Fri, 19 Jun 2026 00:33:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+pZ/qbRKuY1e8jVLcbizV2MIBnVDbk+XM3VjoqxxKRF6OYvK4YoR5oHo5fxFlHeUa5tQ4I9mvyhmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBSl8bioYbefp5rZtg6JRl+SowINk4/2JloaW0yFTi45FLed8L
	OtMncU9enj1hkALUpuI8BMRWbI0g+ye48aMliIeIEAWTdtMjoQeOGXhrqfCt2OFE8zzQAZn0yvk
	PmWadSznPRc40kmwLoUB3feQu/up59IipJ7+o8vBVEg==
X-Received: by 2002:ac2:568a:0:b0:5a2:b43d:ac47 with SMTP id
 2adb3069b0e04-5ad576da270mr715841e87.5.1781854408062; Fri, 19 Jun 2026
 00:33:28 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 19 Jun 2026 02:33:26 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 19 Jun 2026 02:33:26 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260618133429.3214475-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618133429.3214475-1-andriy.shevchenko@linux.intel.com>
Date: Fri, 19 Jun 2026 02:33:26 -0500
X-Gmail-Original-Message-ID: <CAMRc=MfBnNu=-8mKHd8iKaNZLwQc6AdtWOL2-HQGj-M4B2ZYXA@mail.gmail.com>
X-Gm-Features: AVVi8CfdqQjSmbAIMicu3OVmdSBzQBf6rAXZIdVBoir9zi2zoP5Df-vwZZAL8Yg
Message-ID: <CAMRc=MfBnNu=-8mKHd8iKaNZLwQc6AdtWOL2-HQGj-M4B2ZYXA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] i2c: davinci: Use generic definitions for bus frequencies
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jun 2026 15:34:29 +0200, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> Since we have generic definitions for bus frequencies, let's use them.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-davinci.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> index 66c23535656b..67ce39cb000d 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -117,8 +117,6 @@
>  /* timeout for pm runtime autosuspend */
>  #define DAVINCI_I2C_PM_TIMEOUT	1000	/* ms */
>
> -#define DAVINCI_I2C_DEFAULT_BUS_FREQ	100000
> -
>  struct davinci_i2c_dev {
>  	struct device           *dev;
>  	void __iomem		*base;
> @@ -760,7 +758,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>
>  	r = device_property_read_u32(&pdev->dev, "clock-frequency", &prop);
>  	if (r)
> -		prop = DAVINCI_I2C_DEFAULT_BUS_FREQ;
> +		prop = I2C_MAX_STANDARD_MODE_FREQ;
>
>  	dev->bus_freq = prop / 1000;
>
> --
> 2.50.1
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
