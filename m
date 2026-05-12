Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB0A4DA527;
	Tue, 12 May 2026 12:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778587993; cv=none; b=FUvvkxhqEj4OI5CXkph0WD88I+Sy2S3VEdvVyS1A1VDY5Bm49Yrl/4WUpu8wCZIT6VfgAlS3GhVmAw5VEuoYe0JarRE7WqdnFkbTG341AVBl9CShZa6gHa8xoWYzmPvL+EXo4lmSPjYme0Gj11SN7p6ztwg63m2e5Rk4OD0P6ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778587993; c=relaxed/simple;
	bh=U7PDfCE27rw3KiR7xbbhGbXblc8BOb+O8LbMMqGsb7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsvZcRz3MgfOzZoxeP/GdTtYfCma276N5oM8kGtOxLrVSNdIei+dkSHeFCAHgC9ZaV77fJJ2be1gDej7NxRzg8+gCVY703UpSOc6xiURtRfHNNh7Q9tTLK1Hpekt+q/jdyMvUg7NtXjaK9ytrB23E5+BWZ4i0xzjnMHqZSmghdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwgxJyRR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwgxJyRR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51B7C2BCF6;
	Tue, 12 May 2026 12:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778587992;
	bh=U7PDfCE27rw3KiR7xbbhGbXblc8BOb+O8LbMMqGsb7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AwgxJyRRwXIQJP50dSXsosDOkbV/+MnRrqyegEtLkbkLZFw+k+kL3FUwv6/z6SaPR
	 BI95C+aM+JuLzk+darTvtOAtvER3qXkHXeEiVXin/vyQT5cpgMmz0NeuCPKm79uApx
	 PZB49oI4tM132AJO57zw9+QfAbOwXhOa/z0thgF6R3Zx06260JTFh869P4YgLjMrcJ
	 CrHEFQ30xwBMhNUuPn+1irlo2WGuVSjVPMQeMnjmMU/NZPiN4NwW2FkKx7sQzLSNfK
	 GmRagjgBH0A4Du0Uc4rT0KYHca81fJ0cD2leSu4SoTAKCv9+/OaB/7D827kWk/Z6Tk
	 yJ3kTh3SD1HrQ==
Date: Tue, 12 May 2026 07:11:25 -0500
From: Rob Herring <robh@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	Peter Rosin <peda@axentia.se>, Andi Shyti <andi.shyti@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: i2c: mux-gpio: remove Wolfram Sang as
 maintainer
Message-ID: <20260512121125.GA1318921-robh@kernel.org>
References: <20260509171354.12263-2-wsa+renesas@sang-engineering.com>
 <177835197844.785566.9553774802925952117.robh@kernel.org>
 <agDxmyIA4-tLDKgX@shikoro>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agDxmyIA4-tLDKgX@shikoro>

On Sun, May 10, 2026 at 10:59:07PM +0200, Wolfram Sang wrote:
> 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.yaml: 'maintainers' is a required property
> 
> I know. But as I was added as maintainer without my consent, I think it
> is okay to remove myself.

I suppose it should be Peter:

GENERIC GPIO I2C MULTIPLEXER DRIVER
M:      Peter Korsgaard <peter.korsgaard@barco.com>
L:      linux-i2c@vger.kernel.org
S:      Supported
F:      Documentation/i2c/muxes/i2c-mux-gpio.rst
F:      drivers/i2c/muxes/i2c-mux-gpio.c
F:      include/linux/platform_data/i2c-mux-gpio.h



