Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D572FC876;
	Tue, 12 May 2026 10:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778583334; cv=none; b=IgHd/a65HrtkKqLiiUUwhC26ictWk0ywH4YxNWfVgiY5g2v7BIoNfb+VOcDzzqkE7Pg1na2vpjYu6zw+IXoXtOmmHOh/nePtbnAlCbk/EjLydUnZ03FQRBZVd1UQFZaRjQBDUuAHJ8uk5OOwYhs3zaF/NK2zzK1FleVKtJE8qQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778583334; c=relaxed/simple;
	bh=Bkz84Bqg90GIL+f0yAgG3Z3x8tWRzRh1Qg1Rxiw9p24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCJ+BXaUgmcFtWFAWW9n6YHLePuLVWIfo5359NY4J7NBhnNEKIoVrhH1bAUJsPiURGkfnZj9V5Rj2gW63quk2WXScyJ1j0Z5wXo3zCymluaACIKTYG50shzog6ik3POjrBVoKV/x0SmPJNssr0bkyCkxRasS4O0wQxn3joSiaF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=goEl3uca; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="goEl3uca"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778583334; x=1810119334;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bkz84Bqg90GIL+f0yAgG3Z3x8tWRzRh1Qg1Rxiw9p24=;
  b=goEl3ucalSv1Yv2sON8z0NuapMN6vE1ZvPNwD9uDKsjtIRkMq+Ba49YK
   Y6I11jYaItnLoKfRfcII5c7bDU5EdIelrSs+S9FivUQWPvoCaoHEAWCwH
   yx067cgXprUNX4r86IWMfa9S2YWt8yTwC87oexgJPCJ0yTtJJeFGWeU8i
   FoVnrxj+uRCK2oPmbfUveFt9wkStWCGGYxBBq//QUAsnem8dsWJgnF4UA
   MMLcAL4OQySAMsltXxe7+69YBttUi3/pfWa/l1TkFDwMd9zUOuFx1r/Yw
   SbcDW90faSuv8gfXInp7UMLZXoymYoo3Tw4OigkfHA+xqrzVQHBg21ozK
   Q==;
X-CSE-ConnectionGUID: i8x2Q+lEQ0yQCWgwOdUZ9A==
X-CSE-MsgGUID: XmfpWOhrQmytzEMtANarkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="89791709"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="89791709"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 03:55:33 -0700
X-CSE-ConnectionGUID: IsDTFWLMRwql9ZNOiq9qdA==
X-CSE-MsgGUID: 7mXOxpW7QYW1LeNXlsQYkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="268082239"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 12 May 2026 03:55:31 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6797399; Tue, 12 May 2026 12:55:30 +0200 (CEST)
Date: Tue, 12 May 2026 12:55:30 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hardik Prakash <hardikprakash.official@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
	linus.walleij@linaro.org, wsa@kernel.org
Subject: Re: [PATCH 2/2] i2c: designware: fix probe ordering for AMD GPIO on
 Lenovo Yoga 7 14AGP11
Message-ID: <agMHIhMzS_8AicAI@black.igk.intel.com>
References: <20260512073139.16343-1-hardikprakash.official@gmail.com>
 <20260512073139.16343-3-hardikprakash.official@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512073139.16343-3-hardikprakash.official@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, May 12, 2026 at 01:01:39PM +0530, Hardik Prakash wrote:
> The existing dw_i2c_amd_gpio_defer_dmi quirk for Lenovo 83TD checks

Existing? Is this message and the whole stuff is somehow AI-assisted?

> gpio_dev->driver to determine if the GPIO controller is ready, but
> this pointer is set before pinctrl-amd's probe completes, causing
> i2c_designware to probe AMDI0010:02 before the GPIO IRQ quirk runs.
> 
> Switch to device_is_bound() under device_lock() to correctly defer
> until GPIO probe has fully completed. Also replace the string-based
> device lookup with ACPI HID/UID matching for robustness, and add
> DMI_BOARD_NAME to the DMI match to reduce false positives.

> Fixes: the lost arbitration on AMDI0010:02 at boot on Lenovo 83TD.

This is incorrect way of providing a Fixes tag.

...

> +struct dw_i2c_hid_uid {
> +	const char *hid;
> +	u64 uid;
> +};

Useless as duplicates the existing strictures. See also below.

...

> +static int dw_i2c_match_hid_uid(struct device *dev, const void *data)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> +	const struct dw_i2c_hid_uid *id = data;
> +
> +	if (!adev)
> +		return 0;
> +
> +	return acpi_dev_hid_uid_match(adev, id->hid, id->uid);
> +}
> +
> +static struct device *dw_i2c_find_platform_hid_uid(const char *hid, u64 uid)
> +{
> +	struct dw_i2c_hid_uid data = {
> +		.hid = hid,
> +		.uid = uid,
> +	};
> +
> +	return bus_find_device(&platform_bus_type, NULL, &data, dw_i2c_match_hid_uid);
> +}
> +
> +static bool dw_i2c_needs_amd_gpio_dep(struct device *device)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(device);
> +
> +	if (!dmi_check_system(dw_i2c_amd_gpio_defer_dmi))
> +		return false;
> +	if (!adev)
> +		return false;
> +
> +	return acpi_dev_hid_uid_match(adev, "AMDI0010", 2);
> +}

The whole flow is just a repetition of acpi_dev_get_first_match_dev().

...

> +static int dw_i2c_defer_for_amd_gpio(struct device *device)
> +{
> +	struct device *gpio_dev;
> +
> +	if (!dw_i2c_needs_amd_gpio_dep(device))
> +		return 0;
> +
> +	gpio_dev = dw_i2c_find_platform_hid_uid("AMDI0030", 0);
> +	if (!gpio_dev)
> +		return -EPROBE_DEFER;
> +
> +	device_lock(gpio_dev);
> +	if (!device_is_bound(gpio_dev)) {
> +		device_unlock(gpio_dev);
> +		put_device(gpio_dev);
> +		return -EPROBE_DEFER;
> +	}
> +	device_unlock(gpio_dev);

Interesting dance. Needs a comment explaining what's going on here and why this
deferral probe won't be a problem in other scenarios.

> +	if (!device_link_add(device, gpio_dev, DL_FLAG_AUTOREMOVE_CONSUMER))

This needs a good comment explaining what's going on.

> +		dev_warn(device, "failed to add device link to AMDI0030:00\n");

Why :00? Is it guaranteed that this is going to be with :00? Note, this suffix
is instance number in Linux and strictly speaking might differ even from boot
to boot on the same machine.

> +	put_device(gpio_dev);
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


