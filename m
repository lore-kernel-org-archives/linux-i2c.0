Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4B422A7E4;
	Tue, 27 Jan 2026 21:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769549008; cv=none; b=WTT9dpbXlNOEmKqzQyszsNSAAv7a2hlCg06JJn0ofD3pfn6Uxmi3kPewNFKnPqyfE7om6cUplgipik65jggMgr0cXrsZTVJWurvm/wYcR7zZu9O6cQ5ojpHx+k7j4NxS3Xk/Q0/AA9se1PlcaX52X9LTyGO9/iT95598b10iT2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769549008; c=relaxed/simple;
	bh=j/bEiAaLxiyNGE+l2ZoC6cQsleLGLQuu/EyYdye+BFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oja9eRPq/HC1BE2jrnilSnp/KJkMJfoSC0X4/3YU4bQE6qSumEJHcRNZ0/Djo9PFwl+tL2KF/6jXqFdIN+aJPDKVNSknV/hABAN1esf3TyUZU1UZ00dd+g9xPczJYzcl7GTQC2BDn8YoxDr5EQdan2djby4kNOYbxRPqJtkCvZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H9t9G4L3; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H9t9G4L3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769549007; x=1801085007;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j/bEiAaLxiyNGE+l2ZoC6cQsleLGLQuu/EyYdye+BFM=;
  b=H9t9G4L3piz+h2nzAtpJKY0t7qQa2wHrKI+tBeRwcHEj45uabxP+Xq12
   o8QSWygm88LAe1SUipKUDRBhTu+jfS6AjyG4WuNoVacNBsIrzhRALOxiZ
   fN/gVwNLDlcR9r5ux5EfkuLovf19kNplmvAnt/WGqgeaLlmNCIDPgLiUS
   V3qdsaL6eZHv+dku4JP5r28q+PkcnXdstGduflCTC5L41BDJeNWVZPVN9
   CtJk4Mf0oKgTsZQG+8vsx0G88rHUfUVQL11xYK9Hk2hnly8KZ+9LCJwH/
   mmdakDfeN4hpYqB5snb/1GnHihzpa5AJxvAV/z6DKTzp3TCU9+XBsq/T+
   w==;
X-CSE-ConnectionGUID: jWDrYs4RTzuI1lHoCWVWnQ==
X-CSE-MsgGUID: S2BQvnfmS6KlvQeecGgAAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="74380482"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="74380482"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 13:23:26 -0800
X-CSE-ConnectionGUID: U0rKPD/dRZal4lvLbz2Yxg==
X-CSE-MsgGUID: JKAPTkMgQF+hD+HkK1dkYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="212628840"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.248])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 13:23:23 -0800
Date: Tue, 27 Jan 2026 23:23:20 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: abdurrahman@nexthop.ai
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, info@mocean-labs.com,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 0/7] i2c: xiic: use generic device property accessors
Message-ID: <aXksyEkisTZdiByx@smile.fi.intel.com>
References: <20260127-i2c-xiic-v6-0-e82e2f6f657c@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127-i2c-xiic-v6-0-e82e2f6f657c@nexthop.ai>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 27, 2026 at 09:03:54PM +0000, Abdurrahman Hussain via B4 Relay wrote:
> Switch to generic device property accessors.
> 
> Switch to managed devm_ functions to simplify error handling.
> 
> Make the clock optional since the driver is designed to operate without
> explicit configuration in firmware thus making it useful on platforms
> where clock is not or cannot be provided.

Why the heck you ignored my tags?!

-- 
With Best Regards,
Andy Shevchenko


