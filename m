Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F5F34C130;
	Fri, 13 Feb 2026 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770975017; cv=none; b=ACpl+X7SM1wQiaq1hZS+U5bAzjbSHsa/uo9JZbTaBvQBNnWYS5/Hgy8ZoJKJUXAD7i2iSKQd/DLsrCg7PecFURSVKKJRn3p80Kzun8IwSbKhETyWeze+k+dshE0wmNqYb6o6Wlo6DPPFq31ANXnyMN8dhQ+MLA8UTKQnO4EnKWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770975017; c=relaxed/simple;
	bh=J0bcRfH5Z4TISZ7oetitXov1i9wHdjUAj8HdvDE9waI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROu6v2UThk+P4ubMr9QEAHuXu63uTjcwDRxyLhMtSQyEVIF5jfZpv1YNLGHJWwnE+ZOOywlAEpuxX+uQ6qt2cyKoOcurXN2R3AOql4KNTL+XFWExW54Cvjgd0pIDm0iOF45rc9s4lbHX/GYj4/J25Ccdqn2kJB2GVPSiEiXoMIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S/Dainof; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S/Dainof"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770975015; x=1802511015;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J0bcRfH5Z4TISZ7oetitXov1i9wHdjUAj8HdvDE9waI=;
  b=S/Dainofg+3+q8TpZhPhIqfhYCGhCvlIjlqOKBh0aVBm9sYu21WYMs/L
   6xBTB3Avz2FNMZ3nStndM7F/dDQv9V8Ps3MlddwReJTZk60FPgh3FgXP0
   ZP6bpQqsWkFPNNTEkc2GnZ9feTnHhatXZhm49q2QMYv+PgoAyWtD3QwPA
   w/HV3uLAT8PyZUQwjPz7ra2whDdp8oV6uOcaydGG1RTn/1m72tnhF3lgc
   /p3eKbIU8/In6uorLuiUHn5PzzwoI8stPhb7SuTfcKknv1bTgWMkSlQXQ
   4CNapbxCqYp63dP4SgComrQeDm8t6UpmqV2wh2FEu6kL4uMzEmri5jTZk
   A==;
X-CSE-ConnectionGUID: 52soXqsjQ4SkTZ2SGCvBWA==
X-CSE-MsgGUID: mYeVQ8DqSTyA6r1ZL7JU3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="83526416"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="83526416"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 01:30:14 -0800
X-CSE-ConnectionGUID: 4vkFDKhCRsWVrissVOAFcA==
X-CSE-MsgGUID: N2UG2pWZR/Ok/wsI2L+FXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="250543332"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.242])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 01:30:11 -0800
Date: Fri, 13 Feb 2026 11:30:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: abdurrahman@nexthop.ai
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v11 6/7] i2c: xiic: use numbered adapter registration
Message-ID: <aY7vIXNqZgoE_gI0@smile.fi.intel.com>
References: <20260213-i2c-xiic-v11-0-5d18aea11bde@nexthop.ai>
 <20260213-i2c-xiic-v11-6-5d18aea11bde@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213-i2c-xiic-v11-6-5d18aea11bde@nexthop.ai>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 13, 2026 at 12:15:21AM +0000, Abdurrahman Hussain via B4 Relay wrote:

> Switch from i2c_add_adapter() to i2c_add_numbered_adapter() to enable
> platforms to specify fixed I2C bus numbers via the platform device ID.
> 
> This allows systems to maintain consistent bus numbering across reboots.
> On platforms where the device ID is PLATFORM_DEVID_NONE (the default),
> the adapter falls back to dynamic allocation, preserving backward
> compatibility.

Assuming that the statement in the last sentence is proven and tested,
code wise patch LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


