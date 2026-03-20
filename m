Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEAE3624C7;
	Fri, 20 Mar 2026 07:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773993558; cv=none; b=ZmSLdsIUwe9NqpGmRnOFK+y1CFlQNTQE5Bj9bYx660b20/12DvBT3YOOrHmq1XTC2ZGqigSW094vv8SHF7je6NcsB/rHvkh0pQoEZ3FtWu771jqcCUPOzIDpvyCasoplEn5WVEQ2aGrV4BHCldFY9sJUrturU1jjPX0ODukPbdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773993558; c=relaxed/simple;
	bh=wEBe04arJWo65GYbdK+opok7r1TtQgRsQgd5NXBQrKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V586Yut9ISRmTBXJtrGxRrjcdDPUWJRqQ/JFMr3jAfCXzBO6rrm5SHleQsoi2N4j2rLwrUJ9t5DvI5fs+fLliJnvr7kb4kIAj664w1aHAl1dtlVkFoxFhKjGjXx+BbNUc8TaGRU/j5klE+D/lV1Uxn0ShFRJH+fUOX8yxENnMws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CfSqCm6e; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CfSqCm6e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773993552; x=1805529552;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wEBe04arJWo65GYbdK+opok7r1TtQgRsQgd5NXBQrKE=;
  b=CfSqCm6es17fqqVQZusBUq02eZrAHjWc6mHi23jHbfNuWGacHnm9B0XS
   Poc3V5LB0DaVwBtqkvoPiNWCz3iSod45cuzFcv9m4tQ/tSW1kkO7MoVod
   SvQKhwkAwMNwV7OH7zaTVM/FPsdT9sxDwg7aRDaXiPzNURxfdC6R+kco/
   VZNYlDxBWp3f124Mz/jAFcXf8oPYdwL7Y31nnt48zLLhxTL83qfP7i4aV
   aE01R8+19NLIWnW+7dvqV3JPNaEqjoxIMn0iwKkPFGnaBciJX0zxICLl5
   TavgnuuZTVnQHpjkR8rUsht2EIfCP4mpF6FqGbblteaJjtpqK0JLEr7X3
   g==;
X-CSE-ConnectionGUID: /h7a1JlWQtamk7aL/YguBQ==
X-CSE-MsgGUID: W/X+J4YASHCxi2Zk4bu2tQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74256395"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="74256395"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 00:59:11 -0700
X-CSE-ConnectionGUID: 4iuIVPrwQPmyP3hL7kxUUg==
X-CSE-MsgGUID: jk/JI3pyRg+PM7yZ4v17YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227940551"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.40])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 00:59:08 -0700
Date: Fri, 20 Mar 2026 09:59:06 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Nirujogi, Pratap" <pnirujog@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Pratap Nirujogi <pratap.nirujogi@amd.com>, andi.shyti@kernel.org,
	mika.westerberg@linux.intel.com, jsd@semihalf.com,
	rafael.j.wysocki@intel.com, mlimonci@amd.com, benjamin.chan@amd.com,
	bin.du@amd.com, king.li@amd.com, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] i2c: designware: amdisp: Fix null pointer dereference
 in runtime resume
Message-ID: <abz-SmE5-_OLcZb_@ashevche-desk.local>
References: <20260309220038.1420996-1-pratap.nirujogi@amd.com>
 <4527c72d-bc59-4f5d-af94-4b2f37d75a96@amd.com>
 <61dbe8a1-6578-4690-8571-6b00c1850d34@amd.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61dbe8a1-6578-4690-8571-6b00c1850d34@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 19, 2026 at 05:09:55PM -0400, Nirujogi, Pratap wrote:
> On 3/9/2026 9:29 PM, Mario Limonciello wrote:
> > On 3/9/2026 5:00 PM, Pratap Nirujogi wrote:

...

> > > Fixes: 02c057ddefef ("ACPI: video: Convert the driver to a platform one")
> > 
> > Is this the right commit that introduced the race?  Did it change the
> > timing?
> > 
> > Or was the race always there and we just got lucky until that commit
> > went in?
> > 
> My apologies for mixing up this change along with other changes that were
> needed to fix the AMD ISP driver regressions in v7.0.
> 
> I investigated further and found that this issue was exposed by the below
> commit.
> 
> https://github.com/torvalds/linux/commit/38fa29b01a6a295aedb69d1bbdad70acd7d204c6

Still it might be not a culprit as at that point the device should be in power
on state.

> However, the resume‑probe race condition existed even earlier and had not
> surfaced because device initialization in resume is done only when init
> handle is valid.

That's what the initial cause, the AMD ISP driver initially relies on
the broken (racy) behaviour. So, the original patch d6263c468a761 does not
explain that bit. You need to go deeper and understand why the heck that
condition is present there.

> Here is some background and context on this change:

Exactly, the below seems that you have nailed it down.

> The amdisp i2c device requires ISP to be in power on state for probe to
> succeed. To meet this requirement, we added this device, which is a amdgpu
> MFD child to the genpd, to control isp power using runtime PM. The
> pm_runtime_get_sync() call before probe triggers a PM resume, which powers
> on the ISP and also invokes the amdisp i2c runtime resume before the probe
> completes resulting in this race condition.
> 
> To fix this issue properly, I’m considering this change. Please review and
> share your feedback on whether this makes sense.
> 
> - Call dev_pm_genpd_resume() to Power ON ISP before probe
> - Call dev_pm_genpd_suspend() to Power OFF ISP after probe
> - Call pm_runtime_enable() after probe is successful to take care of system
> suspend/resume.

I don't know the scope of dev_pm_genpd_*() usage, but the description of
the proposed change sounds sane. And definitely it's much much better than
previous attempt.

-- 
With Best Regards,
Andy Shevchenko


