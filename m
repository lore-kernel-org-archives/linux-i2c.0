Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6AF23909F;
	Mon, 23 Feb 2026 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771858442; cv=none; b=jRElpXUtuWmSeLjvnJSJFM+4cR+/RrbmIs++609u/YPPDSCQvErtkuPyJssU119DptrL5XmoEgXAdznEEjR7r6qq+v9ZDAQGxREyzbaj0nJgpH2JbndczhPomGUwqqqkeKqwgPc8hpQPjTqwsVqH88ASOhZwjfZVk8806dVZKFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771858442; c=relaxed/simple;
	bh=lKSI3fNmZ35AjEPR2S93P8vRyJRP+Lw9+ZmmDpvhR1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0V6uHhcJSN/iBm8ZJy0zpFzeR+elLEMeUWMkKp1hlXY8AjJOvq7x3HIYzu+sKWttP4LeQevS73J0nRb/hhtEpi1OqIl1hizTTiRSDJQNtUxvpNHaBymPHC9F/az832R51E8Wsr53AmCaJiKdxEKjHskmamr/gtJBet58Kq5iY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BN1ZAMFm; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BN1ZAMFm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771858441; x=1803394441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lKSI3fNmZ35AjEPR2S93P8vRyJRP+Lw9+ZmmDpvhR1E=;
  b=BN1ZAMFmDJbHY5NeFL9wxuEWShlj1zRXy+P/t3WBhPRxLsDX3nvbJJjG
   IgYO61S5CdmOInhBMxwAjcb+7KUv6BhCBT5Nu1UYkeDRlWJKutzOrlNo6
   e+rKpBwvt15YhC48CyI8UtNRsMSXdycldClEk3zYjRc/KrT9O5PuaX7G5
   /J4YJ0iyAVUlI0seQo/d1r7Oq5U3Uz4E1DTwhybGKgbXVzEkdI+gchC6f
   LwdzC8AIid6VrZjyC1iWgXP7qRTIL25lcGpPyP9FWGORbdB7pebzjxC6K
   8LChmD7pnY28g0rurTceaYdOKMng3uaHzNxe/PQZPPZvOLgDwT9x6NEbf
   Q==;
X-CSE-ConnectionGUID: SGhCBQkwTr6IMkiUl/zCdg==
X-CSE-MsgGUID: VdtqM4a6Qmy6sLxofeqR5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72893568"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="72893568"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 06:54:01 -0800
X-CSE-ConnectionGUID: CYc3oGXDRh2V11auPgHWmg==
X-CSE-MsgGUID: UrG81fSjSdWzjN+e9HqG/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="238553814"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 06:53:58 -0800
Date: Mon, 23 Feb 2026 16:53:56 +0200
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
Message-ID: <aZxqBOaFId-9WfnR@smile.fi.intel.com>
References: <20260223-i2c-mux-v7-0-ec75b214718a@gmail.com>
 <20260223-i2c-mux-v7-1-ec75b214718a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-i2c-mux-v7-1-ec75b214718a@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 03:33:50PM +0100, Marcus Folkesson wrote:
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

> +	/*
> +	 * If the adapter is a root adapter without set_clk_freq implemented, this feature is not
> +	 * supported
> +	 */
> +	if (!i2c_parent_is_i2c_adapter(adapter))
> +		return -EOPNOTSUPP;
> +
> +	/* Update the clock_hz for non-root adapters, even if set_clk_freq is not implemented,
> +	 * to allow * the clock frequency to be propagated to root adapters that do support it.
> +	 */

/*
 * Please, keep the style of multi-line comment consistent
 * and as per above.
 */

> +	adapter->clock_hz = clock_hz;
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


