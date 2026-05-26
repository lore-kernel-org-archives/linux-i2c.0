Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E32409627;
	Tue, 26 May 2026 15:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807832; cv=none; b=MZfxZ3VSxvCnrWYIwYSYxoDJJjNogx3JtWpXjMExtF5XafghY2qe8EHm+j2Wvu3hepowFEonj7hAf+mZ2nMMJ/LHF7EvJQVa/xgRTCgLEXB5HhD02cd7xZhhQzQNFyt0zGhZOW0Bk07jpjrCns2X3OPEBzG1vmMqj106uLptEYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807832; c=relaxed/simple;
	bh=7WY9SpLgKNoK6SbB2sNnWTouW3Gpclt2bWosMYonSCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5xizaliv/Fy8RHRisT85KH33KGkq2zXw6g/1uy43w7YpcI/Bk4+Jg/sB6FJmaqp1CxfZ7wW7fJ5VekZvqLZSFseBwrqW9uGJejKjkE9Uq8qy+0rYFiAGnVNDu2uc4w+bOpKhoVlHj9ba/FT9jO0SCzPYb0xMwrGdBDAwqAsnFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cO4b7eaq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cO4b7eaq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FDB1F000E9;
	Tue, 26 May 2026 15:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779807830;
	bh=+rZSJLBmdmQ5TDTNTam+3vDjLLn8hPQyVj5Ex2NgWpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cO4b7eaqhuJSwFhFXIFYHnMi76Y8H3sGhZDVaUcsmkOYUyMqBED38lkmdSuEKh3zz
	 EMWV7LG7KJ7bHCeRYWAZsOeouwNgBKsYICl9VbvcXbVkfvBG2SPey9xrSniSFyFM2n
	 G9sznW4hAkIXHwTM/4Od3VwZLm989KZ6UNO/GE8n2wUfGOUN/gjjPDm+3kxGAUUxM6
	 ULZetA2zNTYrQir5+BrLadNXo+HlyPBZDIymhVqrflbROtpmNcYraHwmuuoVQgAlmq
	 PfxGVWGPnXE6n5MW3gVPYCOP0K+pV0VohphikWECT3t6ho7f8C1BPdtK09I56uQG2/
	 cCEgaIJORcN1A==
Date: Tue, 26 May 2026 17:03:47 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Hongliang Wang <wanghongliang@loongson.cn>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	loongarch@lists.linux.dev
Subject: Re: [PATCH v4 1/2] dt-bindings: i2c: ls2x-i2c: Add clocks and
 clock-frequency properties
Message-ID: <20260526-inquisitive-sambar-of-wholeness-22f99d@quoll>
References: <20260526031021.32662-1-wanghongliang@loongson.cn>
 <20260526031021.32662-2-wanghongliang@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260526031021.32662-2-wanghongliang@loongson.cn>

On Tue, May 26, 2026 at 11:10:20AM +0800, Hongliang Wang wrote:
> From: wanghongliang <wanghongliang@loongson.cn>
> 
> clocks property describes the i2c bus reference clock from APB clock.
> clock-frequency property describes i2c bus speed.

Not rally relevant to your code. We know what clocks and clock-frequency
are.

> 
> Signed-off-by: wanghongliang <wanghongliang@loongson.cn>

Please do not use login name as actual name. Your email has different
Latin transcription than above.

> ---
>  Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Best regards,
Krzysztof

