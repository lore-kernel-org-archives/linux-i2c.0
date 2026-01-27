Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A492E11C7;
	Tue, 27 Jan 2026 09:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769506873; cv=none; b=hRJcyN4FK0l+i4Wv+MAHWMe1bv28gNfpCnxI+bcxMOBaWAACM63+ERhAxWpT9Ip3l6r3q6sW9K6S9V+QVUjaeNwpcZuI96VDHlbj0acpiaXUDWo+C0NKPvFSgTv6N2bmmKDLK7wDDtJs5s7Nw8ymNMCXV6iH4R2gCcHyD0N7I1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769506873; c=relaxed/simple;
	bh=wIXG/8Eo//+j0yiImQIH97d8+3mFCxfZi9vJb7DS8pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSXxz74a+utCPeM643HCsE2ZSkHsMVdvYTW5beYTrnXGUa6u9cBrnqKqTipzOIoxjOPrMNWjznwu1HlUh/sPdsDEe2gzWXehNcnet9Jghb1jG+ym0j/+PmYT2Oq/Rj1j66GRVJRl/xvRqHHe7E56rbq6PFKvkTRUZho2c8VFoR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kxMj1pQX; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kxMj1pQX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769506872; x=1801042872;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wIXG/8Eo//+j0yiImQIH97d8+3mFCxfZi9vJb7DS8pc=;
  b=kxMj1pQXRh2fNV2y+cTHrUAZtWykeWy8OGhV442HIccv5LbtbQ1DGzhd
   g2lDlJ36UgQcEX+BOujkc5Nvtya1eh1rnEJ5KWA2EJaGRCK13L+puWj9i
   c8lrYwPZ3++RGTrAkNVm1hiDv6NWM0TJek0d18fTYziD1N1Y1NURNY7O+
   pCFa9d8Gl3s3PiJW9VnSy7ZRyB0sIMHnL0GqU76U2UMdJ0HpcKYILSPfA
   bobqjltAGr6hyPVczWBDN12s3DtdgHtObhUJ2Uvb0zgNwn4GdThflEC3v
   VapGLzKrGShoD2DnsH7N9sFmiKOZNdMrxnXUnSE4DROq3eT/bnuH3X9dJ
   w==;
X-CSE-ConnectionGUID: FrhTtuz9SKWTcPPlXXvS4g==
X-CSE-MsgGUID: Inn1GMYiRKywBM4ogHrGSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="58270410"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="58270410"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 01:41:11 -0800
X-CSE-ConnectionGUID: fAXHViZGSHCLuNfjHWBb0w==
X-CSE-MsgGUID: BFlrLTLRQT2o9ar23b41uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="212475873"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.248])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 01:41:08 -0800
Date: Tue, 27 Jan 2026 11:41:05 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: abdurrahman@nexthop.ai
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, info@mocean-labs.com,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 5/6] i2c: xiic: switch to generic device property
 accessors
Message-ID: <aXiIMUUWREUT8tm_@smile.fi.intel.com>
References: <20260126-i2c-xiic-v5-0-88a16a28721c@nexthop.ai>
 <20260126-i2c-xiic-v5-5-88a16a28721c@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126-i2c-xiic-v5-5-88a16a28721c@nexthop.ai>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 26, 2026 at 05:08:20PM +0000, Abdurrahman Hussain via B4 Relay wrote:

> Use generic device property accessors.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

One nit-pick below.

...

> -	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> -					xiic_process, IRQF_ONESHOT,
> -					pdev->name, i2c);
> +	ret = devm_request_threaded_irq(dev, irq, NULL, xiic_process,
> +					IRQF_ONESHOT, pdev->name, i2c);

>  

Also drop this blank line.

>  	if (ret < 0)
>  		return ret;

-- 
With Best Regards,
Andy Shevchenko


