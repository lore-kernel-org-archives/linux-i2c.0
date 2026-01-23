Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE7532BF42;
	Fri, 23 Jan 2026 11:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166860; cv=none; b=T5IvOFGWZinip4NZAyQ1kOKJcwNR0a8PqO/roBdc9fKqiEFcj+5nkgT/RjghcrEn7RXNkpcbe7RYN0PlQeUb7vTrrR8ySLNHtIRYm9zOxNIjmB/Swy4uhiWClfvJZp21+kr2snawt5LwNnz/2aLGTQoyyyjSafg9uJPqbUY1U2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166860; c=relaxed/simple;
	bh=K6egzW7gYIjzDIoU1oVfC7B5vC8O1YyAGe0a1QNhitc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYa8+3ayChQH3t1EeUIZZDMjwntpSpz6EOB+nvwbwe0f8uSIe2CmVECH63c+htiOIihh2uw/9Va0LKeftHJoOcOYMpbRedpQmLOx3gInoSoHzsrazuYNxVFxr1p6+oILn98oYnVmP0Ab5/rphtcBnbd9FXV98cx7k0yvNRXoYHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ROQkiNum; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ROQkiNum"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769166859; x=1800702859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K6egzW7gYIjzDIoU1oVfC7B5vC8O1YyAGe0a1QNhitc=;
  b=ROQkiNumiltP+DYMaDW1KHnyUHKVR9JEmS0ZWBWIROAVvZZ40vndbCO3
   sjBGHQgVT5fBsrL+pEV3tLUs5pYrEgVkDccvgyvvqc4/p4mtKqxxpbNvy
   OViB4PgoZaeGbtdyj6mQPyA1HCzK9EyEf3B/iDrAAm90NH+e3DIJmPIWJ
   t0hnBCHvAIHarI4DBldTPIwHu5CKG5Jqm5nC7H2SL/3Mta1v+Quj+x/0a
   PXKc9hsptCW01GiPocmcl8ytphaTzNf0oaJrVL35/tokkuDp/64Q+VzFB
   bwscq38GDqxxqyUAkoWO3/6b1v1Vt7NDzgVn93CVZ9Kl9b4Bdd50OgkmX
   w==;
X-CSE-ConnectionGUID: E+2BRVAmTkurNw5W8NjyBw==
X-CSE-MsgGUID: 0pJp5htjTciw2PbG1oGO+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70480277"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="70480277"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 03:14:18 -0800
X-CSE-ConnectionGUID: swmIR8+HRyezJem1LIsjhg==
X-CSE-MsgGUID: UfC/sD4mRweKd2HiX2Ia4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="211502684"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 03:14:16 -0800
Date: Fri, 23 Jan 2026 13:14:13 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: andi.shyti@kernel.org, p.zabel@pengutronix.de,
	mika.westerberg@linux.intel.com, jsd@semihalf.com,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] i2c: designware-platdrv: simplify reset control
 and error handling
Message-ID: <aXNYBahiKTnVkRfg@smile.fi.intel.com>
References: <20260123100537.1429497-1-a.shimko.dev@gmail.com>
 <aXNXx4elBVRpWCWf@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXNXx4elBVRpWCWf@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 23, 2026 at 01:13:16PM +0200, Andy Shevchenko wrote:
> On Fri, Jan 23, 2026 at 01:05:34PM +0300, Artem Shimko wrote:
> > Hello maintainers and reviewers,
> > 
> > This series refactors the DesignWare platform I2C driver to simplify
> > reset control management and improve error handling:
> > 
> > Patch 1 replaces the manual reset control acquisition and deassertion
> > with devm_reset_control_get_optional_exclusive_deasserted(), which
> > combines both operations in a single call and leverages automatic
> > resource management.
> > 
> > Patch 2 follows up by refactoring the probe error handling to eliminate
> > goto statements in favor of direct returns with dev_err_probe(), resulting
> > in cleaner and more linear control flow.
> > 
> > Both patches maintain functional equivalence while improving code
> > readability and maintainability.
> 
> You send a series as _three_ detached emails. Forgot using
> 
> 	git format-patch --thread ...
> 
> ?

On top of that, this is marked as v5, where the changelog for all previous
iterations?

-- 
With Best Regards,
Andy Shevchenko


