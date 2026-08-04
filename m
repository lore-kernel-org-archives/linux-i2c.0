Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC67443AA2;
	Tue,  4 Aug 2026 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785839793; cv=none; b=lcuS3134z5vWYDfVm9irXuxpl0qwfydjjm7mqSr8GL3dtcnQ5FoKqom/ILvVSO/cVbYOL9Tj40DfR5MDUU6e15/LDOy86+IVPm1yRxgEHeJ0RkG8E2++zeCL9VpmwU6wecFnNdLkmmkTX7lFJRZHnt0YMYd87gb5o71AsV+1ZhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785839793; c=relaxed/simple;
	bh=amHk4kQ9LXfJd111OmB8ZsrFZEMGzrFNLNblvY2ALXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8W2i8jdPgurqgv7Mys3qsXaPfMR0gtf/gmcH+4Y3jMV2LgHZUWecJD/0xWkIJYH36k8b6wTYjaj7z4w9i/cuvvMMnXThRDHTGKmd/Ub3QzDPWY6cifInx6PyzkW3+tJG8Ur5kjsBF1dVv2HD+LNShusGR7PtqN0Yxzb7ZUFcMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hLmEFhM0; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hLmEFhM0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785839791; x=1817375791;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=amHk4kQ9LXfJd111OmB8ZsrFZEMGzrFNLNblvY2ALXg=;
  b=hLmEFhM0J/ucNK9ehdZkaKGxxWgefa/QvqoTScZ/aTvWufK+X0j2Pbgg
   TbUBL56c/987uo1l3eFkizqOC5IIcFJEEPUJM5CoHV717PPsvAQHwtzQS
   32WBGvjy79GbE0yWbee1aaHGeHk/IkThoJMUGeOnq1k4qR5hrYYcDbG/I
   G6hCItfpcL1MZW91aODV8ibGrCfLk+R/SCKHufpLVhpL1yZrSOpCoRFLp
   nTQdiAUepLtE1+jqFbdXyVLwDW+j9PyE8OSCk14QGJuV4Oj3oqHZFbHDX
   9ME2iSYujP5hyQ+pqdpKv65zVB88tvQ5fmDYLHQFaAhNLgCyn4crd2e/T
   w==;
X-CSE-ConnectionGUID: aAl6kX7ETCyBBTI+Vq8PBA==
X-CSE-MsgGUID: mGqeZBloTuK9Cnt3LOg/zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="90274931"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="90274931"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 03:36:30 -0700
X-CSE-ConnectionGUID: cmHZ3lP8QrqUHNZn/v+d+A==
X-CSE-MsgGUID: xY8DisLZSo6XW8GssRge6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="284853730"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 04 Aug 2026 03:36:28 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id D28FC9B; Tue, 04 Aug 2026 12:36:27 +0200 (CEST)
Date: Tue, 4 Aug 2026 12:36:27 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Umesh Kumar <ukumar@marvell.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	bbhushan2@marvell.com
Subject: Re: [RFC PATCH] i2c: designware: Enable SAR in slave mode for
 Multiple SAR controllers
Message-ID: <20260804103627.GA69804@black.igk.intel.com>
References: <20260804041842.3205356-1-ukumar@marvell.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260804041842.3205356-1-ukumar@marvell.com>

Hi,

On Tue, Aug 04, 2026 at 09:48:42AM +0530, Umesh Kumar wrote:
> DesignWare controllers synthesised with the Multiple SAR feature (e.g.
> Marvell CN20K) only acknowledge traffic to the primary slave address
> (IC_SAR) when IC_ENABLE[19] (SAR_EN) is set. The slave enable path
> writes only IC_ENABLE[0], so on such controllers the target never ACKs
> its address and a remote master cannot reach it.
> 
> Set SAR_EN together with ENABLE when entering slave mode. The bit is
> reserved (and ignored) on single-SAR controllers, so existing users are
> unaffected.
> 
> Signed-off-by: Umesh Kumar <ukumar@marvell.com>
> ---
> RFC note:
> 
> On our multi-SAR CN20K the slave only ACKs with IC_ENABLE[19] set.
> Existing single-SAR users work without it, and the bit is reserved
> there, so I've written it unconditionally. Would you prefer this
> gated behind a per-device capability flag instead? The CN20K PCI
> device enablement (which would set such a flag) can follow as a
> separate series.

No I think what you do here is fine,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
