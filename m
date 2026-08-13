Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6174728030E;
	Thu, 13 Aug 2026 06:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603074; cv=none; b=m8rlDTFSms27ukFWLAjpK6X+eVPU08Q0S5U1c96XSG6Xp2zZR1duVEdQ0mqQpwZ9G9gLlsuBlq79NET/AP3zkpHdzSTOh3OQj/gNNYedsdR6DrI0ZwOxPJ1YJe/3TEtIXz8P9elvHPVCsCLNFxZkML3vIpejPLPVENN9YicFueE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603074; c=relaxed/simple;
	bh=rF09dkfZ3K0vz9pFWm4Q2Eh+5l9tDU+a7xzIsYn0zTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAaMzcVSXyEKZ1fdn1sFO40tDTNgCYmE1qv5Zv3Zy0WUmfedcdex92bXFY9WygDYrInRcecfDozntAmJlo45Isjcnh+QJqCZyADPpI7EZ7gRt+RhjkAHO8gqyubfWxBUvMSYARPVgPOiG6iRmPQ3PZoWo7IDAbQRQXQ9fFhW7V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WvyQBYLM; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WvyQBYLM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786603072; x=1818139072;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rF09dkfZ3K0vz9pFWm4Q2Eh+5l9tDU+a7xzIsYn0zTc=;
  b=WvyQBYLM2Kk5AJ7iRw38j63ggTrkQpx7jRjPY4rLZUkYR4Oll0m1Nopd
   qgvK0wOSYhMVeAmJaccFLAdj2AQROrMInxK7uuvPnOtLNa7xy/9SwuHH4
   tqZ0CXR7dYZHXOuuDLDSpm+bOG9475uXuDxJ8TIUXt2qytzyo6fgyf07i
   Xt5vOnkKHQPjmEZV8j/Yzjw0p6OtoqRcId6T5K6RJcWoZbghkMwapcoqp
   AW0JVunD9wU73LLHGtKQsaIKktG7kpVioMF5utIFIf42cafPRCri2jHWm
   9FRuZ1edY6BTDlbfCdXr5ekHvWNBVyZlhDkk9jC0F1vAiepxUEIQKXqA+
   Q==;
X-CSE-ConnectionGUID: yIIul5CbRPekmpXsjsdPlg==
X-CSE-MsgGUID: SyMTVoeRQvimPuajiVlo7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="97833758"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="97833758"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 23:37:51 -0700
X-CSE-ConnectionGUID: +KtouXQkSBGvI0d8jcLZag==
X-CSE-MsgGUID: 7Z1FN42BTBqK6h1JEoY7og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="263395391"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.250])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 23:37:49 -0700
Date: Thu, 13 Aug 2026 09:37:47 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Umesh Kumar <ukumar@marvell.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	bbhushan2@marvell.com, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] i2c: designware: Enable SAR in slave mode for
 Multiple SAR controllers
Message-ID: <an1mOxBoqTc_8DE0@ashevche-desk.local>
References: <20260804041842.3205356-1-ukumar@marvell.com>
 <20260812114514.3817964-1-ukumar@marvell.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812114514.3817964-1-ukumar@marvell.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 12, 2026 at 05:15:14PM +0530, Umesh Kumar wrote:
> DesignWare controllers synthesised with the Multiple SAR feature (e.g.
> Marvell CN20K) gate the primary slave address behind IC_ENABLE.SAR_EN
> (bit 19). Per the Synopsys DW_apb_i2c DataBook (Multiple SAR feature),

Also provide a version of the DataBook. Something like v2.20c (hypothetical
example).

> when this bit is set the core acknowledges the address matching IC_SAR;
> otherwise the address is NACKed. The slave enable path writes only
> IC_ENABLE.ENABLE (bit 0), so on such controllers the target never ACKs
> its address and a remote master cannot reach it.
> 
> Set SAR_EN together with ENABLE when entering slave mode. The bit is
> reserved (and ignored) on single-SAR controllers, so existing users are
> unaffected.
> 
> Signed-off-by: Umesh Kumar <ukumar@marvell.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---

This is a v3 and no changelog here... What's going on?

Assuming this will be provided
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> +		/*
> +		 * Per the Synopsys DW_apb_i2c DataBook (Multiple SAR feature),

Ditto (mind the version).

> +		 * controllers synthesised with multiple SARs only acknowledge
> +		 * traffic to IC_SAR when IC_ENABLE.SAR_EN is set; a plain enable
> +		 * is not enough. The bit is reserved (ignored) on single-SAR
> +		 * controllers.
> +		 */

...

> +/*
> + * IC_ENABLE.SAR_EN, per the Synopsys DW_apb_i2c DataBook (Multiple SAR
> + * feature): on controllers synthesised with multiple SARs (e.g. Marvell
> + * CN20K) the primary slave address (IC_SAR) is only acknowledged when this
> + * bit is set. Must be programmed while IC_ENABLE.ENABLE is 0. Reserved on
> + * single-SAR controllers.
> + */

Not sure if we need a dup comment as it's also in the code. Perhaps leave only
in the C code where it makes more sense?

> +#define DW_IC_ENABLE_SAR_EN			BIT(19)

-- 
With Best Regards,
Andy Shevchenko


