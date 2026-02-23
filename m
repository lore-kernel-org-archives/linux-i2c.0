Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BF85C613;
	Mon, 23 Feb 2026 14:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771858542; cv=none; b=bp524sZBHTV1Zmm2fUCk0t24z84aOjPgqCdT8xsQb+ekRQrzqvr/xF0Ojs0ofxe9AUyyQa9iOMILhvxhSLS39fP8nWOf3Bd+VkZm/nQcqB3+FpIe5ZMDJBIk9MH6U2VTTN/ZmkuKVCB/ACfUmz1rWWgwoNfsGP8I0w9b1GwfmjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771858542; c=relaxed/simple;
	bh=WM183hACJaD3Rb+fx+g4iGlrxeXPl34ZFLsoh/Or5D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYeEjlZM7R61R+JyOr0neeIvaMKnFXTZmUvQU3nBHR7sZCc7QtvSPy+5nqM5a1c2x7TQDnjW8V1OpupCsfJr247Ah0DoLi0IFbM9rwqZIu8B/26uvCzNJb1l9t+YqDkuY+RIzavpg/sCxvJ2sBuUdECaE/xWulepS0CS3YVz6sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d3g+fX2y; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d3g+fX2y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771858541; x=1803394541;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WM183hACJaD3Rb+fx+g4iGlrxeXPl34ZFLsoh/Or5D4=;
  b=d3g+fX2yC1YIzIQqJJay/YFL9AmJOtHPsPTlLoNJRECNq0Glyk/Q+apE
   CFZmbW7AP+bXmPHHaHi8RhipirE2q5oxSIkDi/OpHA+OkxbmTisYnMC79
   f8ZksCwi6kgkwTPNhTka0DMpfQaK1YKIRmFycaZx6cVROzUvmwUtzjpXx
   4amM5vugh8+Thp2P7U+GVg6HXJOLYgjEYdyQEaRYZ2aavbW6IKR9m0CDX
   gAAxUDKGxKLeR1FGdkWrgcpIsO+udyJLRPlizqVL9PGe9XGnxoyPbkF3f
   2wcGmMSj89Dvc0aeigWta696kWJ+mQ9jtSD+oTWdIh9pJgmSZXgIp3q5U
   g==;
X-CSE-ConnectionGUID: 1bxlFz+zQGepg1O+SgU9KA==
X-CSE-MsgGUID: Qp0H5HYIRea2gLu0f83w0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="84214932"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="84214932"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 06:55:40 -0800
X-CSE-ConnectionGUID: Dz70m+RIQ3Od/kORcNfEtA==
X-CSE-MsgGUID: ZFIO4c/qQo+zK4iLVPGtvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="213517895"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 06:55:38 -0800
Date: Mon, 23 Feb 2026 16:55:36 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 1/5] i2c: core: add callback to change bus frequency
Message-ID: <aZxqaGxsUuD8vxQL@smile.fi.intel.com>
References: <20260223-i2c-mux-v7-0-ec75b214718a@gmail.com>
 <20260223-i2c-mux-v7-1-ec75b214718a@gmail.com>
 <aZxqBOaFId-9WfnR@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZxqBOaFId-9WfnR@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 04:54:01PM +0200, Andy Shevchenko wrote:
> On Mon, Feb 23, 2026 at 03:33:50PM +0100, Marcus Folkesson wrote:

...

> > +	/*
> > +	 * If the adapter is a root adapter without set_clk_freq implemented, this feature is not

.set_clk_freq()

> > +	 * supported

Please, also respect English grammar and punctuation: Missed period here.

> > +	 */
> > +	if (!i2c_parent_is_i2c_adapter(adapter))
> > +		return -EOPNOTSUPP;
> > +
> > +	/* Update the clock_hz for non-root adapters, even if set_clk_freq is not implemented,

.set_clk_freq()

> > +	 * to allow * the clock frequency to be propagated to root adapters that do support it.
> > +	 */
> 
> /*
>  * Please, keep the style of multi-line comment consistent
>  * and as per above.

...including one thing ^^^

>  */
> 
> > +	adapter->clock_hz = clock_hz;
> > +	return 0;

-- 
With Best Regards,
Andy Shevchenko


