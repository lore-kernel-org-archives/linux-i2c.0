Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CD03A4F53;
	Mon,  9 Mar 2026 11:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773056009; cv=none; b=aYjwi3QHrSAbAkztgA3dZkNPmziUYOnS+zH3jqnmdCThOVHqptqsHAV0folDFuMHlQlUQz0Nm/sxa170XV9AYYAi/STjjel5WCOHJDrNzESn5G3rAgnSxx7edaJOhvVgzri+wctiDI0JvD3uDfT2hLg1rJNCSP4337CNuV/vUpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773056009; c=relaxed/simple;
	bh=JuHpzrbAufQ+zpTIrGamvkXdl9yX1h0YnfoBnl5c9Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InR0rsTLMdofl/d8QxqNRoSiDsBBUKpSrytmg0of22fHgULC/Kh03qYW+amZRdkaksEEczrX2Pbh/ulVUa2jelUpvN19AO+J5avQE0++UtmmYsMc/MU+Ux4jDwnLw9898COZqgXKQgt2OiHVaOFzZ1yEsi76caFakQrzVtbRQrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lp75yGXD; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lp75yGXD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773056008; x=1804592008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JuHpzrbAufQ+zpTIrGamvkXdl9yX1h0YnfoBnl5c9Yo=;
  b=lp75yGXDB6y182gvZTry5GcrRKrnTUYvKf7OQKQzIbysJB2G2+rYObjt
   9FKH8DdICY1KHW4+zuPktn0zTCyo/R9TuMoA9c75XzXcFZSvBAmVkjBKO
   qfrAzi4hdEh0yjQGnqLp/YdOm9iuwtLu0LsntJN2Ov2P0ZIPb1+XDX5zm
   Ryqz4yh6fFLsEkSCj1ygm709P/qaQhXMcKG/ARwSTMAt7gD3HVvv1KGyR
   ux0Tb9ZUZIksKeMRrLGhKy0NAse0J8a5o6e6er8P9SBWbjsDocfFaiohZ
   7tas6OAhh8dhx6sZ1eW4nUKT2wcm3BlBwoaZcRmgl76qFL7WG8bAIma0P
   Q==;
X-CSE-ConnectionGUID: NXtU76+KQvyaTefqHDC4Zg==
X-CSE-MsgGUID: uW7DulIiTjm0kma64vDMpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="77926820"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="77926820"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 04:33:27 -0700
X-CSE-ConnectionGUID: BYjNij6OTQmvnxYxvf3Gqg==
X-CSE-MsgGUID: zc0Q1d8yRM+8lYkv2wtCgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="219851993"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.181])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 04:33:25 -0700
Date: Mon, 9 Mar 2026 13:33:22 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 3/5] i2c: davinci: calculate bus freq from Hz instead
 of kHz
Message-ID: <aa6wAvSdgqs8947d@ashevche-desk.local>
References: <20260223-i2c-mux-v7-0-ec75b214718a@gmail.com>
 <20260223-i2c-mux-v7-3-ec75b214718a@gmail.com>
 <aZxrZbbXxm31q62s@smile.fi.intel.com>
 <aa6rhyZLhPY7aE-D@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa6rhyZLhPY7aE-D@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 09, 2026 at 12:14:15PM +0100, Marcus Folkesson wrote:
> On Mon, Feb 23, 2026 at 04:59:49PM +0200, Andy Shevchenko wrote:
> > On Mon, Feb 23, 2026 at 03:33:52PM +0100, Marcus Folkesson wrote:

...

> > > +	dev_dbg(dev->dev, "bus_freq_hz = %dHz\n", dev->bus_freq_hz);
> > 
> > %u ?
> 
> Thank you for your comments, both this and the other.
> 
> This driver has a a few  other style & formatting issues, would you prefer
> to fix those in a separate patch in this patchset or in a following one?

Depending on the issues and churn it makes.

In cases you already touched the lines these (what I mentioned) can be done at
the same time as they do not change the logic. (Yes, theoretically you may get
-BIG NUMBER for big frequencies, but I do not believe we have 2+GHz for any I²C
controller in the world, so IRL it's close to impossible.)


-- 
With Best Regards,
Andy Shevchenko


