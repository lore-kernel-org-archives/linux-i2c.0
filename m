Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B39534D934;
	Mon, 23 Feb 2026 15:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771858880; cv=none; b=u2Bb0JhZkdBU9lmhWnL6+bDLKcs66mBUB15uYBWPjoslOVO2UB7YzWe5TpbRb57626Y8EdIlBE9cTuuDhOEo4RoQBLQSmaosQqqyhlSnMOSrRTetg8maJmOmbfjhNcN5vkicnS+TKGQ7jFEk4jYWud0i+6Rd/+TM0TbHYHoxfg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771858880; c=relaxed/simple;
	bh=dN8m8k43WpMaWS8vB4HV6uZ0DEcxBZq5ecRCAj/+QNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/WKVCKyb7DsEQCjL7lJFnnfNMtBBOH17vbaoox+fmt/PRdMiNPOa6hKgoiak4NBCevScL5PrLiRwE4jz2wEeuatneCuMgKBsiWw8PsUIWpuDnwIGcToiHVB0CCkI2tjqGGeqD3ufxUqAQ7YSLlU4Owg+IN/kVuacr7dhqMhJ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W9cXDJZs; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W9cXDJZs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771858879; x=1803394879;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dN8m8k43WpMaWS8vB4HV6uZ0DEcxBZq5ecRCAj/+QNw=;
  b=W9cXDJZsBpzwEEonNRHTNSFmW2KyICiRXH42DpJYqA0ylxL1A2IkPY4+
   Wkyf7g5wn19yGNNIDmEzzMlOFGDJkA/5IhzTVjlj7rD6PgXip7DIKVI9k
   7Dp+mvp9LJnUkstsSWHey0elL6FBEbWDYMQ4x0+9U9gumhUHGz7yS+dQg
   bf41tU2CyP71fK2qGchnQlM0lxwHOuvCr3k418zqTDT7TGv/Cv2y5ZJx8
   pzZbdMHZDzxIOmr7HhIPZ7hkioMcIglAyP26K0sI5+xt+brufHsJhwdi2
   ludP++MLGBk9RLxVMHd/kLG44A9+414ob5ErvX7N7Dx7IqnxIK55kAKjC
   w==;
X-CSE-ConnectionGUID: KMJdD5nuS9akRPnGR27HMg==
X-CSE-MsgGUID: W4Tyoa6GQTe8YdihJLa3AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="73030940"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="73030940"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 07:01:09 -0800
X-CSE-ConnectionGUID: KN3As6DRT4qD4KrQRTxh4A==
X-CSE-MsgGUID: fGf7C4b4R+GkTp6MYnaUaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="215729960"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 07:01:07 -0800
Date: Mon, 23 Feb 2026 17:01:05 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 4/5] i2c: davinci: add support for setting bus
 frequency
Message-ID: <aZxrsTXVZpgRy18X@smile.fi.intel.com>
References: <20260223-i2c-mux-v7-0-ec75b214718a@gmail.com>
 <20260223-i2c-mux-v7-4-ec75b214718a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-i2c-mux-v7-4-ec75b214718a@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 03:33:53PM +0100, Marcus Folkesson wrote:
> Populate adapter with clock_hz and set_clk_freq to enable support for

.set_clk_freq()

> dynamic bus frequency.
> 
> Remove bus_freq_hz entirely and only use clock_hz instead.


-- 
With Best Regards,
Andy Shevchenko


