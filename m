Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6FA3546D6;
	Wed, 26 Aug 2026 10:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787739183; cv=none; b=lPmrhQn+NYzjPGZKy7js+kWO316IHSMpvYUKKoq5xhgaY8GDfkCiG7cz48SR2TyviPe21BDGnJReHidTwe7o+BiiyKvdcpw6DMI1myW6FbjMK1yjq0k8aXPMjmgUxCPkyg40oMavZ6pkzQpfxL73ryXJQn3VbHj7LXD5+MnrrH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787739183; c=relaxed/simple;
	bh=Up36DuiCARgsd7NCCPZXMryCpVXDtOv1L89PEYGvE2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVo6UpxTMnmw3Zq0Fn5bqMEdx3CW/FoOrS3yRLnwRb6OlNV21BLF0BQZVlp64VWzQTV1aYdrHjrrCFNt5ofct2odlGPCPb+dSWKXvfdW/DZyIPfFW9jG98aCB9F3SeSM4reryX3O7g5CS1LBZao5vSodDODkE7BOxi0bUQdDiwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C3XeIRTd; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C3XeIRTd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787739180; x=1819275180;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Up36DuiCARgsd7NCCPZXMryCpVXDtOv1L89PEYGvE2s=;
  b=C3XeIRTdXejpTLsuD/d9XqH25Dqjt4+em4LhBk82xVuLpAbGqDxc4MFV
   NHn9dAuAVhOOB3UAAiwNBcD94QcEU3k2+sQJF/WWSDB7PACNYLXhAMdtG
   rS5UY66Kn15144QSAJY+oHv4WuuIkeIZqqVYYdbpxEt97pdVB0mXXCktx
   bH0qSKbAEw/GZHCo53ocHZMNpEhNZLm6wK5v68ekyNRofrSVCZnx/W6wj
   trJUdFHxtbELqgIFAdVyDTHuJ5gjT1fZHEzbTkzJU141o9nuceU0K+X0p
   GCgsqAEfcGGDI7ee5xDNVmgVyd4DjCpPJwpQ/SfIwygfrLB3ln/N6NW6G
   Q==;
X-CSE-ConnectionGUID: 5KZkO2s5SWGwk90bBeRuiA==
X-CSE-MsgGUID: 6IO/Yo6NQdGcwdS+wOq2lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88245826"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="88245826"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 03:12:59 -0700
X-CSE-ConnectionGUID: RyTmD7kPRyWaw3LamK5Nrg==
X-CSE-MsgGUID: Z8ExD74ORSqHk5UdcCgUOA==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 26 Aug 2026 03:12:58 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 09B0399; Wed, 26 Aug 2026 12:12:57 +0200 (CEST)
Date: Wed, 26 Aug 2026 12:12:57 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Hongbo Yao <andy.xu@hj-micro.com>
Cc: andriy.shevchenko@linux.intel.com, andi.shyti@kernel.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	peter.du@hj-micro.com, gwilym.wu@hj-micro.com,
	clarke.li@hj-micro.com
Subject: Re: [PATCH] i2c: designware: Enable interrupt mask workaround for
 HJMC3001
Message-ID: <20260826101257.GN893316@black.igk.intel.com>
References: <20260826070547.268672-1-andy.xu@hj-micro.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260826070547.268672-1-andy.xu@hj-micro.com>

On Wed, Aug 26, 2026 at 03:05:47PM +0800, Hongbo Yao wrote:
> On HJMicro ARM64 servers, the DesignWare I2C controller does not
> retrigger a pending interrupt if the interrupt status changes after
> the current status bits have been cleared.
> 
> The issue is exposed under heavy system load when the corresponding
> SPI is routed across sockets to a core in the remote socket. The
> interrupt is then lost and the I2C transfer times out.
> 
> Enable ACCESS_INTR_MASK for HJMC3001. This toggles DW_IC_INTR_MASK
> before returning from the interrupt handler and retriggers any
> pending interrupt.
> 
> Fixes: 6816ce57c479 ("i2c: designware: Add a new ACPI HID for HJMC01 I2C controller")
> Signed-off-by: Hongbo Yao <andy.xu@hj-micro.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
