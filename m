Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881922882CD;
	Wed, 28 Jan 2026 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611520; cv=none; b=d6jgaWDKiHyBDbWafMFEzcamekVWtaGOiOr721UMbvFjEVUsmK/RCK3HN/5dE1J/PspxLPLT1HmLkOa2cdXoHNq6e22HnPNiznwczzUmN174ohA89vQgmfkYPGuqMvtSTp4efmXwsEzbAEAF7/Xlkuv7ccraBo+varh1+L37c4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611520; c=relaxed/simple;
	bh=/Noec6um4sg420tnSvek85Gdh+vG/B7APWADS2BN5M0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFQJtG590PvHiZ0VjDBvlUvRqkwU1tC4Tte6eRBUrI7H3EyA3YdiJM/8xozXcUuuW7kGy0o6/LkNVJyIFacWweFSorzuseOfRd/rCCTz98nGbJoL2Wh3DBlHBImLQe1SbcnRM5IlQ3o0BKBh0TP2Gs8N1RqaIiWBmrS/EaXq+6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YV/0nosc; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YV/0nosc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769611518; x=1801147518;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/Noec6um4sg420tnSvek85Gdh+vG/B7APWADS2BN5M0=;
  b=YV/0nosc+apQunuw97lymYfJEH0YUr7XUPX0xYYge29icHOuz5mmo0r4
   SdTatftWFdzwZfD794cfqWKCef74ACVb0B/umBTNg0/jQfgVkavmFtPDY
   qrmaj7Ssl51JeWehHUqQ9vsoT1ZJRRBjeVcylFrhSusl+2/lv5+xY/EsY
   OmLaq2p7sCG/nSDmptJomFSaj4SoHv+VtQnI/X4o8KDN+4SUpLQX3+SdH
   M+mSif3+NfECqcVcHX9t0EelJd7gsAOI02Rfz9yZ2RMbsOnrdChtxwJ6h
   XRa78zAbTnWZLdCCDE5nJvru9QNPO2CMjgkxWcWBi9iCp/2p+vg/FaAYX
   A==;
X-CSE-ConnectionGUID: 4s3KWQGESSWOOlQoAj0E3Q==
X-CSE-MsgGUID: 67Onsne5TVGY76zAEFPvUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="93482243"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="93482243"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 06:45:17 -0800
X-CSE-ConnectionGUID: 7dzyFWYbSqCVtXSpEEOFJg==
X-CSE-MsgGUID: V/JExwARRnaYBRB6yGznUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="207903992"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.57])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 06:45:15 -0800
Date: Wed, 28 Jan 2026 16:45:12 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Michal Simek <michal.simek@amd.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, info@mocean-labs.com,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/7] dt-bindings: i2c: xiic: make clocks optional
Message-ID: <aXog-KBw7Bp-VEC4@smile.fi.intel.com>
References: <20260127-i2c-xiic-v6-0-e82e2f6f657c@nexthop.ai>
 <20260127-i2c-xiic-v6-1-e82e2f6f657c@nexthop.ai>
 <20260128-remarkable-airborne-chihuahua-a1a16c@quoll>
 <66c7435c-a936-413e-a016-c860d448c971@amd.com>
 <fc00f8cf-b566-4694-82fe-76010d2f7c78@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc00f8cf-b566-4694-82fe-76010d2f7c78@lunn.ch>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 28, 2026 at 03:34:02PM +0100, Andrew Lunn wrote:
> On Wed, Jan 28, 2026 at 12:21:41PM +0100, Michal Simek wrote:
> > On 1/28/26 11:37, Krzysztof Kozlowski wrote:
> > > On Tue, Jan 27, 2026 at 09:03:55PM +0000, Abdurrahman Hussain wrote:
> > > > The xiic driver is designed to operate without explicit clock configuration
> > > 
> > > And if you change this in the driver, then you change bindings?
> > > 
> > > You miss here explanation based on hardware - how does the hardware work
> > > if nothing ticks it clocks?
> > 
> > Hardware obviously have clock input which needs to be connected. Without it
> > it won't work.
> 
> Should ACPI potential limitations be making the DT description less
> accurate?
> 
> Would it not be better that the driver has an DT binding and an ACPI
> binding? Where there are common properties, common functions can be
> used to retrieve them. However, if ACPI lacks usable clocks, use the
> of_ method to get the clock from DT, and skip it for ACPI.

Why should we use of_ methods? If this is required we can check the type of
fwnode and act accordingly, but I think this should go deeper into some
treewide available helpers, because now some drivers repeat the mantra.

But how do the driver get the clock frequency (if needed for some register
settings and/or calculations)? DT seems to have well established property
'clock-frequency' for that. Can we consider it as "ACPI binding" as well?

-- 
With Best Regards,
Andy Shevchenko


