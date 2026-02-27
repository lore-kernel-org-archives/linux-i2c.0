Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A843E36AB76;
	Fri, 27 Feb 2026 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772218294; cv=none; b=ZR0w/r612HgKjsQgsTMApL9hqV5BMEfJGkC65cIu/BQ/BwQG42fGyybqSqgCDqvxfPb3kLxqzSKXZ4ZRgOf5HewYVBugwFG7Vy0yswgwweTL+hFDVRNyr22X9NOgKpFctht0aL6TNvGoehZAHUw1n7tt2B1vZyJUiZGooH/e1g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772218294; c=relaxed/simple;
	bh=U1htMu6zJAZkuEe4UQH5YZb61BCeD2dg/oP1NLQyJmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWNO2SX+RTm+Llo17mLU9F9RXyNpBaW9F32Q2ZI92HNstHVkI60FYhzRrj2Q35UYZklxLdM7CuZURrfV2+d03lDeeyy2c6GbmxB6N3GZ9NvrE6q9UHe0M0BmN9rJS8dXqaaalT+jD9nQfcjc8jlkUgQ/8K2qIWorQFQ7a9+Sh5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pst27Q8T; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pst27Q8T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772218291; x=1803754291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U1htMu6zJAZkuEe4UQH5YZb61BCeD2dg/oP1NLQyJmE=;
  b=Pst27Q8TcHQ3CcNzZdLcBdTN9WtkAtdl3oatsPgmauQSL8REE58Sdq4E
   Kzln5H49wn78w54a2T58vSXf9tU9wJEi9ANX5oeAYXXs+R2Vrz0ivnwD7
   xhUMTu3h6J5HmBxhh1FNmoJXiQ8HtApgVzE9RecLFoqk8coRr+8L4+kAG
   J59szw0tkRd87PRTyz5LZ5o8x+0Cerro0BsgUH08a+V1cyEpy4rPwKjnC
   ZxP7/7DbZX0G9Uag4YGobUSXQyOAAPTlU7jgL9yVrreO7S0mEVfyvH5by
   2T7LCUA2v2iADvE+ZrimxFdtcmkBcEYfyRd0fCCpCrs9QVBgjL6VhVUHo
   g==;
X-CSE-ConnectionGUID: OpjhLwraQNWjHcPRYb+N7A==
X-CSE-MsgGUID: eFD0sA5gSkOuFXYfYxj2Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="95927701"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="95927701"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 10:51:31 -0800
X-CSE-ConnectionGUID: +IOGpHDHRLmciF5JpjP1Vw==
X-CSE-MsgGUID: aTYHNSvzTvqv6sXxjg7o3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="221960845"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.180])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 10:51:29 -0800
Date: Fri, 27 Feb 2026 20:51:26 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Moritz Fischer <moritzf@google.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, mdf@kernel.org,
	ovt@google.com, Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>
Subject: Re: [PATCH] i2c: designware: Add a new ACPI HID for GOOG5000 I2C
 controller
Message-ID: <aaHnrj0onxlxH5D0@ashevche-desk.local>
References: <20260227182308.776922-1-moritzf@google.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227182308.776922-1-moritzf@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 27, 2026 at 06:23:07PM +0000, Moritz Fischer wrote:
> Define a new ACPI HID for GOOG5000 as used on Google Axion.
> 
> This has been validated on Silicon.

> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Jan Dabros <jsd@semihalf.com>

Please, put Cc list...

> Signed-off-by: Moritz Fischer <moritzf@google.com>
> ---

...somewhere here. It will have the same effect on the email. But the positive
outcome is the noise reduction in the commit message.

See also this discussion (patch 18 subthread):
https://lore.kernel.org/lkml/20260123113708.416727-19-bigeasy@linutronix.de/

>  drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
>  1 file changed, 1 insertion(+)

...

> +	{ "GOOG5000", 0 },

The ID seems legit, but we need an ACPI excerpt from DSDT to show how it's
described (just important pieces of the respective Device() object) and better
reference to the device / platform in question: Is it already on the market?

-- 
With Best Regards,
Andy Shevchenko


