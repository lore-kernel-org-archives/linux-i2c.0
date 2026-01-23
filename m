Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15081227B83;
	Fri, 23 Jan 2026 16:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769187422; cv=none; b=ZD3u6cGQ2gaCXsUKAdMsGZ98m1E6jfQt3OpiE6hOneqfFzrYPVD6vx+QJA8QprDxi4veYerTM5yYLWCEq672RCB9PdCD0/2B1UQcdVGbvMeX7XK8wHCdO7zT7OhsmOFE6HpFzxCw/CZ4GRoPqLiPKgD05ELgwZwHvcx0uD26QgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769187422; c=relaxed/simple;
	bh=ETja2x9jbkMhnduG6jPpAI5mgl3pccMdrptMXW31rbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsb7Hb0h8LNwkI2OX9DxWcyzfRM4q4sg4dWdQ2TFXaoTPw1vw5zWA2wtypMj167TMApFpNXpbp4GVHJ8FVYg688S/4Qv4RVGDgR3YzqIzsYj6r402mNHmSjSoB9GPcrIbOWDb7zRkpiA0SBwlEacKF/Qr19aVMed47UjSS9a1rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nUL3QEJd; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nUL3QEJd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769187421; x=1800723421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ETja2x9jbkMhnduG6jPpAI5mgl3pccMdrptMXW31rbs=;
  b=nUL3QEJd/sn0IkJ1rIA9rpajqibdZdzbGYV3KeXbr0kGWGiMEHJHBo5o
   361piDTOVslC8QL5h4Rbs8Zk0UKZ9HBdbPlhctXx87p4z8oUkvNn+cgzU
   iuDZX5pXmcpAtuJPNOOxvVgcmlI4lZ8foWKlUrLRgK6urI+XbNJef9v9b
   UKxQ9BVVwHl3cpKLHWZ2SetVkPn9Uuu5O95grLoG4yMj0c+kL2oehFJsQ
   0cJ67JhzBXnlj+qvho5YmHCwMbcuM37bf9qC5rDmJibkBfIMtaNh4+BYz
   9J5OpMfBSis9ASmdUb4UgSFcq/ncoD4YWAhIyCRG4QY+PjxJkuC0cIhJq
   A==;
X-CSE-ConnectionGUID: XTTBjxNRRA6cOiA3/L1xXA==
X-CSE-MsgGUID: XCEZSQ/VS+2YnjaUTUxpPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="70501036"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="70501036"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 08:57:01 -0800
X-CSE-ConnectionGUID: MwOpywMySKGwSHbVjeVEAg==
X-CSE-MsgGUID: tv6wIPEiRhqocY18Bga9dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="206185987"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 08:56:58 -0800
Date: Fri, 23 Jan 2026 18:56:55 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: abdurrahman@nexthop.ai
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] i2c: xiic: use generic device property accessors
Message-ID: <aXOoV-rbEGRur_UI@smile.fi.intel.com>
References: <20260123-i2c-xiic-v4-0-4a3eba3510ce@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123-i2c-xiic-v4-0-4a3eba3510ce@nexthop.ai>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 23, 2026 at 04:34:13PM +0000, Abdurrahman Hussain via B4 Relay wrote:
> Switch to generic device property accessors.
> 
> Switch to managed devm_ functions to simplify error handling.
> 
> Make the clock optional since the driver is designed to operate without
> explicit configuration in firmware thus making it useful on platforms
> where clock is not or cannot be provided.

...

> Changes in v4:
> - Reorder the cosmetic patch to be the first in the series.

No. that's not what I meant. I meant that the line that adds a temporary
variable should be moved from the last patch to the first one. The order
of the _patches_ was fine, now it's broken again.

Take your time and try to play with the patches locally to see my point.

Next week v5 would be nice to have that addresses my point.

> - Amend the mutex_init patch to also switch to the managed pm_runtime_
>   variant.

-- 
With Best Regards,
Andy Shevchenko


