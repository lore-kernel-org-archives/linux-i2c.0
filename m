Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6989C21CC5A;
	Thu, 23 Apr 2026 07:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776930209; cv=none; b=CL9LDAj0e8eHfhI0pRLqHC13yOai5LEGgEKuC2femASZWSxLYCovPwqoicSHNo9Fkq+TSQ3691is1UL+Tgod05mUywfcdQmPb4ELrbW9jZMhYGBWA+P3E974Ssfj/3jAdVzqzHwAnG+49DYP715JkSLazKsh8Dp+F4/KbPxT0bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776930209; c=relaxed/simple;
	bh=J4dHfOTUKeJ9GEIQxOV2nPqCssixcNbK2lkF7nAVRgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGXTkr0oFWWYl+lxcR0rS2NY2BqbRFEmgMpljCz+57me3am14J8R0/LHPThgX67+Jdh5PtHdG8uhxEV3MudO8BjUEVlIlS0CJKGG/S9a+RXD2KwmyG449J6dxTak6YyU6mHgpwdLoa5Yqytwc0FrFQU0WddBn9bS1OZtKAPba0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=msCoAUHB; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="msCoAUHB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776930208; x=1808466208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J4dHfOTUKeJ9GEIQxOV2nPqCssixcNbK2lkF7nAVRgM=;
  b=msCoAUHBofioRTQxSPRxq7KdItz9Qyei9WAGABFNrcYa4CNnNUteeTPD
   Be0c2tXfqJBuY+fTra4794QYurEezAEkHfJuuHv2TZEmfstdBUpSV7qgs
   IiMDP6ZoHVmKhbsHv1XUyBIWwkGkrdBvfv1lqBa865Oh9+Cp5LFLjZZKR
   gv44irPXLpL3IXhMf3Rd5OPr5SeYmU7LhcEYG4Aru1zkKReefzrBuQxLg
   8k/uMuSz89ZslY9ohY9Jw1cQtxPP79Xjlrhem+jodPQUSRkk0Q2qoi8JL
   nicIDY5LOplCShw7fVkzrisfiDMVxJI5hvlsdgRvRViRkUNwWmrA9BL1d
   g==;
X-CSE-ConnectionGUID: oJT8S/rhTFqFE2M/+MGhdA==
X-CSE-MsgGUID: lxET+Is3RpGcOrRMF13p8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77771792"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="77771792"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 00:43:28 -0700
X-CSE-ConnectionGUID: C/qPYpEET06KVb2dKuFEUQ==
X-CSE-MsgGUID: HPMHtiCCQx2ax9C7kB3EJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="237568776"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.163])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 00:43:26 -0700
Date: Thu, 23 Apr 2026 10:43:24 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "William A. Kennington III" <william@wkennington.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: designware: Handle active slave and shutdown
 cleanly
Message-ID: <aenNnI4XGHMHr9-I@ashevche-desk.local>
References: <20260423002838.83171-1-william@wkennington.com>
 <20260423005241.89054-1-william@wkennington.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423005241.89054-1-william@wkennington.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 05:51:05PM -0700, William A. Kennington III wrote:
> When the I2C master attempts a new transaction while the slave
> controller is shutting down or restarting, it can lead to bus lockups
> and system bootloops if the hardware enters an inconsistent state.
> 
> Address this by ensuring that the internal state machines are properly
> cleared when disabling the controller if slave activity is detected.
> 
> Additionally, add a shutdown hook that gracefully sets the slave
> disable bit before disabling the controller. This guarantees that any
> incoming requests from the master are immediately NACKed during
> shutdown, preventing the bus from hanging.


Do not send a new version:
- inside the same email thread as the previous one(s)
- too early, give 24h+ _at least_ to others to have a chance to look into it

According to the split I think you can do it in a way that it goes like this
- introducing shutdown exported function (and use it as is)
- convert PCI driver to use it
- convert platform driver to use it
- do something for target case

...

>  static struct pci_driver dw_i2c_driver = {
>  	.name		= DRIVER_NAME,
>  	.probe		= i2c_dw_pci_probe,
>  	.remove		= i2c_dw_pci_remove,

> -	.driver         = {
> +	.driver		= {

Stray change.

...

-- 
With Best Regards,
Andy Shevchenko


