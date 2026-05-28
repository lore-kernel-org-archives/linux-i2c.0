Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45038299A87;
	Thu, 28 May 2026 10:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779963078; cv=none; b=a12HQC2YiMIJ6YLC1tku7VxG6LI0PFLEF5UXFoSR1GnpaxJ0Xk1XKrkUg6Q7qvzSX89J+YzPM8U/Pw/ZkhIDlbGUX0fwCMDK7IP6MEDELcb8ldAWNrKPbIZGtou6amA3lsn7qtj1DYPgn7ZX5WHmOSRieBa6DO/fnnEO+5+uOAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779963078; c=relaxed/simple;
	bh=Z1G2IooUfLdNWTdetd5osB+LagzLa/hv0pvbRV0SEiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpluHbpuwj1ZILWSDxZNuv/D80FJYZw7RCH2fd0cyR5RFy8MjHVnPe7xCbRPBi6/Bw6/N2roDMFp+BaoE6BmHKo5INC5UZMXTahY7RHkXAsro7eKbguT/lfrBcWbbfea4aywX94a+t+FU3122hU7VChg3fqZpwpuK4lifjuVitM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DsyENt/b; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DsyENt/b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779963078; x=1811499078;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z1G2IooUfLdNWTdetd5osB+LagzLa/hv0pvbRV0SEiY=;
  b=DsyENt/bWfGl53RD0cBngV/nNJ1nPJ6X8TAsvxMXZjzA3E7BkH/rslhj
   U4tfboNDNb2lfGai2z755i39uECyddvK+iNWBxqlJKXX2eVmDON+l8qBX
   +N1oJIt8XCFDmeRcrUpakDs5sF7bnbgnbMoJ7PzWd0SPiSWJ7WVl3GlsO
   eUc2bInndk2fpjXVdqmzGNUL5AveJpkGQJKRny08teclQf9d/YcBA0vr/
   G3uyPI5TOfxkZidzdwoLuTdailg/BhPKtxwfKQb6jHgZZwR+eEOyVYK0N
   E/bfyxphe0hQMugbz0Trf6cLqW2mYQGZNQoTyhq5VDp4rxSlghyoCMPIU
   g==;
X-CSE-ConnectionGUID: F2Ec5ZX2TgC7FQgMcl0bOA==
X-CSE-MsgGUID: ZsU/2bNrTYy9UA1HbUDatw==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80863020"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="80863020"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 03:11:17 -0700
X-CSE-ConnectionGUID: M2C1Vsc9T2aMHYwp86WjBg==
X-CSE-MsgGUID: nWDv+cIXQ1ilapZ0GV3p4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="239504095"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 28 May 2026 03:11:15 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 99DBF98; Thu, 28 May 2026 12:11:14 +0200 (CEST)
Date: Thu, 28 May 2026 12:11:14 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "William A. Kennington III" <william@wkennington.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 0/4] i2c: designware: Improve device disable
 handling
Message-ID: <20260528101114.GG3102@black.igk.intel.com>
References: <20260527-dw-i2c-v5-0-3483057f8d67@wkennington.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260527-dw-i2c-v5-0-3483057f8d67@wkennington.com>

Hi,

On Wed, May 27, 2026 at 08:09:48PM +0000, William A. Kennington III wrote:
> When the I2C controller attempts a new transaction while the target
> controller is shutting down or restarting, it can lead to bus lockups
> and system bootloops if the hardware enters an inconsistent state.
> 
> This patch series addresses this by ensuring that the internal state
> machines are properly cleared when disabling the controller if target
> activity is detected.
> 
> Additionally, it adds a shutdown hook that gracefully sets the target
> disable bit before disabling the controller. This guarantees that any
> incoming requests from the controller are immediately NACKed during
> shutdown, preventing the bus from hanging.
> 
> Signed-off-by: William A. Kennington III <william@wkennington.com>
> ---
> Changes in v5:
> - Fixed one last inclusive language mistake
> - Link to v4: https://lore.kernel.org/r/20260507-dw-i2c-v4-0-9a447b23bfdf@wkennington.com
> Changes in v4:
> - Updated language to use inclusive terms
> - Refactored some minor comment / code nits
> - Link to v3: https://lore.kernel.org/r/20260504-dw-i2c-v3-0-57e56135d602@wkennington.com
> Changes in v3:
> - Split the monolithic patch into 4 logical patches
> - Reverted stray formatting change in the PCI driver's dw_i2c_driver struct.
> Changes in v2:
> - Fix description footers
> - Fix emails
> 
> ---
> William A. Kennington III (4):
>       i2c: designware: Introduce shutdown exported function
>       i2c: designware: Convert PCI driver to use shutdown hook
>       i2c: designware: Convert platform driver to use shutdown hook
>       i2c: designware: Handle active target cleanly

For the series,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
