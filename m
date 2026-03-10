Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F8734B197;
	Tue, 10 Mar 2026 11:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141684; cv=none; b=kneTheZoeccwDSrgvT2F+BymMhX52YVMa+YSgwGVdMKkQ6NUSWRJXie9FHp5L5cnsSHkmGBq0i5TrfrorGlE1jN8m8XBsFQ0ToQihJ0pd4dE5eQZqTy2Amj1eptJTL/HfBh59nQ3HMXMccEKZN7UGhnFhD372ZeOl8630r3jfCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141684; c=relaxed/simple;
	bh=5KDxirPBBbxIzsqGPuc6WuIr0Q9QkilWR9hau9H6ioI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdqbu5cbqCSam0hHM72yblhpH3uYSSCBNf+yyK4RstsPVe8PlbNwn1ROX8vdu7dssv8lfYSEDLAB+7lvuiorHVEuYQx24XeFroGwTSP0sDEEXmErQ7EjQ2vg9HY7iEB8FLjORBHzNLTmaQ15pVC7dHSM+Wmw5JhQJIQHAd/ocJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LZOfUCRg; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LZOfUCRg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773141683; x=1804677683;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5KDxirPBBbxIzsqGPuc6WuIr0Q9QkilWR9hau9H6ioI=;
  b=LZOfUCRgy7uTtuiUMYmV+3tVXaTcfIKPUAaKULJuiuEZFNeZnPAukt3u
   xQH1tUordYAzjxEz3DqLuPxXfCRtcwcGrcWou8zAUFxCmRd7JxaFL5CBP
   DI0M9ISbM5jgJEuLYNxxqUNYU4oI9IfzPCGczZvBmsqXAC3ZtQyar/dXq
   tuWYnFzEmb9Tpw9oOnRov2QzA/9/Ft9iZFZmSPYtPn8hsvIJ26gGVPl5O
   HuX8z5RZ5RRvyfRdzd1iWhyCLzxvqxBWdnYahAPMkDOGpr9rxisEpS5IJ
   9UH1lYfANRdp7tdsvOdbplGP+Kz7zNxnKPClXwY8MbY9CqDgPOPUK9j0m
   w==;
X-CSE-ConnectionGUID: AhTjLiisSruRB3ui+YoWiQ==
X-CSE-MsgGUID: efD/9jpvS4+GYc37uqy+Mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="74261332"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="74261332"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 04:21:22 -0700
X-CSE-ConnectionGUID: JZmHQ37yS26HpWbrZRf6yw==
X-CSE-MsgGUID: LakJgpNNSZCd87znHnAqOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="224766108"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 04:21:20 -0700
Date: Tue, 10 Mar 2026 13:21:17 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Pratap Nirujogi <pratap.nirujogi@amd.com>
Cc: andi.shyti@kernel.org, mika.westerberg@linux.intel.com,
	jsd@semihalf.com, rafael.j.wysocki@intel.com, mlimonci@amd.com,
	benjamin.chan@amd.com, bin.du@amd.com, king.li@amd.com,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] i2c: designware: amdisp: Fix null pointer dereference
 in runtime resume
Message-ID: <aa_-rfyWBtdkA_qx@ashevche-desk.local>
References: <20260309220038.1420996-1-pratap.nirujogi@amd.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309220038.1420996-1-pratap.nirujogi@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 09, 2026 at 06:00:01PM -0400, Pratap Nirujogi wrote:
> Add NULL check for i_dev->map before calling i2c_dw_init() in the
> runtime resume path. The regmap may not be initialized yet when
> runtime PM tries to resume the device early in the probe sequence,
> leading to a NULL pointer dereference. Skip the i2c_dw_init() call
> if regmap is not yet created.
> 
> This race condition occurs when runtime PM resume is triggered before
> i2c_dw_probe() completes the regmap initialization and was observed in
> kernel v7.0 where the order of device enumeration has changed because
> of the changes in registering the device sources in the device hierarchy.

> Co-developed-by: Bin Du <Bin.Du@amd.com>

Please, read Submitting Patches on the tags, especially how to correctly use
Co-developed-by.

> Fixes: 02c057ddefef ("ACPI: video: Convert the driver to a platform one")
> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>

...

>  	i2c_dw_prepare_clk(i_dev, true);
> -	i2c_dw_init(i_dev);
> +
> +	/* Skip i2c_dw_init if regmap not yet created by i2c_dw_probe */

Use same style for references to the functions: func().

> +	if (i_dev->map)
> +		i2c_dw_init(i_dev);

TBH, Looks like papering over the problem. Why the resume is called on
uninitialised regmap to begin with?

-- 
With Best Regards,
Andy Shevchenko


