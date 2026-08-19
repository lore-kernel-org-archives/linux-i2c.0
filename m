Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645C83BBA04;
	Wed, 19 Aug 2026 06:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787121944; cv=none; b=B8OteokxDNl1lyZUU9HoFqrzKiubGPNQC/9n1iDBIKlE4EGSqzbQENu3HaBcblhud27dPB1Kp65t7Ej+w7EMadz7I5DXJKyulcUT6V32rjM8vmUGgOfmatFxXGqmPvs6nLUx16YDeJ5lE3JJ6e8wd4xgtDWN0kN7GlcWACFLjBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787121944; c=relaxed/simple;
	bh=12reE8wYpDisf9Z1pLaA6vVzzI2+6J2CVzQ6j8h7qW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQbILuLDj//CxV3x61YXgHpKrysliwyqwvwQh/7dFXqfddWzhdVb2A3QTTGuThScp202uQWhLkCAMvz8lsQ2ytmFS3sprcYXXf4pwY/qutf9Ooj/6X/q632IOgZqIjSEPUqk6dTqbyym1a2GOarAWlv8WJ7+CLSWuWO0YxBylAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bEe+6Lzv; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bEe+6Lzv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787121943; x=1818657943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=12reE8wYpDisf9Z1pLaA6vVzzI2+6J2CVzQ6j8h7qW0=;
  b=bEe+6LzvY5ovdH3KeUFUZSCPewTtnQXiBIeX05OI62lm+/aaeb0K2d4k
   nTyKd9dzVHV0vacxntQFqu045feoClblE+LbUfshexzFmlz5UutHxymgG
   Yq2sb0BJQkGCQDWOWRJ2zEF+Yzsrm/esVA7NKdybMePiUB0xewjT804p+
   8cVQCPI8MPzUsYbljJfwL8E9RKWAWmIKznXx1NHvAp1cUfVJX8yF34VGg
   QKrA0l+8QojZJMHZvYDkHOckA/lGlTvXisjue3FXz8hpgOP4MsO5v9x7M
   6u/eFnj+DXu906VghHtJ8A3mmMbpS+nGASpcXywKhH9DXrQqw7rNB9dn3
   A==;
X-CSE-ConnectionGUID: rSUosdN2ThWMgCrfq+9zcA==
X-CSE-MsgGUID: TA+kdDpLQpuG8vA/Yva0UQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="105007616"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="105007616"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 23:45:42 -0700
X-CSE-ConnectionGUID: 26tNyrbXR6WtNCoQBh4Z3Q==
X-CSE-MsgGUID: WTdqJy6NQsmcpT2UCq0xCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="288962761"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.106])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 23:45:40 -0700
Date: Wed, 19 Aug 2026 09:45:37 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] i2c: xiic: restore non-managed runtime PM to fix clk
 WARN flood
Message-ID: <aoVRETUfgS4FwMnq@ashevche-desk.local>
References: <20260818-i2c-xiic-restore-runtime-pm-teardown-v3-1-5fd315b078e1@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-i2c-xiic-restore-runtime-pm-teardown-v3-1-5fd315b078e1@nexthop.ai>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 18, 2026 at 08:35:10AM -0700, Abdurrahman Hussain wrote:
> The devres conversion replaced manual pm_runtime_enable()/disable() with
> devm_pm_runtime_set_active_enabled() and dropped the remove-time runtime
> PM teardown. The managed release tears runtime PM down in the wrong
> order: it calls pm_runtime_dont_use_autosuspend() before
> pm_runtime_disable(), i.e. while runtime PM is still enabled, and devres
> is LIFO so the devm_clk_get_enabled() release runs afterwards.
> 
> At remove(), pm_runtime_put_sync() leaves the device active with the
> autosuspend timer armed. Clearing use_autosuspend then makes rpm_idle()
> suspend immediately, and xiic_i2c_runtime_suspend() clk_disable()s the
> clock. The later devm_clk_get_enabled() release clk_disable_unprepare()s
> the already-disabled clock, so clk_core_disable() WARNs ("clkN already
> disabled") on every teardown.
> 
> Drop the managed helper and restore the non-managed runtime PM setup and
> teardown, so runtime PM is enabled once in probe and disabled once in
> remove and the clock enable count stays balanced.

...

>  	pm_runtime_set_autosuspend_delay(dev, XIIC_PM_TIMEOUT);
>  	pm_runtime_use_autosuspend(dev);
> -	ret = devm_pm_runtime_set_active_enabled(dev);
> -	if (ret)
> -		return ret;
> +	/*
> +	 * Enable runtime PM by hand: devm_pm_runtime_set_active_enabled()
> +	 * tears down in an order that races the devm-enabled clock release and
> +	 * makes clk_core_disable() WARN (see xiic_i2c_remove()).
> +	 */
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
>  
>  	/* SCL frequency configuration */
>  	i2c->input_clk = clk_get_rate(i2c->clk);

>  	ret = devm_request_threaded_irq(dev, irq, NULL, xiic_process,
>  					IRQF_ONESHOT, pdev->name, i2c);
>  	if (ret)
> -		return ret;
> +		goto err_pm_disable;

This might be problematic now. You need to unwind the IRQ request in non-devm
manner as well. Scenario is that IRQ comes exactly after PM is disabled
in the error path. Is it a problem today? What about tomorrow (assuming some
new chips / code is added)?

The rule of thumb is that, no devm_*() call should be followed by a goto.

-- 
With Best Regards,
Andy Shevchenko


