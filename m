Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCF334A3A7;
	Tue, 10 Mar 2026 19:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773170566; cv=none; b=Q6vA/rbeoa/W11OIiSkRWl597G6jGRLYI8dQQ7FgYBy8M1nHOPkrtmuCnSJo8wjFWutfuuOxlm1Zb3Zw+IsIs0Nnzd5bYTOZ8+k2+/b6KXhvSxIlrPt59q+xZ1K3Y3AoHUWcp3m2AmZcfx02S2c0719zviz5MKndp3BwLcBqPTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773170566; c=relaxed/simple;
	bh=gzNurzWXYwVmfOK8mCe02godV79Je2lCnznHeHpHYUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MemUhNFvAw/mO5wbtVBCphZLNgAC68g7g72NFOvOC6daRoaVKV5e7Q50FIN6tGPH3GGeiXnwOq8Uoy/Ol57wQZfMvi3mYwP+DuCH6I0Pi0byXhZRV0EQRcqtMlZ71wL+7MY0bUHULRDnqNYKUken5TtPIPsXjPVKqpM1hMqrhlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HYbJHBhJ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HYbJHBhJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773170565; x=1804706565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gzNurzWXYwVmfOK8mCe02godV79Je2lCnznHeHpHYUo=;
  b=HYbJHBhJGC9T4bVpCSStouVXYCGtEuXYdt3wGkaQ8MCD1fmPFOVeVfMK
   gkMXONUUQd4v/F8GIccsCwbqx9IllbPLJX3qdFYdZWe0V/oGeBTdoYi1z
   48shsVkMeTgytWEhFIlCUgaCNFb+puMigX/DDM1BEndKmoL678eSnO8cM
   pA9Zllr6kFUVvqlouVje38WD8ujK9J/lkv/o6dQ3yBhk4YfOKkMK4KMIt
   FuvOC8rQYMLb+9l11lDCz/kBYdOkIidvRYWrLfF+poAZ/k3dWCyTyDyLh
   38RwjMBhXhrbspQysNKYBexVsFmNb0lcSLSQSGb36yzXIMzea5atnzHKL
   A==;
X-CSE-ConnectionGUID: cmwpHM8oTiKSJXxxeuht5w==
X-CSE-MsgGUID: KjI0LqUMR6S67o1W13IndQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74202382"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="74202382"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 12:22:45 -0700
X-CSE-ConnectionGUID: jX/RQbL6SIuTdXWAFBRGNA==
X-CSE-MsgGUID: k5Nn9JoMR/W1Dcfd7e6r2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="219338948"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 12:22:42 -0700
Date: Tue, 10 Mar 2026 21:22:39 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: designware: add reset control support in
 suspend/resume
Message-ID: <abBvf9HgLeCpjevu@ashevche-desk.local>
References: <20260310184046.2010403-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310184046.2010403-1-a.shimko.dev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 10, 2026 at 09:40:45PM +0300, Artem Shimko wrote:
> The driver currently acquires reset control during probe but does not
> manage it during system suspend/resume. This can leave the I2C controller
> in an undefined state after resume.
> 
> Add reset control assertion during system suspend and deassertion during
> resume to ensure proper hardware initialization across power management
> transitions. Skip runtime suspend if the device is already suspended to
> avoid redundant operations.

...

> +#ifdef CONFIG_ACPI

Why?

>  static int i2c_dw_prepare(struct device *device)
>  {
>  	/*

>  	 */
>  	return !has_acpi_companion(device);
>  }
> +#endif

...

>  EXPORT_GPL_DEV_PM_OPS(i2c_dw_dev_pm_ops) = {
> +#ifdef CONFIG_ACPI
>  	.prepare = pm_sleep_ptr(i2c_dw_prepare),
>  	LATE_SYSTEM_SLEEP_PM_OPS(i2c_dw_suspend, i2c_dw_resume)
> +#else
> +	SYSTEM_SLEEP_PM_OPS(i2c_dw_suspend, i2c_dw_resume)
> +#endif

Why?

Usually we try to avoid _adding_ ugly ifdeffery. Can you elaborate why the
change is needed in the first place and why there is no better way to handle
it?

>  	RUNTIME_PM_OPS(i2c_dw_runtime_suspend, i2c_dw_runtime_resume, NULL)
>  };

-- 
With Best Regards,
Andy Shevchenko


