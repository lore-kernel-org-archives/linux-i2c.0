Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BFF25D216;
	Sat, 31 Jan 2026 10:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769857056; cv=none; b=kYN9BgxeE5MWMxzdIbm+cO9+/mIsUf5H0FbOJblNK3KFYphpvsRCGzYKpZgNgsvVAaY/SkI/Je0RJYxGbgQVlSpLeDrUKUZB8j6haqNEu/BPW/A7DU4S/M4cOIoixRPxPiNZT1eICW24APfkHBaenFO51pfHPctszezqF3Kouhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769857056; c=relaxed/simple;
	bh=3ctKiyNg4ambyWt7fnVocvftWSiDr2Re2IDPMzawjaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZK+I9xqI6gn9/uUelJRAmYdJooa/rwpKVv7+HpiF6Yss4jhBb6CyC8sCfyqeVdtmFqxXX5Y22c4qVtJqywZ+BhioXCBQPERzhZLC/2bYhlPElo5NmoIYdVIAIVNFnQgdme3s29FsoGYTLrOa/D8UMTikJmM6OIZDMpbWyw8aOK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jU4YbmkQ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jU4YbmkQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769857056; x=1801393056;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3ctKiyNg4ambyWt7fnVocvftWSiDr2Re2IDPMzawjaA=;
  b=jU4YbmkQByfX9OvjMZB8JWUSC+5oyYfuHZ71KMNP3TgugPNkGPwVmR1p
   Ru9AIejBu9TwZIVHwMOcHc5ScT0mQf1TrgUGs/K3EnxddoKZAUHq3TGWx
   t5kiqyfQAxVUHpxr0MmO/Hpucj1OP10o8B305NbRZgIO5+6gNkvTVsfIr
   GXprBxRn47XQCe36FqQY1TlcyJMriAk/cVGF75GLF/oXRoM/sZrKRSyVa
   MRkAJYwKi9KA7FuNoRds5pgUfLfjSYHriygv54Y5Eq19qIe2IXP2DKfpg
   1pgtSJtFj9GQs4TgRaTadFqzvGtIdtWgvOOOnD1Zw9SM7NU9l7x7rG5d7
   A==;
X-CSE-ConnectionGUID: 6DAn7/s2SVSYi6fTaZOe6g==
X-CSE-MsgGUID: LjfIxkGmSHKUyRkRF3EXQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="71003727"
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="71003727"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2026 02:57:35 -0800
X-CSE-ConnectionGUID: 7OLvNaPdQF+ihKc+/98WBQ==
X-CSE-MsgGUID: uxRy37pdR1S6Od9dDDT+CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="213964787"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.97])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2026 02:57:31 -0800
Date: Sat, 31 Jan 2026 12:57:29 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: abdurrahman@nexthop.ai, Michal Simek <michal.simek@amd.com>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 0/6] i2c: xiic: use generic device property accessors
Message-ID: <aX3gGYnBnA8otdMr@smile.fi.intel.com>
References: <20260129-i2c-xiic-v7-0-727e434897ef@nexthop.ai>
 <ec8693a4-e982-4227-9558-0b1fac543e62@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec8693a4-e982-4227-9558-0b1fac543e62@lunn.ch>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 29, 2026 at 11:36:20PM +0100, Andrew Lunn wrote:
> > Skip clock setup on non-OF systems where clock cannot be provided.
> 
> I think 'cannot' is wrong here. Non-OF system technically could
> provide a clock, using whatever binding method they use. Not having a
> clock simply appears to be a limitation of your implementation.

Abdurrahman, can you rebase the series to move DT and clock changes to be the
last in it? This way we can move forward with the cleanups that have no
objections.

-- 
With Best Regards,
Andy Shevchenko


