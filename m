Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E55B400996;
	Tue, 28 Jul 2026 08:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785227460; cv=none; b=qpXvZWXK4uaGbgq9P0ulpBmlEVQOIN/Lj45dyaZ4VeiATeInnPhNzWtKvpa9t3zuqhpA0o8P0/t6R5gp2vngnfouAYYdtblGadJY3niqE0wMey0L+WeKSN9kRVvSHDGerfQXzdABfgGk0//PWnWAn5c6XDjjxr35Z0c4l4ruPUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785227460; c=relaxed/simple;
	bh=4mRZ1E33uUWVognT8iSTdIxl57jSwCTimss1LD4NGEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgIkKCT2KKJPQbn9ax4Ak0r+NhygZ+UZ0lhROqJ/C4fPU5AHNZC0/H23qWG2ME8n30K0rDuYWUPwRJqco6Un3RlvSEGd7W+Ehe4QtHKNMCMCzHQ0nHbXFcl1EepbDLB7J39T0C1X2NiwyP4WEMX/1u/T+2ILbBaUXOK6G9acaVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOtCERTM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOtCERTM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2873E1F000E9;
	Tue, 28 Jul 2026 08:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785227458;
	bh=EZEIVIWP6rHMILD6MHiFQqIs2luNVm4p4VbDh2UlzgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XOtCERTML7f6QxvV8IpQzU4v19NkFlHkPR2KAzzxEKgGZnfqaJ/Hwp4QnuGf0V0uR
	 Yhtbf8ZToZTTbAiKYUHRTE0k2QLriCmHZGVKNaz/YIcMHPp76rrnyZTFpTYCSu1NkU
	 HT0wRn72lpr6D4juKrzyH+pLPX4kvNYOwVnKuTacCJ/NiuSARl7GGeci17XBqG1W5k
	 hE2N3x0UOfKG6yWfmf9t+R5bUJjSi+Vb/4XBLabwL7rauRnDYHZR2T+RWnnANfAAE6
	 LK4JrGtKY5+mCXe2F/Fn4snttPIAZAnVe3TdSJdN51ZNy67rbrP9SJQWMDdToB/YEe
	 fE+OW0klSbTyg==
Date: Tue, 28 Jul 2026 10:30:54 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Hardik Prakash <hardikprakash.official@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org, 
	andriy.shevchenko@intel.com, mario.limonciello@amd.com, brgl@bgdev.pl, 
	basavaraj.natikar@amd.com, linusw@kernel.org, nathan@kernel.org, 
	chaitanya.kumar.borah@intel.com
Subject: Re: [PATCH v13] i2c: designware: defer probe if child GpioInt
 controllers are not bound
Message-ID: <amhodWpAI3K6aeBH@zenone.zhora.eu>
References: <20260718054330.8975-2-hardikprakash.official@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718054330.8975-2-hardikprakash.official@gmail.com>

Hi Hardik,

On Sat, Jul 18, 2026 at 11:13:31AM +0530, Hardik Prakash wrote:
> I2C controllers may have child devices with GpioInt resources that
> depend on GPIO controllers being fully initialized. If the I2C
> controller probes and enumerates children before the referenced GPIO
> controller has completed probe, GPIO interrupts may not be properly
> configured, leading to device failures.
> 
> On Lenovo Yoga 7 14AGP11, the WACF2200 touchscreen (child of
> AMDI0010:02) has a GpioInt resource pointing to GPIO 157 on the
> pinctrl-amd controller (AMDI0030:00). When i2c-designware probes
> AMDI0010:02 before pinctrl-amd finishes initializing, I2C transactions
> fail with lost arbitration errors:
> 
>   0.285952  amd_gpio_probe: registering gpiochip  <- GPIO chip visible
>   0.287121  amd_gpio_probe: requesting parent IRQ <- probe still running
>   0.301454  AMDI0010:02 dw_i2c_plat_probe: start  <- races here
>   2.348157  lost arbitration
> 
> Add a dependency check that walks ACPI child devices and defers probe
> until any referenced GPIO controller is bound.
> 
> Fixes: 3812a9e84265 ("pinctrl-amd: enable IRQ for WACF2200 touchscreen on Lenovo Yoga 7 14AGP11")
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Hardik Prakash <hardikprakash.official@gmail.com>
> Assisted-by: Claude:claude-sonnet-5
> Assisted-by: DeepSeek:deepseek-v4-pro
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221494

This should be "Closes:". "Link:" is referred to the page where
the patch has been discussed.

merged to i2c/i2c-fixes.

Thanks,
Andi

> ---
> v12 -> v13:
> - v12 was sent as an incomplete diff (generated against v11 rather than
>   against current master due to a git format-patch invocation mistake on
>   my end), not a real standalone patch (Andy Shevchenko)
> - Not carrying forward Bartosz Golaszewski's v12 Acked-by, per Andy's
>   request
> - Add blank line before guard(device)(gpio_dev) for readability (Andy
>   Shevchenko)
> - No other functional code changes since v12
> 
> v11 -> v12:
> - Move gdev declaration to point of use with gpio_device_find_by_fwnode()
>   call (Andy Shevchenko)
> - Extract acpi_get_handle() return into acpi_status variable rather than
>   inline in ACPI_FAILURE() (Andy Shevchenko)
> - Use guard(device)(...) instead of scoped_guard(device, ...) {} for a
>   single following statement (Andy Shevchenko)
> - Use LIST_HEAD(res_list) instead of separate declaration + INIT_LIST_HEAD()
>   (Andy Shevchenko)
> - Check acpi_dev_get_resources() error before freeing the resource list,
>   restoring the check-then-free ordering that had regressed in v11
>   (Andy Shevchenko)
> - Split ACPI_COMPANION(dev) assignment onto its own line rather than at
>   declaration (Andy Shevchenko)
> 
> v10 -> v11:
> - Replaced custom gpio_controller_ref list and dedup logic with
>   gpio_device_find_by_fwnode() (Suggested-by: Andy Shevchenko)
> - Moved resource-skip explanation from commit message into a code comment
> - Fixed device_is_bound() to check gpio_device_to_device(gdev)->parent
>   rather than the gpio_device's own internal class device, which is
>   registered on the synthetic "gpio" bus and never has a driver bound to it
> 
> v9 -> v10:
> - Use acpi_gpio_get_irq_resource() instead of open-coding GPIO resource
>   type checks, eliminating duplication with gpiolib-acpi (Andy Shevchenko)
> - Simplify string_source guard to a single string_length check, confirmed
>   sufficient via ACPICA parser in drivers/acpi/acpica/rsutils.c
>   (Andy Shevchenko)
> - acpi_dev_get_resources() on single line, free only on success path
>   (Andy Shevchenko)
> - Reversed xmas tree ordering for variable declarations (Andy Shevchenko)
> - Removed useless int ret = 0 assignment (Andy Shevchenko)
> - acpi_dev_for_each_child() on single line (Andy Shevchenko)
> - Use guard(device)(gpio_dev) pattern to avoid uninitialized variable
>   warning and deduplicate the !gpio_dev check (Andy Shevchenko)
> 
> v8 -> v9:
> - Sent as a 2-patch series: revert of the broken v8 patch, plus a
>   corrected resubmission
> - Use acpi_gpio_get_irq_resource() instead of open-coding GPIO resource
>   type checks, eliminating duplication with gpiolib-acpi (Andy Shevchenko)
> - Remove gpio_dep_ctx wrapper struct, pass list_head * directly (Andy Shevchenko)
> - Add const to gpio_controller_ref.path (Andy Shevchenko)
> - Add NULL check for resource_source.string_ptr to fix a crash on hardware
>   where GPIO resources have no named controller (Reported-by: Nathan
>   Chancellor, Reported-by: Chaitanya Kumar Borah)
> - Use acpi_dev_get_resources() return value properly (Andy Shevchenko)
> - Fix all error paths to call free_gpio_controller_list() (Andy Shevchenko)
> - Change guard to #if defined(CONFIG_ACPI) && defined(CONFIG_GPIOLIB)
> - Remove erroneous put_device() calls -- acpi_get_first_physical_node()
>   returns a borrowed pointer with no refcount increment
> - Use LIST_HEAD() macro, split adev declaration and assignment (Andy Shevchenko)
> - scoped_guard single statement without braces (Andy Shevchenko)
> - Remove misused Reported-by/Closes tags (Andy Shevchenko)
> 
> v7 -> v8:
> - Add revert of the earlier pinctrl-amd DMI quirk (patch 1 of the original
>   v1-v7 series), confirmed unnecessary once probe ordering is fixed
>   (Mario Limonciello)
> - Collect Acked-by (Bartosz Golaszewski) and Reviewed-by (Mario Limonciello)
> 
> v6 -> v7:
> - Fix unused 'ret' variable in check_child_gpioint() (kernel test robot)
> - Replace BugLink: with Link: (Bartosz Golaszewski)
> - Add Reported-by and Closes tags for kernel test robot warning
> 
> v5 -> v6:
> - Replace DMI-specific deferral with a generic GpioInt dependency check
>   walking ACPI child devices (Suggested-by: Mario Limonciello)
> 
> v4 -> v5:
> - Add blank line before #include <linux/acpi.h> (Bartosz Golaszewski)
> - Use scoped_guard(device, gpio_dev) (Bartosz Golaszewski)
> 
> v3 -> v4:
> - Rebase onto Linus Walleij's tree (the original patch 1 already there)
> - Use --base so series is correctly 1/1 (Andy Shevchenko)
> 
> v2 -> v3:
> - Fix variable declaration style (Andy Shevchenko)
> - Add BugLink tag (Andy Shevchenko)
> - CC AMD engineers (Andy Shevchenko)
> 
> v1 -> v2:
> - Replace custom HID/UID lookup with acpi_dev_get_first_match_dev()
> - Use device_is_bound() under device_lock() with explanatory comments
> - Add Assisted-by tags per coding-assistants.rst
> 
> Note: this patch was originally part of a 2-patch series (v1-v7) whose
> first patch was a DMI-specific pinctrl-amd IRQ quirk; that patch was
> merged separately into Linus Walleij's tree at v1 and later reverted at
> v8 once this patch made the manual IRQ restoration unnecessary.
> 
>  drivers/i2c/busses/i2c-designware-platdrv.c | 80 +++++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 6d6e81242f74..c8a203fff4d1 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -8,12 +8,14 @@
>   * Copyright (C) 2007 MontaVista Software Inc.
>   * Copyright (C) 2009 Provigent Ltd.
>   */
> +#include <linux/acpi.h>
>  #include <linux/clk-provider.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/dmi.h>
>  #include <linux/err.h>
>  #include <linux/errno.h>
> +#include <linux/gpio/driver.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> @@ -130,6 +132,80 @@ static int i2c_dw_probe_lock_support(struct dw_i2c_dev *dev)
>  	return 0;
>  }
>  
> +#if defined(CONFIG_ACPI) && defined(CONFIG_GPIOLIB)
> +/*
> + * Check whether an ACPI GpioInt resource's referenced GPIO controller
> + * has finished probing. Resources with no named controller (resource
> + * source string) are skipped, since they can't be resolved to a
> + * struct device.
> + */
> +static int check_gpioint_resource(struct acpi_resource *ares, void *data)
> +{
> +	struct acpi_resource_gpio *agpio;
> +	struct acpi_device *gpio_adev;
> +	struct device *gpio_dev;
> +	acpi_handle handle;
> +	acpi_status status;
> +
> +	if (!acpi_gpio_get_irq_resource(ares, &agpio))
> +		return 1; /* not a GpioInt resource, skip */
> +
> +	if (!agpio->resource_source.string_length)
> +		return 1; /* no named controller, skip */
> +
> +	status = acpi_get_handle(NULL, agpio->resource_source.string_ptr, &handle);
> +	if (ACPI_FAILURE(status))
> +		return 1;
> +
> +	gpio_adev = acpi_fetch_acpi_dev(handle);
> +	if (!gpio_adev)
> +		return 1;
> +
> +	struct gpio_device *gdev __free(gpio_device_put) =
> +		gpio_device_find_by_fwnode(acpi_fwnode_handle(gpio_adev));
> +	if (!gdev)
> +		return -EPROBE_DEFER; /* controller not registered yet: abort walk */
> +
> +	gpio_dev = gpio_device_to_device(gdev)->parent;
> +
> +	guard(device)(gpio_dev);
> +	if (!device_is_bound(gpio_dev))
> +		return -EPROBE_DEFER; /* controller not bound yet: abort walk */
> +
> +	return 1; /* bound, skip adding to resource list, continue walk */
> +}
> +
> +static int check_child_gpioint(struct acpi_device *adev, void *data)
> +{
> +	LIST_HEAD(res_list);
> +	int ret;
> +
> +	ret = acpi_dev_get_resources(adev, &res_list, check_gpioint_resource, NULL);
> +	if (ret < 0)
> +		return ret;
> +
> +	acpi_dev_free_resource_list(&res_list);
> +
> +	return 0;
> +}
> +
> +static int i2c_dw_check_gpio_dependencies(struct device *dev)
> +{
> +	struct acpi_device *adev;
> +
> +	adev = ACPI_COMPANION(dev);
> +	if (!adev)
> +		return 0;
> +
> +	return acpi_dev_for_each_child(adev, check_child_gpioint, NULL);
> +}
> +#else
> +static int i2c_dw_check_gpio_dependencies(struct device *dev)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_ACPI && CONFIG_GPIOLIB */
> +
>  static int dw_i2c_plat_probe(struct platform_device *pdev)
>  {
>  	u32 flags = (uintptr_t)device_get_match_data(&pdev->dev);
> @@ -138,6 +214,10 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
>  	struct dw_i2c_dev *dev;
>  	int irq, ret;
>  
> +	ret = i2c_dw_check_gpio_dependencies(device);
> +	if (ret)
> +		return ret;
> +
>  	irq = platform_get_irq_optional(pdev, 0);
>  	if (irq == -ENXIO)
>  		flags |= ACCESS_POLLING;
> 
> base-commit: 58717b2a1365d06c8c64b72aa948541b53fe31eb
> -- 
> 2.54.0
> 
