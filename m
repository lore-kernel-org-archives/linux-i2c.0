Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F2B1DF73C;
	Mon,  2 Mar 2026 07:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772437897; cv=none; b=cQbbe767lD6tO81yyS9qWSpTdCKbJm+RQgVtI8L2cxO4lwjGDoq4X644H6RaNU20IutOcNb/G0j6FQUidrnZ75VvcFiR3mxN3vn0V9ETLsODD40zJq1/QFl9EfDB3oCDsAHfvtc9959DwD9QQqGZCMBvcKH7qsbB2JMuo46JfwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772437897; c=relaxed/simple;
	bh=jDWwIMhpvWhr+hgcm3uoSHgMOFJeN+QEZ6fs9JqT2vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UidHeu/u9yohE3HxukykGclHOiUMz8fBQC76yU/xaLJShNaLW+vT1hG6Pb9qHqFq8x6DvR7s/ABAyT88PJGvz2F6ykNiYV76pTxNw28poxr/H3zUHC2ledLeaEk7DJcEiJawHHO7SB+yTuRVGgvUsokdyj4BTMCKG4LNih2r7eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D57wUE68; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D57wUE68"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772437896; x=1803973896;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jDWwIMhpvWhr+hgcm3uoSHgMOFJeN+QEZ6fs9JqT2vg=;
  b=D57wUE68R0J6VgIfQRYW3Pw7E374ekHq4AAi2b68ONm31pXTTsAXuGrE
   r3ypZzoxs4SnVHJ5+U4IVXwTNbv2PMdKZdgHGkCm5Z0lTe9EkB7PuvCp0
   j038eJmaFrrA1jAnVCbn5RcJ8FVgN2DGadNEYkRAi2EtxeCfTH9w7NgoT
   ASWKSnRX7ienNA76NCcto+JkKiTRnuKLla18ocBP8oiBPppqWKnAeVk/A
   CeNeuaapOgx5J+SPTGzamDlhrm0SAtRsP45U2a2JXoCxGCgvw75kYqj8o
   zWUu8zv5w0XqMpYrSxZjl+oXxzXj6UjKjZCnLj3TbgGUDQ2jzMD+a0ona
   w==;
X-CSE-ConnectionGUID: 39qNJbJSSCuNBBr2/DHV6g==
X-CSE-MsgGUID: ezOAolwlQkSj8qkJevJHCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="98908189"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="98908189"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2026 23:51:35 -0800
X-CSE-ConnectionGUID: 42fr2R+tS2CipYEmG2QuuA==
X-CSE-MsgGUID: FamnUeSMSgyDSyEOjlBdKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="216706086"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.52])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2026 23:51:34 -0800
Date: Mon, 2 Mar 2026 09:51:31 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Moritz Fischer <moritzf@google.com>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, mdf@kernel.org, ovt@google.com,
	Jan Dabros <jsd@semihalf.com>
Subject: Re: [PATCH] i2c: designware: Add a new ACPI HID for GOOG5000 I2C
 controller
Message-ID: <aaVBg3tX8MRR9rZK@ashevche-desk.local>
References: <20260227182308.776922-1-moritzf@google.com>
 <aaHnrj0onxlxH5D0@ashevche-desk.local>
 <ttbg5vcgzximy77bswykeprkl27hc2civnlpfwmgusm62wvzad@hvnapqphg6af>
 <aaLH0wYeUki0jqGc@ashevche-desk.local>
 <20260302053738.GO2275908@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302053738.GO2275908@black.igk.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 02, 2026 at 06:37:38AM +0100, Mika Westerberg wrote:
> On Sat, Feb 28, 2026 at 12:47:47PM +0200, Andy Shevchenko wrote:
> > On Fri, Feb 27, 2026 at 09:52:48PM +0000, Moritz Fischer wrote:
> > > On Fri, Feb 27, 2026 at 08:51:26PM +0200, Andy Shevchenko wrote:
> > > > On Fri, Feb 27, 2026 at 06:23:07PM +0000, Moritz Fischer wrote:
> > > > > Define a new ACPI HID for GOOG5000 as used on Google Axion.
> > > > >
> > > > > This has been validated on Silicon.
> > > 
> > > > > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > > Cc: Jan Dabros <jsd@semihalf.com>
> > > 
> > > > Please, put Cc list...
> > > 
> > > > > Signed-off-by: Moritz Fischer <moritzf@google.com>
> > > > > ---
> > > 
> > > > ...somewhere here. It will have the same effect on the email. But the
> > > > positive
> > > > outcome is the noise reduction in the commit message.
> > > 
> > > > See also this discussion (patch 18 subthread):
> > > > https://lore.kernel.org/lkml/20260123113708.416727-19-bigeasy@linutronix.de/
> > > 
> > > Ok, fair. Do you want me to resend or do you want to patch it when
> > > applying?
> > 
> > I'm not a maintainer, so from my p.o.v. the safest option is to send a new
> > version with all data gathered and put properly (Cc list, ACPI excerpt, et
> > cetera) in one place.
> 
> I don't think the excerpt adds any real value.

It doesn't per se in the commit message. I am asking to have it in the comment
block for the record (in the mailing list archives).

> Only thing that really
> matters is that the ACPI ID is "correct" meaning that it is properly
> assigned by the owner and that's true here. For the CC list does not matter
> to me but if you want to resend with that fixed no problem.
> 
> Either way,
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks!

-- 
With Best Regards,
Andy Shevchenko


