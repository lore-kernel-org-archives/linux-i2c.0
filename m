Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667D03DB31A;
	Wed,  8 Jul 2026 19:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783539041; cv=none; b=FCpjA/yvXIklbeBOzJpt0NuAe2ZVgyI2uC4FnmK1MRnmkFQkfYPqx7H8MQvOAHt2Kmr2+s55Y87rjE0L1M1WKhOzbRcXQ7eH1CN69SK6fdPrJSqtiTduJX3HzUr2q+Nq3Hej3Fb2EcEQh54BcPquivbURg6QsZnpEbJlyFn7H+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783539041; c=relaxed/simple;
	bh=qAq+ZSPXLg44QlTgS1ix9LoGfl+1op/1FU+72xyaugQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fY+NcWhTDBe+gt4HCQg95OqjEwpxqdvwq5hH6Ky0NfjdXmnS9WmyHbqvJLVyDUAqXqroN6wySX034n0fCVZao6aMwiRw/w95r+QguUzUjIhTeYCmAkl68Bp1VQcjQlFfAJ8LtAU9udCfKU6AyjFLRSIFLXH5pgtth4PJV3vmydo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ivXrQbI3; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ivXrQbI3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783539039; x=1815075039;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qAq+ZSPXLg44QlTgS1ix9LoGfl+1op/1FU+72xyaugQ=;
  b=ivXrQbI3k7vDPyVSEpMjjDqvcO+9hInDYR/wj1PFT1SSprxkGMrn26Ub
   AwXwPDxub93apyC2QiCIt7ip5QziDk8fYR3NAeeM0MKvbpR1XQBIEdcLc
   nM86HIFXw7kcbJIpbADBP7xfSksTBwDWJVW45tyCixBUWEcKD1LPilEN9
   OtekIKyFk7XlTfy9yVsDSTrq830J0jgh52ZOx5K5QAVgtuYVJ4pWiVPat
   0QPRkDZki521Gi/MfIZoaAw1N58oicci5O37rEyOkBxsMS3Ym+HFN/I0D
   EYc2Qqr0lW04lGbXsCkV8jTjgl3SquVVVtd5wvJhJ5tfWMEJ7D9ml2Ksu
   g==;
X-CSE-ConnectionGUID: 6unRKvqTSYewbLF8G92jGg==
X-CSE-MsgGUID: eeN+1I0ORy6kd8Ad2xOF2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="86759740"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="86759740"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 12:30:37 -0700
X-CSE-ConnectionGUID: B1vqodKVQpqhh0ViXt/yQA==
X-CSE-MsgGUID: ga5rGlrpT2e1FEmaSw3fbA==
X-ExtLoop1: 1
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 12:30:35 -0700
Date: Wed, 8 Jul 2026 22:30:32 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 4/7] i2c: davinci: calculate bus freq from Hz instead
 of kHz
Message-ID: <ak6lWKWDM8XwqLgw@ashevche-desk.local>
References: <20260708-i2c-mux-v10-0-09dca03c8a15@gmail.com>
 <20260708-i2c-mux-v10-4-09dca03c8a15@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708-i2c-mux-v10-4-09dca03c8a15@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 08, 2026 at 02:16:16PM +0200, Marcus Folkesson wrote:
> The bus frequency is unnecessarily converted between Hz and kHz in
> several places.
> This is probably an old legacy from the old times (pre-devicetrees)
> when the davinci_i2c_platform_data took the bus_freq in kHz.
> 
> Stick to Hz.

...

> -#define DAVINCI_I2C_DEFAULT_BUS_FREQ	100000
> -

You need to rebase this on top of the i2c-next.

...

> +	/* standard bus frequency */
> +	unsigned int		bus_freq_hz;

While at it, I would dare to suggest _Hz as we started doing in IIO (id est
we start following more closely the SI units in the suffixes of constant
definitions and variables to be case sensitive).

...

>  	r = device_property_read_u32(&pdev->dev, "clock-frequency", &prop);
>  	if (r)
> -		prop = DAVINCI_I2C_DEFAULT_BUS_FREQ;
> +		prop = I2C_MAX_STANDARD_MODE_FREQ;
>  

See above about rebase.

-- 
With Best Regards,
Andy Shevchenko


