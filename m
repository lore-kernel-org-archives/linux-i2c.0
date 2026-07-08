Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC043D8125;
	Wed,  8 Jul 2026 19:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783539441; cv=none; b=meuwlq9C+D+uUD9HmEzV/Sj1kTTXzlc9zQ8XKxp1ADjtHwp3ILK4cK/trFg0LwD4MYjEBZUqgFlrz8epYFlubTk+iX0PafcNK1/ri7cYdH5X09e+uSoJkwrA+Kz/mgZXyiNpWJSjAccGGc+P6ChxD9Ju5Y0xlI/gArWzKKPROD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783539441; c=relaxed/simple;
	bh=vy0hljr9IlKplzOF7YFnwyGpNmOwQ9rIA6BOUnYi+94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpsXNjBSRlrWk7M0eOHgdGYGt7V5Mgfb6KtSfDYFCk181Ywdo93O/c9nDtPonmD19b6x5SM6zzrcXRulXwzseUmVl9065l5wb3SnnetTVtEAibmEqCBJKzp52GTCWoOM2aZK1TN8K+HXzrjt6i0d7ZSwFignSDWDJeGfehOdA7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PvglZMf2; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PvglZMf2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783539440; x=1815075440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vy0hljr9IlKplzOF7YFnwyGpNmOwQ9rIA6BOUnYi+94=;
  b=PvglZMf2Xbj6suquxBavoxiJIklSftDDmzgbdkUe05ApQA9h7OQzGOjb
   trJxZKFvjbFwwrubmCV8cB9F68mCA17E+z/rbdiTLq7H8CYYaLY4Vrqmh
   Xr9H7znJssyeVySQmXWe3UTkDGOp1YzjEzQk989xvRdsryviNPbxSpw6j
   ToTRjs5ZcEPQA5BbLgdrq/4Wrh281RwFW/IKwaUAQRYyj5aV+ICLK35Mi
   6CeFC+kFE94hoH2vdYj+5yp0pQ7QyCQ9HiIAQW0j8RTRX9eZcpviPjNFw
   TdKYJrkyO22jHOTX252h8M1AWXpvDKe8FDmroaJC6pgj6Kob2N2QuUqlr
   A==;
X-CSE-ConnectionGUID: I6/Q2pHETyOH1vczz9kGyQ==
X-CSE-MsgGUID: h3LdxhZCTfmh0ylyUGWWzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84234725"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84234725"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 12:37:19 -0700
X-CSE-ConnectionGUID: q0VdNDk+S1G66pycizUskg==
X-CSE-MsgGUID: sjHt9dcISqKhxWkEm/hGGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="254478245"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 12:37:16 -0700
Date: Wed, 8 Jul 2026 22:37:14 +0300
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
Message-ID: <ak6m6srzX8dd6_nT@ashevche-desk.local>
References: <20260708-i2c-mux-v10-0-09dca03c8a15@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708-i2c-mux-v10-0-09dca03c8a15@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 08, 2026 at 02:16:12PM +0200, Marcus Folkesson wrote:
> This was a RFC on how to implement a feature to have different bus
> speeds on different channels with an I2C multiplexer/switch.
> As no major complaints on the design came up during the review, I
> decided to submit the series without the RFC tag.
> 
> The benefit with this feature is that you may group devices after
> the fastest bus speed they can handle.
> A real-world example is that you could have e.g. a display running @400kHz
> and a smart battery running @100kHz using the same I2C controller.
> 
> There are many corner cases where this may cause a problem for some
> hardware topologies. I've tried to describe those I could think of
> in the documentation, see Patch #5.
> 
> E.g. one risk is that if the mux driver does not disconnect channels
> when Idle, this may cause a higher frequency to "leak" through to
> devices that are supposed to run at lower bus speed.
> This is not only a "problem" for changing bus speed but could also be
> an issue for potential address conflicts.
> 
> This patchset has been used and tested heavily the last months
> on a custom board based on a da850 (DaVinci) platform.

...

> Changes in v10:
> 
> - Fix gramatics in documentation
> - Move {__,}i2c_adapter_set_clk_freq() to i2c-mux.c

Can you point to the discussion where it was suggested, please?
It was like ages ago (too many patches to review) and I probably
missed and/or forgot the rationale for that. Also if we move
to i2c-mux, why do we leave it in the adapter namespace?

> - Make set_clk_freq() return actual frequency
> - Reimplement idle_state (from earlier version)
> - Implement example on idle_state for ltc4306
> - Link to v9: https://lore.kernel.org/r/20260324-i2c-mux-v9-0-5292b0608243@gmail.com

FWIW, I briefly read the v9 discussion and haven't got the above move,
seems wasn't discussed there?

-- 
With Best Regards,
Andy Shevchenko


