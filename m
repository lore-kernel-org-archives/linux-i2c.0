Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC7125A359;
	Thu, 16 Jul 2026 18:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784227831; cv=none; b=fOuvkTCCxfczITFNQu/F3k0w0+NuS8RxNTjuRN/8jumwQWf1/XPTl60X5kd/fsaef5WxKfiK1pDsi18ZtEuAmPpdio5kVoOmV6+bAvHs2RN0yZ6LMTx0dByDpV3l7jryyIU8b3Ll4jsUurHu4tOsksZqzDAPP7GJ9+pa6mDV9NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784227831; c=relaxed/simple;
	bh=CKijKRJw5IyDEmzlL11azG0J/e0WZNoISw/TUJYm3kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEp+14AKliPBlrOnVYqiMitdeIpxqh3yPwBM4sWpOR4dsrM1rCfmu4r8ZiZU5hgfgoOwF823qc+vRddM4o3qHP9ZztTZnNaTWPgVfeZf67CxrJErgl0zgINb8RpWSBZsLxsOslkuDAXb8ntA1AAMIiTSImP3u7Ol8LCjp38UZgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BToL/nOI; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BToL/nOI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784227830; x=1815763830;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CKijKRJw5IyDEmzlL11azG0J/e0WZNoISw/TUJYm3kk=;
  b=BToL/nOIb2jSEgBG6rKiGoew+ifu943rVI00zu3goZjH1WnCnAO629s4
   J8oVEYUZOgPyZLYeXmrc9i/QP7CD0eTr+dyMKWLTn7J4i8HUhiVwPgsNh
   QFVKjWp5ZDosFdkUeES3wu8T5K+5XkHPbzDcio2whRRAVBn0C/H0Vktpd
   d1jQfVdOo0b/E+vvGfhrpgyTM715aQ2UaQHfCBbGdrhGpt360eng4O7Gm
   T99qg93MHHryDgOr4jeQ4QnTqnNEMw7+OldlI6CmSLQYSwtIb2qfyLq7v
   ULsK03xTYxzIIGLcUvBFV6hMtjD+s7HAdbOzYJ1ETqkmc6Uor/OtDRcyM
   Q==;
X-CSE-ConnectionGUID: IWYH5ZHjTPSg1A12+J/vPg==
X-CSE-MsgGUID: /k1UsQLrTgep4nwm+YDU3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="95254229"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="95254229"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 11:50:30 -0700
X-CSE-ConnectionGUID: 6LLnaabwSrOWITfXMNEn7w==
X-CSE-MsgGUID: lvm9LoyEQaK8AeKcyKmfCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="286643250"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.26])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 11:50:27 -0700
Date: Thu, 16 Jul 2026 21:50:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Hardik Prakash <hardikprakash.official@gmail.com>,
	linux-gpio@vger.kernel.org, wsa@kernel.org,
	mario.limonciello@amd.com, brgl@bgdev.pl, basavaraj.natikar@amd.com,
	linusw@kernel.org, nathan@kernel.org,
	chaitanya.kumar.borah@intel.com, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v12] i2c: designware: defer probe if child GpioInt
 controllers are not bound
Message-ID: <alkn8HBmu_aDjKHK@ashevche-desk.local>
References: <20260716113055.41319-1-hardikprakash.official@gmail.com>
 <CAMRc=MdN4AYdS8mz9JbVc8fCz7MOik+Dsthb-BviVtX3h987rQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MdN4AYdS8mz9JbVc8fCz7MOik+Dsthb-BviVtX3h987rQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 16, 2026 at 07:10:47AM -0700, Bartosz Golaszewski wrote:
> On Thu, 16 Jul 2026 13:30:55 +0200, Hardik Prakash
> <hardikprakash.official@gmail.com> said:
> > I2C controllers may have child devices with GpioInt resources that
> > depend on GPIO controllers being fully initialized. If the I2C
> > controller probes and enumerates children before the referenced GPIO
> > controller has completed probe, GPIO interrupts may not be properly
> > configured, leading to device failures.
> >
> > On Lenovo Yoga 7 14AGP11, the WACF2200 touchscreen (child of
> > AMDI0010:02) has a GpioInt resource pointing to GPIO 157 on the
> > pinctrl-amd controller (AMDI0030:00). When i2c-designware probes
> > AMDI0010:02 before pinctrl-amd finishes initializing, I2C transactions
> > fail with lost arbitration errors:
> >
> >   0.285952  amd_gpio_probe: registering gpiochip  <- GPIO chip visible
> >   0.287121  amd_gpio_probe: requesting parent IRQ <- probe still running
> >   0.301454  AMDI0010:02 dw_i2c_plat_probe: start  <- races here
> >   2.348157  lost arbitration
> >
> > Add a dependency check that walks ACPI child devices and defers probe
> > until any referenced GPIO controller is bound.
> >
> > Fixes: 3812a9e84265 ("pinctrl-amd: enable IRQ for WACF2200 touchscreen on Lenovo Yoga 7 14AGP11")
> > Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Signed-off-by: Hardik Prakash <hardikprakash.official@gmail.com>
> > Assisted-by: Claude:claude-sonnet-5
> > Assisted-by: DeepSeek:deepseek-v4-pro
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=221494
> > ---
> 
> Looks good to me.
> 
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

But this is wrong. It's a patch over v11 (basically it's a diff v11..v12).

Please, Hardik, be careful on what you are sending.

-- 
With Best Regards,
Andy Shevchenko


