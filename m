Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C09F34B661;
	Fri, 13 Feb 2026 11:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770981251; cv=none; b=TZ5imyONoUkU65UzV4m960A4d8q6QB6jzeDorUhq413fiiTUHwIh2g9RQeykUAj8EoZ4o4TRE8xnQLfQ2hJxjokSRp45BNesGMU5pQ+M61gRJYDCO6mAJhzvPdLrt0I8aixol8qV4qidKc+nBM+Gk4Mn0jk/kj7oVQ6mhEOy+Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770981251; c=relaxed/simple;
	bh=+8aBZJqxJhqCJZ7eoqLEz+sX3tjpS03I8vQECstrgo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEj1oeg8yfstDmKOnHJjfl+WwoXoBKxAwxMxyDal2gAC9Hsg+VuI9Nag9JH8jMSSXeR/xYej2X6HXRXhwOnCFEJQM/UxH7U5LsxWD7xTMS+r5Hw6nUfajB/zd5YTLqGwP0qljKR5/zfdoSFi97n11Yk+eVT0no5Fm3LfGDXDe60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UWJeO3St; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UWJeO3St"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770981249; x=1802517249;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+8aBZJqxJhqCJZ7eoqLEz+sX3tjpS03I8vQECstrgo8=;
  b=UWJeO3StGNjPXymef/RR9weYvgeNcHWblHKvNf0IpBfr0Vgxi7O0ii6x
   ax0EPkApUdth3W6X8/Gu+Zfv7a7286SaDOcrW+/xPx4clS7+MyFgN43Mn
   jgOagbA4M7AKFnBooydZduD/nir+XJHjhH0rqOEn+regtnrd4188HulTB
   2aSLfIUiqAmC59S/RiF0DQBS+48kldQ9QcY7EzqjD5Seuf6K0A3OLXtkm
   tIH0pKNFoOurKKBPEpiUjS9YhrEyhkh3zUcBpq7XVvXjS6jQRTvHMFvWw
   LFCsM+dLlTZM0YSdbP+Iw6RezQ0JugNHe9Az6pC68fIxA84IsV8wb2QBY
   Q==;
X-CSE-ConnectionGUID: J5XwLyP/QQmJER9rZ20lcg==
X-CSE-MsgGUID: 5nXQEmAcQjaEsvFt0/IDGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="59736395"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="59736395"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 03:14:08 -0800
X-CSE-ConnectionGUID: jZ8rbkQGR/yPUGqsWkTfOg==
X-CSE-MsgGUID: Qow4PsEwRXi7vWUXA83rOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="217438803"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 13 Feb 2026 03:14:06 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id D2B3595; Fri, 13 Feb 2026 12:14:04 +0100 (CET)
Date: Fri, 13 Feb 2026 12:14:04 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/5] i2c: core: add callback to change bus frequency
Message-ID: <aY8HfN3c3qcVbOJj@black.igk.intel.com>
References: <20260213-i2c-mux-v5-0-fb2cbf9979b3@gmail.com>
 <20260213-i2c-mux-v5-1-fb2cbf9979b3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260213-i2c-mux-v5-1-fb2cbf9979b3@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 13, 2026 at 12:06:50PM +0100, Marcus Folkesson wrote:
> All devices on the same I2C bus share the same clock line and the bus
> frequency has therefor be chosen so that all attached devices are able
> to tolarate that clock rate. IOW, the bus speed must be set for the
> slowest attached device.
> 
> With I2C multiplexers/switches on the other hand, it would be possible
> to have different "domains" that runs with different speeds.
> 
> Prepare for such a feature by provide an optional callback function to
> change bus frequency.

...

> struct i2c_adapter {

> +	int clock_hz;

Why signed? Even inconsistent with the parameter of the below.

> +	int (*set_clk_freq)(struct i2c_adapter *adap, u32 clock_hz); /* Optional */

It's already a huge struct, can we make this compile-time chosen
(when I²C muxes are not required, for example)?

...

> +static inline int
> +i2c_adapter_set_clk_freq(struct i2c_adapter *adapter, u32 clock_hz)
> +{
> +	int ret = -EOPNOTSUPP;
> +
> +	if (adapter->set_clk_freq)
> +		ret = adapter->set_clk_freq(adapter, clock_hz);
> +
> +	return ret;

The 'ret' is redundant and can be dropped completely. This makes the function
2LoCs shorter.

> +}

-- 
With Best Regards,
Andy Shevchenko


