Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB263101B4;
	Fri, 23 Jan 2026 08:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769157474; cv=none; b=Xg2Fd9JoDpPm1kq7krfSTmXfxEW43L9gem221tmSp0FqRXMSZQ8rNlBkLQPrT1HtZQ0EURq+QpFZVbWQM9jP8s7/QNnPfjRAJRASHmRl9nShoB2L47RZnWlJKOP3EqdVYtv84DaxRUAN6/2wzJtosashsDn1Y2SAEdn5QDLUJtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769157474; c=relaxed/simple;
	bh=Cm6DUjGv65AjQpL0tAuNheTXPfR6F+soqcbey/Xrz3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHMcisKWfJrxBtAscgtG8/VKVvSGbVik2eXE0n/xJlyP9Woh/RVXvu2roAfHnmIeuJkZjd7lIs5ygebu+h55sHjl2qVHfIqUrw4l3JkbmHntfUsskrTqarbzBnoiB2B6AMNepOUqxuPEfYKu88bZoC/zQQVmzMN3Cvv8bbVQDa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h+6rj/gz; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h+6rj/gz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769157474; x=1800693474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cm6DUjGv65AjQpL0tAuNheTXPfR6F+soqcbey/Xrz3g=;
  b=h+6rj/gz8MjS2GAjNKwJRtDuqL7f8sn3RdoeSHCTjob93YFCKZQ48txd
   ZUXfJo2J6thXIjvBMphid9adZ6qBgB0th3gCuHzucTmv/39FD3QKz/iDL
   /8Ovz9FI4S+nLGWNXcmIoogMnRYIRSugCO4pHi7fXCLekn6LC6RTaNlo5
   fi2UVhhG6FR54bECha7li41ez0aqBU2BxmkXihDCcl9pqtI6rF0US9/qg
   tK0ddRV0ENnueSMJQc2JzqQtMgeqIIEEaFx4avOAACOtw0igBt4UR0Hif
   fZ/7sXegLQqCHEvWU+J1fthjqcMf7XjYut8Ss+g3DTf3cmS35bg/sUIJ7
   w==;
X-CSE-ConnectionGUID: HZHQL4PiSJ2sc7QbMkv9Hw==
X-CSE-MsgGUID: OUTdne8lQPyh8pLWBR3mhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="95879977"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="95879977"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 00:37:53 -0800
X-CSE-ConnectionGUID: I1E9nIyOQsGIDQEZJihH4g==
X-CSE-MsgGUID: wZjDcOigS6q5PBDrcxnuHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="244586979"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 00:37:51 -0800
Date: Fri, 23 Jan 2026 10:37:48 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: abdurrahman@nexthop.ai
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] i2c: xiic: minor cosmetic cleanup
Message-ID: <aXMzXH4vvh3HK8wN@smile.fi.intel.com>
References: <20260123-i2c-xiic-v3-0-eb7cd4254dfb@nexthop.ai>
 <20260123-i2c-xiic-v3-5-eb7cd4254dfb@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123-i2c-xiic-v3-5-eb7cd4254dfb@nexthop.ai>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 23, 2026 at 08:02:48AM +0000, Abdurrahman Hussain via B4 Relay wrote:

> Add a temporary dev variable and reuse it instead of referencing pdev->dev
> everywhere.

...

> -	pm_runtime_enable(i2c->dev);

> +	pm_runtime_enable(dev);

Ah, please also move this to devm_pm_...* in a separate patch or combine it
with mutex and explain that this fixes the cleanup ordering and simplifies
error handling.

-- 
With Best Regards,
Andy Shevchenko


