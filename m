Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFFE33A00C;
	Fri, 14 Aug 2026 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786699828; cv=none; b=PmDSFIiR0fB3OkPl93FjT2m1Fj/ccQWLpF8o4XGBThVuuzu8l6sdb9uXnulCPhJqfKEJDj/geHBbLs1yoTUEhu3vGXk/3ToLTnNaseCByGqg9E8kw2e5W0Q/TLdyE6YT5DXyINoFSPwW9gQKOAtUJ5dV9AbPeJ9MetbdtwJ5u7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786699828; c=relaxed/simple;
	bh=Pmxz/X63qocUfI4qWYyUiBkC++1SDPoWGpV0SJppfAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTmlGsvBqujGnPHSeajmAvkWJFPcmVB+OQR3OYV+44fhroiuKddQ1DaSQStCcAuQ/3UaN5sATOiUWQm0gDf4LwR+zoug4u9Dph2NWqw/3Iv5KmtwNtwe7GUq//32+AV/ZnfCPJZLtTQHoUM5awMvJFL2yPE5fERw09nm7Hshhn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NrRW+91P; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NrRW+91P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786699827; x=1818235827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pmxz/X63qocUfI4qWYyUiBkC++1SDPoWGpV0SJppfAo=;
  b=NrRW+91P8+nW44b7jf4pgbwDqCzlRZTqRocDdjW0LPQdeV9MVb9EhWAu
   aarhaL2H7kO0rNdV6uRvhIXw0tOQcXsOXZ7y4WnabCoZgSD23Wu48nRKZ
   0AuvNriNugFzXMsU7VupvoExnudtF/hF1vGbv/go99vmx1iqbFu8he88O
   Zk5byKQmZulcaku/gVoeyw7T/J4m1vspE0JGOXrUld/PifTJHeDqkGXUe
   YcRWNVktdagPrcEz9I6zo4e3JZJP+6iP25y8neoS1M2Y0D86ThFJuZ8Yc
   bHB9Bx+UbZH3bNSZV2MOaEjVgzznXcCXLmjBLlrhIiU1G5k3yzZLsUNnA
   w==;
X-CSE-ConnectionGUID: f0VY8rNbQ9m8WAJ1jUJbDQ==
X-CSE-MsgGUID: B76bxPrKRmWWRRYeQeWysQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="97870024"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="97870024"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 02:30:26 -0700
X-CSE-ConnectionGUID: 6u2kxSleTwC5SyizR6B1iQ==
X-CSE-MsgGUID: ehOKJ2Q2QiCg6HZHAlpHgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="287657898"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.134])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 02:30:24 -0700
Date: Fri, 14 Aug 2026 12:30:21 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: xiic: restore runtime PM teardown in remove to fix
 clk WARN flood
Message-ID: <an7gLYzltJgjIUNQ@ashevche-desk.local>
References: <20260813-i2c-xiic-restore-runtime-pm-teardown-v1-1-0e7dfb206790@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813-i2c-xiic-restore-runtime-pm-teardown-v1-1-0e7dfb206790@nexthop.ai>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 13, 2026 at 02:06:40PM -0700, Abdurrahman Hussain wrote:
> The devres conversion dropped the remove-time runtime PM trailer
> (pm_runtime_disable + pm_runtime_set_suspended +
> pm_runtime_dont_use_autosuspend). devm_pm_runtime_enable's release
> action then calls pm_runtime_dont_use_autosuspend() while runtime PM
> is still enabled, triggering an immediate runtime suspend: the suspend
> callback clk_disable()s the clock that the devm_clk_get_enabled()
> release is about to clk_disable_unprepare(), and every device teardown
> WARNs in clk_core_disable() ("clkN already disabled").
> 
> Restore the trailer: with runtime PM disabled and the state forced to
> suspended before devres runs, the suspend callback cannot fire and the
> clock enable count stays balanced.
> 
> Fixes: 50c63491ff26 ("i2c: xiic: switch to devres managed APIs")
> ---

^^^ Something went wrong. The SoB must be part of the official commit message.
Putting it under the cutter '---' line makes it disappear.

-- 
With Best Regards,
Andy Shevchenko


