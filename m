Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F35D26ED28;
	Fri, 30 Jan 2026 05:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769751232; cv=none; b=GTWa8g/cuiUiOTVlhIbz44QBU3lVugIVeNOQG3uu44M9bScpmahMhUgSnKuSjWocmUHSyRLEsEuDXuEoP6b6bKSh2E4PEAx6zQ9cT4SgnJNvHpl3c2aHewzH/mFZKzt6LBFIj0rlgQ+rNLm8T8pl9ie9W7cjWHW0Ay4LZktZ7Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769751232; c=relaxed/simple;
	bh=Im+HvNbj0ndXZaZVUPje1i7Nrb7blygWvVN9bRfpCts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVs52i+upvwJFvKBNYLSDFnCEXPCpTWmisTMy/97TNt/jDvZr0ONjoRLhG1tTLaBtSNIbIibLUWKfYcxbYTNwuRDIRplqWAoEaNVdVPXibPg1wvGPxB/bl7umx/4nK4n2opZetyNpN029arbXiYCQcwMqSMGAkcWsqGaDU1RIwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hvIKQzNY; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hvIKQzNY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769751230; x=1801287230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Im+HvNbj0ndXZaZVUPje1i7Nrb7blygWvVN9bRfpCts=;
  b=hvIKQzNYwTdPQguKikfd7fiRclwTtUUc7QwfrvUTsZBg3ZGmrYO0n5o9
   VHiGOUBaDtSobQ8zaIbsHFiQdAOllwkPndlCv1HN74nusPEQ7pD7Lwi3j
   ePP4hUqsr0npW3Ii9tOz4MFY3tylyxOOvc6BToqTpAq+XK4whwnjIgDi+
   F8l2CRlC8dC1x602fGxpYmd346oPElQgwmxEBbdpBIB4aGlVC83crhaqK
   +uHbpd9ZanigRtsY7qti3xTucHL9cCZ5h30DUGaXqJ3wyIryQuQCbK6is
   F/BN19774ZvArBppI1cXgewh/mtHgvOmRn2HjbeghP1S2sMPxK7D26hgt
   A==;
X-CSE-ConnectionGUID: OMWsN4vIQuOvd2t+jMBMAw==
X-CSE-MsgGUID: KqFvuTaHRxWd99Fu7Boe6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="71036903"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="71036903"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 21:33:48 -0800
X-CSE-ConnectionGUID: SfVn35EeQP6FDwAlkmE0vw==
X-CSE-MsgGUID: sYVCc8fCQ++1lWOh6CTfOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="213298390"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.227])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 21:33:45 -0800
Date: Fri, 30 Jan 2026 07:33:43 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rob Herring <robh@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Michal Simek <michal.simek@amd.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Andi Shyti <andi.shyti@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, info@mocean-labs.com,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/7] dt-bindings: i2c: xiic: make clocks optional
Message-ID: <aXxCt6N0RyfgoC7D@smile.fi.intel.com>
References: <20260127-i2c-xiic-v6-0-e82e2f6f657c@nexthop.ai>
 <20260127-i2c-xiic-v6-1-e82e2f6f657c@nexthop.ai>
 <20260128-remarkable-airborne-chihuahua-a1a16c@quoll>
 <66c7435c-a936-413e-a016-c860d448c971@amd.com>
 <fc00f8cf-b566-4694-82fe-76010d2f7c78@lunn.ch>
 <aXog-KBw7Bp-VEC4@smile.fi.intel.com>
 <20260129161404.GA1118793-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129161404.GA1118793-robh@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 29, 2026 at 10:14:04AM -0600, Rob Herring wrote:
> On Wed, Jan 28, 2026 at 04:45:12PM +0200, Andy Shevchenko wrote:
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
> Well established and somewhat deprecated. Generally, 'clocks' should be 
> used instead. There are some exceptions like I2C buses here to set the 
> bus frequency (or max freq). We probably should have used 
> 'bus-frequency' in this case, but that predates me.
> 
> ACPI can use whatever the ACPI binding maintainers want. If you know who 
> they are, please let me know. :)

There is no such "entity" AFAIK, as on ACPI side we try pushing vendors to make
their efforts to bring a standard. Nevertheless, we have players, like MSFT, who
make decisions on their own (hence we have tons of "extensions" to the ACPI and
other specifications. Speaking of the standard, we have UEFI, MIPI and problably
others that have their own properties (but standard) and they usually use dedicated
prefixes (uefi-*, mipi-*). Also we have custom vendor specific ones, for example,
Intel in some cases (legit I suppose, as it's about Intel's IP) provides intc-*
properties. In many cases, though we have utilisation of the DT properties and
vendors more or less follow that. (Disclaimer: I described how I see it's done,
and not how I think it has to be done)

-- 
With Best Regards,
Andy Shevchenko


