Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E1248AE10;
	Tue, 16 Jun 2026 23:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781653524; cv=none; b=A57ckSNqJDmPFjz/QuPKGaSB5e4dwD3FaX/TcGdS9uP72ItVliVJ+Pppw92zXVJLPDAmm5Pi1enfrVG/TDuRk8VoJUguxNWaDOItlbc5DPyoBegRqaPuxH1t+Ovr7P+6BoN0AmEDzAN5zhhZrpyIcqOZPw8PLREXT89DXd9LX6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781653524; c=relaxed/simple;
	bh=zBshGbGG7Dsrjk3t+cTVXqTpIBVpdi3SXAHUaRaqndw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdMN3kJ1uvOnNmOG0d9Vr5tCQpsNXYFPAVpmniVdRB0dvRXqQugI7Sc4J1O8edVnYUrnWIl5DG4OfXKuHQu4ENsiQ6u/Lr2mwKAFPJ0lbcr0UFFw9jIXmQWIJ6p1h7ZuMn0RxoMoy3Yq9EbzEmGdqifhRzyxXPlClzEhoF1a5Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNObnnaC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNObnnaC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244E61F000E9;
	Tue, 16 Jun 2026 23:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781653523;
	bh=fnZctqJ9JUJa0dpu1bMXxLaV39Qis4wHH7G2XZVYwa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BNObnnaCxsJaaexQf3i7p5ci/YKP54imBKssllRd5lEMhfJ/p/E3zt0G57ZsvS30T
	 nINv+khVxP7T4RlHm2SakjpQv58OJHR6kq2Zk0v45/qkgcv5NpVbV96OQhBGbZLNHP
	 4yPMeWLfV1+wZ23fvVzzAb3k5zrOpHEn1GSgxkYhtV8a5jGyGcXhlYti4MQLmXtGfk
	 BlMpLX4ZviPnAemSC/JylnXuumzr+DbsYYsrEU0sPviA+64zcqOs1TNJ1hqpejJNBT
	 WO+HNbJm1qV101YsAbMY1c7pSUCNt3dr6JAvfejCk++6QAQN8X7wEMqyexwr8NdWKd
	 hH4/eDt6OJf6A==
Date: Wed, 17 Jun 2026 01:45:18 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: linux-i2c@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Daire McNamara <daire.mcnamara@microchip.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: i2c: microchip,corei2c: permit resets
Message-ID: <ajHf_colM2_15FZU@zenone.zhora.eu>
References: <20260506-bronchial-kitten-e3697fb66ba7@spud>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506-bronchial-kitten-e3697fb66ba7@spud>

Hi Conor,

On Wed, May 06, 2026 at 04:00:46PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Both CoreI2C and the hardened versions of it on mpfs and pic64gx have a
> reset pin. For the former, usually this is wired to a common fabric
> reset not managed by software and for the latter two the platform
> firmware takes them out of reset on first-party boards (or those using
> modified versions of the vendor firmware), but not all boards may take
> this approach. Permit providing a reset in devicetree for Linux, or
> other devicetree-consuming software, to use.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

merged to i2c/i2c-host.

Thanks,
Andi
