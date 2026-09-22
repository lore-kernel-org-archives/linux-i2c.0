Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9415448A9;
	Tue, 22 Sep 2026 12:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081347; cv=none; b=VW5g5nxkBbYPnVXlsMtmSbALIIvGHhzt8071ch3TAmU1cjqMsR3ow0gNRZF+kHqdye1ukCmNcmLPnlTLDneQL69MHQ6+oSa9VhX19nx6g9zIf6HJAtflnH2Z9BiYHIz4dWqsC/90GSecCRuJfWOWPdqh0TBZamiRoAkSXZ3id4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081347; c=relaxed/simple;
	bh=1wOh3D0F/H6C1GYZXZlGVpU4HRjp6VoWtm1WgM238C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4IHQzn/UGN8bICqvkcyEG9yDK+X+g2lYjt9ZJx1Np5UFj4gr2sBqdQMnGUlA2VGWoQH0Q+bpmTwYC7felSS3qTtbgPF7QwQwcsVBVXbP4Mg7Qy0lF5Tqpqd6tYS2LUmlwRUvSPJCCTn2LuP/fAzz8FlPzZIpmjSMZ9S6vwMM3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KVSndena; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KVSndena"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790081346; x=1821617346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1wOh3D0F/H6C1GYZXZlGVpU4HRjp6VoWtm1WgM238C4=;
  b=KVSndenann6vg1A/nvpIUPi0iaE4/dKq0Odz7r5Ueoqp3M4mVXw64P64
   Ltui2gguhpdlGESeda4xVonD+t81LjyG5YdA7itIGOPiwW/9UrBL+QAx4
   hgZUCqelaN0Wg7JZrfnbPtL9Gc1wsCI2yKoA80e9MRYVuBdCWYe2p1ctu
   tIchUcKVTkL/tO9zD9fqWX0A9DO9L8KOB0RJIWQyIYQ+IK5KwI/TNUEQc
   LSLAygxB04+kdV/uP2q8WbjbstRrkpYnju52zHpldzuuX++lsyf3den+6
   WuSter3D7XDuY87JUHDkwoaqp0a7/SVEGPWVy6iKHoIoUMsJsd2ZlfPNz
   g==;
X-CSE-ConnectionGUID: MwjXSpmSQWmUmMi0uiQpgg==
X-CSE-MsgGUID: 8TY5+JIZSk2WcMSozcZMEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="89812883"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="89812883"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 05:49:05 -0700
X-CSE-ConnectionGUID: 363i8ljHQRu4uSRjSAVoXw==
X-CSE-MsgGUID: hrCNEZLRSg2kiI4K4K0P3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="272613182"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 05:49:04 -0700
Date: Tue, 22 Sep 2026 15:48:59 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Navon John Lukose <navonjohnlukose@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: designware: size the RX FIFO threshold to the
 queued transfer
Message-ID: <arJ5O1cpqcWE2QYm@ashevche-desk.local>
References: <20260919232647.448748-1-navonjohnlukose@gmail.com>
 <arJRC4Ou1LSAMGTs@ashevche-desk.local>
 <20260922121249.46057-1-navonjohnlukose@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922121249.46057-1-navonjohnlukose@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 22, 2026 at 05:42:49PM +0530, Navon John Lukose wrote:
> On Tue, Sep 22, 2026 at 12:57:31PM +0300, Andy Shevchenko wrote:
> > Nobody will go with 0 in cpu_dma_latency. It basically kills the idea of CPU
> > power states.
> 
> Agreed, and the patch does not ask anyone to. Holding it at 0 was how I
> measured where the added latency comes from. Mika raised the same point and
> there is more detail in that subthread:
> 
> https://lore.kernel.org/all/20260921170456.53354-1-navonjohnlukose@gmail.com/
> 
> > If you need a dynamic run-time PM QoS, patch the HID subsystem to
> > make those when they want to heavily communicate with the HW.
> 
> A QoS request would bound the latency, AFAIK. It would not change that the
> controller raises RX_FULL once per received byte, which is what this patch
> is about, so I do not think one blocks the other.
> 
> > There is also the issue of the interrupt locality.
> 
> I am not sure what the i2c driver can do about that. What did you have in
> mind?

i2c-hid

> Worth noting i2c_dw_configure_mode() sets TX_TL to half the FIFO and
> RX_TL to 0 on adjacent lines, so a transmit interrupt moves up to half a
> FIFO and a receive interrupt moves one byte, which is what this patch
> changes.

-- 
With Best Regards,
Andy Shevchenko


