Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE96534A3A2;
	Mon, 16 Mar 2026 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773655223; cv=none; b=NVqyRtO6i1Gmx5VqfvnSF2NTxqea26gw0T62pHumSXVNWqQv5rPbTPsMqwrftwkbhjhLh5XLEZHfr1abPE199pS7OJf7qpFpwIF34itI1ASX7IAjBRqg1fnxE2MoF2Pb1BVpWpva1ZFfIG2AyT3t6PeIyo6pkuSz1/8VRXQVhdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773655223; c=relaxed/simple;
	bh=oDCWXtcdNUoexWPdAJlnnGHY5eh//4KjcNNcgNjgvqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dm1JwKKpG8GRvGMfeswQTlZyxhHDdqVmgZNS8jrT/fn9aoHWlb4qoh0MeOhL90r2zYM2tyXb4ZleB0FiWUz5QwntKJX//LL+0imVKqo7gPUg808bPj7XF80xmyrYnsvd9DZWfxVaWtbkaqZlVgpvvwEht4qFJc6m4WzWyPGVQHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q8n1M2ss; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q8n1M2ss"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773655222; x=1805191222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oDCWXtcdNUoexWPdAJlnnGHY5eh//4KjcNNcgNjgvqA=;
  b=Q8n1M2ssUJEGoQpJZn+myeSY/ra3jWdENJ3ZRq/if1ABoOJzOkaXz+pI
   eFrb0tkFuQNBXA/5OyaeJo46LHh/n+/+OeeGKHNjWWwBV0ilfZ9UCUY0v
   Hn5k8a8ex2iwbRmqcyyap8zuAHCPVOfcxlGNyfWoOgHmvGp8BXZ2mzQbE
   k/Z9NTLoJf+OEyLPCYD3VhO9uCOkVAvDV/+VqaHZwOo42lyQ1ikBPH6Oc
   dnbQLQQJowJpAOyzPFHhjiHBdUdxc6hfilaO5ldV++8TJo6+lO1hSuanF
   QShkLAHmkIPHW/0f7bYG8NKFiAwnetCnhqYCPIvYyu8qemVHI1/6vKsIP
   Q==;
X-CSE-ConnectionGUID: k4yZI/uESMOS5z32IUtZUw==
X-CSE-MsgGUID: P1egZdJ+QK6RGyD6+j2/Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="73681468"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="73681468"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 03:00:21 -0700
X-CSE-ConnectionGUID: rSxpTnUpRkqodHdy8QXgDw==
X-CSE-MsgGUID: t2z2WKsKS7qI22OnAKAatw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="259768354"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 03:00:18 -0700
Date: Mon, 16 Mar 2026 12:00:16 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 4/5] i2c: davinci: add support for setting bus
 frequency
Message-ID: <abfUsE0cR6GddDDz@ashevche-desk.local>
References: <20260314-i2c-mux-v8-0-fb1738a4df0a@gmail.com>
 <20260314-i2c-mux-v8-4-fb1738a4df0a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314-i2c-mux-v8-4-fb1738a4df0a@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Mar 14, 2026 at 10:22:43AM +0100, Marcus Folkesson wrote:
> Populate adapter with clock_hz and .set_clk_freq() to enable support for
> dynamic bus frequency.
> 
> Remove bus_freq_hz entirely and only use clock_hz instead.

...

>  	u32 input_clock = clk_get_rate(dev->clk);
> +	u32 bus_freq_hz = dev->adapter.clock_hz;

> +

Stray blank line. We have already one below.

>  
>  	/* NOTE: I2C Clock divider programming info
>  	 * As per I2C specs the following formulas provide prescaler

-- 
With Best Regards,
Andy Shevchenko


