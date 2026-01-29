Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6261D2C3256;
	Thu, 29 Jan 2026 22:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769726635; cv=none; b=N5TbOIhOh8ZBAK5mh+2wWAj5+NHm+axEsL8NvXTekKT5Gvbxy3LVeaalnk1i0/WBYkqQw6QSOLLLqREsJFOeyemxbZ0Uo5FbSfxlaRIQvy7vSgWYtzfZLVB1JSBdo59DxGJxfRzlEOANXJmrLvOFfqCKd83MZNM3BB+X2wDOHj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769726635; c=relaxed/simple;
	bh=LfaqgqNCcHK0zoZesJW76AFCFitVV4pX17hSuqEq8ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snzGZzZMaK4oUfoRL77xkO1z9vmDfEeR+k9+lwAKyQOgXxuEXtcAFHLEDD7MFszs4Sm4oeTL6ra6xpQvC+oEcGzaSq+duHJ42CJ7wJ6LQa1VV9SJCWiXa+2FE+ZOscPDpZMuLnBvmmBg+Z/p2ibmxtUBJrOvKDoQH0RNMagy9uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pDvDIRUh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pDvDIRUh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bKLZ0w1FYI1K7rdVU/IfNX2bi5AgxvocffDhnuwufoI=; b=pDvDIRUhZ5TcZe8c5n49cAeQLG
	n2RwXdk7oHFTFP/nuAX1xKQHRO0B+X4XgirvMmfVSHvpQXxBZHTy6BXpNENXs4tYfEVRXEAYtQ9GH
	Y/+8VQGM503gqGdi/INyMYRdJGGsgzhkC9+SZ3kXdtA/eO8dCKTqH2GQbqo0nAbFF3+A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vlajp-005PxL-Oa; Thu, 29 Jan 2026 23:43:45 +0100
Date: Thu, 29 Jan 2026 23:43:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: abdurrahman@nexthop.ai
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/6] i2c: xiic: skip input clock setup on non-OF
 systems
Message-ID: <ab9dc191-59c1-40a9-bbf1-e6c082af128a@lunn.ch>
References: <20260129-i2c-xiic-v7-0-727e434897ef@nexthop.ai>
 <20260129-i2c-xiic-v7-1-727e434897ef@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129-i2c-xiic-v7-1-727e434897ef@nexthop.ai>

On Thu, Jan 29, 2026 at 09:43:13PM +0000, Abdurrahman Hussain via B4 Relay wrote:
> From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> 
> The xiic driver supports operation without explicit clock configuration
> when clocks cannot be specified via firmware, such as on ACPI-based
> systems.

Are you saying it is technically impossible to specify a clock in
ACPI?

Maybe a more accurate would be:

The xiic driver supports operation without explicit clock
configuration when the clocks are not specified via firmware, such as
when the ACPI tables are missing the description of the clocks.

	Andrew
