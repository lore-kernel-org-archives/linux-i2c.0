Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F95A374E6C;
	Tue, 23 Jun 2026 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226617; cv=none; b=cDQrYbjBWJ0SvFKbWeY2+mOlDMElfhpKX9W1ymoWwek/bM52DPZvSFAkGFoNiUoFdaDTlRNu9ZQ+TD+xB4fTOG8wsPlHkd1PyeDK5glcwjw7aRWpKHFLGIJjeTP5thlvfZmRX2w+A1P1suazmVuoDDl2f9zEmQQ8NdNthvTg7X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226617; c=relaxed/simple;
	bh=mVYsYw1ucVaXNKvtzbi6Oa9Co2xKK5qNdkDxi0uQTAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lE6T0ZNWpKYdfldadXOnt87dncgOMEG/9XkIDd8tnLfDj5DSWBbg5XqrxtQWJsnvTq6PRd+6tWrQ5IUlujZkZxO9m+ZejCqUDry3wcwd0/1ECmcf7hLMDvcIiwnRwdsDN/XkChzU4yLYXl+33yRXuQZkEtJih2Qz4zwt4T+LjfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QZ6i8TqX; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZ6i8TqX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782226617; x=1813762617;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mVYsYw1ucVaXNKvtzbi6Oa9Co2xKK5qNdkDxi0uQTAA=;
  b=QZ6i8TqXpG1ThM0xIvmMmXVO09mpfPgjs5cENJcu25Z6yRKTelG1kmJn
   9PMhrwSLcRhL21zdL8m0wqotxphwkCZ8TxcKRun3sE3s7y72D6JmnuY2l
   CTSWkhlZxoE7JCTmobxFrQHm1rwOx3RQin6MxJ47cgytEOUGD88E+wf0b
   stu7EK9I1Tdjzm3/Pyxdnmfnus+5TB8XGRusxQhDfC0pg6mL5EmAmaURn
   fBb3Wh7H7GxbeQIWlNm220YoEDkLrLRvcaCpjNJbb6kQvhcUnK0+/KVJB
   IZ/2Y1/zMEk7cHbnjRQpNsdq1VhZSlzY89RYn4QBEyXvnBRT1vdG2n4Ht
   A==;
X-CSE-ConnectionGUID: EjQW+eRGStyHul+ArbWZ9Q==
X-CSE-MsgGUID: QPK2sWqlRMO3yZlpSpYiUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="105763840"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="105763840"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 07:56:56 -0700
X-CSE-ConnectionGUID: T3Z0S8oOQi+u4vJDuzeBDg==
X-CSE-MsgGUID: W+Ok/sbYQeGQzEInTBJZ8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="243176004"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 07:56:54 -0700
Date: Tue, 23 Jun 2026 17:56:52 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] i2c: k1: Use generic definitions for bus
 frequencies
Message-ID: <ajqetPOoD1uY8HgD@ashevche-desk.local>
References: <20260618141125.3241048-1-andriy.shevchenko@linux.intel.com>
 <ajqYHXuaibeBdiEL@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajqYHXuaibeBdiEL@zenone.zhora.eu>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 23, 2026 at 04:31:08PM +0200, Andi Shyti wrote:
> On Thu, Jun 18, 2026 at 04:11:25PM +0200, Andy Shevchenko wrote:
> > Since we have generic definitions for bus frequencies, let's use them.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> This had some merge conflicts that I fixed. If you want to double
> check here's the commit id(*).

Looks fine to me.

> Merged to i2c/i2c.

Thank you!

> (*) fda74eaaf4cf ("i2c: k1: Use generic definitions for bus frequencies")

-- 
With Best Regards,
Andy Shevchenko


