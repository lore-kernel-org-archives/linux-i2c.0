Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAF82003A0;
	Tue, 12 Nov 2024 15:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731424442; cv=none; b=m0L/yIcyre0KnU2fgxAtsK+Wy3CTAJfauZ3yLNjmzvqFI4VLi+tqLORxOuj/2ejLRoMZaxpolD3VKnLkBGrGt+r1xkbdsFte1PEaPjYAdAEcUa4K5pT9Vxw6jWnj6YhNWtNz0kScMXvwMqjfonk5T/4lNZHSYyTJBB4Sk+ykmq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731424442; c=relaxed/simple;
	bh=HU7xQZHVLo7mJxnU+OBgtHpRxQNpBqipDKG4HfaQa0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSvR/xMlW+T0fW01UJcEe0joErDHbJvmD4cwDatDo0WKdMVWuCtqE9EOD5hnf5H1KZxjVnWu64VkA6TVgRP5Ter24yXw/nZOdcp1O9MZ4Uatu70+dfZqPC4HrkrTFw/IDWYjjaV9RO+BqXpsem7Dh+MsnyitB95pl9khljlC+hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1tAsVf-0004rR-00; Tue, 12 Nov 2024 16:08:51 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 6E7E7C0110; Tue, 12 Nov 2024 15:56:10 +0100 (CET)
Date: Tue, 12 Nov 2024 15:56:10 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andi.shyti@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v9 2/4] mips: dts: realtek: Add syscon-reboot node
Message-ID: <ZzNsiu+rbYs7l9Wb@alpha.franken.de>
References: <20241106001835.2725522-1-chris.packham@alliedtelesis.co.nz>
 <20241106001835.2725522-3-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106001835.2725522-3-chris.packham@alliedtelesis.co.nz>

On Wed, Nov 06, 2024 at 01:18:33PM +1300, Chris Packham wrote:
> The board level reset on systems using the RTL9302 can be driven via the
> switch. Use a syscon-reboot node to represent this.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     Changes in v9:
>     - None
>     Changes in v8:
>     - None
>     Changes in v7:
>     - None
>     Changes in v6:
>     - Drop wildcard compatible
>     Changes in v5:
>     - Krzysztof did technically give a r-by on v4 but given the changes to
>       the rest of the series I haven't included it.
>     - Use reg instead of offset
>     - Add a rtl9302c.dtsi for the specific chip which pulls in the generic
>       rtl930x.dtsi and updates a few of the compatibles on the way through.
>     - Update Cameo board to use rtl9302c.dtsi
>     Changes in v4:
>     - None
>     Changes in v3:
>     - None
>     Changes in v2:
>     - drop redundant status = "okay"
> 
>  .../dts/realtek/cameo-rtl9302c-2x-rtl8224-2xge.dts  |  2 +-
>  arch/mips/boot/dts/realtek/rtl9302c.dtsi            |  7 +++++++
>  arch/mips/boot/dts/realtek/rtl930x.dtsi             | 13 +++++++++++++
>  3 files changed, 21 insertions(+), 1 deletion(-)
>  create mode 100644 arch/mips/boot/dts/realtek/rtl9302c.dtsi

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
