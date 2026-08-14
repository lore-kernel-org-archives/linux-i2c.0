Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366A63E7BC4;
	Fri, 14 Aug 2026 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786704639; cv=none; b=hGseMoO1vgm84zCS6mWZd9eYczGenl61Xup5F8bj7Nsy91dNkqDOLT2hlBQnjalDBiheud7qrEPNYS3v3AONjPS242VBBH4GIZK5uif8UychPjM36Nz/cYhebZiGu8hZaHTKolHnF0Arom7sxJpu9XruRGYUaPRstp/K4X1aTvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786704639; c=relaxed/simple;
	bh=2Slq7BfV2veArz26Xz+0G16CbKrTuLeus7G2djTzJ8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V5B97FjdC2qaI44wSpRUwNdHDQIX2AQkvAuueg9LT2R1syF/NiyaR1MY36yhGRIIEKD3mc+AFj8AbQmywUQLwLvO4ssx+jNK1VcyglvU0j5S7Yk43tWEfixYOkSMIjTfFU4BJRdqASQhnkqzGY1Reo6CmiPsM5+topA8QjCc6MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=O1wawpXj; arc=none smtp.client-ip=188.68.63.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="O1wawpXj"
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4hLzWs166Qz6D4s;
	Fri, 14 Aug 2026 12:50:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1786704601;
	bh=2Slq7BfV2veArz26Xz+0G16CbKrTuLeus7G2djTzJ8Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O1wawpXjLPBIqgXQD6T+0puVRJ447eteenkDXuOEKyz4QucLjg5RmxZDSeZoAStJ1
	 krZJD5+71vnucX+YaTRqJlfqpkgbdbR+DR0iYa4PP2B2VCSLIi1/pDG4lzinzzpSqR
	 fmtHCyC2Nk0gg1pDTWAPnyS5+/8ImfUu4G63z2/TMt/9OwTMYCh+VJFtR44VPuXVD5
	 Cx70G7xbsl5V7hzko16xbWvKtfP0LVs/wJ8QBN6t03JQRNYrxCMJL5ApRcxm8FcMVK
	 by3W8yc6zhcY2HS0xElG6vUX4OHllYa694FgLoUteDBBCUClGJRQ0SPX4nZBPijbub
	 WQTOpADC3IVcA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4hLzWs0MFtz4yR7;
	Fri, 14 Aug 2026 12:50:01 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hLzWr3Hrwz8svk;
	Fri, 14 Aug 2026 12:50:00 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 374535FABB;
	Fri, 14 Aug 2026 12:49:55 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=linux@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <ba1fe2d7-ac65-4665-82cc-43800fa9ed12@leemhuis.info>
Date: Fri, 14 Aug 2026 12:49:54 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "i2c: designware: defer probe if child GpioInt
 controllers are not bound"
To: andi.shyti@kernel.org, linux-i2c@vger.kernel.org
Cc: linux-gpio@vger.kernel.org, wsa@kernel.org,
 Hardik Prakash <hardikprakash.official@gmail.com>,
 andriy.shevchenko@intel.com, mario.limonciello@amd.com, brgl@bgdev.pl,
 basavaraj.natikar@amd.com, linusw@kernel.org, nathan@kernel.org,
 chaitanya.kumar.borah@intel.com, regressions@leemhuis.info,
 linux-kernel@vger.kernel.org
References: <20260814100719.9548-1-hardikprakash.official@gmail.com>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: de-DE, en-US
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: <20260814100719.9548-1-hardikprakash.official@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178670459582.447294.14979340147217821489@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 374535FABB
X-NC-CID: 6vKNQ0l+MznL72/D+nmJQIMFHcZHuW9jUKibdKJ2tN/jiF5yQyY=

On 8/14/26 12:07, Hardik Prakash wrote:
> This reverts commit 0a4bb2abc3e56d7be6e69b050c88ba52c87e22bf.

@Andi Shyti, would be great if you could pick this up and send it to
Linus for 7.2 (aka soon) or ask him to apply this from here. But from a
quick search on lore it looks like you are busy, on vacation, or
something. No worries, but therefore I might ask Linus to pull this
directly tomorrow to ensure this makes it into 7.2, as mentioned
yesterday already here:
https://lore.kernel.org/all/9095d7c8-92fe-4163-98f8-a53bbcefd6cb@leemhuis.info/

> The reverted commit causes a regression on ThinkPad T14s Gen 4 (AMD):
> the touchpad's I2C controller fails with lost arbitration errors,
> because it delays i2c-designware's probe by roughly 500ms, which
> shifts the touchpad's first HID descriptor fetch into a window where
> the platform's embedded controller is still acting as a secondary I2C
> bus master. Debug tracing confirms the GpioInt dependency check itself
> behaves correctly (it defers appropriately and confirms the GPIO
> controller is bound); the arbitration failure happens roughly a
> second after the check passes, when i2c_hid_acpi's own probe attempts
> its first transaction.
> 
> The original fix is still needed for the Lenovo Yoga 7 14AGP11
> touchscreen race the commit addressed, but a corrected version will
> be resubmitted once the EC bus-mastering interaction is understood
> and handled properly, rather than reintroducing a different
> regression on more widely-used ThinkPad hardware in the meantime.
> 
> Reported-by: Thorsten Leemhuis <linux@leemhuis.info>

Tested-by: Thorsten Leemhuis <linux@leemhuis.info>

Ciao, Thorsten

> Closes: https://lore.kernel.org/all/b4a4eadb-282f-464c-843a-19d415a34d0c@leemhuis.info/
> Signed-off-by: Hardik Prakash <hardikprakash.official@gmail.com>
> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c | 80 ---------------------
>  1 file changed, 80 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index c8a203fff4d1..6d6e81242f74 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -8,14 +8,12 @@
>   * Copyright (C) 2007 MontaVista Software Inc.
>   * Copyright (C) 2009 Provigent Ltd.
>   */
> -#include <linux/acpi.h>
>  #include <linux/clk-provider.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/dmi.h>
>  #include <linux/err.h>
>  #include <linux/errno.h>
> -#include <linux/gpio/driver.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> @@ -132,80 +130,6 @@ static int i2c_dw_probe_lock_support(struct dw_i2c_dev *dev)
>  	return 0;
>  }
>  
> -#if defined(CONFIG_ACPI) && defined(CONFIG_GPIOLIB)
> -/*
> - * Check whether an ACPI GpioInt resource's referenced GPIO controller
> - * has finished probing. Resources with no named controller (resource
> - * source string) are skipped, since they can't be resolved to a
> - * struct device.
> - */
> -static int check_gpioint_resource(struct acpi_resource *ares, void *data)
> -{
> -	struct acpi_resource_gpio *agpio;
> -	struct acpi_device *gpio_adev;
> -	struct device *gpio_dev;
> -	acpi_handle handle;
> -	acpi_status status;
> -
> -	if (!acpi_gpio_get_irq_resource(ares, &agpio))
> -		return 1; /* not a GpioInt resource, skip */
> -
> -	if (!agpio->resource_source.string_length)
> -		return 1; /* no named controller, skip */
> -
> -	status = acpi_get_handle(NULL, agpio->resource_source.string_ptr, &handle);
> -	if (ACPI_FAILURE(status))
> -		return 1;
> -
> -	gpio_adev = acpi_fetch_acpi_dev(handle);
> -	if (!gpio_adev)
> -		return 1;
> -
> -	struct gpio_device *gdev __free(gpio_device_put) =
> -		gpio_device_find_by_fwnode(acpi_fwnode_handle(gpio_adev));
> -	if (!gdev)
> -		return -EPROBE_DEFER; /* controller not registered yet: abort walk */
> -
> -	gpio_dev = gpio_device_to_device(gdev)->parent;
> -
> -	guard(device)(gpio_dev);
> -	if (!device_is_bound(gpio_dev))
> -		return -EPROBE_DEFER; /* controller not bound yet: abort walk */
> -
> -	return 1; /* bound, skip adding to resource list, continue walk */
> -}
> -
> -static int check_child_gpioint(struct acpi_device *adev, void *data)
> -{
> -	LIST_HEAD(res_list);
> -	int ret;
> -
> -	ret = acpi_dev_get_resources(adev, &res_list, check_gpioint_resource, NULL);
> -	if (ret < 0)
> -		return ret;
> -
> -	acpi_dev_free_resource_list(&res_list);
> -
> -	return 0;
> -}
> -
> -static int i2c_dw_check_gpio_dependencies(struct device *dev)
> -{
> -	struct acpi_device *adev;
> -
> -	adev = ACPI_COMPANION(dev);
> -	if (!adev)
> -		return 0;
> -
> -	return acpi_dev_for_each_child(adev, check_child_gpioint, NULL);
> -}
> -#else
> -static int i2c_dw_check_gpio_dependencies(struct device *dev)
> -{
> -	return 0;
> -}
> -#endif /* CONFIG_ACPI && CONFIG_GPIOLIB */
> -
>  static int dw_i2c_plat_probe(struct platform_device *pdev)
>  {
>  	u32 flags = (uintptr_t)device_get_match_data(&pdev->dev);
> @@ -214,10 +138,6 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
>  	struct dw_i2c_dev *dev;
>  	int irq, ret;
>  
> -	ret = i2c_dw_check_gpio_dependencies(device);
> -	if (ret)
> -		return ret;
> -
>  	irq = platform_get_irq_optional(pdev, 0);
>  	if (irq == -ENXIO)
>  		flags |= ACCESS_POLLING;
> 
> base-commit: 3d6d817622b0a9721e3cc404df3469171582be13

