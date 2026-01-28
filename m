Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCA5258CE7;
	Wed, 28 Jan 2026 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769610864; cv=none; b=IWtIOLy50endBMIIT0Zb5SnPOIQaj93wH0HNNYFendnGTP+RquAdSouLnxj0wIWkUhx7jQ9mJzgPNAKNMEOMFHWi6RW/tc+AWIr6AIghFYg6iIZlTOTb2C4HjSk00YIkFzFVfjqCh+vt1DCUBai36uZRk2ZjRWpC+V4WT7aKyF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769610864; c=relaxed/simple;
	bh=kVw+QdJGRCIjZDTvU575OdqlXNU+VNQT1A1rsbmrP+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJLUkSdE4UH+ad+Pulp5a/HdJql4HP2WoeC03b2prxeKgSmo4iiQVEh1rR7biypkVsSFn6sXnrKphoO8apo0R2NmqlSI5FnFtffd6L5E2g9IVgWcDEWsICio77JVlP9APDvPFMwaIiS7dgIvaXglOMoggJOGtbI+q4qp8Gwydb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Jqd63wam; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Jqd63wam"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2VhMoCs8T6Tzt4R6FnUGRsdZDOhvxg9vusVkkhl7NE8=; b=Jqd63wamWs5CSiGZAR11jjhdNe
	cZQLYkDv6jK4htGKRqG2qxUODl+86JluF3ndSWj/4zZcvApO+xXhyL0Zve00rJZc/RF6b5t+qbcYB
	tD2JU+D8/L8b4o7EPOJktlWKQ4RYLb+7AVvAja6MI3OARzkBiD5f2VhXNiXOwtEL8tqc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vl6cM-005CMM-6D; Wed, 28 Jan 2026 15:34:02 +0100
Date: Wed, 28 Jan 2026 15:34:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Michal Simek <michal.simek@amd.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, info@mocean-labs.com,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/7] dt-bindings: i2c: xiic: make clocks optional
Message-ID: <fc00f8cf-b566-4694-82fe-76010d2f7c78@lunn.ch>
References: <20260127-i2c-xiic-v6-0-e82e2f6f657c@nexthop.ai>
 <20260127-i2c-xiic-v6-1-e82e2f6f657c@nexthop.ai>
 <20260128-remarkable-airborne-chihuahua-a1a16c@quoll>
 <66c7435c-a936-413e-a016-c860d448c971@amd.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66c7435c-a936-413e-a016-c860d448c971@amd.com>

On Wed, Jan 28, 2026 at 12:21:41PM +0100, Michal Simek wrote:
> 
> 
> On 1/28/26 11:37, Krzysztof Kozlowski wrote:
> > On Tue, Jan 27, 2026 at 09:03:55PM +0000, Abdurrahman Hussain wrote:
> > > The xiic driver is designed to operate without explicit clock configuration
> > 
> > And if you change this in the driver, then you change bindings?
> > 
> > You miss here explanation based on hardware - how does the hardware work
> > if nothing ticks it clocks?
> 
> Hardware obviously have clock input which needs to be connected. Without it
> it won't work.

Should ACPI potential limitations be making the DT description less
accurate?

Would it not be better that the driver has an DT binding and an ACPI
binding? Where there are common properties, common functions can be
used to retrieve them. However, if ACPI lacks usable clocks, use the
of_ method to get the clock from DT, and skip it for ACPI.

    Andrew


