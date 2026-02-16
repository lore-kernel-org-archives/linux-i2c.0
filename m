Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED71B2836B0;
	Mon, 16 Feb 2026 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771234308; cv=none; b=Gc7+RzdfyB5GyhRhjprgBiORelfHcxyDwlf/VoUFPkWtYOX+ceuHrXb96z9rzYEb/27U4dsgAtcnMQbg4zeV50350ZqV38XAua/IcKYqld9szRHQWQZVSXg+fUCspmFnteymjOelZP3sf5KHmqYpKf4Ec3lWFLA4ypPYcnUXJ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771234308; c=relaxed/simple;
	bh=VqmQ8cU6ecdNri2hd0MgTCwaRZCbGcpQt8oiFnMymNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcazwRD8wXU8wC1R6f/g1nXkIec495pScj5oMs+h1HJTWZ+/aK8EcD9wuSWNJXHi/jFJJTFZhhYti0xcgGrLDZ8xUDfFqXTEMsNv3iDkAWS9AUsBOPfq+2A8pR9uitxlE23XG5AVCpqcpbA70M5TWqHFLolrGaZGx2uF9CKNd4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A0SObN7G; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A0SObN7G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771234307; x=1802770307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VqmQ8cU6ecdNri2hd0MgTCwaRZCbGcpQt8oiFnMymNw=;
  b=A0SObN7GmV88on03iEM6FR/u07468FOv0+i6yf34T6igxVQS6DJIi1kn
   GO6EhG9J7Kp95I4POd6KtBGLTGT4jskfeSLuBphT/zW6hnuiV/iiRM8SS
   VMwNFwOLcOql6HPislCJC7bgC/6wwGxdNVN//rMRdi/pl+4fc3SZ5obFM
   WHOq0TlVev7RGXYWwOU44Y0IB0vxNEQz/xPnb68s+fM9oReqiI4prt+Mw
   WXbR6sHNTFhehkTIBodWKUvGWxwJPiqejnRwazb8mPbS2pP6bJKToloG5
   4HaZ8wTWlFtvZQF4Yvb8pwfMbem+X0hj5mEArCwJ+2nccuZv+m6a8xqUQ
   A==;
X-CSE-ConnectionGUID: DnAMKtjnQ1GX2iQSFABZrw==
X-CSE-MsgGUID: 4s5loZsVTdW9Qz0kGwtvsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11702"; a="72355164"
X-IronPort-AV: E=Sophos;i="6.21,293,1763452800"; 
   d="scan'208";a="72355164"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 01:31:46 -0800
X-CSE-ConnectionGUID: taENNqnyRY+eGYUhBVdZnw==
X-CSE-MsgGUID: XKK/X2j2Qx6WHX3pf0yeTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,293,1763452800"; 
   d="scan'208";a="218104475"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 01:31:43 -0800
Date: Mon, 16 Feb 2026 11:31:41 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/5] i2c: core: add callback to change bus frequency
Message-ID: <aZLj_dGXOPzp4tMz@smile.fi.intel.com>
References: <20260213-i2c-mux-v5-0-fb2cbf9979b3@gmail.com>
 <20260213-i2c-mux-v5-1-fb2cbf9979b3@gmail.com>
 <aY8HfN3c3qcVbOJj@black.igk.intel.com>
 <aZLhuIfP7rh7o3MH@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZLhuIfP7rh7o3MH@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 16, 2026 at 10:22:00AM +0100, Marcus Folkesson wrote:
> On Fri, Feb 13, 2026 at 12:14:04PM +0100, Andy Shevchenko wrote:
> > On Fri, Feb 13, 2026 at 12:06:50PM +0100, Marcus Folkesson wrote:
> > > All devices on the same I2C bus share the same clock line and the bus
> > > frequency has therefor be chosen so that all attached devices are able
> > > to tolarate that clock rate. IOW, the bus speed must be set for the
> > > slowest attached device.
> > > 
> > > With I2C multiplexers/switches on the other hand, it would be possible
> > > to have different "domains" that runs with different speeds.
> > > 
> > > Prepare for such a feature by provide an optional callback function to
> > > change bus frequency.

...

> > > struct i2c_adapter {
> > 
> > > +	int clock_hz;
> > 
> > Why signed? Even inconsistent with the parameter of the below.
> > 
> > > +	int (*set_clk_freq)(struct i2c_adapter *adap, u32 clock_hz); /* Optional */
> > 
> > It's already a huge struct, can we make this compile-time chosen
> > (when I²C muxes are not required, for example)?
> 
> Hrm, many bus drivers (k1, jz4780, stm32 to mention a few) already have
> the clock value stored in their private data, so maybe it is better to
> have this value in a uniform place in the i2c_adapter struct and make
> those drivers use it instead?

Perhaps say it clearly in the commit message? It seems that commit message
currently focused on I²C mux.

-- 
With Best Regards,
Andy Shevchenko


