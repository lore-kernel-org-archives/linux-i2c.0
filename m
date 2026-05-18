Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F2E3E00A9
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 08:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779091320; cv=none; b=UNAGsBSoWDuU9N5t9zCx8p20Cz+d9Dw0oEqJG9/GUUw6Y0997tdpbt+xDBUXGA2L5uHS5IwzGRYctZOI4AqbhDb6y88RE2DkOGCqXYYad6h2DIqw01muShqBm/UFAQDQPx56GojtlUsCqo2dIJDc1YKzAWlRCXCcHIxA/OpfiPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779091320; c=relaxed/simple;
	bh=Szxe4uR+z2SalkTXFaMC0PsQG6FLID/9Q/TTJ8kZxXY=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8ld5I8E5miO8xjVxdpaF64eezUKIEhT9AF+WBAgxdPLpFrYgMhacSDEV79PDzSPv26pP3vwR1LdreqoHBZOGNveb+K+VwnVtbIrBR1NoyT3zdb5Ik3YqEzznqpL6hV/kan+OlAOM0zpm8xicEWRGY/ivYxdp4Fs021FfCVtLOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sag4IRhn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sag4IRhn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95877C2BCB7
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 08:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779091320;
	bh=Szxe4uR+z2SalkTXFaMC0PsQG6FLID/9Q/TTJ8kZxXY=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=Sag4IRhnfU/eMwaPn8uattkG6U2DS6Tgzm4hVf7ERx1nwlXr3Us4zxHsC4e/sKldR
	 Rl7hQeymd+MxRhLe2qH50E5gEC8cSC9cGiVXbcpofm0I4h/XSRJtSrg5d//ozpsgkF
	 s/VkyAWMFXR9Y5n38AkK2RqGI1pG3UsG7EMJ5EI3Gt6hwUABV7cFN+Hu99lLOr19iW
	 noi1sQVcJ0m1PAgnFU2On082PhLCGpfNZ5my9xbkYNJhLFgiClqIKoTIYKveCmIEi4
	 omcl95CpOcaEM/k8H7CnFg9UN7iMiymsPZ7HOWa8x4Sq3T4DXxzUH9Q7vYS5hMakZY
	 Nn7TXInqQmEAw==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38e97e73234so18356611fa.1
        for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 01:02:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ95LV4YO6tN8hBPk+9imwX07TgSou9E+sZCRRDZW/3NlUfzdQwtYG+W5YY/2aQ8vHFadZwigESa9G4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCCy02wFHT8x9ZrgwsyHq5gUFJAvIWUEMGPtVZNliniJXDK0UJ
	+YpNjAFHfMN6d8lLMr5NwV+da0u6MGxunucHg2aFqYVwTGubzAhU1xMS9Q/QfbYImuK8pg1/tzF
	8gTu7pE5FMmyoLTQ1naxKCkJ7sOShLCn31yjE7bsfgg==
X-Received: by 2002:a05:651c:41d5:b0:38f:e2ad:e975 with SMTP id
 38308e7fff4ca-39561c0d38amr41642981fa.14.1779091319243; Mon, 18 May 2026
 01:01:59 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 18 May 2026 01:01:56 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 18 May 2026 01:01:56 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260515092520.9006-1-chaitanya.msabnis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515092520.9006-1-chaitanya.msabnis@gmail.com>
Date: Mon, 18 May 2026 01:01:56 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfLi2Ny-U5U3z-RMk5pVq-Vbe4A8THNyHv=NEMmnL4Vpg@mail.gmail.com>
X-Gm-Features: AVHnY4IaNhVu5lcH7cgyEg9L3kHOwb1wCT_RRLI-YStqpM1fc4cfeVrcxNXrqg4
Message-ID: <CAMRc=MfLi2Ny-U5U3z-RMk5pVq-Vbe4A8THNyHv=NEMmnL4Vpg@mail.gmail.com>
Subject: Re: [PATCH v3] i2c: davinci: fix division by zero on missing clock-frequency
To: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, brgl@kernel.org, 
	andi.shyti@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 May 2026 11:25:20 +0200, Chaitanya Sabnis
<chaitanya.msabnis@gmail.com> said:
> When the 'clock-frequency' property is missing from the device tree,
> the driver falls back to DAVINCI_I2C_DEFAULT_BUS_FREQ. However, this
> macro was defined in kHz (100), whereas the device tree property is
> expected in Hz.
>
> The probe function divided the fallback value by 1000, causing
> integer truncation that resulted in dev->bus_freq = 0. This triggered
> a deterministic division-by-zero kernel panic when calculating clock
> dividers later in the probe sequence.
>
> Fix this by redefining DAVINCI_I2C_DEFAULT_BUS_FREQ in Hz (100000)
> to match the expected device tree property unit, allowing the existing
> division logic to work correctly for both cases.
>
> Fixes: b04ce6385979 ("i2c: davinci: kill platform data")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260514044726.57297C2BCB7@smtp.kernel.org/
> Signed-off-by: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
> ---

Missing changelog.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

>  drivers/i2c/busses/i2c-davinci.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> index a773ba082321..a264a480dc3c 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -117,7 +117,7 @@
>  /* timeout for pm runtime autosuspend */
>  #define DAVINCI_I2C_PM_TIMEOUT	1000	/* ms */
>
> -#define DAVINCI_I2C_DEFAULT_BUS_FREQ	100
> +#define DAVINCI_I2C_DEFAULT_BUS_FREQ	100000
>
>  struct davinci_i2c_dev {
>  	struct device           *dev;
> @@ -761,9 +761,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>  	r = device_property_read_u32(&pdev->dev, "clock-frequency", &prop);
>  	if (r)
>  		prop = DAVINCI_I2C_DEFAULT_BUS_FREQ;
> -
>  	dev->bus_freq = prop / 1000;
> -

These a ninja changes, at least mention them in the commit message.

Bart

>  	dev->has_pfunc = device_property_present(&pdev->dev, "ti,has-pfunc");
>
>  	dev->clk = devm_clk_get(&pdev->dev, NULL);
> --
> 2.43.0
>
>
