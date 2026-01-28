Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3FC301717;
	Wed, 28 Jan 2026 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615009; cv=none; b=gfcSbNTkOv1AxZ7JsOvii0fO1Dis8MQr52bWE+w/tDwz5LGbj5SlDRbaRWvZJGfW9hCM0i6dMXV1VKcBsiKkgyH7883W0+n1W+PddxUt+QBgWpcQ8V98izBuDFXNqwDLF2jWAqg9AfjIGbXJHk+zAlfE3Y3ul6YqRH3qVbR2D3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615009; c=relaxed/simple;
	bh=KQSgejY1A/+GDVs72frruYIXekaBlGtguMeTaoWvT3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mU8fytGAWi6sHzq1iyBH4wj+nrVlFWPCYYzL6y69IhgBQ/v+fRVeOXR4JWMMdMe8/cdJIxeen3DA2QHIgaDTumgEZ9a0GJPrhadSEmEm0Igjgia+eWF6zZVDfdcj3aLKkzgkqbIL1YDempaSUy9mXOh9pOPzxI+9P4CuFSrm+i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LEYerdTu; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LEYerdTu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769615007; x=1801151007;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KQSgejY1A/+GDVs72frruYIXekaBlGtguMeTaoWvT3Y=;
  b=LEYerdTuuSaznBkN9+1sNU1W2ZCFAX1PreVXRF8gwIvviAc9UeyOPazm
   w2DMYXKq+Z5cx8dT+P2x/Kkk5AJkkj9ImrK69/NokdssSbMFmCCXgivgl
   e+4RlKAuR6AiHQxXS11uHsWh9Dj5KX+DuH8t9oWRTxf3Zk4gYdE97J/DN
   UJwbtMIR9luWmaT27m2AUJT5bDJJhZozK3sJxy5VWDoLlMVK4no+qbFfs
   4oiOpCwijxC+xUb/lJdT23lMYPmuT4HM70fBdY9NJiarZ7b57oHH9lXdn
   L2Wzgc0gQ+KYmpDb2lr7+UaTIuaDl54XwmJO9oM76X19xEARLto6Ig80I
   A==;
X-CSE-ConnectionGUID: +NYBBRYCSi6TH3hMaxdAsg==
X-CSE-MsgGUID: X7fuzfncRky13C7Q6o3sYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="70029621"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70029621"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 07:43:25 -0800
X-CSE-ConnectionGUID: 8iZq+VOyQ4u7jfUKW3qguA==
X-CSE-MsgGUID: yYbDE6b3S8yn2waeuq0EFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="208735649"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.57])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 07:43:22 -0800
Date: Wed, 28 Jan 2026 17:43:19 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Krzysztof Kozlowski <krzk@kernel.org>,
	Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, info@mocean-labs.com,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/7] dt-bindings: i2c: xiic: make clocks optional
Message-ID: <aXoul5n9sA1UmqoS@smile.fi.intel.com>
References: <20260127-i2c-xiic-v6-0-e82e2f6f657c@nexthop.ai>
 <20260127-i2c-xiic-v6-1-e82e2f6f657c@nexthop.ai>
 <20260128-remarkable-airborne-chihuahua-a1a16c@quoll>
 <66c7435c-a936-413e-a016-c860d448c971@amd.com>
 <fc00f8cf-b566-4694-82fe-76010d2f7c78@lunn.ch>
 <aXog-KBw7Bp-VEC4@smile.fi.intel.com>
 <5dc423be-c1f4-4a59-abcc-807f63b25f3f@amd.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dc423be-c1f4-4a59-abcc-807f63b25f3f@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 28, 2026 at 04:00:30PM +0100, Michal Simek wrote:
> On 1/28/26 15:45, Andy Shevchenko wrote:
> > On Wed, Jan 28, 2026 at 03:34:02PM +0100, Andrew Lunn wrote:
> > > On Wed, Jan 28, 2026 at 12:21:41PM +0100, Michal Simek wrote:
> > > > On 1/28/26 11:37, Krzysztof Kozlowski wrote:
> > > > > On Tue, Jan 27, 2026 at 09:03:55PM +0000, Abdurrahman Hussain wrote:
> > > > > > The xiic driver is designed to operate without explicit clock configuration
> > > > > 
> > > > > And if you change this in the driver, then you change bindings?
> > > > > 
> > > > > You miss here explanation based on hardware - how does the hardware work
> > > > > if nothing ticks it clocks?
> > > > 
> > > > Hardware obviously have clock input which needs to be connected. Without it
> > > > it won't work.
> > > 
> > > Should ACPI potential limitations be making the DT description less
> > > accurate?
> > > 
> > > Would it not be better that the driver has an DT binding and an ACPI
> > > binding? Where there are common properties, common functions can be
> > > used to retrieve them. However, if ACPI lacks usable clocks, use the
> > > of_ method to get the clock from DT, and skip it for ACPI.
> > 
> > Why should we use of_ methods? If this is required we can check the type of
> > fwnode and act accordingly, but I think this should go deeper into some
> > treewide available helpers, because now some drivers repeat the mantra.
> > 
> > But how do the driver get the clock frequency (if needed for some register
> > settings and/or calculations)? DT seems to have well established property
> > 'clock-frequency' for that. Can we consider it as "ACPI binding" as well?
> 
> "clock-frequency" property in i2c is used for selecting i2c speed 100/400kHz.
> 
> Clock frequency in this driver is about describing clock coming to IP itself.
> Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml

Ah, I see, then is_of_node() probably is the compromise how to deal with
this setup.

-- 
With Best Regards,
Andy Shevchenko


