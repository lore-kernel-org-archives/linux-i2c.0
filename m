Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2A9355F46;
	Mon, 21 Sep 2026 12:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992336; cv=none; b=eIe1VY1qinQ3QsIKjRU0o8ZsiALtQ5ryp5E8ROjM3cU6FwryvzsPpy1h8jqlPAnNnDmkuKF+0JtAoXa37LcXGUqmStFjshwrsHkVwX5/UdG1UG6yd6ik5IH6JhNE0RN4UC79gG6u3G4PKeLAu6epaAau4VbRnj/Yk65mLo1Xs1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992336; c=relaxed/simple;
	bh=xylT/7n+paBi0apD21M9UA506TVCK8ZyVRRxL+8cvPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZF7lPlbdUHaymJ9aGqMjwrHudcrtjNHw0qc8ComEFLmV+M95yHdmkUlaB726UnHaeqsqOu0xNP696zSkEwuISIFqg+stVPXnD8fT0iSxt91HznD3Rhofvoa/bwpRBxiJwc2RhSkEz68UbYdnsVRbp6ZO16Pj+kvHMYSkvZpXwNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UreMuO+s; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UreMuO+s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789992334; x=1821528334;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xylT/7n+paBi0apD21M9UA506TVCK8ZyVRRxL+8cvPM=;
  b=UreMuO+sUwwPvXwProBfUS0gF8G2JcyVQVuzPM5LhFuqVm+gPrS5eLyt
   B6lu/for642Z6eX9opSnhflH8WSjlbUoVkib0g6AxVPH9DCQcHyufW7j1
   B7npXX6bl9xh8eAnPOZeZc6DocfW0FiCK0ihLXE7HGf1LxtCHgK9pocKe
   n3Qc+dNxke9uosU9u/kO4++oPgoZkTFWmmwE6VmWbJiQ7CPJpUdGc7URL
   OMUeDFGO8B3XtbFiPrH19edF7zFRVdODz5u0FXeEBajsmEVhokAiTAcq/
   A+mdUJe8OMxr7P3GRkcOYplb0zyhvcW4OOzIXnLGbYdUrfhRP7Xaut13K
   Q==;
X-CSE-ConnectionGUID: HysHaZ4/TiixXrPoCaSGGw==
X-CSE-MsgGUID: Ez7keocIQ76/jW1FYzAoNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="90366341"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="90366341"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 05:05:33 -0700
X-CSE-ConnectionGUID: 1znsR1Y4R3O88q/1FYs0CQ==
X-CSE-MsgGUID: sheyVaw0Rd+qlY/15BMy5Q==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 21 Sep 2026 05:05:31 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id E0FFD99; Mon, 21 Sep 2026 14:05:26 +0200 (CEST)
Date: Mon, 21 Sep 2026 14:05:26 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Navon John Lukose <navonjohnlukose@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: designware: size the RX FIFO threshold to the
 queued transfer
Message-ID: <20260921120526.GV106095@black.igk.intel.com>
References: <20260919232647.448748-1-navonjohnlukose@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919232647.448748-1-navonjohnlukose@gmail.com>

Hi,

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

I'm slightly worried about the latency increase here and the fact that
HIDIOCGINPUT is pretty much same as HID_REQ_GET_REPORT so it's not only
hidraw that is affected but everything else using HID_REQ_GET_REPORT as
well. We cannot expect regular user knows or should be using
/dev/cpu_dma_latency (and it may be bad thing to keep the CPUs from using
certain C-states).
