Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A62744D02B;
	Wed, 21 Jan 2026 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768984574; cv=none; b=AqzABMExjwRVf/SHsss4SX7OlMAlFoOkG3QpQ6x3PprspCJSkdXvxi7UM624QzdiSxnk2ieV41/jTLS5Xflw9d/2lK45u16xT+x1ISlvBvXir3cntiQRv2Yc8282AjfkH6g1n4VVpV5wB2eC/WERJBfgnLuZ0dWHp+kTMo6T3cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768984574; c=relaxed/simple;
	bh=AmAt/5VJ7tS0yWz5F1R0sjelT69xys6GeqwdR0QvhZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ov88co5+eRvjxQSGtaJG38MHpRP5zUnf/aH23xROzCFl5fRkAzkSlP3HTz5LjiYqum9OhlbQumab1GlMc56WP8vMiLESAweEccWjPXOu6phMSyz9H/53Ikz0WJ75Bd8uZOsqiYFMp3bEpjZYle0m4MVqChiX1HBMYiasn4OST5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QsX2A0qF; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QsX2A0qF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768984573; x=1800520573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AmAt/5VJ7tS0yWz5F1R0sjelT69xys6GeqwdR0QvhZE=;
  b=QsX2A0qFj2ZibFAhZmb4tEM5KlgMfM2O1vGvh//2QEgwvSXn0zZYeDU4
   i2fWKsGka13/FBtu55sCgbssrMJecBtOtezyOY7/nVDsi77MDsSFKN04I
   75GNIjmmZNkO700DfXhPE8yy5sjBDGcKLKSp9OdvwvX7U9Qj3tYvLlVbZ
   hPRbDaf0P68qaQzaI5WhmuEQcYPQtCKv0Oyx/BYii/5JCZE3TRldv1z9p
   +qRpikT8GvvLQC2HkY3tLgHaM3iAHdCJm2f/GZiQmZg4QuEY7PKR8fQGA
   X6/TNbgVZV+jJ+NsfUzWMPZy7EHZoIWQQeUETVBxrgXyItxtvBU4bTITa
   Q==;
X-CSE-ConnectionGUID: jGfh0BdTRcOVcT3bBOzyvw==
X-CSE-MsgGUID: cjxxjyhuSQS2oy3HYPWZkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="80835385"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="80835385"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 00:36:06 -0800
X-CSE-ConnectionGUID: y0n/W5e5TIy+9Z8MZXZB3Q==
X-CSE-MsgGUID: +PBGUecEQL+drmTeR2NE0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="205638284"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 21 Jan 2026 00:36:05 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 5049498; Wed, 21 Jan 2026 09:36:03 +0100 (CET)
Date: Wed, 21 Jan 2026 09:36:03 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: xiic: add ACPI support
Message-ID: <aXCP87og_n1DLUKL@black.igk.intel.com>
References: <20260115002846.25389-1-abdurrahman@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115002846.25389-1-abdurrahman@nexthop.ai>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jan 15, 2026 at 12:28:46AM +0000, Abdurrahman Hussain wrote:
> Use generic device property accessors.
> Make the clock optional assuming it's managed by firmware.

The generalisation parts are okay in a sense for prototyping, for ACPI-based
platforms, we want to see the proper _HID allocated by a platform vendor
(and maybe accompanied _CID allocated by the IP vendor).

Also you need to reshuffle header inclusions (removing of* and adding proper
headers following IWYU principle).

...

Add

	struct device *dev = &pdev->dev;

to the top of the function and use it everywhere.

>  	i2c->adap.dev.of_node = pdev->dev.of_node;
> +	ACPI_COMPANION_SET(&i2c->adap.dev, ACPI_COMPANION(&pdev->dev));

Instead of two lines, switch to

	device_set_node(...);

...

> -	i2c->clk = devm_clk_get_enabled(&pdev->dev, NULL);
> +	i2c->clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
>  	if (IS_ERR(i2c->clk))
>  		return dev_err_probe(&pdev->dev, PTR_ERR(i2c->clk),
>  				     "failed to enable input clock.\n");

This needs to be in the separate change explaining why this is okay to go with.

-- 
With Best Regards,
Andy Shevchenko


