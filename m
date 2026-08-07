Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DBA28DB54;
	Fri,  7 Aug 2026 14:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111664; cv=none; b=F7rwb068bkSbM9M4bpXEsddCda+mNFa/+nKoESqtFRoZVBUQLsO5jiDolPO2lszdug+k/zoUHoa5rW6MejA70MT7EqKrfb9DHMHOK5oC8YIeKRDVsYmHA+G02Y6xXiKX4xSuDnnLeMJ9vVpDKH86sd3uuCJUgl2midt82smq/P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111664; c=relaxed/simple;
	bh=OlINJuSfHyW+KxBCr6ii0RuJGP+wReHA7vLxUxoQDUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hs+E3v3u/ylC0viq2oSngTWTvxXFNdvsWGFt4Bx/A2qWB3shooA+kSXHPIuKC7eI2QhhpcKODGB9r+gdVFT7wUPMUPDE8yv0nKxrGNNgwULuUtTVaTqQMyhe7m3Z5ejJBX4N6Nbl93NwrzzSXt9HA8F2y3cYRfaxOdCn4oAr1K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=XZhgm+Xc; arc=none smtp.client-ip=188.68.63.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="XZhgm+Xc"
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4hGmDz5DWBz6B07;
	Fri,  7 Aug 2026 16:07:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1786111651;
	bh=OlINJuSfHyW+KxBCr6ii0RuJGP+wReHA7vLxUxoQDUs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XZhgm+XcMW42+KFAcl6TJwtEAkWGVLFxaOJs7qbSiWppkQ6rm46JgaCDxH8JesSKq
	 uBP17nRPvsv63FWQ0Vz5VyGk3KO9h0d+dMTm3elWMDjnK6Z95V09LHFIPd2CWasZO5
	 29Sv/EjWvPJ4WgoInWIs/qvw5NLG6THLBwesd+Y5qcO3qXnRkqbAgVgF5kjdtY+Io3
	 aoKB9xSET34HS62ioVyMH+OshxTo7KpuV6iw6dKOiVjwb7CiEKyOAKCPkWx5aa/d+y
	 mj2IebJZgGVfV1af8I5rQodLVGnLrtSRXCVPSbeQUUyxp7fGn7wdcCZ6yUi3DyIeD1
	 /3dHKOJsB2QVA==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4hGmDz4TcTz4wjk;
	Fri,  7 Aug 2026 16:07:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4hGmDx5slkz8tYb;
	Fri,  7 Aug 2026 16:07:29 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id BE53C5FA52;
	Fri,  7 Aug 2026 16:07:24 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=linux@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <b4a4eadb-282f-464c-843a-19d415a34d0c@leemhuis.info>
Date: Fri, 7 Aug 2026 16:07:23 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: i2c designware change broke touchpad of a thinkpad (was: i2c:
 designware: defer probe if child GpioInt controllers are not bound)
To: Andi Shyti <andi.shyti@kernel.org>,
 Hardik Prakash <hardikprakash.official@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org,
 andriy.shevchenko@intel.com, mario.limonciello@amd.com, brgl@bgdev.pl,
 basavaraj.natikar@amd.com, linusw@kernel.org, nathan@kernel.org,
 chaitanya.kumar.borah@intel.com,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260718054330.8975-2-hardikprakash.official@gmail.com>
 <amhodWpAI3K6aeBH@zenone.zhora.eu>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: de-DE, en-US
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: <amhodWpAI3K6aeBH@zenone.zhora.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <178611164533.1324321.17645473351261494769@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: BE53C5FA52
X-NC-CID: sxMiVO3Cy4RDvxaFE024WLSZ8Wt856n00+g3iclWmsXiUVO8x1s=

On 7/28/26 10:30, Andi Shyti wrote:
> On Sat, Jul 18, 2026 at 11:13:31AM +0530, Hardik Prakash wrote:
>> I2C controllers may have child devices with GpioInt resources that
>> depend on GPIO controllers being fully initialized. If the I2C
>> controller probes and enumerates children before the referenced GPIO
>> controller has completed probe, GPIO interrupts may not be properly
>> configured, leading to device failures.
>>
>> On Lenovo Yoga 7 14AGP11, the WACF2200 touchscreen (child of
>> AMDI0010:02) has a GpioInt resource pointing to GPIO 157 on the
>> pinctrl-amd controller (AMDI0030:00). When i2c-designware probes
>> AMDI0010:02 before pinctrl-amd finishes initializing, I2C transactions
>> fail with lost arbitration errors:
>>
>>   0.285952  amd_gpio_probe: registering gpiochip  <- GPIO chip visible
>>   0.287121  amd_gpio_probe: requesting parent IRQ <- probe still running
>>   0.301454  AMDI0010:02 dw_i2c_plat_probe: start  <- races here
>>   2.348157  lost arbitration
>>
>> Add a dependency check that walks ACPI child devices and defers probe
>> until any referenced GPIO controller is bound.
>>
>> Fixes: 3812a9e84265 ("pinctrl-amd: enable IRQ for WACF2200 touchscreen on Lenovo Yoga 7 14AGP11")
>> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
>> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> [...]
> merged to i2c/i2c-fixes.
> 
> Thanks,
> Andi

This became 0a4bb2abc3e56d ("i2c: designware: defer probe if child
GpioInt controllers are not bound") and causes a regression for me: the
Touchpad in my ThinkPad T14s Gen 4 (AMD) stopped working. From the
kernel log:

i2c_designware AMDI0010:01: i2c_dw_handle_tx_abort: lost arbitration
i2c_designware AMDI0010:01: controller timed out
i2c_hid_acpi i2c-SYNA8018:00: failed to fetch HID descriptor: -110
i2c_hid_acpi i2c-SYNA8018:00: Failed to fetch the HID Descriptor

Reverting this change in current mainline/master (f9a2394a23482) fixed
things for me. Full dmesg of current master and master+revert can be
found here:

https://www.leemhuis.info/files/misc/dmesg-master
https://www.leemhuis.info/files/misc/dmesg-master-plus_revert

Ciao, Thorsten

#regzbot introduced: 0a4bb2abc3e56d
#regzbot title i2c: designware: ThinkPad touchpad broke

>> ---
>> v12 -> v13:
>> - v12 was sent as an incomplete diff (generated against v11 rather than
>>   against current master due to a git format-patch invocation mistake on
>>   my end), not a real standalone patch (Andy Shevchenko)
>> - Not carrying forward Bartosz Golaszewski's v12 Acked-by, per Andy's
>>   request
>> - Add blank line before guard(device)(gpio_dev) for readability (Andy
>>   Shevchenko)
>> - No other functional code changes since v12
>>
>> v11 -> v12:
>> - Move gdev declaration to point of use with gpio_device_find_by_fwnode()
>>   call (Andy Shevchenko)
>> - Extract acpi_get_handle() return into acpi_status variable rather than
>>   inline in ACPI_FAILURE() (Andy Shevchenko)
>> - Use guard(device)(...) instead of scoped_guard(device, ...) {} for a
>>   single following statement (Andy Shevchenko)
>> - Use LIST_HEAD(res_list) instead of separate declaration + INIT_LIST_HEAD()
>>   (Andy Shevchenko)
>> - Check acpi_dev_get_resources() error before freeing the resource list,
>>   restoring the check-then-free ordering that had regressed in v11
>>   (Andy Shevchenko)
>> - Split ACPI_COMPANION(dev) assignment onto its own line rather than at
>>   declaration (Andy Shevchenko)
>>
>> v10 -> v11:
>> - Replaced custom gpio_controller_ref list and dedup logic with
>>   gpio_device_find_by_fwnode() (Suggested-by: Andy Shevchenko)
>> - Moved resource-skip explanation from commit message into a code comment
>> - Fixed device_is_bound() to check gpio_device_to_device(gdev)->parent
>>   rather than the gpio_device's own internal class device, which is
>>   registered on the synthetic "gpio" bus and never has a driver bound to it
>>
>> v9 -> v10:
>> - Use acpi_gpio_get_irq_resource() instead of open-coding GPIO resource
>>   type checks, eliminating duplication with gpiolib-acpi (Andy Shevchenko)
>> - Simplify string_source guard to a single string_length check, confirmed
>>   sufficient via ACPICA parser in drivers/acpi/acpica/rsutils.c
>>   (Andy Shevchenko)
>> - acpi_dev_get_resources() on single line, free only on success path
>>   (Andy Shevchenko)
>> - Reversed xmas tree ordering for variable declarations (Andy Shevchenko)
>> - Removed useless int ret = 0 assignment (Andy Shevchenko)
>> - acpi_dev_for_each_child() on single line (Andy Shevchenko)
>> - Use guard(device)(gpio_dev) pattern to avoid uninitialized variable
>>   warning and deduplicate the !gpio_dev check (Andy Shevchenko)
>>
>> v8 -> v9:
>> - Sent as a 2-patch series: revert of the broken v8 patch, plus a
>>   corrected resubmission
>> - Use acpi_gpio_get_irq_resource() instead of open-coding GPIO resource
>>   type checks, eliminating duplication with gpiolib-acpi (Andy Shevchenko)
>> - Remove gpio_dep_ctx wrapper struct, pass list_head * directly (Andy Shevchenko)
>> - Add const to gpio_controller_ref.path (Andy Shevchenko)
>> - Add NULL check for resource_source.string_ptr to fix a crash on hardware
>>   where GPIO resources have no named controller (Reported-by: Nathan
>>   Chancellor, Reported-by: Chaitanya Kumar Borah)
>> - Use acpi_dev_get_resources() return value properly (Andy Shevchenko)
>> - Fix all error paths to call free_gpio_controller_list() (Andy Shevchenko)
>> - Change guard to #if defined(CONFIG_ACPI) && defined(CONFIG_GPIOLIB)
>> - Remove erroneous put_device() calls -- acpi_get_first_physical_node()
>>   returns a borrowed pointer with no refcount increment
>> - Use LIST_HEAD() macro, split adev declaration and assignment (Andy Shevchenko)
>> - scoped_guard single statement without braces (Andy Shevchenko)
>> - Remove misused Reported-by/Closes tags (Andy Shevchenko)
>>
>> v7 -> v8:
>> - Add revert of the earlier pinctrl-amd DMI quirk (patch 1 of the original
>>   v1-v7 series), confirmed unnecessary once probe ordering is fixed
>>   (Mario Limonciello)
>> - Collect Acked-by (Bartosz Golaszewski) and Reviewed-by (Mario Limonciello)
>>
>> v6 -> v7:
>> - Fix unused 'ret' variable in check_child_gpioint() (kernel test robot)
>> - Replace BugLink: with Link: (Bartosz Golaszewski)
>> - Add Reported-by and Closes tags for kernel test robot warning
>>
>> v5 -> v6:
>> - Replace DMI-specific deferral with a generic GpioInt dependency check
>>   walking ACPI child devices (Suggested-by: Mario Limonciello)
>>
>> v4 -> v5:
>> - Add blank line before #include <linux/acpi.h> (Bartosz Golaszewski)
>> - Use scoped_guard(device, gpio_dev) (Bartosz Golaszewski)
>>
>> v3 -> v4:
>> - Rebase onto Linus Walleij's tree (the original patch 1 already there)
>> - Use --base so series is correctly 1/1 (Andy Shevchenko)
>>
>> v2 -> v3:
>> - Fix variable declaration style (Andy Shevchenko)
>> - Add BugLink tag (Andy Shevchenko)
>> - CC AMD engineers (Andy Shevchenko)
>>
>> v1 -> v2:
>> - Replace custom HID/UID lookup with acpi_dev_get_first_match_dev()
>> - Use device_is_bound() under device_lock() with explanatory comments
>> - Add Assisted-by tags per coding-assistants.rst
>>
>> Note: this patch was originally part of a 2-patch series (v1-v7) whose
>> first patch was a DMI-specific pinctrl-amd IRQ quirk; that patch was
>> merged separately into Linus Walleij's tree at v1 and later reverted at
>> v8 once this patch made the manual IRQ restoration unnecessary.
>>
>>  drivers/i2c/busses/i2c-designware-platdrv.c | 80 +++++++++++++++++++++
>>  1 file changed, 80 insertions(+)
>>
>> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
>> index 6d6e81242f74..c8a203fff4d1 100644
>> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
>> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
>> @@ -8,12 +8,14 @@
>>   * Copyright (C) 2007 MontaVista Software Inc.
>>   * Copyright (C) 2009 Provigent Ltd.
>>   */
>> +#include <linux/acpi.h>
>>  #include <linux/clk-provider.h>
>>  #include <linux/clk.h>
>>  #include <linux/delay.h>
>>  #include <linux/dmi.h>
>>  #include <linux/err.h>
>>  #include <linux/errno.h>
>> +#include <linux/gpio/driver.h>
>>  #include <linux/i2c.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/io.h>
>> @@ -130,6 +132,80 @@ static int i2c_dw_probe_lock_support(struct dw_i2c_dev *dev)
>>  	return 0;
>>  }
>>  
>> +#if defined(CONFIG_ACPI) && defined(CONFIG_GPIOLIB)
>> +/*
>> + * Check whether an ACPI GpioInt resource's referenced GPIO controller
>> + * has finished probing. Resources with no named controller (resource
>> + * source string) are skipped, since they can't be resolved to a
>> + * struct device.
>> + */
>> +static int check_gpioint_resource(struct acpi_resource *ares, void *data)
>> +{
>> +	struct acpi_resource_gpio *agpio;
>> +	struct acpi_device *gpio_adev;
>> +	struct device *gpio_dev;
>> +	acpi_handle handle;
>> +	acpi_status status;
>> +
>> +	if (!acpi_gpio_get_irq_resource(ares, &agpio))
>> +		return 1; /* not a GpioInt resource, skip */
>> +
>> +	if (!agpio->resource_source.string_length)
>> +		return 1; /* no named controller, skip */
>> +
>> +	status = acpi_get_handle(NULL, agpio->resource_source.string_ptr, &handle);
>> +	if (ACPI_FAILURE(status))
>> +		return 1;
>> +
>> +	gpio_adev = acpi_fetch_acpi_dev(handle);
>> +	if (!gpio_adev)
>> +		return 1;
>> +
>> +	struct gpio_device *gdev __free(gpio_device_put) =
>> +		gpio_device_find_by_fwnode(acpi_fwnode_handle(gpio_adev));
>> +	if (!gdev)
>> +		return -EPROBE_DEFER; /* controller not registered yet: abort walk */
>> +
>> +	gpio_dev = gpio_device_to_device(gdev)->parent;
>> +
>> +	guard(device)(gpio_dev);
>> +	if (!device_is_bound(gpio_dev))
>> +		return -EPROBE_DEFER; /* controller not bound yet: abort walk */
>> +
>> +	return 1; /* bound, skip adding to resource list, continue walk */
>> +}
>> +
>> +static int check_child_gpioint(struct acpi_device *adev, void *data)
>> +{
>> +	LIST_HEAD(res_list);
>> +	int ret;
>> +
>> +	ret = acpi_dev_get_resources(adev, &res_list, check_gpioint_resource, NULL);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	acpi_dev_free_resource_list(&res_list);
>> +
>> +	return 0;
>> +}
>> +
>> +static int i2c_dw_check_gpio_dependencies(struct device *dev)
>> +{
>> +	struct acpi_device *adev;
>> +
>> +	adev = ACPI_COMPANION(dev);
>> +	if (!adev)
>> +		return 0;
>> +
>> +	return acpi_dev_for_each_child(adev, check_child_gpioint, NULL);
>> +}
>> +#else
>> +static int i2c_dw_check_gpio_dependencies(struct device *dev)
>> +{
>> +	return 0;
>> +}
>> +#endif /* CONFIG_ACPI && CONFIG_GPIOLIB */
>> +
>>  static int dw_i2c_plat_probe(struct platform_device *pdev)
>>  {
>>  	u32 flags = (uintptr_t)device_get_match_data(&pdev->dev);
>> @@ -138,6 +214,10 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
>>  	struct dw_i2c_dev *dev;
>>  	int irq, ret;
>>  
>> +	ret = i2c_dw_check_gpio_dependencies(device);
>> +	if (ret)
>> +		return ret;
>> +
>>  	irq = platform_get_irq_optional(pdev, 0);
>>  	if (irq == -ENXIO)
>>  		flags |= ACCESS_POLLING;
>>
>> base-commit: 58717b2a1365d06c8c64b72aa948541b53fe31eb
>> -- 
>> 2.54.0
>>
> 
