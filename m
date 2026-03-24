Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683D82D5950;
	Tue, 24 Mar 2026 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774361448; cv=none; b=A0JczbXlbNeX03sp99h/22M2WD0EsOwu+In+1NoMwTFILHPnp/n7zR/e5nWNCy5zh1IEkBncpGPUbiPgOyz3QPwuhbSeVVEc9qe8FGHdGy4zPJejDj/Nn8LP0UR6BirwS40eKpn5MYmldMWwNcSJoUuTbvCpmzbIdgQHFJzhKBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774361448; c=relaxed/simple;
	bh=Zwde7jG+zF9qr5SPigLAIwxRSoBCrA0SpkWRrEkdqSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZzB/NN1N7CQ2vL1ySZGKWNsu+o+zs2eHfveeDXkVi6mb6wyZWbl/moAxWGa734lCCsjFEd5TuwhZBL6voR4t1GxmegQ+DNfSf6Pf4EjdlQYeA9xiASGGwiXQYgpYqvKguvybV5RAPE/LBBgiavOdI8j9xKYJnYXROuLu7v2rvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XjBt1M2O; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XjBt1M2O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774361446; x=1805897446;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zwde7jG+zF9qr5SPigLAIwxRSoBCrA0SpkWRrEkdqSo=;
  b=XjBt1M2OyBeE5AFStSif+mBQkGedxZyLRSXF2mhzCAegp5v7NCNlWhE+
   CUeV2EM4Kf3tQkdleA7/g2+DmnJjOclZK9yFSLLtFPSX34FvlA9jERVTx
   QxD3qJ9rdjZPqu1BFrjZc1qWTi/nrtx5X4kW2AXac0fkKsnOB05vzxpGF
   +6Ngza4g4pMVps3XX6kG7T8MRRVnaYtK9hBg5ywJCTE3hSWR5iYXY3i9a
   cPpm1fz7xHgT8OtDO1XEoRkQ+mit/31XEew6rYN7wWSVvBHbejw5wPlNK
   GVZ5flNpLrdW+gcPLHcRX0OXuHkxxatMYbsRCpcnKWSTqwFrtMdQbVcmr
   w==;
X-CSE-ConnectionGUID: S9CN8qS8QfOGlm4lcLZfCg==
X-CSE-MsgGUID: AhiyiqmtRCmNKY/A1GAvtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="78974106"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="78974106"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 07:10:46 -0700
X-CSE-ConnectionGUID: yBwwehg/RoG+sHw14JK3TQ==
X-CSE-MsgGUID: d5ltkdDNRIm+yGn5KU0M0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="247970109"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.214])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 07:10:44 -0700
Date: Tue, 24 Mar 2026 16:10:42 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 2/5] i2c: mux: add support for per channel bus
 frequency
Message-ID: <acKbYhbwZzv2gTnB@ashevche-desk.local>
References: <20260324-i2c-mux-v9-0-5292b0608243@gmail.com>
 <20260324-i2c-mux-v9-2-5292b0608243@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324-i2c-mux-v9-2-5292b0608243@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 24, 2026 at 02:54:16PM +0100, Marcus Folkesson wrote:
> There may be several reasons why you may need to use a certain speed
> on an I2C bus. E.g.
> 
> - When several devices are attached to the bus, the speed must be
>   selected according to the slowest device.
> 
> - Electrical conditions may limit the usable speed on the bus for
>   different reasons.
> 
> With an I2C multiplexer, it is possible to group the attached devices
> after their preferred speed by e.g. putting all "slow" devices on a
> separate channel on the multiplexer.
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
> If no clock-frequency property is set, the channel inherits their parent
> bus speed.

...

> +		of_property_read_u32(child, "clock-frequency", &priv->adap.clock_hz);

Wondering if we may use existing API to get i2c timings from fw description?
i2c_parse_fw_timings() (it might be that it needs to be split for pure fwnode
one and device wrapped).

> +
> +		/* If the mux adapter has no clock-frequency property, inherit from parent */
> +		if (!priv->adap.clock_hz)
> +			priv->adap.clock_hz = parent->clock_hz;
> +
> +		/*
> +		 * Warn if the mux adapter is not parent-locked as
> +		 * this may cause issues for some hardware topologies.
> +		 */
> +		if ((priv->adap.clock_hz < parent->clock_hz) && muxc->mux_locked)
> +			dev_warn(muxc->dev,
> +				 "channel %u is slower than parent on a non parent-locked mux\n",
> +				 chan_id);
> +
> +		/* We don't support mux adapters faster than their parent */
> +		if (priv->adap.clock_hz > parent->clock_hz) {
> +			dev_err(muxc->dev,
> +				"channel (%u) is faster (%u) than parent (%u)\n",
> +				chan_id, priv->adap.clock_hz, parent->clock_hz);
> +
> +			of_node_put(mux_node);
> +			ret = -EINVAL;
> +			goto err_free_priv;
> +		}

-- 
With Best Regards,
Andy Shevchenko


