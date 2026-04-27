Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0610F3B2FF3
	for <linux-i2c@vger.kernel.org>; Mon, 27 Apr 2026 09:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777283074; cv=none; b=SZ2gxmOmkxeT6BJDCd/TVbEjIstCvV+MYAh5LzuUufeThcn+yITVtkwoAmdhkT35jXYRW/ZfRGLZuE8RdWoBtEiq9qGUOieIBvVhK3+cfkIlrweI+WlDtVk7/h52f9nk/o+IFpXx1zccn5sKGCo5p2EuNaphSCAdBixqvXF4U8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777283074; c=relaxed/simple;
	bh=filCqGpB7mjd5246OBMYMY9Jcs4otMHq69T97hkG1f0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7rcS+caU17Nn7tdtV+fRJaIrbmqPQcNJHkAvzt6EZi9miOAixjLVT0xDVr0Bii7Q7K1t1xTr45hto4BDZoxzl9Ya22zWE3baC6KIQSJOW0ctNGH2T2oVNPHqizocQ+ktXinrrIWuqmCJMoItxr8KwpSMfULFoYG69fa2BMObrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNGAlDDU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNGAlDDU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C766AC2BCB6
	for <linux-i2c@vger.kernel.org>; Mon, 27 Apr 2026 09:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777283073;
	bh=filCqGpB7mjd5246OBMYMY9Jcs4otMHq69T97hkG1f0=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=pNGAlDDUhM1uOvxfx0GsE/jJ3emzmo2TXQIeFmg9yjvdvx05IJM0ML7PBBdBJYSqh
	 ymMJ5Ot1aKxyWFYei2fXXaM57N7N+WQak+0sbBt7hk5fcOA2dVxBFPX0SJuWPfnOrN
	 HHh4kzmWd1UUGGqEm/92AtFXiu+t0rC6tsg0FeMGAr0/8ZRC7nuJJz0EKJnOv/qcyF
	 NWR97/kXlZ/YQ06FnGXFfUmm5tJDkicwQRep0NFcnSxCA0j/ekJOjg9ZUgTku38l0K
	 NaxoS9t1YKDsYj+H3XaujkdNLtZd/1eTSga/1M8nuTTZ6RHbRbaC4vwUjH1R5itEA8
	 M8d34JzX+JVwA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-38e7d983f91so101293021fa.2
        for <linux-i2c@vger.kernel.org>; Mon, 27 Apr 2026 02:44:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ835kCPuyQXtHu3rqbSlD9iEeV8p2rUYdZSyIfarZlkLfo85BZXXCTYrqLmSRiJt84RBrEV/tLRKEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOoU1zjAWTesfcDVzGILGr8IABUQXbWWOpvuJ4YpDSw8j78XYg
	qWHmomX1QLbF7IDvpeh/NOdjAfNR/LjZ7ZGKFPu05pnpw+9nBHCd1g3MmwU2FY4Buz1ywO0jm4n
	+l83zAPxOTr9PlIS9u3z+aZ+hW2G2MokBwNIOEYsZTw==
X-Received: by 2002:a05:651c:160d:b0:383:7f85:8eef with SMTP id
 38308e7fff4ca-38ec7afdab6mr127689941fa.29.1777283072375; Mon, 27 Apr 2026
 02:44:32 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Apr 2026 05:44:30 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Apr 2026 05:44:30 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260426024507.597480-1-marex@nabladev.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260426024507.597480-1-marex@nabladev.com>
Date: Mon, 27 Apr 2026 05:44:30 -0400
X-Gmail-Original-Message-ID: <CAMRc=Me0UunWyG8s5B1vBRjwvCj3Ps8fEu=6h26irqBPBOXDHw@mail.gmail.com>
X-Gm-Features: AVHnY4KBlBKwLMUkIvho2ET2upBG1ekZt4R-DFjYMkvYhLlMrCdIgTDa3iGJb6c
Message-ID: <CAMRc=Me0UunWyG8s5B1vBRjwvCj3Ps8fEu=6h26irqBPBOXDHw@mail.gmail.com>
Subject: Re: [PATCH v2] nvmem: core: Default to read-only if wp-gpios present
To: Marek Vasut <marex@nabladev.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Bartosz Golaszewski <brgl@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Srinivas Kandagatla <srini@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 Apr 2026 04:44:32 +0200, Marek Vasut <marex@nabladev.com> said:
> In case the nvmem DT node contains "wp-gpios" DT property, the device
> currently defaults to read-write and the force_ro sysfs attribute reads
> 0. Switch to the default read-only, which is both safer, and aligned
> with eMMC HW BOOT partition force_ro sysfs attribute behavior, which
> also defaults to read-only.
>
> The adjustment of nvmem->read_only value to read-only in case wp-gpios
> DT property is present must be done only after the device_add() got
> called because device_add() does internally call nvmem_bin_attr_get_umode(),
> which configures the permissions of 'nvmem' bin attr based on the value
> of nvmem->read_only that is only parsed from DT property 'read-only',
> without any adjustment. This way, if DT property 'read-only' is present,
> the 'nvmem' attribute is always read-only. Otherwise, if the device is
> writeable, then 'nvmem' attribute is writeable, and nvmem->read_only
> defaults to read-only, but can be switched to read-write at runtime via
> the 'force_ro' attribute.
>
> The updated behavior can be tested as follows:
>
> Current content:
> "
> $ cat /sys/bus/nvmem/devices/logging7/force_ro
> 1
>
> $ hexdump -C /sys/bus/nvmem/devices/logging7/nvmem
> 00000000  66 6f 6f 0a ff ff ff ff
> "
>
> Write into default-read-only device:
> "
> $ echo bar > /sys/bus/nvmem/devices/logging7/nvmem
> bash: echo: write error: Operation not permitted
> $ cat /sys/bus/nvmem/devices/logging7/force_ro
> 1
> "
>
> Unlock and write into device:
> "
> $ echo 0 > /sys/bus/nvmem/devices/logging7/force_ro
> $ cat /sys/bus/nvmem/devices/logging7/force_ro
> 0
>
> $ echo bar > /sys/bus/nvmem/devices/logging7/nvmem
> $ hexdump -C /sys/bus/nvmem/devices/logging7/nvmem
> 00000000  62 61 72 0a ff ff ff ff
> "
>
> Relock and write into device, fails because device is read-only again:
> "
> $ echo 1 > /sys/bus/nvmem/devices/logging7/force_ro
> $ echo baz > /sys/bus/nvmem/devices/logging7/nvmem
> bash: echo: write error: Operation not permitted
>
> $ hexdump -C /sys/bus/nvmem/devices/logging7/nvmem
> 00000000  62 61 72 0a ff ff ff ff
> "
>
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> ---
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Bartosz Golaszewski <brgl@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Srinivas Kandagatla <srini@kernel.org>
> Cc: linux-i2c@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> V2: Simplify the implementation, make devices with wp-gpios default
>     to read-only and let users unlock those devices via force_ro
>     sysfs attribute, just like eMMC HW BOOT partitions
> ---
>  drivers/nvmem/core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 311cb2e5a5c02..0b1942e389113 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -1019,6 +1019,12 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>  	if (rval)
>  		goto err_remove_dev;
>
> +	/* If the device has WP GPIO, default to read-only */
> +	if (nvmem->wp_gpio) {
> +		nvmem->read_only = true;
> +		gpiod_set_value_cansleep(nvmem->wp_gpio, 1);

Why is this needed if we already did:

	nvmem->wp_gpio = gpiod_get_optional(config->dev, "wp", GPIOD_OUT_HIGH);

?

Bart

> +	}
> +
>  #ifdef CONFIG_NVMEM_SYSFS
>  	rval = nvmem_populate_sysfs_cells(nvmem);
>  	if (rval)
> --
> 2.53.0
>
>
