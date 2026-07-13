Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54613382CB;
	Mon, 13 Jul 2026 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959097; cv=none; b=WlC9A9PF8FFJUUWQxCloGizUBxg3HBfjQ5aV38xlNc5sGpNwbTbIbAEswgPG1Htqh0eesDr4VZGp8DHJxtsiP5014jewNnaDwP1RA4wU5vZo6phxCz18Yn1CeB84mwEETyQ4oEuPyubnbzQIug0zNaM3YitzXiQT9Vf8DZ/fkd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959097; c=relaxed/simple;
	bh=+IU61+Jwj0fMNgcOY65R9qPPSYIUxxsbnaMdI892scM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idelNOYN/0HXsxGOqMz3QyTrYFBiELcshzOUgmtWSv/oSLkn6DXE+5PusuvypwJkNz3aHb7Ps2LiR/z6uTW3m0oC0NrRccRa+wfBtH3EVhEOD5lpMDnlmpaTkwmMyR1x0M3QszFumoO2WOAQ2ufuD6vXcy5DwHc2xRDWJxzZJXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iSt268Hl; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iSt268Hl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783959094; x=1815495094;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+IU61+Jwj0fMNgcOY65R9qPPSYIUxxsbnaMdI892scM=;
  b=iSt268HlBAE1W3O8c2BmxOdywMGJauauX9oikkfdX19AgUA1cix45h3B
   xnEoieLxe40zwRXty9mLOfTn7uC6fBnruvQiXQGSPqv2hKL7TXXr6ssBg
   b+5ZNW6mJDgsD2TuxyAmTC2E0QIGA94ctj8qvnVzrHUzYMAF7kX8h+p0s
   wktT1WSpKmxd771WWXpK8LKIbCah+jC5bsbOE30MkTpXdk8+Xp5kXPtJh
   LtYXrB86nUrNwdU14TLhKEXgvruNgDc8q/Pbr0eyfwg+rUe4RB8jHRkJN
   cOz27yw7Wj2YKWDaH7Lp4VWhQjZbIbNME2NOjn/oDBa/NWq+O8P9GLQ36
   w==;
X-CSE-ConnectionGUID: XHBsoD6NSB6kQaoP+eHSXA==
X-CSE-MsgGUID: nQG75TH3S66aHjqEXQtdqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83551651"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="83551651"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 09:11:31 -0700
X-CSE-ConnectionGUID: zTJ+zbqmRTShmr594eTWxA==
X-CSE-MsgGUID: 9qK1kM3gTW2YwQIZ2QQNIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="256233993"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.88])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 09:11:28 -0700
Date: Mon, 13 Jul 2026 19:11:25 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v11 1/7] i2c: core: add callback to change bus frequency
Message-ID: <alUOLfkkB1oNTa-n@ashevche-desk.local>
References: <20260713-i2c-mux-v11-0-72bb8af8ee8c@gmail.com>
 <20260713-i2c-mux-v11-1-72bb8af8ee8c@gmail.com>
 <alUODujJFdtYElbY@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alUODujJFdtYElbY@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 13, 2026 at 07:10:58PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 13, 2026 at 09:19:57AM +0200, Marcus Folkesson wrote:

...

> > +	u32 clock_hz;			/* bus clock speed */
> > +	int (*set_clk_freq)(struct i2c_adapter *adap, u32 clock_hz); /* Optional */
> 
> Ah, I thought you also updated to _Hz here...
> 
> But no need to resend just for that, only in case of a new version for
> something else. (Or maybe Andi even can tweak this whilst applying...)

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


