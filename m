Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E434F3EDE;
	Tue, 22 Sep 2026 06:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059850; cv=none; b=lI70KMh0KcVoND9nRxoaD13hISNO4u6lgEsn9eQ7fFjzB37WpkB3A6NEmue3kCxLB/C49vGjVDU4jDcdQGTyXB6P7dSSIAlpdZa8QnTM53M56qIP9+6W+9YUsJQVDjUc2qMihsmHGmB2FlfdDuTzn9X+cxmgLxLkhDrm4FaTx/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059850; c=relaxed/simple;
	bh=JcjkJf8GYnQtN5VEdGAWSua7sSPagwhqpIJdiI9/CH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6GsKqetrDZvoBNGrErx4XqcPDY14dRHhDhoasDd5olDhbAkuQ+abDeH1UAd4qJoRTATZ0BLjLY8xS1jJ4/OUgcCB0jiYBboM5znKT4jXh91oxAMxpiXf+Yes9co5eETfYzsv1025ToSTr19B3ipE+9BMH4SK7fnyoBMcbJ06u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cBQaDb4o; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cBQaDb4o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790059848; x=1821595848;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JcjkJf8GYnQtN5VEdGAWSua7sSPagwhqpIJdiI9/CH0=;
  b=cBQaDb4o9mH6fiEhKoKI6jqOv8OfoufR8BeAMnjup7KPfcVplcVc2USo
   oZPBAuMjkBrGaNPeTBoFArl5bIZvvr0h+97DPd+Ny5iPkGkFsrApB9vA1
   FGJp6kOLAi+EX+uGFhSK8Lq72XR/gXUaiME3Mxs0e/iPWbQBZUK9lH2HF
   kq1b4I5tjcJbbKHdQf9ZMIwLFgaZQ8kx7n+CQrxhnYH7CjREL76kN7b5K
   wo+cv3sxITsKwGA25YoqnHP6yZ12nBa+XtH0Tqvy5HOORhSLkrpE3+CrV
   rXrVatY4+i2L6qaZPEyusPi7oHXAnQOSaFjQCbfGetSEVAHyeiaH+oJN9
   w==;
X-CSE-ConnectionGUID: atGr9gaLRlmXMB8nWR0WMQ==
X-CSE-MsgGUID: F6aGG4t4Tcu0TOwWPZ+wSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90651525"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="90651525"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 23:50:47 -0700
X-CSE-ConnectionGUID: HbQWR4b0S1ua0EYeIO5fsQ==
X-CSE-MsgGUID: PB3Zqhp6SfScGzdzb0K46A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="269526813"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 21 Sep 2026 23:50:46 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id A661599; Tue, 22 Sep 2026 08:50:41 +0200 (CEST)
Date: Tue, 22 Sep 2026 08:50:41 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Navon John Lukose <navonjohnlukose@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: designware: size the RX FIFO threshold to the
 queued transfer
Message-ID: <20260922065041.GC106095@black.igk.intel.com>
References: <20260919232647.448748-1-navonjohnlukose@gmail.com>
 <20260921120526.GV106095@black.igk.intel.com>
 <20260921170456.53354-1-navonjohnlukose@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921170456.53354-1-navonjohnlukose@gmail.com>

Hi,

On Mon, Sep 21, 2026 at 10:34:56PM +0530, Navon John Lukose wrote:
> On Mon, Sep 21, 2026 at 02:05:26PM +0200, Mika Westerberg wrote:
> > I'm slightly worried about the latency increase here and the fact that
> > HIDIOCGINPUT is pretty much same as HID_REQ_GET_REPORT so it's not only
> > hidraw that is affected but everything else using HID_REQ_GET_REPORT as
> > well.
> 
> You are right, it is every HID_REQ_GET_REPORT user, not just hidraw.
> 
> The main motivation for this patch was cutting the wakeups from the
> interrupts, and I should have made that clearer. The /dev/cpu_dma_latency
> line was just to measure where the extra latency comes from.
> 
> What the wakeups cost, measured with a 21-byte HID GET_REPORT at 142 Hz
> pinned to one CPU, display off, 32 reps per arm in randomized order:
> 
>                         psys W
>     idle             1.87 +/- 0.28
>     patched          2.53 +/- 0.17
>     stock            4.11 +/- 0.44
> 
> Against the idle floor the polling costs 2.24 W without the patch and
> 0.66 W with it. Paired saving 1.58 W, 95% CI [1.42, 1.75].
> 
> So the added exit latency is the package idling deeper than it can when
> the controller interrupts once per received byte.

Yes power savings are always good but in this case it also affects the
latency visible to the user so we don't want devices like touchpads become
"sluggish" either. Do you see any such issues with the devices when you
have this enabled and not using /dev/cpu_dma_latency or any other interface
to limit the CPU low power states?
