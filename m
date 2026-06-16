Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B9830F95F;
	Tue, 16 Jun 2026 13:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781615695; cv=none; b=SbMaygY5JREoGCZIuZRTCEq3NFdtJJcfp8OPecckMg36fiUxQKdHeZA+3RpegFPAb9MrZYSFitFUhVfiGcc2OPUGR3X+TuHUj+aVO7eHZxX3+0RAfhzMhTEcBgoD/kpQsY4y5BkCnRA3olTBT1jLmXI5/aMytw2d+KF6d8QZtlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781615695; c=relaxed/simple;
	bh=+vEHAq6JqKee+5TYzlcxRCMcSm7nheGSzXoNQYgcw0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B06vkFEgf/8Dfu5osZgzCYoai0hZs+3ZAkiwrvdziB0rl7RpLE9NdDd2qW8iK3uBULxW9mFbBKtpTAvbRGmj6hD2GJekLTxNiByWqdostnZxMt4DTBaZ0EIdhpuJmvj0avc/1AS08MUH83ILhW+sHkymqLSwQDLjFKWx3JZILVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldhtxA2r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldhtxA2r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868551F000E9;
	Tue, 16 Jun 2026 13:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781615693;
	bh=CKYceXvCS70pXX2CGanLkSeqT50lCSe78sHgZWUuGJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ldhtxA2rLRXxy21WIkHSj7eRAAynPxZbcRgAOnu9qTm2QzeSk+p8TrpGrxTTdORIT
	 KfUXkKUZWNT1D+MSlT0fxmAsNGnveHY0Km8YA/ASID3teYJw71uqbaOV6A18sFDOEH
	 7E85O6NZS2Eysmy1/ZNmrgbYERNZIu4Cv/LG35+Eb7RUlJmU00DCLMU9VD7ryQAdDa
	 0/1MKX9WOcXySGO3cbeN+yzTRL3zjFiNl4RUgm6ANwMAjfVM+x+BQ/buKrcyElMNZf
	 pt5BEGZRkSIiwjAcTRI1Vg1mwkPpXMcSPFSN6NrLNVyBTcCqqSj+irqx59TXovcjyY
	 +r025muftjJkQ==
Date: Tue, 16 Jun 2026 15:14:49 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Thierry Reding <thierry.reding@kernel.org>, 
	Peter Rosin <peda@lysator.liu.se>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: i2c: i2c-mux-pinctrl: change maintainer
Message-ID: <ajFMLtgvETjZT3BW@zenone.zhora.eu>
References: <20260616060910.1480-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616060910.1480-2-wsa+renesas@sang-engineering.com>

Hi Wolfram,

On Tue, Jun 16, 2026 at 08:07:59AM +0200, Wolfram Sang wrote:
> The YAML conversion added me as maintainer but I can't recall being
> asked nor do I want to maintain it. Thierry has created the YAML file
> and works for the company which contributed the driver.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Thierry Reding <thierry.reding@kernel.org>

with Conor's ack, merged to i2c/i2c-host.

Thanks,
Andi
