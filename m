Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A481D1A2C0B;
	Thu, 22 Jan 2026 09:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769072517; cv=none; b=hw2UD59ghFya2SDdVCY3Om24kRxEa0vxdoQTPY55TPfRdrJboybjUrEIHroFFrqDLJyyc4lCZtH0Dm9ofl4cdyE87GaXRIZ57MK7SIzj1myrZ/fheN2ON5OItn65mk1KKa/6inpvzRyhMpKOdu9JKqs29I2FHRT/7UcAdxtk1JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769072517; c=relaxed/simple;
	bh=0PLhBGRCcCQ6B4NkqwzugRep/KhDaHErzomQNLHyNBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuE7rm4Ui50BLk1iTlHKmBFojQe/0bflno3TexPYcHHRsWUMOT7DkrH5EQctHRG6VMSmK/6QMnb6IThCDZav949OP8OshU1OxcSWmZGtcrqASNQPMDro1kDOPnHStWOS5Uk8o7tidYlaQ7zbHtGySqcG7yLjoKYP0Co8TqbDo4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZOf/BcIt; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZOf/BcIt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769072516; x=1800608516;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0PLhBGRCcCQ6B4NkqwzugRep/KhDaHErzomQNLHyNBo=;
  b=ZOf/BcIt3t5dktyUhjbtJAG7gbIoJYMdhFhIE6gAAbGgSzL4Dlz32sNZ
   DzsW3UNrKyMuPIhamEFA9pfGmQxnLE32V7CZ6GekqJk1rCxJyF0qhQs+0
   lMPp1115F5ABIi+661lsVjp74+A39TpfB7nA7wEIq7BgEBI5jIff4Rjvc
   YAxcUfngLKCbiarH6YsfGsVXIDkiBOwbQb4+lp/nLVTutc+Xbz/lbgDoh
   /Ih54LpH6QH9/9ksOX+kYTauIRWgjBmoN2vvMCOl2a+kyjWfjWAzjuUnN
   Kvohlax8dsLNMzPlTRDOGH/UR8CmN96/MAlsKCfRclM5xxpB2swiRlsz1
   w==;
X-CSE-ConnectionGUID: UxRkiO0CTsG0YanEyT+NmQ==
X-CSE-MsgGUID: 300CRWDFQSqrMG8GJLXbqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="57873612"
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="57873612"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 01:01:55 -0800
X-CSE-ConnectionGUID: mYHlDwRGS3ymDiM1OUGzww==
X-CSE-MsgGUID: T+lTUCIST0iYTuO+Xq/YCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="206732450"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 01:01:53 -0800
Date: Thu, 22 Jan 2026 11:01:50 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: abdurrahman@nexthop.ai
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] i2c: xiic: make the clock optional
Message-ID: <aXHnfhUU6vSoFVok@smile.fi.intel.com>
References: <20260122-i2c-xiic-v2-0-134f5d743e8b@nexthop.ai>
 <20260122-i2c-xiic-v2-2-134f5d743e8b@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122-i2c-xiic-v2-2-134f5d743e8b@nexthop.ai>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 22, 2026 at 08:32:32AM +0000, Abdurrahman Hussain via B4 Relay wrote:

> The xiic driver is designed to operate without explicit clock configuration
> when clocks are not specified in the firmware. This functionality is
> already implemented in xiic_setclk(), which performs an early return when
> either i2c_clk or input_clk are zero:
> 
> This condition is satisfied when clocks are missing, as clk_get_rate(NULL)
> returns zero, allowing the driver to rely on hardware-configured timing.

Hmm... Sounds to me like a fix to the early introduced feature.
Might worth to add Fixes tag and make this to be the first patch in the series.

Either way, LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


