Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4023334F256;
	Fri, 13 Feb 2026 09:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770976790; cv=none; b=DmI8Hd/XOr29E1wLFLaSlnP2mIhxkF3xG/3ahAHrK1cxdEwg4ycfEo9t/33a0cUVSO5EB9DFHFvlQG9FIWTeupXj5z4oxkVQXFgXNzX1im9DeynC8amt/5xFhSYOS7/atHWFpoDNscHTD/+HQFzSAOQJchg7EY4uSVC7+r62M94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770976790; c=relaxed/simple;
	bh=g4Px+rF4j2zO6sLf5t/WktofEyLTwzxfotiEC9NhgjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xd03siPUL1hDnPxZJ7LG5HBCVmm0rdZNXX30nounMIywqQajs0umKXiKTQp33P33OmkKNf4IuIpSlVjGZ/GGnp4r5cr2SfxUMon5MfhqspKX1r/WqJalhO2/8YDIvHVdJRvT/s0FsALSYjkBHWodMh2ei68EiVydnh20wlpuUYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mPb2bzmv; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mPb2bzmv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770976788; x=1802512788;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g4Px+rF4j2zO6sLf5t/WktofEyLTwzxfotiEC9NhgjA=;
  b=mPb2bzmvdmP4Y5/joPRFjlLbGRITg55tyx5GGc7LCpx8cLUuFvKVR07x
   0BSJSLl/IKIDe9na9jGFSKn7MH2YoM1GXXM5w8UMcU+KkKdsmqxGoHJmC
   brzXUliYlnPDYKNKBvEJpod1zuRxaHPjv+bxfxnm3RYVlE8hWrvjdxwQN
   K+xK2cLAihZU/eQ22IPLYWt3TGFPwu5a7IA3OcARAVXmNU5iLGQYL95i8
   VXUIJoA2m0nV9njCgwiG/RFTSEfhkLu9U7vmc5u4EYx6iDnLMuheu/1TX
   CNG+Pv9Asc9gA5d7out26cEXlLpm5luFYQ7CGjr+JSqA1vb+115j3yLQT
   Q==;
X-CSE-ConnectionGUID: INJ6Kou5TC+juVFwl6FfKw==
X-CSE-MsgGUID: 7pA+dt7bRTelGoCUxNvH+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="89571124"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="89571124"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 01:59:47 -0800
X-CSE-ConnectionGUID: s7Aj24DqSn6NXPib4aGpNQ==
X-CSE-MsgGUID: UuvcFjcfS5+WPe/RF/REOQ==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.242])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 01:59:45 -0800
Date: Fri, 13 Feb 2026 11:59:42 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: abdurrahman@nexthop.ai, Michal Simek <michal.simek@amd.com>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v11 3/7] i2c: xiic: switch to generic device property
 accessors
Message-ID: <aY72DtP9qwGxhMLd@smile.fi.intel.com>
References: <20260213-i2c-xiic-v11-0-5d18aea11bde@nexthop.ai>
 <20260213-i2c-xiic-v11-3-5d18aea11bde@nexthop.ai>
 <738dbc7c-9915-4308-8e0b-388d6b73b067@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <738dbc7c-9915-4308-8e0b-388d6b73b067@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 13, 2026 at 10:53:40AM +0100, Krzysztof Kozlowski wrote:
> On 13/02/2026 01:15, Abdurrahman Hussain via B4 Relay wrote:

> > Use generic device property accessors.
> 
> You should explain here the impact, e.g. making them work for ACPI
> platforms.

Good suggestion!

This all probably warrants a v12, but please, wait a few days. In any case
we are in the middle of a merge window, not much activity is usually happening
regarding to patch acceptance.

-- 
With Best Regards,
Andy Shevchenko


