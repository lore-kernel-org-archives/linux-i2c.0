Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C502E7F38;
	Sun, 17 May 2026 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779011507; cv=none; b=UZINAAtGTFcuBVQPxPsRkofBrqs+MSppRdSpttjPss9frJOHAtopXtlpcWJmDV2yQG8EDPMyrgQ5layQoe/9IHdpvvKqJjmFrNfimKmVy3uAPYVy3aYLdRzOW8NXXSgkLet135FKxLDT5HMOZl9p5yk70dZzFcRlXirFWSbGwlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779011507; c=relaxed/simple;
	bh=RSbYTW8L/bWuK+oPxsWaIdEa2cwS8gxgqJNurF445fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibZG/9yDXGgDQOv6pX1qLmnS8nkQC175hdFdMN8LmFF4azvLC1QNhRx6gGhHZo1V7D4kXksoOIH1+1Yb9SQjkfXVXot53sejvcg0R+uKhY5NspkOyv3/D0wWiJLOqI3keyopuBQ5jOf6k364cihwKgYRiRNtG/e+yWR5FmEunU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l69qFHY9; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l69qFHY9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779011506; x=1810547506;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RSbYTW8L/bWuK+oPxsWaIdEa2cwS8gxgqJNurF445fs=;
  b=l69qFHY9DYs+Cv8UNIO9fKMTPahLR8WtZUwkGvlQsRW7/ci8/KokzVZC
   Rz5cvfdXOLfms5eBWJ91LFUEiLdlCVYXdFb/f6mYglrRiL+A0qIwTavCd
   3pLk702Y0433MJmZlgh6N5t5mW5/rVXQ0f6poUXcJINEfg/sPqNpF4159
   M929Ix2bmx53cmXAqt18ThZiaaOLOggaROR0Oy3FgVKsCn2vf4WgXo5BQ
   C1FIi+q43k7XvlLkaizL/JbK2trarH6Bgd2EyLOCsHWEzCkQTNr8kkjSG
   DnrYD9EGnFM7YPMQYkK9GEn1XWQ3qalC2QamELZemEC1xGsbIQudJkyMn
   Q==;
X-CSE-ConnectionGUID: b50g5kirQZC5MLKl5wW8Kg==
X-CSE-MsgGUID: JPGBMUupQ/qYc9kzIqTM4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="90473916"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="90473916"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 02:51:45 -0700
X-CSE-ConnectionGUID: 7JdggwRITyK8tVqF4bCtiA==
X-CSE-MsgGUID: y8njifCnSQq6UcsBxPBhcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="238150023"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.182])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 02:51:43 -0700
Date: Sun, 17 May 2026 12:51:40 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hardik Prakash <hardikprakash.official@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org,
	mario.limonciello@amd.com, brgl@bgdev.pl, basavaraj.natikar@amd.com,
	linus.walleij@linaro.org
Subject: Re: [PATCH v3 0/1] i2c: designware: fix probe ordering for AMD GPIO
 on Lenovo Yoga 7 14AGP11
Message-ID: <agmPrF0IClOpDYlR@ashevche-desk.local>
References: <20260515161516.10474-1-hardikprakash.official@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515161516.10474-1-hardikprakash.official@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, May 15, 2026 at 09:45:15PM +0530, Hardik Prakash wrote:
> The Wacom WACF2200 touchscreen on the Lenovo Yoga 7 14AGP11 (83TD) is
> non-functional on Linux due to two bugs. Patch 1 (pinctrl-amd GPIO IRQ
> fix) has already been taken into Linus Walleij's tree. This v3 resend
> covers patch 2 only, addressing Andy Shevchenko's formatting feedback.
> 
> Root cause: i2c_designware probes AMDI0010:02 before pinctrl-amd's
> probe completes, so GPIO 157 (WACF2200 GpioInt per ACPI _CRS) has its
> interrupt bits cleared when the first I2C transaction is attempted,
> causing lost arbitration errors. The udev rebind workaround (which
> works because pinctrl-amd has finished by userspace time) confirms
> probe ordering as the root cause.
> 
> Note: the dual-master hypothesis raised by Mario Limonciello was
> investigated. TPNL's _DSM (UUID 3cdff6f7-4267-4555-ad05-b30a3d8938de)
> is a pure query method returning a constant HID descriptor address with
> no side effects, making firmware acting as secondary I2C master unlikely
> on this hardware. Awaiting Mario and Bart's technical verdict before
> any further approach changes.
> 
> v3:
>  - Patch 2 only (patch 1 already in Linus Walleij's tree)

The patch numbering is broken. Where did 2/2 come from?

-- 
With Best Regards,
Andy Shevchenko


