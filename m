Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871DF3D6473;
	Wed,  4 Feb 2026 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770199913; cv=none; b=iBVqAzkflY3PXm49Inns1KKO+QWyExa4qeieoXBC13H6u1gW3Qdt3mYJ2TNdgP8zxYH3fs7Fyfpqj3ouSIYhCz1zRDWtjFtRD4BAVLZRmsezF2Z/g4wKJIrsG9VOpyvmT0YJu+2DfLCRezmZRQsbJ+IfX4hGv5n0fADwtxcScPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770199913; c=relaxed/simple;
	bh=VCztL+ZGIqEKl+3prqcGfzggNapxW9kzpdyfA9ixefg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYLRehBMtwvmiD4uYzfPD4jP5NzSQXNygrxpcQoLpsbFm3g014GTNeUfvwrg/pzdgk20dH/EjTuXPpyL2+eM2dip5ERh2MncjSv8LicxMCXx4OG7zUSD3cs+pcPWXh9sDQmkdUkpZgMUlGKQq7d6Zcq3fohTMXkP/RHA/mtdIa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JJ1LXOWm; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JJ1LXOWm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770199912; x=1801735912;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VCztL+ZGIqEKl+3prqcGfzggNapxW9kzpdyfA9ixefg=;
  b=JJ1LXOWmIqQjsG63GdCJpd9rokAdDRFY9PaQWIQGB1Bmvb0d8dPy+ZHQ
   rjyYpRJz19CtpfShsMzC34UQd758u9ltRGKkDKICsEe+bVBAYebLu9VI8
   4AYcNO/hwHcJYniJoQL8ANTQlvvmG2ZAVdyRvnG76p+obBb3N5rPYDEnh
   ObQm4r89QrgoazVc8WLh7GKPp6q61iEW+5Br2JFLLU9OUrQQ4a6jqle8j
   75nIPSMW3wcjF+xfjEIAMcZdC6ZoMIUBXQWJNQrxxVXjJOLpBZIJR8410
   kzHLF8pVgKpRMJZRITKyVsIAxqVjRLciC/M/61/h6fvef1nbQmx/rUcYV
   A==;
X-CSE-ConnectionGUID: CG6TV+YfT4ioHeWsqSTuTQ==
X-CSE-MsgGUID: /0pvuI16RxmuGm1FH4R1cQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="75004732"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="75004732"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 02:11:52 -0800
X-CSE-ConnectionGUID: jygyKsJoSMi7YU6MZZBLBw==
X-CSE-MsgGUID: ExVi6qRYQre5wvCap/MlSQ==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.188])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 02:11:49 -0800
Date: Wed, 4 Feb 2026 12:11:47 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>,
	abdurrahman@nexthop.ai, Michal Simek <michal.simek@amd.com>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v10 1/7] i2c: xiic: switch to devres managed APIs
Message-ID: <aYMbY62uJo95yc1l@smile.fi.intel.com>
References: <20260204-i2c-xiic-v10-0-c2b996425235@nexthop.ai>
 <20260204-i2c-xiic-v10-1-c2b996425235@nexthop.ai>
 <20260204100034.000050b2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204100034.000050b2@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 04, 2026 at 10:00:34AM +0000, Jonathan Cameron wrote:
> On Wed, 04 Feb 2026 07:01:58 +0000
> Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org> wrote:

...

> > -	return 0;
> > -
> > -err_pm_disable:
> > -	pm_runtime_disable(&pdev->dev);
> > -	pm_runtime_set_suspended(&pdev->dev);
> > -
> >  	return ret;
> Trivial but if you are respinning...
> If you get here we know ret must be 0, so make that explicit to the reader as it
> was before with
> 	return 0;

> Otherwise they need to look up a few lines to realize that is true.

Right and this is already the line above, just wrong one was removed.

...

> > -	pm_runtime_disable(&pdev->dev);
> > -	pm_runtime_set_suspended(&pdev->dev);
> >  	pm_runtime_dont_use_autosuspend(&pdev->dev);
> 
> Take a look at docs for the devm_runtime_enable() that is called
> by the cleanup for devm_pm_runtime_set_active_enabled()
> 
> Short story, it will call pm_runtime_dont_use_autosuspend() for you

Good catch! It's not obvious from the devm_pm_*() naming... :-(

...

This definitely means v11 should be send at some point, but,
Abdurrahman, do not hurry with it, this series missed the cycle
anyway, we have a few *weeks* to polish this.

That said, send it after v6.20-rc1 (or v7.0-rc1) is out.

-- 
With Best Regards,
Andy Shevchenko


