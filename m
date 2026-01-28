Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2840233D9E;
	Wed, 28 Jan 2026 10:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769596646; cv=none; b=nmPVLL4osP6OLvDqsZFsg48+uyoKW+kj3Ei9Mux4fJG5vQKdW7pRnlU70qVC7QI4HA6KJtBhZssMFagkmpk18QIbS5PWZxXBV9Hogf5c7ssaxuTLV6cRWbdtztHfXH3bWZLnFG4rVrJ53PNRqlkb7mWZm/1FZGN07zRi6M7KwPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769596646; c=relaxed/simple;
	bh=0ls6lQ8h9xsQ33EtNja3RPbSmj6Vry9dJFwMxv4NbtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXOWG/fQ2J02+CskP3gbnZPX68aPHRCG9mYamLioYy6BNXIqL9qk731H6mPrEesPyP1wz4GAczPmvo34WWMet2Z/1xB4DpcoiFXMtv5yS/qgX/QwrHKow62f7k4bhIHmHcajPfBvz+8bD+o+BXjypBYd9wjCJ80GRd7F+9K8W0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrkHLkKp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrkHLkKp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70CEC4CEF1;
	Wed, 28 Jan 2026 10:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769596646;
	bh=0ls6lQ8h9xsQ33EtNja3RPbSmj6Vry9dJFwMxv4NbtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PrkHLkKp0QVXBgqNGZzUMhDtL3A8NSnd5SYm80EIy7t0o7y0ox9HX9imYtmDWJp4j
	 70AmSJVG3tkOxRbDDjXrfeJB1F14qiGLpYD6lmk7GunOJcfkgEZAgUqyG3kap0HU2I
	 cpMMvMxUUDozz2jSeOOD0TaXfQc+5AVfkMIn9L6MqCDKnAEEZMzY/tv53hOOrMaMdP
	 yMTcNMN0LTJ6rlwszCzb/gk9YsJhmasPvPLeWwOz7MZiEx/exW38vgsVsZf3hQTuX6
	 SbXH2Vhl0UUta27+PuFZwYh9kODSxGcCUa+6Uk/QG+txH4vDxmg30+6Y436hAtYjP/
	 zB/bb4xDeGCjA==
Date: Wed, 28 Jan 2026 11:37:23 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Michal Simek <michal.simek@amd.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, info@mocean-labs.com, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/7] dt-bindings: i2c: xiic: make clocks optional
Message-ID: <20260128-remarkable-airborne-chihuahua-a1a16c@quoll>
References: <20260127-i2c-xiic-v6-0-e82e2f6f657c@nexthop.ai>
 <20260127-i2c-xiic-v6-1-e82e2f6f657c@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260127-i2c-xiic-v6-1-e82e2f6f657c@nexthop.ai>

On Tue, Jan 27, 2026 at 09:03:55PM +0000, Abdurrahman Hussain wrote:
> The xiic driver is designed to operate without explicit clock configuration

And if you change this in the driver, then you change bindings?

You miss here explanation based on hardware - how does the hardware work
if nothing ticks it clocks?

Best regards,
Krzysztof

