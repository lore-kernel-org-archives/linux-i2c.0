Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C4A3B42DE;
	Wed,  8 Jul 2026 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783520703; cv=none; b=ZFVVeA/5nBLtfY7UZIggGwFvXv8YgfifsCyc53PyTEXe2J4XLFOA2mUtCjVMBQvdrSAVtJ5zyGsMk+QHeR+JnygP+M3YenbTaFGoZjRKwYd2GZdDu0kuCwKzzO/gRNQRNWYJ8cF6P6pfqhcmFnqcywwcv5NFARSOCehSRjJvgMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783520703; c=relaxed/simple;
	bh=mVNcON9LeM0cMFsZoRkkLKIiELaBG/SE+W5/mf8/PWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyToUHoRHAXwc/2aX1ZNdDYDeRP9MRixDm9UhtoLcDeUJbfP/HWBSqR99ACuJ4EJrmDrdHomN6c3EEFB3sSPF1NiXHePlw4wuj8LTlpJJZzm6hIvMbhJ9X+wfjiWnlCVIpPkoZo3o477GUiuAXXwQQmD7TZhw2ZNxPwds0GozQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FUe2Rlld; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FUe2Rlld"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783520701; x=1815056701;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mVNcON9LeM0cMFsZoRkkLKIiELaBG/SE+W5/mf8/PWU=;
  b=FUe2RlldvPzrelw6/cMFN5gARi/gFAv1ag8klsT1ZIjgovW3bzzW3AC8
   3DG8co4dDjNckznfkvik6Tp//j2Yu8dghRccb3pQJMK1BjRE0ba7iKOOM
   rurF8nsktqtXb8BZ8UhmrvIdjwCTqhH96VtTf7CKnwJj8ybdLdfaoA2aD
   8O1HfOzkGrfTkYvgH5y5Gy8t0DYeOxWp6F3c8xl+H44ywXa5jv223O5Ik
   ssY5J88UL7SpBy2wPUUZWhqcQYmgUyViZyvR3B0xK+Dc8tpSYKiEtuQ4c
   Y5v6Ffft1u8MzYG3BBQSFSgwRzliH+/A1jwFAITw9TPVEKxNUvaEbBVM5
   g==;
X-CSE-ConnectionGUID: Xn0mHuKwR3K498W6WNZmwQ==
X-CSE-MsgGUID: wKjuEZqFQii7KxUsYYPCIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88096434"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="88096434"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 07:25:00 -0700
X-CSE-ConnectionGUID: UaHb8Dz5RxqPTSa/A8E5/A==
X-CSE-MsgGUID: HlplSxtbRaCXG4xdYgTSLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="254391667"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 07:24:58 -0700
Date: Wed, 8 Jul 2026 17:24:56 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Nirujogi Pratap <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>,
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: designware: amdisp: balance genpd on probe failure
Message-ID: <ak5duEKw9slpfFcm@ashevche-desk.local>
References: <20260708090552.739789-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708090552.739789-1-lgs201920130244@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 08, 2026 at 05:05:52PM +0800, Guangshuo Li wrote:
> The change referenced by the Fixes tag avoids a runtime PM resume during
> probe by powering the ISP domain directly with dev_pm_genpd_resume()
> before calling i2c_dw_probe(). Runtime PM is enabled only after
> i2c_dw_probe() has succeeded.
> 
> However, the i2c_dw_probe() failure path still uses the old runtime PM
> cleanup path. At that point pm_runtime_enable() has not been called yet,
> so pm_runtime_disable() is not paired with any enable. The failure path
> also skips the dev_pm_genpd_suspend() needed to balance the direct
> dev_pm_genpd_resume() call.
> 
> Suspend the genpd on the i2c_dw_probe() failure path instead of disabling
> runtime PM. This keeps the direct genpd resume/suspend pairing symmetric
> on both success and failure paths.

Ideally this needs AMD people to Ack.

-- 
With Best Regards,
Andy Shevchenko


