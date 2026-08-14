Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF21833F399;
	Fri, 14 Aug 2026 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786719354; cv=none; b=Z1KrjzF1pAWZMrR9U+WpO+MPjo8Rdc0PDwDtz1cHLEkHb/o8RRulQsU5u2Y6kuS0hfIULNqe2iU+ZwNHam1RfvGA2Jy5lUiMy0VI77i4166IeDubksHOmLAXle0rO3AJ34X+rb5TnVcACurUwf4cJHrbyd7THvpLPUjfstt0aqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786719354; c=relaxed/simple;
	bh=cI1qptQgGmh/0PLqMmqBt6Px0+LPlV8Kv3glNf0LNCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DOrWqKEAlq60c5z1xp5vcLlO6BwfRfBbPYrP9hS8Zz6N1oN7B2SeOKAHlsNuS2l9In7FJdzn+aKdrbkLQm/gKZZ7B5FAQod4zddyIuy9uCuH3CoiB0UkWede1GaAYSzgzttzaJii3+tzmVzEbm/9blrkf6hsic8Q6tNrmpRzVV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgtJKxfT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgtJKxfT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160C21F000E9;
	Fri, 14 Aug 2026 14:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786719352;
	bh=r/zZOYnzFvLEtjGFgJrq0XLFLH+9pGohXEf6ao7glVo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YgtJKxfTSjzYritFAwSl2kM8kKNdzZPhhAdBFMCov82xiu+U5z6o0SL+APuVbAVbv
	 zw7x3w58o6BSyGcvr+GeWW0YcegcZYviBZgUCYVnj6ixtPa452RGl+TLuDBaxv/gmF
	 rWSk6or0XO6Gybi+T90syCf4yn57SePz+LxIaEyPwpCyNa/+LLrlvT+Yu7gVQPv1Mi
	 5Ef2MZe2COMc1k4Gz+F50J1Mo87y5fJVtBH1mMgGW15Ldp5SAa8LkU4L60fAVf4HyR
	 4L3bqUZ5COXPMEQX0Wg1zCVUZMhum2VbVgmCwgndWlH2ZNRXMII4nGJ9xAPa+4kNo9
	 OH+b8j4Zna29w==
Message-ID: <cda84d69-89d2-46f6-9c86-a758bf385f54@kernel.org>
Date: Fri, 14 Aug 2026 09:55:49 -0500
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "i2c: designware: defer probe if child GpioInt
 controllers are not bound"
Content-Language: en-US
To: Hardik Prakash <hardikprakash.official@gmail.com>,
 linux-i2c@vger.kernel.org
Cc: linux-gpio@vger.kernel.org, wsa@kernel.org, andriy.shevchenko@intel.com,
 brgl@bgdev.pl, basavaraj.natikar@amd.com, linusw@kernel.org,
 nathan@kernel.org, chaitanya.kumar.borah@intel.com, andi.shyti@kernel.org,
 linux@leemhuis.info, regressions@leemhuis.info, linux-kernel@vger.kernel.org
References: <20260814100719.9548-1-hardikprakash.official@gmail.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260814100719.9548-1-hardikprakash.official@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/14/26 05:07, Hardik Prakash wrote:
> This reverts commit 0a4bb2abc3e56d7be6e69b050c88ba52c87e22bf.
> 
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
> Closes: https://lore.kernel.org/all/b4a4eadb-282f-464c-843a-19d415a34d0c@leemhuis.info/
> Signed-off-by: Hardik Prakash <hardikprakash.official@gmail.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>> ---
>   drivers/i2c/busses/i2c-designware-platdrv.c | 80 ---------------------
>   1 file changed, 80 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index c8a203fff4d1..6d6e81242f74 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -8,14 +8,12 @@
>    * Copyright (C) 2007 MontaVista Software Inc.
>    * Copyright (C) 2009 Provigent Ltd.
>    */
> -#include <linux/acpi.h>
>   #include <linux/clk-provider.h>
>   #include <linux/clk.h>
>   #include <linux/delay.h>
>   #include <linux/dmi.h>
>   #include <linux/err.h>
>   #include <linux/errno.h>
> -#include <linux/gpio/driver.h>
>   #include <linux/i2c.h>
>   #include <linux/interrupt.h>
>   #include <linux/io.h>
> @@ -132,80 +130,6 @@ static int i2c_dw_probe_lock_support(struct dw_i2c_dev *dev)
>   	return 0;
>   }
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
>   static int dw_i2c_plat_probe(struct platform_device *pdev)
>   {
>   	u32 flags = (uintptr_t)device_get_match_data(&pdev->dev);
> @@ -214,10 +138,6 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
>   	struct dw_i2c_dev *dev;
>   	int irq, ret;
>   
> -	ret = i2c_dw_check_gpio_dependencies(device);
> -	if (ret)
> -		return ret;
> -
>   	irq = platform_get_irq_optional(pdev, 0);
>   	if (irq == -ENXIO)
>   		flags |= ACCESS_POLLING;
> 
> base-commit: 3d6d817622b0a9721e3cc404df3469171582be13

