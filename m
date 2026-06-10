Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C22374A00;
	Wed, 10 Jun 2026 10:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781088490; cv=none; b=X0rH/aZwVHKA7l/B+keNQmTD47oAuxv7eqKM39lCWOPo0Mz4ryLU+aglLMLh+MkU9lvi4se5LRFyy2Y+OO/v602a44Msn9P2OIs69bRGv+Jwu+cRj1F0nIM5cbZEuP6ao04hJDv9tGerX845WAqjUmkN2eezCHKHuz4f9otgg60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781088490; c=relaxed/simple;
	bh=mWiY9VjJPgb0nubsZ0gsX+/ngoAwAIjn6+neW6DgM7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHHVloIyY7V+7XK97G0oydkLvEd6b51uiyCZda3rNSpJlcixswX4WyOpWY5ZMB3FBULEuPTmVTCp+ZRDSLXbRAq99Qi3lSqODUQEGafmPC5PDXHNpS1FmQ0jOXyML//kRtdcvTB9bLqjPHBtSQrQpDEN62RoOqzRb7LP3LNXsuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z0rLSJcq; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z0rLSJcq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781088480; x=1812624480;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mWiY9VjJPgb0nubsZ0gsX+/ngoAwAIjn6+neW6DgM7c=;
  b=Z0rLSJcq7x+Z7PkFSjeLEVncUa8xU74VpLjriYVfuYcQBTKnqanRUR5Q
   PFbC2pVXFG6ZzA7r0WrWocDsfjOovv/QVbEj0y3U+diqV/AMekUCtVtWv
   4ITT8shk3y9t447cGhYXEoSp68uWKyp6b5sz8bCBX6PjE3VHzDtRpvhWB
   QwN3gCTxCb91Fg/aIfV9vGjySxvCF039bvooWXSYdxbV/3w8pW1Lh/BbE
   8uUrKl4lpmPGNMiyaajtLed7ousW8YYcQ2hRPjSulBd3UiQmlmxPvveoE
   B2lozRSFQy6k2zBFm09yzmWwITChcj6sWls2B4FFqYzK5OFQbbBDxh+Zi
   A==;
X-CSE-ConnectionGUID: 5+a72/I3R0Gjice1glb6Lw==
X-CSE-MsgGUID: oK8uCtsXTuKONFzjzLl0/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="84446667"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="84446667"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 03:47:59 -0700
X-CSE-ConnectionGUID: ELYo/XroQqu9tx0aM1i9NQ==
X-CSE-MsgGUID: kWLh+SuGSYuFfDC6ePGTWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="246167719"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 03:47:57 -0700
Date: Wed, 10 Jun 2026 13:47:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hardik Prakash <hardikprakash.official@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org,
	mario.limonciello@amd.com, brgl@bgdev.pl, basavaraj.natikar@amd.com,
	linusw@kernel.org, nathan@kernel.org,
	chaitanya.kumar.borah@intel.com
Subject: Re: [PATCH] Revert "i2c: designware: defer probe if child GpioInt
 controllers are not bound"
Message-ID: <ailA2izdpOc4nhxN@ashevche-desk.local>
References: <20260610083701.18663-1-hardikprakash.official@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610083701.18663-1-hardikprakash.official@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 10, 2026 at 02:07:01PM +0530, Hardik Prakash wrote:
> This reverts commit ef76a3a28c79b628890431aa344af633e892035b.
> 
> The patch causes boot regressions on multiple machines. A NULL pointer
> dereference occurs when agpio->resource_source.string_ptr is NULL (i.e.
> when string_length is 0), and a probe deferral loop causes CPU starvation
> leading to kernel panic on Intel CI machines.
> 
> The patch needs a proper rewrite addressing these issues before resubmission.

Yes, please apply this (whoever is the right maintainer to do so).
Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


