Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BE6276038;
	Mon, 23 Feb 2026 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771858795; cv=none; b=R30ENkey4opIxVuHqF4N5W58ATkZmiAhsTuYV/tTzj7hITKppaJJ8hmZyfqGiZXUZYxyiApN9eBFwJyU4cFYvV9EKG0Cz1TeJtZy7Fwxv2vPaQWeVniPM0V1UhiLuonyc15J1AhJ/glckTwlLUeJCOIG1+3H3KNYlXUHT5PCTPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771858795; c=relaxed/simple;
	bh=eeWYPc8OuwfwyaVW6aOAdz8XwY93DInoJYhirUrauSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tns0L0Zw9hQ8Sl6+PyP7XAr6kRfa2LAtq6gc9mXyRnjZvsXcK6lD0Mq7J9uNR1KNWvX4lxrZq5GbxZzJhCyF2v0RNLiYRsbUflLLqIku1fyjJUrrdrV0nkNGv2YYMkanlhIKPj5FjUlfdR51tCmEbo+PNF3+7QqZg9xSSAlg+j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ONhwtS1p; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ONhwtS1p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771858794; x=1803394794;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eeWYPc8OuwfwyaVW6aOAdz8XwY93DInoJYhirUrauSw=;
  b=ONhwtS1pHSFvJnhMJDShh5Xk5OfeU3raHaIfPSzsntkv2ePRb9xlq+0T
   CrcgThvfLl6bR3HH6aipeqnXfnkmiMx/PAAjjssyawhC6r8sUYKtYD63P
   IyCfm/+6RbNxuuWYJfDth4Un1hiEz56wTrcEk99ckngPGgYcJOI7jrEI4
   UUSpX+eLtf6GYccgR8h5mwAbbYzbr9WX6r0e6/3WZd2q4n8MNFMu3fjI1
   mLSZjRFv4261ZLSNdSPLamsc3iZxbXGdcT57Us5ZWaJ094a2ZjmJIp/Hf
   C34MLa/Rvx1O9kjmfhQZkJR2R6hABam2qD0PScn1FR/XsEu/DuEoRaxY+
   Q==;
X-CSE-ConnectionGUID: z2/+d9kXS7ulxtCGKe1wCA==
X-CSE-MsgGUID: rMg/+P51TfWxSac51jkBdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72732162"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="72732162"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 06:59:53 -0800
X-CSE-ConnectionGUID: shuSI13fSgCfW9D2/WJiUQ==
X-CSE-MsgGUID: bJFQHpcxSWuxnu5RtOf7iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="214666564"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 06:59:51 -0800
Date: Mon, 23 Feb 2026 16:59:49 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 3/5] i2c: davinci: calculate bus freq from Hz instead
 of kHz
Message-ID: <aZxrZbbXxm31q62s@smile.fi.intel.com>
References: <20260223-i2c-mux-v7-0-ec75b214718a@gmail.com>
 <20260223-i2c-mux-v7-3-ec75b214718a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-i2c-mux-v7-3-ec75b214718a@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 03:33:52PM +0100, Marcus Folkesson wrote:
> The bus frequency is unnecessarily converted between Hz and kHz in
> several places.
> This is probably an old legacy from the old times (pre-devicetrees)
> when the davinci_i2c_platform_data took the bus_freq in kHz.
> 
> Stick to Hz.

...

> -	clk = ((input_clock / (psc + 1)) / (dev->bus_freq * 1000));
> +	clk = ((input_clock / (psc + 1)) / (dev->bus_freq_hz));

Two pairs too many parentheses!

	clk = (input_clock / (psc + 1)) / dev->bus_freq_hz;

...

> +	dev_dbg(dev->dev, "bus_freq_hz = %dHz\n", dev->bus_freq_hz);

%u ?

-- 
With Best Regards,
Andy Shevchenko


