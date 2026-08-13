Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02622349CE8;
	Thu, 13 Aug 2026 07:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786606548; cv=none; b=We1v7g8fpkF0sC6Fp1pnB4inQaC8v27AB2eGqyU3whfwdTQ6s/1gZu94dqnGfUyfszCFINUyiXfLiwM1CeXqhNZPrOox2QsVJtsE/JRv1qlWExaSDG2ZuDxaEEzjQzA2EU6hrZZCqCx8nQrIvJ5xPbzm4s6MWlMUJwf6jnxrV6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786606548; c=relaxed/simple;
	bh=cuNXeAVdWv3xL9pwIpH7JbgWejFU7j7EWG1EvCAsu4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqriL2joxz7mI4pOOHnxDDv5ErnEAELoTw1SGXPXLZRU6skESG7zkfK1ULkBYw7mgLpCV/n34XMUExQgUQEMf/GPEq3lzG6Ngs26vRd88x4ufHiEfsO2BZs0NbZ1k81YwpwevjV1fMwQJMvBvWPt8OwO5Gkgem5e8rttrpHsnBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jxd/GB+p; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jxd/GB+p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786606546; x=1818142546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cuNXeAVdWv3xL9pwIpH7JbgWejFU7j7EWG1EvCAsu4c=;
  b=Jxd/GB+p43dxlE127aCFPDmhCIYVphA+lOzOb93JyvC8r0vhDpU8unNm
   mFmDdqo8CwuBAH+VnV96tCcvI/px8oD3e+LpxFITUrWFBXb86rvX1pLZE
   FFFad0LAsxJCDbNtP36aKJBN8trPf2P2r1Ycqm8Sgxhp2LYSHbweTgkiL
   vhBonLab5KPM7Gu1rEyv9ToRKY9du7fdAM94UireGvq4K8ujB4pHWzst9
   ULJ2QDwQK73vFQ923FUpoR+uOAd9byyrDgjpQIgg9FVEfrq3DfFfZOqH7
   Ei9OWnj9TfeT8bzzN9E6EIRiUiDhSlg9PMMhE2feYwH5VMDRURrhRRB9i
   A==;
X-CSE-ConnectionGUID: UzRcDsMBSAa/97/6IpmazQ==
X-CSE-MsgGUID: samNe6niRXe4QF6GDzU5NQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="87034230"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="87034230"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 00:35:46 -0700
X-CSE-ConnectionGUID: gcj8aimEQgOxzpJJGGx0jw==
X-CSE-MsgGUID: FgIsAtpKQtqkf5hmYuzm8g==
X-ExtLoop1: 1
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.250])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 00:35:43 -0700
Date: Thu, 13 Aug 2026 10:35:41 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "clarke.li" <clarke.li@hj-micro.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>, linux-acpi@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>, andy.xu@hj-micro.com,
	peter.du@hj-micro.com
Subject: Re: [PATCH v4 1/2] ACPI: APD: Convert fixed clock rates to use
 HZ_PER_MHZ
Message-ID: <an1zzWb0mpm1huz_@ashevche-desk.local>
References: <20260722073031.1078080-1-clarke.li@hj-micro.com>
 <20260813063005.42925-1-clarke.li@hj-micro.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813063005.42925-1-clarke.li@hj-micro.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 13, 2026 at 02:30:04PM +0800, clarke.li wrote:

> Use HZ_PER_MHZ multiplier for fixed_clk_rate values to
> improve readability.

And actually increases robustness of the code as there is less chances
to miss a 0 or have an extra one.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


