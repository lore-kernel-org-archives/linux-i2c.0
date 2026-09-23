Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD253F3263;
	Wed, 23 Sep 2026 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170595; cv=none; b=pYUlesnoZ79rx83q3cuc5oxnJC+f1kqGqnoiWoHnEd/jGKT0qlU1jqPxrtvcveIQRqcHM238FAGoUC8bNuFfOaYQ1gYdpXDTjBsg6tIqjrbZ49lZbn1HuDCDdKAQ3Ng7/DkrCuZwzSMI54jRynTyVoLZZYPteheUSQ5YTwZfEHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170595; c=relaxed/simple;
	bh=v6sU/OMdzPpuatwwNDBvlqfARUR910C7YyewI/5MOug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ap+xqb6VJ622o2KGvsAvpiOjKaPG1eBRxbnOUks8h5J6CL7C2InQrgDDGt4qy9hBFej5WYZOVkCcpo0uMaXf5CfeoAvJE0M24fjvwsfiolvMlbszSI/8zV3eAGi5PNIulsawHyd4No9fLU8a78IGNrC/LgM+QXymMhdSnOT8PEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KJlx3T4s; arc=none smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KJlx3T4s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790170593; x=1821706593;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v6sU/OMdzPpuatwwNDBvlqfARUR910C7YyewI/5MOug=;
  b=KJlx3T4sPZ19dc7RU9dROkp0Z0MDD879iqrVVrF2Kn+Jmvn0J8JJDS6F
   jY791yrUGY1mDD5DYzKEwkGc2uy43wlIXj7OTSvG8cN9oKvLt2mrVQx6j
   W5zwEvlbB6XXw9kYJFcor9Hk387wmXB0QHUlS7MsGMOAQ7Hkr1e98VVo+
   MnAaAl56fuEbhPvXmi2BusbzFEksu1RN1wAkTvyUfCzs+un3xFnmTrzCX
   OqlV7l8J7X0pLf8PDRrT0hyJGKljXvelVYByNfVgiFV4B8dcffL7acUFw
   WTEeFmLvw7eJ+a1qHAEHiIJkzqfD1YAngtQsFk2K4mLY90rT0+mR0JoLQ
   w==;
X-CSE-ConnectionGUID: PZN2KxfSRkyBrCWUljC7Cg==
X-CSE-MsgGUID: LaIaY7htQuucojnEheL/Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="1381643"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="1381643"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 06:36:32 -0700
X-CSE-ConnectionGUID: MJImz0ZNTZSW3L7JPsPViw==
X-CSE-MsgGUID: AoVnFZqzSsWckOJL1i0Tuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="299862783"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 23 Sep 2026 06:36:31 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id D207299; Wed, 23 Sep 2026 15:36:29 +0200 (CEST)
Date: Wed, 23 Sep 2026 15:36:29 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Navon John Lukose <navonjohnlukose@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: designware: size the RX FIFO threshold to the
 queued transfer
Message-ID: <20260923133629.GI106095@black.igk.intel.com>
References: <20260919232647.448748-1-navonjohnlukose@gmail.com>
 <20260921120526.GV106095@black.igk.intel.com>
 <20260921170456.53354-1-navonjohnlukose@gmail.com>
 <20260922065041.GC106095@black.igk.intel.com>
 <20260922121238.46016-1-navonjohnlukose@gmail.com>
 <20260922122902.GE106095@black.igk.intel.com>
 <20260922132334.34682-1-navonjohnlukose@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260922132334.34682-1-navonjohnlukose@gmail.com>

Hi,

On Tue, Sep 22, 2026 at 06:53:34PM +0530, Navon John Lukose wrote:
> On Tue, Sep 22, 2026 at 02:29:02PM +0200, Mika Westerberg wrote:
> > Yeah I don't think 0.7ms is much but we have things like touchscreens and
> > the like with various report sizes so at least it would be good to check if
> > those have any issues.
> >
> > Unfortunately I don't have any of such devices anymore but I asked our
> > validation to check if they have something that could be used to test this.

Turns out they don't have touch screens either :(

> I have a Goodix touchscreen on a second controller on the same machine, so
> I ran it at three report sizes. GET_REPORT at 100 Hz, 2000 transfers per
> cell, three interleaved passes, ~normal desktop use in the background:
> 
>     bytes   interrupts/report      mean latency
>        7      4.17 ->  2.00     1776 -> 2093 us
>       21     10.06 ->  2.00     2131 -> 2676 us
>       64     63.97 ->  3.21     2303 -> 3512 us
> 
> 64 bytes is past rx_fifo_depth on this part, so that is also the first
> exercise of the half-FIFO cap.

Okay thanks for checking this. If the latency stays in low single digit ms
I think that's fine.

> So the latency is not a fixed 0.7 ms as I implied earlier, it grows with
> the report size. Breaking down where it goes, with kprobes on i2c_dw_xfer
> and i2c_dw_isr, for 64 bytes:
> 
>     segment                       stock   patched
>     xfer start -> first ISR          78       146
>     first ISR -> last ISR          2157      2748
>     last ISR -> xfer return         101       147
>     i2c-hid and ioctl overhead       12        49
> 
> 84% of it is between the first and last interrupt. Stock's 65 interrupts
> are 33 us apart, too close together for the CPU to idle deeply, so each
> wakeup is cheap. Patched leaves 3 gaps of around 900 us, deep enough to
> idle properly, and pays the exit latency on each one.
> 
> So the power saving and the added latency are the same effect seen from
> either end. Lowering the cap trades one back for the other at roughly the
> same rate, so if the latency needs bounding (I personally think it is
> overkill) it wants a QoS request as Andy suggested.

I agree. Just wanted to check that there are no user visible (negative)
side-effects.

So no objections from me,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
