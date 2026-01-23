Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0892A313E27;
	Fri, 23 Jan 2026 08:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769156954; cv=none; b=r7qmZj8peUaAq8AWzNEiRsCAYMJvRoCVxnr38olEsKtqv+Ik3Yn41MfEvnRjC2uQpkxcaoGQhoAgylSBZIcY3Uzzb9amxXkSGScJBgKnZBO4GhInaUfPb0M5gq1ipfyRJ4EAIRHTI8I8EJAAsgHoJtaysmwAFDyZAmiXha1PIIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769156954; c=relaxed/simple;
	bh=+FO1sOyryoVaL+5sM+Kc3yiCES2ozS3s2AkTaIZ9ALU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYSSs5N3kXwXOA80g6IMpXyRaybEkGT0srBsNreFgHdQRmz87xXt7sxpQQjcV/j51ouIA20UrVDLu9wJcHyX/qjwhu8oFBO9prvXvHYMkLywL7+NNV/zxkShHz3/fTcJYBXtSE1qJ6P9+uLUiAyR7VYGQ1jkMz4fKzymNFOvQUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B5mJiQai; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B5mJiQai"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769156954; x=1800692954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+FO1sOyryoVaL+5sM+Kc3yiCES2ozS3s2AkTaIZ9ALU=;
  b=B5mJiQaic9HGXGRXORM99q67wpdD5PumtlaPRiOGekjTayzKwUXXJFCv
   HYKF9Rr2MW+XJxeCUl1lXVeNQZ5Mz6AFASOdQ5U6iQvqRoUc4OyeybWVe
   KnSkp2Cq1ornoBbIirfixDHqaNFFR7sKansb9FS/Dj4n0hxlCuSvpMgnB
   3E8hwUHLznEjlc5bt3DDqcw6T3Z+Y/PiEIL+qT5WDQ9aQlwtVaawHbMyL
   i4yplXYxX54MDP9OquEbwLxjV0CpfasVOyS4ZYlw90NfkdG/fqRYdcy1o
   POh6cmWHG8gKnpfIZU7RuY+LxesoKfJCcjbbCTuNDcKVJcUFRYmaldQ90
   Q==;
X-CSE-ConnectionGUID: lS9EVhhRRjuT6Jde2FQiyQ==
X-CSE-MsgGUID: hzuA3+GOTCqKA6L1vBmweg==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="80714489"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="80714489"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 00:29:13 -0800
X-CSE-ConnectionGUID: bUbY8p2ISkaKRR8vT0t7sw==
X-CSE-MsgGUID: DK67XXI0SJW3+VLCKZZNYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="229930151"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 00:29:10 -0800
Date: Fri, 23 Jan 2026 10:29:08 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: abdurrahman@nexthop.ai
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] i2c: xiic: make the clock optional
Message-ID: <aXMxVK5nGjeO1wGX@smile.fi.intel.com>
References: <20260123-i2c-xiic-v3-0-eb7cd4254dfb@nexthop.ai>
 <20260123-i2c-xiic-v3-1-eb7cd4254dfb@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123-i2c-xiic-v3-1-eb7cd4254dfb@nexthop.ai>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 23, 2026 at 08:02:44AM +0000, Abdurrahman Hussain via B4 Relay wrote:

> The xiic driver is designed to operate without explicit clock configuration
> when clocks are not specified in the firmware. This functionality is
> already implemented in xiic_setclk(), which performs an early return when
> either i2c_clk or input_clk are zero:
> 
> This condition is satisfied when clocks are missing, as clk_get_rate(NULL)
> returns zero, allowing the driver to rely on hardware-configured timing.

...

>  	mutex_init(&i2c->lock);
>  	spin_lock_init(&i2c->atomic_lock);
>  
> -	i2c->clk = devm_clk_get_enabled(&pdev->dev, NULL);
> +	i2c->clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);

You also need to have

	struct device *dev = &pdev->dev;

in *this* patch.

>  	if (IS_ERR(i2c->clk))
>  		return dev_err_probe(&pdev->dev, PTR_ERR(i2c->clk),
>  				     "failed to enable input clock.\n");

-- 
With Best Regards,
Andy Shevchenko


