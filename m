Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B5F2DB7A9;
	Tue, 27 Jan 2026 09:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769506541; cv=none; b=R2uysreuP4pdk4Qd5TEsVWMw5zuGjHFsvLgwkTDZ8dHBKoSiYxHWD6kIV+NdmncHIjiMYzEAQ6wZAQVvu8y0gy7kFAYCSm0mhQcyMAoClPBJCLAU0u8Gb2gPp+hTxoKnBfqvrGX27hpcMKJfRk8Ynvb22OtIZQiyHaIahhifvlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769506541; c=relaxed/simple;
	bh=u9fgX4gOpXlnZ/mXQcZ3TbVrsG5fbHhYBvVFFPW/45E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMB020RHRK4trJ2fhbZmLUjFJL+koaIFiPKdpBw4/e/NTy1H8mR47teGFi0hXBzWbZJ22twOSF8/TN1DHASwmL8/t/W/ZGOmdEKNEEPbrnvbk+tXh2RMpTR0+5F5zXU+QvTFMrDlRMa6x6XvQQzLtLCxZTMaQaQub9pVQ6NLGuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FN3hgyMA; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FN3hgyMA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769506539; x=1801042539;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u9fgX4gOpXlnZ/mXQcZ3TbVrsG5fbHhYBvVFFPW/45E=;
  b=FN3hgyMAg41lqIcOEI6H8q8tx+45cEsU8TLJw9oqmK8jqxWX/QDaDdq6
   bC0sW/l9mcfYC3nVDdtRtMhRy21ZOHvZ/caAL9yAm7ge+fOY+WGbhGtlY
   w8qmbLb50LJ5nwL3vGNVxGfED0acdXfEBTlhqkXPuERTe2KBaYMCXnHeh
   gJZ0A2rySdXoFvTmsPdL1fV/RoWDHXJG+azZahkDTawkfVtgwTasxE1n5
   ykRnUwdxfCZSF8+Ni2UhkfkJOyxV0WDm0Kj2tPUeNBU626adtbEKFfh9X
   YxtTeYBNLG/c9cCYtGDizjY08boBqhlOOaAbTReDo5WhN9qWyzTT3/0jt
   g==;
X-CSE-ConnectionGUID: hCm8CRQdRkWQVD2Bi/7XzQ==
X-CSE-MsgGUID: hO7Wxa0OQs+9VBgXk5nsrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70591253"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="70591253"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 01:35:39 -0800
X-CSE-ConnectionGUID: YSXB+yfTQSuClfxtWBR2zA==
X-CSE-MsgGUID: dA66sZBFQn2pvXbzeSQpag==
X-ExtLoop1: 1
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.248])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 01:35:36 -0800
Date: Tue, 27 Jan 2026 11:35:34 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: abdurrahman@nexthop.ai
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, info@mocean-labs.com,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 3/6] i2c: xiic: switch to devres managed APIs
Message-ID: <aXiG5p9BQ-vkAgbV@smile.fi.intel.com>
References: <20260126-i2c-xiic-v5-0-88a16a28721c@nexthop.ai>
 <20260126-i2c-xiic-v5-3-88a16a28721c@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126-i2c-xiic-v5-3-88a16a28721c@nexthop.ai>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 26, 2026 at 05:08:18PM +0000, Abdurrahman Hussain via B4 Relay wrote:

> Simplify the error code paths by switching to devres managed helper
> functions.

Thanks for the update, my comments below.

...

> +	ret = devm_mutex_init(dev, &i2c->lock);
> +	if (ret < 0)

Why ' < 0'?

> +		return ret;

...

> +	ret = devm_pm_runtime_set_active_enabled(dev);
> +	if (ret < 0)

Ditto.

> +		return ret;

...

>  	if (ret < 0) {
>  		dev_err_probe(&pdev->dev, ret, "Cannot claim IRQ\n");
> -		goto err_pm_disable;
> +		return ret;

		return dev_err_probe(...);

>  	}

...

>  	ret = xiic_reinit(i2c);
>  	if (ret < 0) {
>  		dev_err_probe(&pdev->dev, ret, "Cannot xiic_reinit\n");

Ditto.

> -		goto err_pm_disable;
> +		return ret;
>  	}

...

>  	dev_dbg(&pdev->dev, "mmio %08lx irq %d scl clock frequency %d\n",
>  		(unsigned long)res->start, irq, i2c->i2c_clk);

Side note, consider using %pR instead of ugly casting for resources.
(separate change).

-- 
With Best Regards,
Andy Shevchenko


