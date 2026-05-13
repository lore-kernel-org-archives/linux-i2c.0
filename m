Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A4B30DD1B;
	Wed, 13 May 2026 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778691910; cv=none; b=bXGNa+ybiHfZWbf/r6SLzvfgqbeHp3OdZgrB3Tnk0JiGavPBfpqOibkKNSYMYWKV01U+uRmB8biiuRlTp3qVJY7ePSlw3FEQF6maWNGp8odSyvqwLTbgaTapiWVrm/zJME8tFj3KF0UTK82WX5O+6lDKQgN9hgJo8I96AWEEFhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778691910; c=relaxed/simple;
	bh=pD2y133+MNgkoNr3quTW76FGiTi0U6sd84qgVAoBu1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zu8IiskgP2BzqV0St1OpKkxxvuD0tcP6GMir/C0gmOFMC+UJN8wwu/4ddkGMeyZaCQsmIOknEeEnutMUKu4jHd54U6tv3cLJXPcEcoHALwtuVenHMZBmbicEB08EnNM6/eSPY9sNd04Jk0/ZZm+G0cGFDDsCH09xQFt62C1FjSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oY1+9yFw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oY1+9yFw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE86DC19425;
	Wed, 13 May 2026 17:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778691910;
	bh=pD2y133+MNgkoNr3quTW76FGiTi0U6sd84qgVAoBu1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oY1+9yFwysb+cDH0n/dgzJTvyWmbhvdAQhddqS44JEXn5L8gVbWcMAo7qTJYusa4X
	 r/3sh6MeRxRbb/ykQhqT4ZMaCHIeI1r2WB8oSPZDj2DkIIaYIUq8w6Xpo4eZfdR6NU
	 dPkcRlY3Sj6KmLLcKIrTTC/L/NZLfQOJ5z+JFeT2B4OpPWRM5W6Y+EsgfqcXkOi+qp
	 fRIe9Qk4lcQ/ACRc02mPTgtwdkh+KllvoFxthMJ31n8R4rWhD/zlyUeM1Aq2LmJAtb
	 dKIBsqe2M+NDEi0415Laq+bwL1YUqa8kKG2NRSxMWc1Tsq6562u7+CR7a9CuZyBTOy
	 WxK16Cg4W+B0Q==
Date: Wed, 13 May 2026 12:05:07 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Joel Stanley <joel@jms.id.au>, openbmc@lists.ozlabs.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Rayn Chen <rayn_chen@aspeedtech.com>, linux-i2c@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, jk@codeconstruct.com.au,
	andriy.shevchenko@linux.intel.com,
	linux-arm-kernel@lists.infradead.org,
	Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH RESEND v29 1/4] dt-bindings: i2c: Split AST2600 binding
 into a new YAML
Message-ID: <177869190656.1316879.13816659240778800181.robh@kernel.org>
References: <20260513-upstream_i2c-v29-0-fe9926964d55@aspeedtech.com>
 <20260513-upstream_i2c-v29-1-fe9926964d55@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513-upstream_i2c-v29-1-fe9926964d55@aspeedtech.com>


On Wed, 13 May 2026 13:32:00 +0800, Ryan Chen wrote:
> The AST2600 I2C controller introduces a completely new register layout
> with separate controller and target register blocks, unlike the mixed
> register layout used by AST2400/AST2500.
> 
> Move AST2600 I2C binding from aspeed,i2c.yaml to a dedicated
> aspeed,ast2600-i2c.yaml schema.
> 
> Besides the split, this also adjusts for AST2600-specific requirements.
> - require two reg regions (controller register block + buffer block)
> - use clock-frequency for bus speed description
> - interrupts are required on AST2600
> - use correct DTS coding style in example
> 
> No compatible strings are changed.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
> Changes in v26:
> - commit message: include details of changes from original binding
> - fix example property ordering to follow DTS coding style
> - use consistent "AST2600" naming
> ---
>  .../bindings/i2c/aspeed,ast2600-i2c.yaml           | 62 ++++++++++++++++++++++
>  .../devicetree/bindings/i2c/aspeed,i2c.yaml        |  3 +-
>  2 files changed, 63 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

