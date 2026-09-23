Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC3F3750C4;
	Wed, 23 Sep 2026 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790175782; cv=none; b=tojBpDGh3Q0s/Da/LpaWu1xWlPxzcbPjjnmeDWb5UTTwJjyNB9XzXiWjxsAG527qVWVw7q1zh9omgaKv35TE9lgQYvVIlhSRisqtkZSaHn5w7kjUaOfRzUIJeAJjglnDQTIeomdo0WpnRQz8x6GJ9TDabDewD1n/YOZcEIU6PJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790175782; c=relaxed/simple;
	bh=g4yztPLF14IFKat6B/4l1+1nklLi8lbpN+VrOZgaHGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBqrAGS7rhZ41e9QpLs88KrTx26tuYyuhRx9AXK1vhzKLhVFIs2985Z22E9TJFWw15Y/02D847R8Pz8dy7or9UoEm6D++0mppRdq0NUuXDwklZN2mfCY1eTiFKIkRvjSZ8yQ3i4MF+gYjPY0CIYkYzqkmL9T3Iwb88IlFr0LE8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNtMUE8X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNtMUE8X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFED1F000FF;
	Wed, 23 Sep 2026 15:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790175779;
	bh=OCxq+ZHhtCCy9E971jUUATPIiEsaqmg1t95wT9gz/IE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WNtMUE8XTGSA/CgJBnZEdZIlrnSlkUN4U2POw3LpaQmujhBHigtisLzC5E60+TiUy
	 tSvuueuA3HukTbJpd69VQxex59xqTDJnqy2xSMhoQ16IVYoZwnHRD7wHI0/XMqNud0
	 q6XP4QaGShXVKvFfV/KKV1cbiWiPQCjtbMTbBNjNL2/STS4UWhfpyw9ZXEHYJFBpD5
	 R2MJ6SlIBpvBtBYkJtThW43MrtVQqhO7JCqSWAlgBWA6HIFfB+VoR6NdYOHK1hXUyq
	 0L5YpZ1P/aXlpBn8282dd5mGMXd8E5c1MtChIoV9f7pZCIwgu/HVrRQaWYU09mbkJf
	 /QjSH4aYZBlbQ==
Date: Wed, 23 Sep 2026 16:02:54 +0100
From: Lee Jones <lee@kernel.org>
To: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v3 2/9] mfd: cgbc: Add I2C platform data
Message-ID: <20260923150254.GH3864833@google.com>
References: <20260911-cgbc-i2c-storage-devices-support-v3-0-594b53fbc5ea@bootlin.com>
 <20260911-cgbc-i2c-storage-devices-support-v3-2-594b53fbc5ea@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-cgbc-i2c-storage-devices-support-v3-2-594b53fbc5ea@bootlin.com>

On Fri, 11 Sep 2026, Thomas Richard (congatec GmbH) wrote:

> Define I2C platform data for each I2C bus in the cgbc MFD driver. Platform
> data passes per-bus parameters to the I2C driver, rather than being defined
> inside the i2c-cgbc driver itself. This makes the i2c-cgbc driver more
> generic.
> 
> Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
> ---
>  MAINTAINERS                            |  1 +
>  drivers/mfd/cgbc-core.c                | 39 ++++++++++++++++++++++++++--------
>  include/linux/platform_data/i2c-cgbc.h | 22 +++++++++++++++++++
>  3 files changed, 53 insertions(+), 9 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6215fcb07770..561f102c2541 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6621,6 +6621,7 @@ F:	drivers/mfd/cgbc-core.c
>  F:	drivers/video/backlight/cgbc_bl.c
>  F:	drivers/watchdog/cgbc_wdt.c
>  F:	include/linux/mfd/cgbc.h
> +F:	include/linux/platform_data/i2c-cgbc.h
>  
>  CONSOLE SUBSYSTEM
>  M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
> index 4a409234e66c..321fa3fff2ac 100644
> --- a/drivers/mfd/cgbc-core.c
> +++ b/drivers/mfd/cgbc-core.c
> @@ -16,6 +16,7 @@
>  #include <linux/mfd/cgbc.h>
>  #include <linux/mfd/core.h>
>  #include <linux/module.h>
> +#include <linux/platform_data/i2c-cgbc.h>
>  #include <linux/platform_device.h>
>  #include <linux/sysfs.h>
>  
> @@ -55,6 +56,35 @@
>  
>  static struct platform_device *cgbc_pdev;
>  
> +static const struct cgbc_i2c_platform_data cgbc_i2c_gp_pdata = {
> +	.name = "Congatec General Purpose I2C adapter",
> +	.cgbc_bus_id = 0,
> +};
> +
> +static const struct cgbc_i2c_platform_data cgbc_i2c_pm_pdata = {
> +	.name  = "Congatec Power Management I2C adapter",
> +	.cgbc_bus_id = 4,
> +};
> +
> +static const struct mfd_cell cgbc_devs[] = {
> +	{ .name = "cgbc-backlight" },

MFD_CELL_*

> +	{ .name = "cgbc-gpio" },
> +	{ .name = "cgbc-hwmon" },
> +	{
> +		.name = "cgbc-i2c",
> +		.id = 1,

Why does PLATFORM_DEVID_AUTO not work for you?

> +		.platform_data = &cgbc_i2c_gp_pdata,
> +		.pdata_size = sizeof(cgbc_i2c_gp_pdata),
> +	},
> +	{
> +		.name = "cgbc-i2c",
> +		.id = 2,
> +		.platform_data = &cgbc_i2c_pm_pdata,
> +		.pdata_size = sizeof(cgbc_i2c_pm_pdata),
> +	},
> +	{ .name = "cgbc-wdt" },
> +};
> +
>  /* Wait the Board Controller is ready to receive some session commands */
>  static int cgbc_wait_device(struct cgbc_device_data *cgbc)
>  {
> @@ -235,15 +265,6 @@ int cgbc_command(struct cgbc_device_data *cgbc, void *cmd, unsigned int cmd_size
>  }
>  EXPORT_SYMBOL_GPL(cgbc_command);
>  
> -static struct mfd_cell cgbc_devs[] = {
> -	{ .name = "cgbc-wdt"	},
> -	{ .name = "cgbc-gpio"	},
> -	{ .name = "cgbc-i2c", .id = 1 },
> -	{ .name = "cgbc-i2c", .id = 2 },
> -	{ .name = "cgbc-hwmon"	},
> -	{ .name = "cgbc-backlight" },
> -};
> -
>  static int cgbc_map(struct cgbc_device_data *cgbc)
>  {
>  	struct device *dev = cgbc->dev;
> diff --git a/include/linux/platform_data/i2c-cgbc.h b/include/linux/platform_data/i2c-cgbc.h
> new file mode 100644
> index 000000000000..4465e8a7b40e
> --- /dev/null
> +++ b/include/linux/platform_data/i2c-cgbc.h

I think this area is mainly used to share data with OF.

Did you consider include/linux/mfd?

> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * i2c-cgbc interface to platform code
> + *
> + * Copyright (C) 2026 congatec GmbH
> + * Author: Thomas Richard <thomas.richard@bootlin.com>
> + */
> +
> +#ifndef _LINUX_I2C_CGBC_H
> +#define _LINUX_I2C_CGBC_H
> +
> +/**
> + * struct cgbc_platform_data - Platform data of the CGBC I2C driver
> + * @name:		I2C adapter name
> + * @cgbc_bus_id:	I2C bus ID (from Board Controller point of view)
> + */
> +struct cgbc_i2c_platform_data {
> +	const char *name;
> +	int cgbc_bus_id;
> +};
> +
> +#endif /* _LINUX_I2C_CGBC_H */
> 
> -- 
> 2.53.0
> 

-- 
Lee Jones
