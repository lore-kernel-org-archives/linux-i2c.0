Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973E043F0A1;
	Sat, 18 Jul 2026 08:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784364656; cv=none; b=mLA5QMGnv3Pza/3ZOdPRBEjcalBx5sDd/tMSIAFrnCI4SM4ZRl2nstDiSst4LE0sU1yIL3NHFGji5RTNKrQ3uda17+aChOwLsp3fkA6TUtSLQyj1HngDZ69HIkiiQV7ciM/PRRnn1lo6GUG/wqQJjevdFpNxJPjJKHxh70L2NNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784364656; c=relaxed/simple;
	bh=BXolcRUkqumIcSctx8J2g/sfQbe4i7Q6U9nWOG4thfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVgGA+LECChoUJY8rOwDFWvle54iEuf0UqWlNUKnd52PoO6UVM7Qpij3PthYQHu7mmz3Pp3/ijyf7G5GkbIKiZbbHGQUr0I0Zja8KCABI7qt4tBEHOdPP5t0cs2FXk3wTynG6wyw0v+hqwiRpGweVwVmbkRQIY7XraOsPNweuas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EI+y0DX5; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EI+y0DX5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784364654; x=1815900654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BXolcRUkqumIcSctx8J2g/sfQbe4i7Q6U9nWOG4thfw=;
  b=EI+y0DX5ZvxT6Ula84ND1OFFU8fgVBTEYvrbwKInTj77mMKtvKH4a2I2
   7ynCYKckdsG2iZ1/1iVJk6hnzGZMhf9VH90EuJscqEyFAaF/8EDPkyJ6L
   gY3Yh5DlTbu4HGy6hVL9zqHsfIFH1NMQUlmnTXxGFctDGnr4hjcDNFNEK
   WjRIhWrSzDOCDJpVXv56BkFMO9pEz4gPscNa8uCflzHontZBTxHVs/db4
   dOgv4W19sgZtff8CuhQO1C1s9DYdp1SaEvJOCxOQ8IUUqUmZpefae/Uyp
   aG/XZN9Jjpdh4cxYXluYRuoZ3k7X2tQW3FYeabxwWG5wmTJA3g+AvzBRt
   w==;
X-CSE-ConnectionGUID: CDwALh4DS4m/wjELJXq+fg==
X-CSE-MsgGUID: JptmxOGeQyOmjvi/N0DlpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="85222109"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="85222109"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 01:50:54 -0700
X-CSE-ConnectionGUID: QzITa/0sSdKuJgoufUDDFQ==
X-CSE-MsgGUID: cT1Eh9iJSBGXRgZ5vYCVwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="253020229"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.22])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 01:50:52 -0700
Date: Sat, 18 Jul 2026 11:50:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hardik Prakash <hardikprakash.official@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org,
	mario.limonciello@amd.com, brgl@bgdev.pl, basavaraj.natikar@amd.com,
	linusw@kernel.org, nathan@kernel.org,
	chaitanya.kumar.borah@intel.com
Subject: Re: [PATCH v13] i2c: designware: defer probe if child GpioInt
 controllers are not bound
Message-ID: <als-afMzPlxLs0HY@ashevche-desk.local>
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
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

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

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

One nit-pick below. No need to resend, hopefully Andi can tweak that
whilst applying.

...

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

+ blank line here as well. I asked to add blank lines before and after.

  "...make sure it has a blank lines before and after, so it's visible
   as a separate entity."

> +	if (!device_is_bound(gpio_dev))
> +		return -EPROBE_DEFER; /* controller not bound yet: abort walk */
> +
> +	return 1; /* bound, skip adding to resource list, continue walk */
> +}

-- 
With Best Regards,
Andy Shevchenko


