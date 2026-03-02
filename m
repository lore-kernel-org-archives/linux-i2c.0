Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A14130E0E9;
	Mon,  2 Mar 2026 05:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772429864; cv=none; b=r4BNVYkq0vSbwQ3/NLCq2nNn1Nu6BpU/bMhvoqrbwBN8BF8WL74UqTIaqMjEPdzuFjb2iWMrl3VYwFevbd7v8GTCJDQZ0Pb+hc9A9N4IqnLrmitSq5vog5aI7wBJY8oRegutKLN723aaprT0P9Et9VKEILlI6LQqIgag8PeS3JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772429864; c=relaxed/simple;
	bh=edhVmc9VGgbqzSJc7LpoLV9GlpZ/Y2vb+lcTI8qcia8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TO07Ig0ezFrvt3xmKgULXHXgHMhgHOEHKXrD+h4sTQIYQzf+f2kO2iTCGUGrJhfDe1gSmX2EhSWsIsovW0lJABGQu6EuI3BXZckTNLWiI7FSnM2AW9vchVmTKwpF57xek1Fra650XsuoY71r+mIPaGCrs/83B79jzQk5zBz1+gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KZEh+yjd; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KZEh+yjd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772429863; x=1803965863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=edhVmc9VGgbqzSJc7LpoLV9GlpZ/Y2vb+lcTI8qcia8=;
  b=KZEh+yjdKvjjDnzzA/R8MjfhnJfRcKTHQXmN+gjuPcGdvh7Vfk64mHGG
   dr/p5e56v0dQrHUUyCjcU2iH8k0xtNlNKVCGCfUH2gPaSvTsyxduJV5US
   Gfa+2hL8NFI0Zeh8drINRbBQCbR9/rPI13ihBdxo3rSpc9jUDCLHafAoO
   +IUt0PN1CDTOGGN9FQb4ISwU0e+U/lhGg3tU08DekzdeEYv+EFKozt3uD
   Ihcyd/ZU7E4XT3r+sL5z0t5TGuMyn1MAUmXXXdrTnwJy3degHdo1rH0vq
   CdTBZyj1qbxgNT0J+AFfZESjLEjpNVblFQh2xbyXfBR7YU0Ci0TAt1wJX
   Q==;
X-CSE-ConnectionGUID: YSsiWA7BSl25ZmAlIK1LpQ==
X-CSE-MsgGUID: vEzjo6WfQ3utSHGp7Sa13g==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="77040350"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="77040350"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2026 21:37:41 -0800
X-CSE-ConnectionGUID: vv4H0LvGRSig0Hm6jUUIYQ==
X-CSE-MsgGUID: PnCZWF9tQ5WB5Ilyb1qTcQ==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 01 Mar 2026 21:37:39 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id D1FA095; Mon, 02 Mar 2026 06:37:38 +0100 (CET)
Date: Mon, 2 Mar 2026 06:37:38 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Moritz Fischer <moritzf@google.com>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, mdf@kernel.org, ovt@google.com,
	Jan Dabros <jsd@semihalf.com>
Subject: Re: [PATCH] i2c: designware: Add a new ACPI HID for GOOG5000 I2C
 controller
Message-ID: <20260302053738.GO2275908@black.igk.intel.com>
References: <20260227182308.776922-1-moritzf@google.com>
 <aaHnrj0onxlxH5D0@ashevche-desk.local>
 <ttbg5vcgzximy77bswykeprkl27hc2civnlpfwmgusm62wvzad@hvnapqphg6af>
 <aaLH0wYeUki0jqGc@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aaLH0wYeUki0jqGc@ashevche-desk.local>

On Sat, Feb 28, 2026 at 12:47:47PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 27, 2026 at 09:52:48PM +0000, Moritz Fischer wrote:
> > On Fri, Feb 27, 2026 at 08:51:26PM +0200, Andy Shevchenko wrote:
> > > On Fri, Feb 27, 2026 at 06:23:07PM +0000, Moritz Fischer wrote:
> > > > Define a new ACPI HID for GOOG5000 as used on Google Axion.
> > > >
> > > > This has been validated on Silicon.
> > 
> > > > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > Cc: Jan Dabros <jsd@semihalf.com>
> > 
> > > Please, put Cc list...
> > 
> > > > Signed-off-by: Moritz Fischer <moritzf@google.com>
> > > > ---
> > 
> > > ...somewhere here. It will have the same effect on the email. But the
> > > positive
> > > outcome is the noise reduction in the commit message.
> > 
> > > See also this discussion (patch 18 subthread):
> > > https://lore.kernel.org/lkml/20260123113708.416727-19-bigeasy@linutronix.de/
> > 
> > Ok, fair. Do you want me to resend or do you want to patch it when
> > applying?
> 
> I'm not a maintainer, so from my p.o.v. the safest option is to send a new
> version with all data gathered and put properly (Cc list, ACPI excerpt, et
> cetera) in one place.

I don't think the excerpt adds any real value. Only thing that really
matters is that the ACPI ID is "correct" meaning that it is properly
assigned by the owner and that's true here. For the CC list does not matter
to me but if you want to resend with that fixed no problem.

Either way,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
