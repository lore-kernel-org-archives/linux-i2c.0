Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8921D354ACC;
	Fri, 13 Feb 2026 11:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770981710; cv=none; b=NycHtJNXWuQDlL12gNI2XZi5m5Q2MNCfnLSDaENQyV63rDbolPKwjztFTmoeR+5aq9UAhocGagL9aRo4eo6ZsWftH3ocoI05L5BoY3CoeAFInUa+maSDB15bxx8Fl4scbzuMrfLUrBQbMVLA1KqU65oHbVAvVBtLBWfFS+lH390=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770981710; c=relaxed/simple;
	bh=oalafXRy+yr0lqdQBdCAF5RFXuogFNzSlpMBL4VEGjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVjMnP3/JN/DOz1eFS7FQ44itcuEOqIuWaaNwEO3spOnMz9HAOTgZUl78i9eBR9YL5qtsJiHZtXYsptRvMv1PwINRNSyvH3Q6GJlpDX+xBPleLSXiMilkngOpxbceJhapfLVpCjHB2QNdpV/TuzU3jQzj4fFyD6ZtTWBFl1CEgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uon9WCsz; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uon9WCsz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770981707; x=1802517707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oalafXRy+yr0lqdQBdCAF5RFXuogFNzSlpMBL4VEGjY=;
  b=Uon9WCsz2xx++6DUfZKVKa2nf6B7kLAOnjNNl9MOMGaEDY/PqJbLuwoK
   cQKSc18cpqq1ktEh123hZ+03y1TxlN0MkjP0QQ8hS03rVwXnUJ6qzCeDj
   9Ew5Se1uGbdKcvbddu1qO41AC96t0d+rr6susIWHhgXhK6WBeiqwjWKyA
   7072B6CUP8h2YHRTD7QUPlBIC6xMwdYQOnJNAfHsC3dBTgUyQthrWlaoC
   +3yDWOcJiA6185hLjz71/M6/Lc/jRHDHBu4PE86lM1XYNRivN2NkCHE5u
   fda91Q0kC3pJElKC/UdwDagRVegVPplf/koal8VtbifVEV5MmNaAF3MIm
   A==;
X-CSE-ConnectionGUID: HjB/wElsSOCi5P0H/D7s4g==
X-CSE-MsgGUID: Nf7ymAjzTlycoOqKilMTKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="89577333"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="89577333"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 03:21:46 -0800
X-CSE-ConnectionGUID: sqh92NJLR9GkfsOsYZe56A==
X-CSE-MsgGUID: V94onIbZSsmDUjqrfDU45g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="243498330"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 13 Feb 2026 03:21:44 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 738F695; Fri, 13 Feb 2026 12:21:42 +0100 (CET)
Date: Fri, 13 Feb 2026 12:21:42 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/5] i2c: mux: add support for per channel bus
 frequency
Message-ID: <aY8JRikJpM4v5BcM@black.igk.intel.com>
References: <20260213-i2c-mux-v5-0-fb2cbf9979b3@gmail.com>
 <20260213-i2c-mux-v5-2-fb2cbf9979b3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213-i2c-mux-v5-2-fb2cbf9979b3@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 13, 2026 at 12:06:51PM +0100, Marcus Folkesson wrote:
> There may be several reasons why you may need to use a certain speed
> on an I2C bus. E.g.
> 
> - When several devices are attached to the bus, the speed must be
>   selected according to the slowest device.
> 
> - Electrical conditions may limit the usuable speed on the bus for
>   different reasons.
> 
> With an I2C multiplexer, it is possible to group the attached devices
> after their preferred speed by e.g. put all "slow" devices on a separate
> channel on the multiplexer.
> 
> Consider the following topology:
> 
>                       .----------. 100kHz .--------.
>     .--------. 400kHz |          |--------| dev D1 |
>     |  root  |--+-----| I2C MUX  |        '--------'
>     '--------'  |     |          |--. 400kHz .--------.
>                 |     '----------'  '-------| dev D2 |
>                 |  .--------.               '--------'
>                 '--| dev D3 |
>                    '--------'
> 
> One requirement with this design is that a multiplexer may only use the
> same or lower bus speed as its parent.
> Otherwise, if the multiplexer would have to increase the bus frequency,
> then all siblings (D3 in this case) would run into a clock speed it may
> not support.
> 
> The bus frequency for each channel is set in the devicetree. As the
> i2c-mux bindings import the i2c-controller schema, the clock-frequency
> property is already allowed.
> If no clock-frequency property is set, the channel inherit their parent
> bus speed.

...

> +static int i2c_mux_select_chan(struct i2c_adapter *adap, u32 chan_id)
> +{
> +	struct i2c_mux_priv *priv = adap->algo_data;
> +	struct i2c_mux_core *muxc = priv->muxc;
> +	struct i2c_adapter *parent = muxc->parent;
> +	struct i2c_mux_core *mux_locked_ancestor = NULL;
> +	struct i2c_adapter *root;
> +	int ret;
> +
> +	if (priv->adap.clock_hz && priv->adap.clock_hz != parent->clock_hz) {
> +		mux_locked_ancestor = i2c_mux_topmost_mux_locked(adap);
> +		root = i2c_root_adapter(&adap->dev);
> +
> +		/*
> +		 * If there's a mux-locked mux in our ancestry, lock the parent
> +		 * of the topmost one. Mux-locked muxes don't propagate locking
> +		 * to their parents, so we must explicitly acquire the lock above
> +		 * the highest mux-locked ancestor to reach the root adapter.
> +		 */
> +		if (mux_locked_ancestor)
> +			i2c_lock_bus(mux_locked_ancestor->parent, I2C_LOCK_ROOT_ADAPTER);
> +
> +		ret = i2c_adapter_set_clk_freq(root, priv->adap.clock_hz);
> +
> +		if (mux_locked_ancestor)
> +			i2c_unlock_bus(mux_locked_ancestor->parent, I2C_LOCK_ROOT_ADAPTER);

> +		if (ret < 0) {

Would it (ever) have any positive returned values?
Ditto for other similar cases.

> +			dev_err(&adap->dev,
> +				"Failed to set clock frequency %dHz on root adapter %s: %d\n",
> +				priv->adap.clock_hz, root->name, ret);
> +
> +			return ret;
> +		}
> +	}
> +
> +	return muxc->select(muxc, priv->chan_id);
> +}

...

> @@ -223,6 +317,7 @@ struct i2c_adapter *i2c_root_adapter(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(i2c_root_adapter);
>  
> +
>  struct i2c_mux_core *i2c_mux_alloc(struct i2c_adapter *parent,

Stray and unneeded change.

>  				   struct device *dev, int max_adapters,
>  				   int sizeof_priv, u32 flags,

...

> +		of_property_read_u32(child, "clock-frequency", &priv->adap.clock_hz);

Why OF-centric APIs? Muxes may and do appear on other systems as well.
Okay, this function seems fully OF-centric :-(

-- 
With Best Regards,
Andy Shevchenko


