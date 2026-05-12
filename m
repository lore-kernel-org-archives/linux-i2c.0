Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FAA3EDE55;
	Tue, 12 May 2026 18:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609109; cv=none; b=IIpUImCkEZQAxQ4rinBIucNqDfqIxESa3BIF16ouKghI0khdGvohnMETteUC24RQ0HVzjJZEBI1yKfOwU/NYNX3ok42u1TMzN/8jt8PSbykHPi5Pmm1l1cr6jvieWzWHGimIkym+V/AsGnEFDCuy0VirFpLz7DYxmVBNiiXEVOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609109; c=relaxed/simple;
	bh=AmzkJdlaT4IlIx5hWLbHD+/7+hdohkb4WSCfTgw3RuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kp5nMrszMAfznZPWkNVk2R77TVqnA0GXppMZpzFjz08qOOzcNuFagbHcuKc0zprzZKcqEEOaIsCMIPFmbtSpya0SKwTMt1mik6B/ME4jpgM8vJMEhTrvTWYGz/vA9/csEmDqxos1YznAjg+g07XFlVEPQ8d5vIx4QTtI+ydFyRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j+ip7qFj; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j+ip7qFj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778609109; x=1810145109;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AmzkJdlaT4IlIx5hWLbHD+/7+hdohkb4WSCfTgw3RuY=;
  b=j+ip7qFj1h2tOnxDUwPzrK7gbqgI6WF7HkoBeoPuqqsUzgm/mrz9pmgt
   N+MpGTGJakKs2RZvSOhqEeaRL5VIQerp4kT7zXLkCqgLat0ikuPtiEuMJ
   ydfeZOhvFeBhIwOQFyCMpI8XG5ri7vlpcdtfYeNQxlwI4IQnGQVPx9s12
   tYxiviU6tho/eo39kozATSNWeMgENaNHIHMgLpPQDIXRpFNNynKZ1CYSw
   vVl+d7KNOHXpWxxMyVcqmTAC9cg0YvIj7o6TR80iUd9HBvDDNsbtks5kE
   hFpgYj799T7jkjFJQ8bo1rwAEup4sgWKDkRRnUQtGjukJcs7DvQ8GraI7
   g==;
X-CSE-ConnectionGUID: dkQVSsIGR9mECPdmdaX/Aw==
X-CSE-MsgGUID: ylGWlQyHSq+vSLzLCXtzsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83401018"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="83401018"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 11:05:08 -0700
X-CSE-ConnectionGUID: OyL7RCeQRNuDh0jD097a5Q==
X-CSE-MsgGUID: IxNOx//NRrmKAe+otRcbJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="242808265"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.244])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 11:05:06 -0700
Date: Tue, 12 May 2026 21:05:04 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hardik Prakash <hardikprakash.official@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
	linus.walleij@linaro.org, wsa@kernel.org
Subject: Re: [PATCH 2/2] i2c: designware: fix probe ordering for AMD GPIO on
 Lenovo Yoga 7 14AGP11
Message-ID: <agNr0AoHJKRu6gzk@ashevche-desk.local>
References: <20260512073139.16343-1-hardikprakash.official@gmail.com>
 <20260512073139.16343-3-hardikprakash.official@gmail.com>
 <agMHIhMzS_8AicAI@black.igk.intel.com>
 <CANTFpSX-U5pJ3zQ7NMQMpSu+bw1wB5weW7E-oQ51oE7oZg1cZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANTFpSX-U5pJ3zQ7NMQMpSu+bw1wB5weW7E-oQ51oE7oZg1cZw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 12, 2026 at 04:37:58PM +0530, Hardik Prakash wrote:

First of all, please do not top-post!

> Thanks for taking the time to review, Andy.
> 
> To answer your question directly: yes, this patch series was indeed written
> with significant AI assistance (Claude, GPT-Codex). I used it to navigate
> ACPI analysis, interpret GPIO register diffs, and draft code I don't yet
> have the kernel experience to write from scratch. I performed the
> investigation, testing, and hardware debugging, but I want to be
> transparent about the process.

So, please study the kernel documentation about AI assistance.
This has to be clearly mentioned in the commit message (we have special
tag nowadays, Assisted-by: IIRC).

> On the technical points:
> 
>    1. "Existing?": My bad, the commit message is indeed wrong. The
>    dw_i2c_amd_gpio_defer_dmi table and dw_i2c_add_amd_gpio_link function are
>    added by patch 2 and do not pre-exist. I'll fix the commit message in v2.
>    2. Fixes tag: Noted. I will use the correct format with a commit hash in
>    v2.
>    3. dw_i2c_hid_uid struct duplicating existing structures: I will take a
>    look at acpi_dev_get_first_match_dev() and simplify accordingly.
>    4. device_lock deferral probe: I will add one explaining the race
>    between driver pointer set and probe completion.
>    5. device_link_add comment: will add.
>    6. ":00" suffix hardcoded in the warning: Understood. Will correct this.
> 
> I'll send a v2 addressing all of these. Is there anything else you'd like
> addressed before I do?

Two things that I mentioned above. The rest will see when there is the v2
appears.

-- 
With Best Regards,
Andy Shevchenko


