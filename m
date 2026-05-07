Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956FE3BC673;
	Thu,  7 May 2026 10:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778148268; cv=none; b=MUzE5zlgjmvOSbjLOpVFWjTSbzAdkyJ2Lxf66sZOGJlVS4PrDcENbMbBezbMMTF+/qVEsqdpOWZ3NcXvbJjeH67sJ4enBkZbwATMWmYmlWRudHUq+dRz+q/cQt+E/FrX74QxsLyzqVYySW+FmVj6vPQsmLguwgkoQ1oDC175WHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778148268; c=relaxed/simple;
	bh=4PwmtKc9rXVYpjCQBH6PZpSV/qmCalDqSouPSwZ6xtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0DBuvvnv240HlNJRrHrgFRNa9UgMFdd1WOacIjLiS+YO3ki1H9GMGDKVAEvxh9g7WewbnUqxaBZa+ETb6T8Gk07OLAQEWI90+pkiMDCLkT4BYncdVapVpMgXiJxJsm3dvk3HUqdvcJ86F7e6FZkoYRJNCWuRqEuSGP3bl6tWFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TRfFQVvh; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TRfFQVvh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778148266; x=1809684266;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4PwmtKc9rXVYpjCQBH6PZpSV/qmCalDqSouPSwZ6xtQ=;
  b=TRfFQVvh/6LgMENWMlWP4dxBvm1X1NNsoDPY/S2iQsvsSQWA5KIy7eZS
   shXYdsA9DfHQH80EH3UrHUdZIsBlmCKOrqXd8H02uVPQUE2M39uDmBsZj
   uFYcwJ269oFz9Kg6NTYxjWK13qvmn6whXxrKHUrLBPLHibUbx4K4xiK67
   a366d6pxvzB5nvuWhBq1HLRzV8ooO7J25+QBKS9ErzEVFBJpG3JV2/BvU
   xoDkpGk/gl7qRUetUEFN8F9nqZY/lijOhmoZn9U5aQY1s7OWrrDjFOMpF
   rniOrM6Lis34RYceVyQgZvb1KOh+40P37c6iguVhgcmXw2mTfrrxvXFoP
   A==;
X-CSE-ConnectionGUID: e4oj+GMRQWmDWzh25UHbDQ==
X-CSE-MsgGUID: SfuJ99f6QgigIViHYCmAHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="79111644"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="79111644"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 03:04:25 -0700
X-CSE-ConnectionGUID: hYQ6tYeMS0iJiGrftaoKug==
X-CSE-MsgGUID: HbigTnPkRm27hIbHUp3sWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="233335359"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.149])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 03:04:23 -0700
Date: Thu, 7 May 2026 13:04:20 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "William A. Kennington III" <william@wkennington.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] i2c: designware: Introduce shutdown exported
 function
Message-ID: <afxjpG8Gvh7FyC5z@ashevche-desk.local>
References: <20260504-dw-i2c-v3-0-57e56135d602@wkennington.com>
 <20260504-dw-i2c-v3-1-57e56135d602@wkennington.com>
 <afmcdXJt9X0Y3mw3@ashevche-desk.local>
 <471722ab-a6f2-4e21-9b68-ef2050ec4e65@wkennington.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <471722ab-a6f2-4e21-9b68-ef2050ec4e65@wkennington.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 07, 2026 at 12:56:50AM -0700, William A. Kennington III wrote:
> On 5/5/26 00:29, Andy Shevchenko wrote:
> > On Mon, May 04, 2026 at 08:15:02PM +0000, William A. Kennington III wrote:
> > > Introduce an exported shutdown function to safely shutdown the
> > > DesignWare I2C controller.
> > > 
> > > This shutdown hook gracefully sets the slave disable bit before disabling
> > > the controller. This guarantees that any incoming requests from the master
> > > are immediately NACKed during shutdown, preventing the bus from hanging.
...

> Is this just language correction?

I have asked for replacing 'slave'/'master' terminology to a new,
inclusive one.

...


> > > +	/*
> > > +	 * We only need to handle shutdown for slave mode to ensure
> > > +	 * we NACK any incoming master requests. Master mode cleanup
> > > +	 * is handled after each transfer in i2c_dw_xfer.
> > i2c_dw_xfer()
> > 
> > > +	 */
> > Since it's a newly added comment, can you switch to use inclusive language?
> > Same for the whole series related to the commit messages, comments, and
> > documentation.

Same here and...

> > > +	/*
> > > +	 * To quickly NACK the master during shutdown, we set the slave
> > > +	 * disable bit while the controller is still enabled.
> > > +	 */

...here.

...

> > > +EXPORT_SYMBOL_GPL(i2c_dw_shutdown);
> > Can we use namespace?
> 
> It already does use namespaces with
> 
> `#define DEFAULT_SYMBOL_NAMESPACE    "I2C_DW_COMMON"`
> 
> I assume I should just keep it consistent as-is?

Yep, thanks for pointing that out!

-- 
With Best Regards,
Andy Shevchenko


