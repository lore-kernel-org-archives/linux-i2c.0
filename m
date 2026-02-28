Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3604D40F8DA;
	Sat, 28 Feb 2026 10:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772275673; cv=none; b=YWc+jbeMFIf2mThS7EH5rrZkt2ZlMMBAnQ11K4E5mQA0QHSWZH2GLGN6XIS7PP61JGfy2fDTqrWeez6LeJ5i4HpsBMCU6wRQzZ9dNYNW6xb4bAlRBhDx/X3KpYu1PGFcQxERcWbstELawDnX037IiJ7PFEHVoVZYLBHv4qIqqTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772275673; c=relaxed/simple;
	bh=Wp7N/Bur+qepvCnUr3xVdMJur0M8+r23EUDZqtEPWXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvrX4/8po0pQ3+6mXU66U3vRSqDaA5GGEEIEsINwKgAbwg+mUZdqlFxKUE36ki3d/0IKN6tRBXvrswaNp3I+m19GpaK4w+n47IUA+XMv87pKRMLjzv63XU6iOUtGFV5cjxKvodY7BtWwdVB1m33aR/hTBwpAGgoZdxc/B7mileE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UMDa+lg3; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UMDa+lg3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772275672; x=1803811672;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wp7N/Bur+qepvCnUr3xVdMJur0M8+r23EUDZqtEPWXY=;
  b=UMDa+lg3hAXExVS04ueLcT5wmJvsgfS3xOjj3l+Ue4ZFeuNSVqD9cFiw
   2PuTy8aziwlmSx0iAxLTTnAmJM0E4V0AaZH4mDA/sb0wIn9d4DjJoC9Sd
   VapLEMMWaB8Fqu3pWUWVYSwCrh+9MD/LdV11400mhc64ukQEp3khcsboU
   RC5VUhaz6DcUwWQtuZpRsSk0L4BPgIDMfRMaiQg/vE8H0g6jp0GOgGtTS
   8dxgp7SSkN+8ZPF3gTDXVqe41QK63wo+z2JZYKMlV//gcWZ7EZm4to8FI
   PYTKr1nOOY+J5ovAjhxrtPfrTjqwaEkItXpoP1TU8TV0qH/UzwaNAchKD
   Q==;
X-CSE-ConnectionGUID: zhyvXiq0QmK3iTEtQ5fCRQ==
X-CSE-MsgGUID: Dp63X0DfQ2+k6FymDp+ZBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="84700545"
X-IronPort-AV: E=Sophos;i="6.21,316,1763452800"; 
   d="scan'208";a="84700545"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 02:47:51 -0800
X-CSE-ConnectionGUID: qMqK+YQiTki4hKV07FaIsg==
X-CSE-MsgGUID: 7qKbLsOURwG+g/YunwndcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,316,1763452800"; 
   d="scan'208";a="213894829"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.224])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 02:47:49 -0800
Date: Sat, 28 Feb 2026 12:47:47 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Moritz Fischer <moritzf@google.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, mdf@kernel.org,
	ovt@google.com, Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>
Subject: Re: [PATCH] i2c: designware: Add a new ACPI HID for GOOG5000 I2C
 controller
Message-ID: <aaLH0wYeUki0jqGc@ashevche-desk.local>
References: <20260227182308.776922-1-moritzf@google.com>
 <aaHnrj0onxlxH5D0@ashevche-desk.local>
 <ttbg5vcgzximy77bswykeprkl27hc2civnlpfwmgusm62wvzad@hvnapqphg6af>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ttbg5vcgzximy77bswykeprkl27hc2civnlpfwmgusm62wvzad@hvnapqphg6af>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 27, 2026 at 09:52:48PM +0000, Moritz Fischer wrote:
> On Fri, Feb 27, 2026 at 08:51:26PM +0200, Andy Shevchenko wrote:
> > On Fri, Feb 27, 2026 at 06:23:07PM +0000, Moritz Fischer wrote:
> > > Define a new ACPI HID for GOOG5000 as used on Google Axion.
> > >
> > > This has been validated on Silicon.
> 
> > > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Cc: Jan Dabros <jsd@semihalf.com>
> 
> > Please, put Cc list...
> 
> > > Signed-off-by: Moritz Fischer <moritzf@google.com>
> > > ---
> 
> > ...somewhere here. It will have the same effect on the email. But the
> > positive
> > outcome is the noise reduction in the commit message.
> 
> > See also this discussion (patch 18 subthread):
> > https://lore.kernel.org/lkml/20260123113708.416727-19-bigeasy@linutronix.de/
> 
> Ok, fair. Do you want me to resend or do you want to patch it when
> applying?

I'm not a maintainer, so from my p.o.v. the safest option is to send a new
version with all data gathered and put properly (Cc list, ACPI excerpt, et
cetera) in one place.

...

> > > +	{ "GOOG5000", 0 },
> 
> > The ID seems legit, but we need an ACPI excerpt from DSDT to show how it's
> > described (just important pieces of the respective Device() object) and
> > better
> > reference to the device / platform in question: Is it already on the
> > market?
> 
> I pulled this out of the EDK2 code, I hope this satisfies your request.
> 
>     Device (I2C0)
>     {
>       Name (_HID, "GOOG5000")
>       Name (_UID, 0x00)
>       Method (_STA) {
>         Return (0xf)
>       }
>       Name (_CRS, ResourceTemplate ()
>       {
>         QWordMemory (
>           ResourceProducer,
>           PosDecode,
>           MinFixed,
>           MaxFixed,
>           NonCacheable,
>           ReadWrite,
>           0x0,
>           0xA02048000,
>           0xA020480FF,
>           0x000000000,
>           0x000000100
>         )
>         Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive)
> 	{
>           109
>         }
>       })
>       ...
>     }
> 
> This is being used by SoCs powering Google's Axion product line.
> 
> I can't go into more details on timelines etc, but they *are* real
> products.

Good, just collect summary of this with the ACPI excerpt in the comment field
(after '---' line) in a new version, so we will have it for the record in the
ML archive in one place.

-- 
With Best Regards,
Andy Shevchenko


