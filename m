Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C63244692;
	Mon, 23 Feb 2026 14:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771858674; cv=none; b=S9LkHZEbgVSlJkUBYOUS8f5Z0ebW5ETVu4bwR9BoYw9VeQ92wFcO9svZTKf1Q8/jXlujEo0ko4u9zxBFMXNIbh8Imgi5gC/Lns077g4hQ6VO4+CF9IYComFUIhzY8p2JeAvK4WpCv4RRtWpd9jHZsDCXvuQfS6rlR8NBlQmHxKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771858674; c=relaxed/simple;
	bh=flglz7jLz0npManpl/9aE8WpQyBTpZbOojs4WvzstnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7q4u4xA2uXjfondsm6XcZKIDoqDTpcXFTaoLXuX/ZPeDmzfljDoUELLfN645CXRikb7KViiAUVsqDbIL+1vaKpEkgfty7n1+yZGzB9rtHeBO9KQUTtHVkoAE3b0kqh4EWkLQ5jT/DEdKEIN07bf5u/UxlviZlLmODV+1XusuxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ecjeTwe8; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ecjeTwe8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771858673; x=1803394673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=flglz7jLz0npManpl/9aE8WpQyBTpZbOojs4WvzstnE=;
  b=ecjeTwe8xEjbm0xeByHgXsKbWZlaUxrwe4m/8yUYNusXExRVzZtDNHHB
   WxmV92wuH5kVmwsK2z1l1EkrV78njWQe1Y0jPb6cWLIGhraSwlTVguqwe
   4J9Fk0yydIdbVkY3fYF0m9+1WP+pfe4XaaXceEBg/RsaNRJZl3exYrOh3
   L16Ot4ZW9vK6j9yJ6TABbesPKC/PyQAwKAMpZkpaICsHLox3EeJxCKpGD
   fzeyZi95qriEAUiKoHMQNdxdVqotlQ5H1mE+pBjE2sc+lXPTQd38Nlks9
   9+DDBz45tiUmUFgzBvZSkLzED+C2lh/8Jx//OmwqJKrYusHry8cgCIFtJ
   A==;
X-CSE-ConnectionGUID: gMYUWkfXTciJhtZ43ghNKg==
X-CSE-MsgGUID: VAlL5HikSFmoIfpTHlIbEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="83566012"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="83566012"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 06:57:52 -0800
X-CSE-ConnectionGUID: t/bW694MTr2W80FjruUmOA==
X-CSE-MsgGUID: 0C3LqggtSgmn0EmsY8zpQg==
X-ExtLoop1: 1
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 06:57:49 -0800
Date: Mon, 23 Feb 2026 16:57:47 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 2/5] i2c: mux: add support for per channel bus
 frequency
Message-ID: <aZxq6wXsS7DDEfIV@smile.fi.intel.com>
References: <20260223-i2c-mux-v7-0-ec75b214718a@gmail.com>
 <20260223-i2c-mux-v7-2-ec75b214718a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-i2c-mux-v7-2-ec75b214718a@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 03:33:51PM +0100, Marcus Folkesson wrote:
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
> 
> The following example uses dt bindings to illustrate the topology above:
> 
>     i2c {
> 	clock-frequency = <400000>;
> 
>         i2c-mux {
>             i2c@0 {
>                 clock-frequency = <100000>;
> 
>                 D1 {
>                     ...
>                 };
>             };
> 
>             i2c@1 {
>                 D2 {
>                   ...
>                 };
>             };
>         };
> 
>         D3 {
>             ...
>         }
>     };

...

> +static int i2c_mux_select_chan(struct i2c_adapter *adap, u32 chan_id, u32 *oldclock)
> +{
> +	struct i2c_mux_priv *priv = adap->algo_data;
> +	struct i2c_mux_core *muxc = priv->muxc;
> +	struct i2c_adapter *parent = muxc->parent;
> +	int ret;
> +
> +	if (priv->adap.clock_hz && priv->adap.clock_hz < parent->clock_hz) {
> +		*oldclock = parent->clock_hz;
> +
> +		if (muxc->mux_locked)
> +			ret = i2c_adapter_set_clk_freq(parent, priv->adap.clock_hz);
> +		else
> +			ret = __i2c_adapter_set_clk_freq(parent, priv->adap.clock_hz);
> +
> +		dev_dbg(&adap->dev, "Set clock frequency %dHz on %s\n",
> +			priv->adap.clock_hz, parent->name);

%u

> +		if (ret)
> +			dev_err(&adap->dev,
> +				"Failed to set clock frequency %dHz on adapter %s: %d\n",
> +				*oldclock, parent->name, ret);

%u

Oh, and so on...

Please, carefully inspect all printf() specifiers in the patches.

> +	}
> +
> +	return muxc->select(muxc, priv->chan_id);
> +}

-- 
With Best Regards,
Andy Shevchenko


