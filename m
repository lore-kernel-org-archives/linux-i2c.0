Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB9937EFFB;
	Fri,  8 May 2026 08:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228111; cv=none; b=oxhEYRGzIY4oULX0OdhQXl3nTFZk7JFOKhfv1RRvEiBjY/TLR2fNQ88ZdWFLLsGZ7VOa8HPsKWxneZ5Z8yBOI6aFJHoRkBZ6Q3CYRt32GNf1zTDXEECWiucVN/dwys7cffN2O/jGejJjEwm2SV4PTQD770t/nWTWgXmGC2J8CCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228111; c=relaxed/simple;
	bh=Z+3KsG3ELs7KD2eAtSFnsKfaQfjBuEh/PJlTEcRP7bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbNHO85+1Jpf8eigDD6xcVQXsxIATEDaPYTvtx27Ms4Wwqu1oVLRtpfgtt1Yiq4X2ewN+S8P05+cviyjXBMYTssLWfXC0ig5sAlZ2yaYx67lzJMytDT/dscHvKYToV8nit2sCEszfw43+w9cHH6Sb79qTxqQ7j0Ln5MRoVHXUUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cf+6/eHs; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cf+6/eHs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778228110; x=1809764110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z+3KsG3ELs7KD2eAtSFnsKfaQfjBuEh/PJlTEcRP7bk=;
  b=Cf+6/eHsHsdVKcjPBabA92fconbIyd2GMMLjFa0ph9o1esssQbH8otXN
   fGrK2nkHBePpqzHlOnBsqYk19yWDS+rGDHc4RAALOvdDHp40NCTC9DRZc
   DWXSuBMDlQkt5dkyMuNGcEdwKaTVdFA426NpsTIpL0vso7ZO5F894KNht
   T/ahpEbmvXSKHIZwcBNZ/T8on97pjxqdbEtuaFujAXGGbNM0DEw9IHbQL
   ffGdo7CtOCCJGXB/pzF5GVDdu6T0uVFTkdT8r46h5UbhgxwXSJQ57LH4U
   JwF722YxouiYFobIm1alfERohzv2532nBENufD+fMxf9p2Ai4dShL6ilQ
   Q==;
X-CSE-ConnectionGUID: kcYsSooVSs+Me/5OX6zGRg==
X-CSE-MsgGUID: TLisdqMOT+iHfAItALHifA==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79180829"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="79180829"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 01:15:09 -0700
X-CSE-ConnectionGUID: zql1AlYQSGmT5/WdKucXgw==
X-CSE-MsgGUID: JaOaDRBBThKw5ngS6zv4tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="260427085"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.237])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 01:15:07 -0700
Date: Fri, 8 May 2026 11:15:05 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "William A. Kennington III" <william@wkennington.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] i2c: designware: Convert PCI driver to use
 shutdown hook
Message-ID: <af2biS8SRkeNtGDC@ashevche-desk.local>
References: <20260507-dw-i2c-v4-0-9a447b23bfdf@wkennington.com>
 <20260507-dw-i2c-v4-2-9a447b23bfdf@wkennington.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507-dw-i2c-v4-2-9a447b23bfdf@wkennington.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 07, 2026 at 08:05:16PM +0000, William A. Kennington III wrote:
> Convert the PCI driver to use the new i2c_dw_shutdown() hook, allowing
> the controller to gracefully NACK master requests during system shutdown.

...

> +static void i2c_dw_pci_shutdown(struct pci_dev *pdev)
> +{
> +	struct dw_i2c_dev *i_dev;
> +
> +	i_dev = pci_get_drvdata(pdev);
> +	if (!i_dev)
> +		return;
> +
> +	pm_runtime_disable(&pdev->dev);

> +	if (!pm_runtime_status_suspended(&pdev->dev))

There is a difference between pm_runtime_status_suspended() and
pm_runtime_suspended(). Are you sure you use the proper call here?
(Please, double check.)

> +		i2c_dw_shutdown(i_dev);
> +}

-- 
With Best Regards,
Andy Shevchenko


