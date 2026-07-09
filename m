Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED5738E8C6;
	Thu,  9 Jul 2026 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591527; cv=none; b=IdwLFB03NW8FV5N7KHK2fsHvRkSsv1lUGPi2DoO1BzxhatSdNgK/nzNWysDK6/ei88WQsOKk66jrq78Ok+k3hAe0RjUafzJNny2nI9uEv5JpihzqgBeokFe5LETB74ydRmt2pUXnKSFVvftPSgxXhZsValV8DPCKWAx1XP89KxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591527; c=relaxed/simple;
	bh=kynRmd6VkJDJaKnAtp481E/LYoCY9IfgfoGNoe6Bgsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxJX+qf0pKO5hXX7OgyzL9Wbb9tis0SAmENtoUNFDgg3PcCOtFXIOS2vQrQHtVCahG0TJSSGzSyg+3p3emmlF75ldqlsF9txBWl3F/9bHAEskxPq+o5XWLBOFPKHiCN8fYZ35Y+f21orqXHt8MMEVFQ/6UUnCae/lGre2BFzUBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bR+M0CV4; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bR+M0CV4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783591526; x=1815127526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kynRmd6VkJDJaKnAtp481E/LYoCY9IfgfoGNoe6Bgsc=;
  b=bR+M0CV4l1kr3OnHYLiy6aVCPkN9U4sugdomOgGwqI8Opl3n2LcSLrYz
   pEfjwvHynJE9TWgCkVLdK/vV6in3/MedLvxV1qa9lwAzyE+W/nmf5X7yU
   d4b/QWtMQXpBiZV7Z1CTRXrBKQp4nv/moozCASMdZrjiD7lcbsIQIdynG
   vEDShyOeY0+1EMsySB1t7Ygqlh5V7lDYb9QRE9X5KqImjHvAQE+rxYn8C
   IdkdJnSBtfm2t5QZ0I2YEvQdJswTQMnWRPgPdgGPBPYUZH87tkZ+DlUdL
   9Z7hgupLIuSRLtPfQxkXd6wn9RmeylDAx7yEntLRDiBAh6Q+vFaQMwMpw
   w==;
X-CSE-ConnectionGUID: 3ztgoLCiQ/GM/h0+cItNbw==
X-CSE-MsgGUID: 2zYNaqsYTNeD5tbo4425Lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84286571"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84286571"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 03:05:25 -0700
X-CSE-ConnectionGUID: hTUNBWWGR3eFq+am3Mq5pg==
X-CSE-MsgGUID: 7Ic9mailTa6mlsefKI3aRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="255200185"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 03:05:22 -0700
Date: Thu, 9 Jul 2026 13:05:19 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 0/7] I2C Mux per channel bus speed
Message-ID: <ak9yXzjO_DwJXXgD@ashevche-desk.local>
References: <20260708-i2c-mux-v10-0-09dca03c8a15@gmail.com>
 <ak6m6srzX8dd6_nT@ashevche-desk.local>
 <ak9c6nGBsgMTP099@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak9c6nGBsgMTP099@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 09, 2026 at 10:33:46AM +0200, Marcus Folkesson wrote:
> On Wed, Jul 08, 2026 at 10:37:14PM +0300, Andy Shevchenko wrote:
> > On Wed, Jul 08, 2026 at 02:16:12PM +0200, Marcus Folkesson wrote:

...

> > > - Move {__,}i2c_adapter_set_clk_freq() to i2c-mux.c
> > 
> > Can you point to the discussion where it was suggested, please?
> > It was like ages ago (too many patches to review) and I probably
> > missed and/or forgot the rationale for that. Also if we move
> > to i2c-mux, why do we leave it in the adapter namespace?
> 
> Hrm, it seems like the mailing list wasn't CC:ed for that comment.

Please, be sure next time everything like this important will be available
to all.

> It was suggested by Peter and the rationale to remove it was:
> 
> "
> I'not sure it's a good idea to expose {__,}i2c_adapter_set_clk_freq().
> 
> Do we really want to make it so simple for random (non-mux) I2C drivers
> to muck about with the bus speed? Any bus speed changes not coordinated
> with mux-locked bus speed changes are going to be problematic. This is
> shown by the discussion about D2 for the multi-level mux-locked example
> (patch 5/5) -> it is problematic even when the bus speed is changed by
> the mux code itself.
> 
> I think these helpers should be moved from i2c.h to i2c-mux.c.
> "

Okay, let's assume I'm fine with this reasoning, I would still go with
the proper namespace. Otherwise it's inconsistent.

-- 
With Best Regards,
Andy Shevchenko


