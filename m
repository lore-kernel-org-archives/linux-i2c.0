Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9963F54C8;
	Tue, 11 Aug 2026 06:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786431284; cv=none; b=Pn3yikzcN7SlTjBLJ3BBBNAwQ2rPeT8HUuz4BLTYHKbbWreiX3+qOS0CPV1hdmvyhjRag7tUpZadpeRE+xwG3BugdF/taatSlT3dS5/qOPPMMMsYHYXk16YYuDpAighSAdo7i1XAM3ykoDdBmnQbQQBMFLUOpTGu3u5qFRiyWEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786431284; c=relaxed/simple;
	bh=ic3K9BQJq/OVmymXuEfj1LgU8GMOnfOC76au+Xvn9RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ej8G7SiNyFAOMnFxGV1buZOBEjEhTV335B1J324HuZUmDR8v1C3pr7uEBTvbWrdOOFd8fM6XvesCXMZrnCQ4N4XTuemWeXB9EPDarhs9+S1z+UkqpTCgnrOj3aa8eCSxPOnlp5yVdZu9eIwx+E3OrFnk2wCsOYogeNEZy98Cvnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UEvsPcS6; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UEvsPcS6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786431282; x=1817967282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ic3K9BQJq/OVmymXuEfj1LgU8GMOnfOC76au+Xvn9RY=;
  b=UEvsPcS6kNiYPBtWgNGOt1IDUrB2TYWC54yV2Q5rgQaKcYUEvRjxKTpR
   K8G4Ed+1hEEnzRjZ0P1rkDpiE9OLx8xtnJGnlQ1tVvy0Rd8GGfGrdDaVQ
   GZB++CTeh20E3P3M/b0Um4XgZYKEruTEgIAj1KNTya/3z2kT17oy+r8Vr
   CqouEoAuBgTSlzLXDUnDRjI2pT3NtP3M06arYOZghpH8HuNUlpfVERNv6
   sa1RWXz0jjo50rO+zGWC95uT23a2oV/JMF8Bsba0vz2UMiWm7hMwLtYzl
   /c2jzJ+k2xe35OsKId9S+HKvcVmLpUmyoaN2xDxNWlSlbaqHDG9bZ81xf
   w==;
X-CSE-ConnectionGUID: 0yYNZ6eST5Gh0QEnCHn9mw==
X-CSE-MsgGUID: GzAMKRw8RPiK0FvwItgVJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="86076133"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="86076133"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 23:54:39 -0700
X-CSE-ConnectionGUID: lsYTd/iBSz2XSZs2Pzrp9A==
X-CSE-MsgGUID: 5LfAZEvBS9m0t2YKUXuk9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="267533406"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 23:54:36 -0700
Date: Tue, 11 Aug 2026 09:54:33 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "clarke.li" <clarke.li@hj-micro.com>
Cc: andi.shyti@kernel.org, andy.xu@hj-micro.com,
	jarkko.nikula@linux.intel.com, jsd@semihalf.com, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org,
	peter.du@hj-micro.com, rafael@kernel.org
Subject: Re: [PATCH v3] ACPI: APD: Add clock frequency for HJMC01 I2C
 controller
Message-ID: <anrHKdFEUF339B7Q@ashevche-desk.local>
References: <anTvBaRZNDhCz60e@ashevche-desk.local>
 <20260811062234.74676-1-clarke.li@hj-micro.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811062234.74676-1-clarke.li@hj-micro.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 11, 2026 at 02:22:34PM +0800, clarke.li wrote:
> On Thu, Aug 06, 2026 at 11:31:01PM +0300, Andy Shevchenko wrote:
> > On Wed, Jul 22, 2026 at 03:30:31PM +0800, clarke.li wrote:

...

> > > +	.fixed_clk_rate = 200000000,
> >
> > Can you at some point update these constants to use
> >
> > 	.fixed_clk_rate = 200 * HZ_PER_MHZ,
> >
> > and so on?
> 
> Thanks for the suggestion, I will use 200 * HZ_PER_MHZ in the
> next version.
> 
> By the way, do you also want me to convert the other
> fixed_clk_rate constants in acpi_apd.c to use HZ_PER_MHZ?
> If so, I can send it as a separate cleanup patch.

The idea is that you convert existing ones in a separate patch and then use a
new format for the new hw support.

-- 
With Best Regards,
Andy Shevchenko


