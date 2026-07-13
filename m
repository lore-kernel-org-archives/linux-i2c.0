Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EF131A07F;
	Mon, 13 Jul 2026 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959060; cv=none; b=Hm1vUW2B0sZMu7+utds9bNQDfbP3mwE054aUVlQEOw0W3Hr/Fs/1ZN5vLMLLWNGZm9cm1UoWyy7vjFKyJOOR0QQTjRu70OwBslSXMs7YHEzS/cB6Os7TPbxHBnTnTPtfYXkCYGyGGnpYdCY3g5/NnZIJla2EtyI/qbjvZ42jYG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959060; c=relaxed/simple;
	bh=YZ/BOqdI0asVtPSpoTQNzl05BwwgREcjJn07zQcObpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKsUHvKlQi4s/N1mhZVzE0LLPwaLekjEP7b2vGDUShcMmZ6ygOpM9hXwzDmupC3iYww1J+EcqXNZuXndXkm78XtrWeigFuxcPI0wO278Df+VxnLJr2IwOczzjGVGjB80eq5PLyK+woCEhHIkDXB9dcCNnYP8gG8UPgPviMyDtcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H7UuQiWC; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H7UuQiWC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783959060; x=1815495060;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YZ/BOqdI0asVtPSpoTQNzl05BwwgREcjJn07zQcObpg=;
  b=H7UuQiWCNk5p6GHXQ5+XYNDxls7mluAsSqQTJob+SynoDrTkaO2ut5EV
   fdY2EW57naR6kYB9yW5eYoPjveII9Dmxl76huqQSTxiqLvA2AcR2ilRru
   y5FZPQ03q2K7lJQLRJZAm55/xenlx1VBkPtUVWy0oKKyREKdZsDjz9+O5
   2Zs7KRYyiHQypIutJJoS4WHgcfAgKkPklUK0bBo69vjwrX2FvlckjLgxN
   kV0ikebqu/UzBOLP7FiHTdO/tqLh3xmUzQhUkdmGCqSNcXvKOtv+g5Tww
   KEt/lH+S/S2mZv86TrWE4gtwR8VaHVIPFxI4PDVAs9RM5YVvNcvf5w8GY
   g==;
X-CSE-ConnectionGUID: 3pcFCFenQFqEgGds1E4hdg==
X-CSE-MsgGUID: GcbbA+c6Sxye5djh6FkpFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84536924"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84536924"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 09:10:59 -0700
X-CSE-ConnectionGUID: 853GWs/YSl+HSJAOIgZ20A==
X-CSE-MsgGUID: rXLkjSZ9TLWvhbkbQGT0jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="253858335"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.88])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 09:10:56 -0700
Date: Mon, 13 Jul 2026 19:10:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v11 1/7] i2c: core: add callback to change bus frequency
Message-ID: <alUODujJFdtYElbY@ashevche-desk.local>
References: <20260713-i2c-mux-v11-0-72bb8af8ee8c@gmail.com>
 <20260713-i2c-mux-v11-1-72bb8af8ee8c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713-i2c-mux-v11-1-72bb8af8ee8c@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 13, 2026 at 09:19:57AM +0200, Marcus Folkesson wrote:
> All devices on the same I2C bus share the same clock line and the bus
> frequency has therefor be chosen so that all attached devices are able
> to tolarate that clock rate. IOW, the bus speed must be set for the
> slowest attached device.
> 
> With I2C multiplexers/switches on the other hand, it would be possible
> to have different "domains" that runs with different speeds.
> 
> Prepare for such a feature by provide an optional callback function to
> change bus frequency.
> 
> As a side effect, several bus drivers keep the bus speed in a
> private structure and can now have this value stored in a uniform way
> instead.

...

> +	u32 clock_hz;			/* bus clock speed */
> +	int (*set_clk_freq)(struct i2c_adapter *adap, u32 clock_hz); /* Optional */

Ah, I thought you also updated to _Hz here...

But no need to resend just for that, only in case of a new version for
something else. (Or maybe Andi even can tweak this whilst applying...)

-- 
With Best Regards,
Andy Shevchenko


