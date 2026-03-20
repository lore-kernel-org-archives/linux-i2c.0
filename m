Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B4523E35F;
	Fri, 20 Mar 2026 20:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774038336; cv=none; b=JOIzD2wjkxuoW6ProOEXWqlMNmQb7GBn1qd/svHbiD1i2pdLTzg831GgiFFaHpH0UvH4yMi0dPZaZsI4L9neqY7JJHJgvaIhTxsGPhODWPMjKfA1NGc7ocHIRVQclR8BhhO42TWA15Qf9xfjnwMnec1UFHgHk+LLIM6tntBKe5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774038336; c=relaxed/simple;
	bh=+EBofhuo5rIf0h9wfB2tgLKm69Xa4NcTglFRtyb4NAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCB62p+tV5v41BbKStrTGcZcM4ApltT6HK9U0qAQ+Id9ewmduuJiKXXWmUnzuNrL1LcaoBAxHIbHoWQ9s22C+wvXC466EZPKOg2e47HHOIetYY85Xq0Oh+vfoAmdpCUfk4KDynL5GrQ+akNJwkg4x7oWtnBfDNZd3nmVte5DsZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b2Rtj3RZ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b2Rtj3RZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774038335; x=1805574335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+EBofhuo5rIf0h9wfB2tgLKm69Xa4NcTglFRtyb4NAw=;
  b=b2Rtj3RZaxV/ZyPPDI7mVbLTZGK8wi6H3oxujQREr74M+sY8NmU5I6eX
   r93dtgfsslzKvfMR1Yz3SnSmlenpdeFluuzoXJtPRPRuYkRS5yX7/j1Fv
   Ob4J4jzEO/BqGds4miOKnzPq8Xb0FwMOLL1r+xjDuazBBIiiTSkseKgjJ
   1G3qaG3PNJcDxK9C7kaBJsYXnWy8nHQ9/5rZydeVxPy4WMq0SK158QZCI
   kpZnhDSSRWeuE0EkO6LcbgcC1qbQM7+w7aZm5eHxjf5vM4iamNKRpa2XM
   +h2bhngLdHAgCj/4jx/diEVyXX7rz7mKKQh8Ke7tD22eUy+kEuSoohcFo
   A==;
X-CSE-ConnectionGUID: Nspv1v3TSHWFUI9fFPtnZQ==
X-CSE-MsgGUID: 1FXmn73rSIy8SDX9se9LMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="74833716"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="74833716"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 13:25:35 -0700
X-CSE-ConnectionGUID: AkyUCEWrSBqlLOHSVgQv/Q==
X-CSE-MsgGUID: ZJv4MECfTMyt1BS+qoVzQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="228119139"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.40])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 13:25:31 -0700
Date: Fri, 20 Mar 2026 22:25:29 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Pratap Nirujogi <pratap.nirujogi@amd.com>
Cc: andi.shyti@kernel.org, mlimonci@amd.com,
	mika.westerberg@linux.intel.com, jsd@semihalf.com,
	rafael.j.wysocki@intel.com, benjamin.chan@amd.com, bin.du@amd.com,
	king.li@amd.com, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: designware: amdisp: Fix resume-probe race
 condition issue
Message-ID: <ab2tOW_D582rG-rH@ashevche-desk.local>
References: <20260320201302.3490570-1-pratap.nirujogi@amd.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320201302.3490570-1-pratap.nirujogi@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 20, 2026 at 04:12:22PM -0400, Pratap Nirujogi wrote:
> Identified resume-probe race condition in kernel v7.0 with the commit
> 38fa29b01a6a ("i2c: designware: Combine the init functions"),but this
> issue existed from the beginning though not detected.
> 
> The amdisp i2c device requires ISP to be in power-on state for probe
> to succeed. To meet this requirement, this device is added to genpd
> to control ISP power using runtime PM. The pm_runtime_get_sync() called
> before i2c_dw_probe() triggers PM resume, which powers on ISP and also
> invokes the amdisp i2c runtime resume before the probe completes resulting
> in this race condition and a NULL dereferencing issue in v7.0
> 
> Fix this race condition by using the genpd APIs directly during probe:
>   - Call dev_pm_genpd_resume() to Power ON ISP before probe
>   - Call dev_pm_genpd_suspend() to Power OFF ISP after probe
>   - Set the device to suspended state with pm_runtime_set_suspended()
>   - Enable runtime PM only after the device is fully initialized

LGTM, assuming that genpd calls are okay,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


-- 
With Best Regards,
Andy Shevchenko


