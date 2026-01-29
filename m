Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1A433ADB8;
	Thu, 29 Jan 2026 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703245; cv=none; b=iHI5j+M8CoDuAcRnUb1Tuh1lAD8fWP2rFy9AMDINVC2fFQNYLXP0yofzHXYwEq264gDX0CNIcySZvJfauKIf2VbtJOxKav6ojyR/ra/o8rlxZ2w43qs2jXWJE0kcOG+MyOq12Rw/ohivu0dxrH0JO0NxDA1PtmRXe91qqNVUdQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703245; c=relaxed/simple;
	bh=qPHPxNpWWMDsGxyMBTnvxI4E48w2EhAOUYqVNBC3rCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atnDKhzDwYRH9DpMnEAnHZ7K14VSlX/X+pCO2a8XbWOewCkozoKm7rUskDZYPAb0nHTFeaRNkJ19EX0Gie0uC8I/6PuPDkL1Mnxtc4NXO9TimvlmUAECQdNK7eVbuuISZ6rcAy8fAub7nrh+6SUdRFr/N0qMVXYWf4zLvs8uwhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cz86Urx1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cz86Urx1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A02C4CEF7;
	Thu, 29 Jan 2026 16:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769703245;
	bh=qPHPxNpWWMDsGxyMBTnvxI4E48w2EhAOUYqVNBC3rCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cz86Urx1igiIQvTFTGutmwPdZkymvZ6zyMF4hl10hrKUhIi08rZfeK0wzyh9huT5j
	 O02Ux4L1rjmNPwqTQcisZ0vIsEwN26pxyNS3f31UzLxlFYXIlIBewtJTNcMm5iBQ6f
	 Zi1IHkHBphI91FBI0Ckujkeq1FueMncKbQ5aESt9iOEn/XQNnmcQK7Zcf4lTvK7y8k
	 IOG23yFPUwhCHvx59ke9GuNCRXfgm19WA6RrRO5fiRbym9M9bAAL4lZKSvB8g6YhCV
	 51bW9CoQgHMhDLQ1UrtCNf5462F6QTiLRzK0N/eM2F01Y9h5wTpVtIRYXit5VPxdxp
	 3/9N3OYPx+LpQ==
Date: Thu, 29 Jan 2026 10:14:04 -0600
From: Rob Herring <robh@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Michal Simek <michal.simek@amd.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Andi Shyti <andi.shyti@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, info@mocean-labs.com,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/7] dt-bindings: i2c: xiic: make clocks optional
Message-ID: <20260129161404.GA1118793-robh@kernel.org>
References: <20260127-i2c-xiic-v6-0-e82e2f6f657c@nexthop.ai>
 <20260127-i2c-xiic-v6-1-e82e2f6f657c@nexthop.ai>
 <20260128-remarkable-airborne-chihuahua-a1a16c@quoll>
 <66c7435c-a936-413e-a016-c860d448c971@amd.com>
 <fc00f8cf-b566-4694-82fe-76010d2f7c78@lunn.ch>
 <aXog-KBw7Bp-VEC4@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXog-KBw7Bp-VEC4@smile.fi.intel.com>

On Wed, Jan 28, 2026 at 04:45:12PM +0200, Andy Shevchenko wrote:
> On Wed, Jan 28, 2026 at 03:34:02PM +0100, Andrew Lunn wrote:
> > On Wed, Jan 28, 2026 at 12:21:41PM +0100, Michal Simek wrote:
> > > On 1/28/26 11:37, Krzysztof Kozlowski wrote:
> > > > On Tue, Jan 27, 2026 at 09:03:55PM +0000, Abdurrahman Hussain wrote:
> > > > > The xiic driver is designed to operate without explicit clock configuration
> > > > 
> > > > And if you change this in the driver, then you change bindings?
> > > > 
> > > > You miss here explanation based on hardware - how does the hardware work
> > > > if nothing ticks it clocks?
> > > 
> > > Hardware obviously have clock input which needs to be connected. Without it
> > > it won't work.
> > 
> > Should ACPI potential limitations be making the DT description less
> > accurate?
> > 
> > Would it not be better that the driver has an DT binding and an ACPI
> > binding? Where there are common properties, common functions can be
> > used to retrieve them. However, if ACPI lacks usable clocks, use the
> > of_ method to get the clock from DT, and skip it for ACPI.
> 
> Why should we use of_ methods? If this is required we can check the type of
> fwnode and act accordingly, but I think this should go deeper into some
> treewide available helpers, because now some drivers repeat the mantra.
> 
> But how do the driver get the clock frequency (if needed for some register
> settings and/or calculations)? DT seems to have well established property
> 'clock-frequency' for that. Can we consider it as "ACPI binding" as well?

Well established and somewhat deprecated. Generally, 'clocks' should be 
used instead. There are some exceptions like I2C buses here to set the 
bus frequency (or max freq). We probably should have used 
'bus-frequency' in this case, but that predates me.

ACPI can use whatever the ACPI binding maintainers want. If you know who 
they are, please let me know. :)

Rob
