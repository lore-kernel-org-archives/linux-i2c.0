Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32373EBF29;
	Fri, 23 Jan 2026 19:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769196021; cv=none; b=k8uTq0k7Btqci7aSQ6vbGkiHUDjaJcMjSGl4wouVYI0S4VmpBgOmnDNxx7FBVo/CZ1VgQf6vkTWE9e4KjWy6LkLjCtosZ5dbgniJW11kSHTmWq+dm6EVMXoHRMDpxLPPcTFD5vuK2DxXOoCQFuV4ddc4AWm9lg78CBs3On+C1R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769196021; c=relaxed/simple;
	bh=0ggcUNHOTP4iZjPCnKneAI/P16zXSRlCmgLVygPxYds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twE1Sew/r4fwPJO1ENvZciORHO8ZC1KStZRa3iNLPwRn1ZaG6mxt4cz09uvBvkoeVyiDqmLxfHU/7OxvM7XpjJStp4noUEhKQip80N7HTO+Jjk9G0XQ7nFHVscOK+w//wix1sSJVXdQ5XIWcGxLnyP8IJ5U9iiHoIQV4vOboAdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ezQCvFrB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ezQCvFrB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xHQm9bnj1/GWAjCCnA6ZzBSntz/5N/YkgHq/jkLFlJY=; b=ezQCvFrBQAwEGfeDquY1GLsHj1
	VnX8WQIMn6wAdU/CCFhND+hibxrqTszjnCygPfseBKvrt+OQHdPKDODF/PA7mT1abxDoO3+lTaaHO
	Tc/8YO+3bjoHQMNfAHwD00yU6fHWrwy0oJDM8iRWv83PpH1gdzunpG7fV+9qsw60n//Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vjMhS-004J3v-Gm; Fri, 23 Jan 2026 20:20:06 +0100
Date: Fri, 23 Jan 2026 20:20:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: abdurrahman@nexthop.ai
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] i2c: xiic: make the clock optional
Message-ID: <df9e1a39-3928-491a-920f-fd45120d8024@lunn.ch>
References: <20260123-i2c-xiic-v3-0-eb7cd4254dfb@nexthop.ai>
 <20260123-i2c-xiic-v3-1-eb7cd4254dfb@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123-i2c-xiic-v3-1-eb7cd4254dfb@nexthop.ai>

On Fri, Jan 23, 2026 at 08:02:44AM +0000, Abdurrahman Hussain via B4 Relay wrote:
> From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> 
> The xiic driver is designed to operate without explicit clock configuration
> when clocks are not specified in the firmware. This functionality is
> already implemented in xiic_setclk(), which performs an early return when
> either i2c_clk or input_clk are zero:
> 
> This condition is satisfied when clocks are missing, as clk_get_rate(NULL)
> returns zero, allowing the driver to rely on hardware-configured timing.

https://elixir.bootlin.com/linux/v6.18.6/source/Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml#L42

The binding indicates the clock is required. You need to update the
binding to match the code.

	Andrew
