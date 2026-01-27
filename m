Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4536357A26;
	Tue, 27 Jan 2026 14:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525043; cv=none; b=R+3s5llrESwo6Gz0wximfkm7gjCpK0xgPvITVAAEA1geXhNBmHjihrSl95rN2VZdn1IG/vcoo4IPrONtyP4C/mxsHjIxqbjyVNM1xA0+aEgz0nfyvv/D2x8o7TYi/QS55c1YzoiK64RWsQ21sPS+ifrjE6R8r0Nitz7fF60sW28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525043; c=relaxed/simple;
	bh=T0qWElQLzg+1ZC1JrnIAFEDP5+QVXsscSywLXBIs8Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upeYC5rHQJfnSiHk2LuXkbb0rKzsLQmKADHp4D1Pgq+NTgnyfosztZVnDzeOcbZIjJIQtzNXNFPT3PgzaCbwq+jcpHMWQQbBe9McxhJqmaOtsIm68JfmpgfHpztGX6cNp+UpSMfaMWInEpv6v1UXb2EabtmQWKJRc1Ydq61pn6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZCxAgdhQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZCxAgdhQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769525040; x=1801061040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T0qWElQLzg+1ZC1JrnIAFEDP5+QVXsscSywLXBIs8Y0=;
  b=ZCxAgdhQI2lIzXUdpgG5X14Em5Oh1yIlxlPhsW/U/si12oEohDFqfyAz
   EuFKiBx5mgw4/nk7eVYXN0L0W+d1DM8PmCBBxYqNqP/yNP5MmCV7ywuvn
   n2afxA/t/4dZaK3fa67kG7EiERvugpgvCV/A9kSMs42ro6ry3KzGHI3ZG
   auxAa+58C+p5vgXQsYDqXo2sQfBqNdm2wTWkhP67c8jVxcbL4iwlsURU2
   rhUbFTa8sCJ3YNNvSXgovI/aRjvmxJAU3eWgc91erWyyZ+8oH4zGjhKvs
   9OC7wkG+juMF84XdZ2tHjNJpaMQMd6zAGPEm9Ma4VVaj6K4eSlXpH0BE/
   A==;
X-CSE-ConnectionGUID: cD3XHOqfRa2hmLLAnkx3Sw==
X-CSE-MsgGUID: cfbxy0RQR+2n5Mi3QTOH/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="93378906"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="93378906"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 06:44:00 -0800
X-CSE-ConnectionGUID: j/FmQVYhQBGghL9jn8vrcA==
X-CSE-MsgGUID: fLGOckWMTq+WoYmrqBPF8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="212852373"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 27 Jan 2026 06:43:59 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id B7AF998; Tue, 27 Jan 2026 15:43:57 +0100 (CET)
Date: Tue, 27 Jan 2026 15:43:57 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: correctmost <cmlists@sent.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dmaengine@vger.kernel.org, regressions@lists.linux.dev,
	vkoul@kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] Lenovo IdeaPad touchpad does not work
 when idma64 is present in initramfs
Message-ID: <20260127144357.GL2275908@black.igk.intel.com>
References: <20260122110021.GO2275908@black.igk.intel.com>
 <a6474592-87db-4fdc-958c-8b09d324df1e@app.fastmail.com>
 <20260123063621.GP2275908@black.igk.intel.com>
 <5c5645eb-66b8-4419-a4e9-ba2672af2f40@app.fastmail.com>
 <20260126135353.GT2275908@black.igk.intel.com>
 <57727c07-33d5-4b52-abe2-4fdc2a7488b6@app.fastmail.com>
 <20260127084201.GA2275908@black.igk.intel.com>
 <b285137a-06bc-43c2-ab24-b3bacf8592ec@app.fastmail.com>
 <20260127101912.GJ2275908@black.igk.intel.com>
 <3d78d3cf-bebd-4bdb-8dca-3024dd769f76@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3d78d3cf-bebd-4bdb-8dca-3024dd769f76@app.fastmail.com>

On Tue, Jan 27, 2026 at 05:56:37AM -0500, correctmost wrote:
> > Okay can you set CONFIG_INTEL_IDMA64=n in .config? That should prevent it
> > from loading. Keep the rest as it was.
> 
> That change makes the IRQ message go away and the touchpad seems to work
> fine in my desktop environment (log attached).
> 
> These are the config changes that I tested with:
> - CONFIG_I2C_DESIGNWARE_CORE=m
> - CONFIG_I2C_DESIGNWARE_PLATFORM=m
> - CONFIG_INTEL_IDMA64=n

Okay thanks it looks good to me too.

I tried to go through the datasheets again but could not figure why the
LPSS I2C IP would keep the interrupt asserted. However, I think we can
hack^Hwork this around by simply not creating the IDMA64 device at all for
I2C. This should be fine to do because I2C is really not using DMA in the
first place so this is kind of just wasting "memory". So something like
below.

Please re-enable CONFIG_INTEL_IDMA64=m and the rest and try if this makes
it work without the irq splat. And if it does please try with the
"original" arch setup and see if that works too (keeping the patch applied
of course).

Andy, what's your thoughts on this?

diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index 63d6694f7145..088db88b10d5 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -246,7 +246,8 @@ static int intel_lpss_assign_devs(struct intel_lpss *lpss)
 
 static bool intel_lpss_has_idma(const struct intel_lpss *lpss)
 {
-	return (lpss->caps & LPSS_PRIV_CAPS_NO_IDMA) == 0;
+	return (lpss->caps & LPSS_PRIV_CAPS_NO_IDMA) == 0 &&
+		lpss->type != LPSS_DEV_I2C;
 }
 
 static void intel_lpss_set_remap_addr(const struct intel_lpss *lpss)
