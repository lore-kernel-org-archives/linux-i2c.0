Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFE44534AD;
	Tue, 22 Sep 2026 09:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071058; cv=none; b=d+/yc3BZIdbGNFrquOhLT0HUZdRh+kgyhaSf/3+T3gEEzpAxdmPS+Ldh84JybLE4QN+uWk8BOQmh5lpoCBsqi6SX8RTIqaGMqVxkQQmyF/cPLz8FKqkmChKk7HwqStTe+SRyTAj9Q5TZT6D7kN8yjbfbNRW1SSqPhCl0i6J810g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071058; c=relaxed/simple;
	bh=v92zU5YVAU2udt26U4bFcbq3ehy6j1cVdRFUwqJ9H1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pb92OkQGDKKtYlnaynuzYpKn3EcoO+SNgnQ5zvVOAHfqPN+r/RuXD+u/5ltRFX23X/Jq8mvMd3Lr0/d/mkZag1z+9yrFwxJvGi+F5GVUzzWjEuSQb6RPx+cC5q8MasveF1MUvZjHcCYNkKfypsbkG/KeImJtLgKw/q9ckqIYQus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BnEuyQaz; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BnEuyQaz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790071056; x=1821607056;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v92zU5YVAU2udt26U4bFcbq3ehy6j1cVdRFUwqJ9H1c=;
  b=BnEuyQazEqi6lOMnPcX/HjaVdYdtZaK1J61SVrbMBnxFFYETai/lPbHi
   Nhg4Y+QRJJiRBg6XXRU5FcN3OycMkyFO8nawXm6ZLtuZEJ/A7rBwngCJm
   QX7eYl1OytrpQc2hMNb4twrFfsAtt96pV5vKFvVH8aYBLkdU67L42pyn6
   6u2vCXH05IeuSfB5LS1kSRb/MF0tEYav7E7yOld3FeUAKBFhuJ1V+984l
   HHCm/Q8F760lARPsIdCUw4olVU6EjIpmoSuR1vhSKcowOUFngdH/OeDqu
   Sjn/okZiFgHe++tfWqc2RSnBljzBSM70CJ2H4o457G2TnTjWj9hONHi5+
   g==;
X-CSE-ConnectionGUID: F5jxLOj+TQWm3AJA6WmdHQ==
X-CSE-MsgGUID: lmAwT8OUSXSGZfJQOzVpNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="89581562"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="89581562"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 02:57:35 -0700
X-CSE-ConnectionGUID: bQG6BlcxQ/ySlre4N5FJow==
X-CSE-MsgGUID: P5SCH1ieR3Wd/9X9LrDGng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="281125929"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 02:57:34 -0700
Date: Tue, 22 Sep 2026 12:57:31 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Navon John Lukose <navonjohnlukose@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: designware: size the RX FIFO threshold to the
 queued transfer
Message-ID: <arJRC4Ou1LSAMGTs@ashevche-desk.local>
References: <20260919232647.448748-1-navonjohnlukose@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919232647.448748-1-navonjohnlukose@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Sep 20, 2026 at 04:56:47AM +0530, Navon John Lukose wrote:
> i2c_dw_xfer_msg() leaves DW_IC_RX_TL at the 0 that i2c_dw_configure_mode()
> writes, so the controller raises RX_FULL once per received byte. Program
> RX_TL from the reads already queued, capped at half the FIFO until the last
> message is queued, so there is room for the rest.
> 
> On an Arrow Lake-H LPSS core with rx_fifo_depth 32, a 22-byte HID report
> costs 2.00 interrupts instead of 21.43, and a 452-byte descriptor 0.14
> interrupts per byte instead of 1.64. Mean HIDIOCGINPUT latency rises from
> 2522 to 3268 us; holding /dev/cpu_dma_latency at 0 removes 94% of that.

Nobody will go with 0 in cpu_dma_latency. It basically kills the idea of CPU
power states. If you need a dynamic run-time PM QoS, patch the HID subsystem to
make those when they want to heavily communicate with the HW. There is also the
issue of the interrupt locality. Can you try to make that first and see how
much power saving you will get?

-- 
With Best Regards,
Andy Shevchenko


