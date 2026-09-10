Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DA7383305;
	Thu, 10 Sep 2026 06:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789022456; cv=none; b=bBBRk8BeG9qHj1iM2iUhesBkpnHoCostWZu4+bRvuCarg21kk/sGviHBr1QY34OJw+o+I0KeQWeuxcj0FOpeFFjkiKLBSFkBNxwb4JvqA1MY+/y92p0pBUt1ds9mgTBM5tvJwM5xsCZvpLAUGAl+cKudT3ZO+6fh57nv9YiLurI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789022456; c=relaxed/simple;
	bh=AU7p2eSR//jayR3C19gBuBIxS69n4oXnhNgdy1B/xtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJdKkcq3SmJOnaQtNN5Etdt8Xa+qajtdDX+JNvQeJq9AN7HY2Ni1wT7L7rM8UZVy2PnsSkq7UG1ng4oSdXObppDiF3k718Ynx4bbZYZJAT0vcMVg8ak07OYHXeJHrLlbAfBEHUVvj765kpu8OYepxiPlVy9gdjSakYBaCU9wqqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JOqVa/xd; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JOqVa/xd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789022454; x=1820558454;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AU7p2eSR//jayR3C19gBuBIxS69n4oXnhNgdy1B/xtg=;
  b=JOqVa/xdELlQezUdTAlcTAZ1gIuhcmA2q6q6QbpQZhu2karIUUxtpell
   zQxaHBYGR0kgfpRf2YoWv5ZALlAVr6BbFo0wZv5MkZ0YDoGCzuPvNC4XB
   N7pn99246hNuXlM6OfBoaE7m7k7Tpxv+4y3iuGFG13CZdHLURQK0IkwK5
   ajDDF37CvVxbd1MIJTpmo8G51PAVRcGOCqzdQ+hrmuZazfR15bzeqv1h5
   T3afnWdC8rn25RWMN/sME8jluqyxDolhLFVb9MR62/5KbniJRvUYTLDkc
   1KTTtSC6dmzPIfkyt1Vhryfj+sSLt5ggJHG0cVKCBJm0yHTExtrOP+ViG
   Q==;
X-CSE-ConnectionGUID: /dsE46atSRSTlg80OboyqQ==
X-CSE-MsgGUID: yW3gt+92R8GlS4OlaQ6DCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89675204"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="89675204"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 23:40:53 -0700
X-CSE-ConnectionGUID: pntFyr5xTUq0BMpGMNtSIg==
X-CSE-MsgGUID: nRXqZGz7RjWBULdZbtd/1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="268279890"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.177])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 23:40:51 -0700
Date: Thu, 10 Sep 2026 09:40:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] i2c: xiic: restore non-managed runtime PM to fix clk
 WARN flood
Message-ID: <aqJQ8Qm_nhBaWR-s@ashevche-desk.local>
References: <20260821-i2c-xiic-restore-runtime-pm-teardown-v7-1-954e06765144@nexthop.ai>
 <DLBBXHXIVHZL.BIOFL7T9OAM7@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLBBXHXIVHZL.BIOFL7T9OAM7@nexthop.ai>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 09, 2026 at 08:51:33PM -0700, Abdurrahman Hussain wrote:
> On Fri Aug 21, 2026 at 6:12 PM PDT, Abdurrahman Hussain wrote:

> Gentle ping on this one. It has been quiet since v7 went out on Aug 21.
> 
> Andy, v4 onwards switched to request_threaded_irq()/free_irq() with the
> explicit free in the probe error path and in remove(), per your comment on
> v3. Does that address your concern, or is there anything else you would
> like changed?

Seems okay to me.

> Andi, this is a regression fix for 50c63491ff26 (the devres conversion),
> and the WARN fires on every unbind/rmmod of the driver, so it would be
> good to get it into 7.2 or early 7.3 fixes if the patch looks OK to you.

v7.2 is already released, so v7.3-rcX is the best you can get.

> Happy to respin if anything is still open.

-- 
With Best Regards,
Andy Shevchenko


