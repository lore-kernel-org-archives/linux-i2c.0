Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E0D541469;
	Tue, 22 Sep 2026 12:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080146; cv=none; b=A/cKl7IGBJ3Bd/jI01S8Cy8pAGRvR9rRl75F84i+PbpEFLhkobskn8MLpo0qivW3imPJ/usF1y9ZxtXYKWyejGmzdWNVydj8kddALB5PWubSTmqIacwAu4ZQUKBV0azj/ebAfLLa7KoV4LdzcJeA7sOWaZaN7vmEA8f0HvpC2us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080146; c=relaxed/simple;
	bh=Iy0Kojtsduo/C/NofpccyqHinUx0QLiR2gm5v8oENng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8r4Qmi1xc2tMooQ6d2WboBhD7c52aCXWabonYrGfUYpFtTNZXepR6B4venXR3I390RiWP/qAwBu0lKYkajzjDcPOHNaTEc8lCkSsWLKp3XQ9m6J7rt+oYzQbW9m96ulq2eYJwcM9v9EVHDtLMYxiYLkC9FyevU4rn2KciRJYcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BYDJ68Fh; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BYDJ68Fh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790080145; x=1821616145;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Iy0Kojtsduo/C/NofpccyqHinUx0QLiR2gm5v8oENng=;
  b=BYDJ68FhxG06xzb/CUbQJxCrz0HAJvgqh0IbciagISC8XFpx8TKovcVP
   jKgNvHJ2fD+cBZkxMCNvYbyrMuiB35GqZbTr5+aedIbDFil7xJukKtPl2
   biOE6yBuMqa3WBGkkIuMrwzjJZIpXmmzCTNLFC1ZC7wEb63s0ki6+6dzu
   InWnL/ka6J6KU2GSNyR8nFlIpLRe3V2CdnCMAOSLhmMjYgQKSTUtCTAzU
   LNY648K0NPwWlDRaTtTm/luIe8g4gwrQl5gEQRsWWiu+fLE+dZPpPClm5
   lpaLwvKjULIzQjYexaJ1dGq/P1p5W/Ote/F6oZq+/CjXW7Ajx2Nb8iDam
   A==;
X-CSE-ConnectionGUID: mQWJluHDTBOF3HwvGhq2Qw==
X-CSE-MsgGUID: sedhNU63S1CI5JF4mcZYpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="1180513"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="1180513"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 05:29:04 -0700
X-CSE-ConnectionGUID: wNe+hQAWRJqXFRkQvDNizA==
X-CSE-MsgGUID: lEZDUfG8R0ymRYbLcx5bfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="277897867"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 22 Sep 2026 05:29:03 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 7338799; Tue, 22 Sep 2026 14:29:02 +0200 (CEST)
Date: Tue, 22 Sep 2026 14:29:02 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Navon John Lukose <navonjohnlukose@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: designware: size the RX FIFO threshold to the
 queued transfer
Message-ID: <20260922122902.GE106095@black.igk.intel.com>
References: <20260919232647.448748-1-navonjohnlukose@gmail.com>
 <20260921120526.GV106095@black.igk.intel.com>
 <20260921170456.53354-1-navonjohnlukose@gmail.com>
 <20260922065041.GC106095@black.igk.intel.com>
 <20260922121238.46016-1-navonjohnlukose@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260922121238.46016-1-navonjohnlukose@gmail.com>

Hi,

On Tue, Sep 22, 2026 at 05:42:38PM +0530, Navon John Lukose wrote:
> On Tue, Sep 22, 2026 at 08:50:41AM +0200, Mika Westerberg wrote:
> > Yes power savings are always good but in this case it also affects the
> > latency visible to the user so we don't want devices like touchpads become
> > "sluggish" either. Do you see any such issues with the devices when you
> > have this enabled and not using /dev/cpu_dma_latency or any other interface
> > to limit the CPU low power states?
> 
> No. I have been running it as my only kernel for a week with nothing set on
> cpu_dma_latency, and I cannot tell the difference on the touchpad.
> 
> This patch increases latency by 0.7 ms on the mean, which I don't think
> is easily noticeable by humans. Against that, the i2c traffic alone cost
> 2.24 W on the machine I measured, more than its entire 1.87 W idle draw.
> 
> However, if anyone tests and can feel the difference, please let me know.

Yeah I don't think 0.7ms is much but we have things like touchscreens and
the like with various report sizes so at least it would be good to check if
those have any issues.

Unfortunately I don't have any of such devices anymore but I asked our
validation to check if they have something that could be used to test this.

> Also, i2c_dw_configure_mode() sets TX_TL to half the FIFO and RX_TL to 0
> on adjacent lines, so a transmit interrupt moves up to half a FIFO of
> data and a receive interrupt moves one byte, which is what this patch
> changes.

Right and there is no explanation why 0 but it has been working fine so far
;-)
