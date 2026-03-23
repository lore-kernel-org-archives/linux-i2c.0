Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0E82BD00C;
	Mon, 23 Mar 2026 05:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774245286; cv=none; b=UXxDoW8NDF5HimEO773Gy3OQELTes4Nx/ragpz2IeWGHB/rf6NuNM/ohpdK81rQ4lIC74u5rczU1ZCI1vIx/QFf6TdJ/18RDlu/BGWeDR2Nx0o8/iL2X1njgJfSt0PxqEQ//XBiKq02XZsWWhwELlqgT3Tw8TNEaIBoa8s+YNOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774245286; c=relaxed/simple;
	bh=7pB3IexWILkGZQPD/drt3kTnoy8lnETc+f0miqD/wwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgR1Q8MToxNZt4XGFy7eBsien7u16y5YOahEcdAwn+TjijneoSlaQ/MYMxrhV/nxp/R5EOT3eav/x2aYVgC3o1qfKDxJXNv05dZhEG2g4yqjpQscqQxnAPLuOclDDvOh4yzpZDnR9n2sGmWK0tJZPpRUKTkIW+CBCmdJEXhZE3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dU5dg0DG; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dU5dg0DG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774245285; x=1805781285;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7pB3IexWILkGZQPD/drt3kTnoy8lnETc+f0miqD/wwQ=;
  b=dU5dg0DG95E0QKGhu4l1QAv6DCn7npR9hBqgxCH9eBlJ2Z+rAqWbqQyI
   Lr3S7vuk2hKIX4nvHCsZXtaQhZrs+NcFlwIsxaMNllnilRkv9BElFLh8W
   ucjCmkX1CdqIsvefX0e1PkoJPgXv+k1Tl5WCZ4m74v0ABau6vEiboZB/N
   gvbL5p6GLL/Cp9tA2SrQHXys96V0KCRWm01ib4ejRCDKEhThoZxlfL5Gg
   tM0ZnOFK/vvGDlHtl6DJ8cyqsJitx41oQhHqQ0woXX1LuZoLZRlKUwAB5
   IClvejT4UVO+rJdReTL5xXk9LCnqg6THdr1w7vbmeKBmVekpzv5vlHvxp
   w==;
X-CSE-ConnectionGUID: Kq4rOqwzQhezH0SUBnIo7w==
X-CSE-MsgGUID: 6vApx4snReSXgaeDnz90Sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="92618808"
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="92618808"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 22:54:45 -0700
X-CSE-ConnectionGUID: HStTgEnoQiq48sXoYSDMSg==
X-CSE-MsgGUID: nP0vo3MQS/+MU+R7E+PBFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="228393311"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 22 Mar 2026 22:54:42 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 58B8B95; Mon, 23 Mar 2026 06:54:41 +0100 (CET)
Date: Mon, 23 Mar 2026 06:54:41 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Pratap Nirujogi <pratap.nirujogi@amd.com>
Cc: andi.shyti@kernel.org, andriy.shevchenko@linux.intel.com,
	mlimonci@amd.com, jsd@semihalf.com, rafael.j.wysocki@intel.com,
	benjamin.chan@amd.com, bin.du@amd.com, king.li@amd.com,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: designware: amdisp: Fix resume-probe race
 condition issue
Message-ID: <20260323055441.GW2275908@black.igk.intel.com>
References: <20260320201302.3490570-1-pratap.nirujogi@amd.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260320201302.3490570-1-pratap.nirujogi@amd.com>

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
> 
> Fixes: d6263c468a761 ("i2c: amd-isp: Add ISP i2c-designware driver")
> Co-developed-by: Bin Du <bin.du@amd.com>
> Signed-off-by: Bin Du <bin.du@amd.com>
> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
