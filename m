Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3FB33F5BA;
	Fri, 20 Mar 2026 09:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773998698; cv=none; b=XSV5S8fGhGAi47BZApIFRew27k3YkzGG0QYWRy17XE186Osl5ZT6zR97JtbeTcKqZzvFb5ksFeQDFYtiJDUZYbkomEPpxdhUMwMbuoNC3Lphq9NutvhZhFo2eVW6n4CAv80AbiGrqeYJ6lsl8sAWyPh6erCa90aOeYaEzgU3KCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773998698; c=relaxed/simple;
	bh=JhovlCCRFIcQnnOt8rpjmH8E0JhfopFVJaFIPDeTz0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBabg8j1g+gszivpL5AcXGbnBLaMajqQfPkle4qiODbXpKV9hL6Yh6droBKq0qNMijEmPgjl+SespUF10jnRFUS4id7bvta0PPM1C6zGPEyDWyG6v7dydkk+3c84dl4RLnd1g1mdmIHqCfR0/kcmeXVk5PnJ5vIh2Wjnl+AuNfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+lP9vgx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+lP9vgx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E17C2BCAF;
	Fri, 20 Mar 2026 09:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773998698;
	bh=JhovlCCRFIcQnnOt8rpjmH8E0JhfopFVJaFIPDeTz0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S+lP9vgxFczkZ1lgz0/rDbqh2i0Ey1m8c7j4xGjl9kJSpaHphW9qa2MirYTiH3821
	 rt6CHCXXDuNV5SOWKB+yfgQEFajQ7JxQD5iYt2U0FspX5K36+Tr55uJE7d32lejtCi
	 clZMpTfGGXMZntEtZTr8NTah53TZUYfKU80CJnfpxmvDT+4bqCta0djtFFmTb/O/B1
	 nV4dhd4LW7xOAq4S5opHsweoiG8/hS9B6MAZb0ZKwMYvNCHJckiCyd2Uv6y6asJZVF
	 1X2p93eWH8v6wGLC7LyW6TfYtnzADGzQ5mLgmfdi8JYk7P9HQ3mh4zGNh8AfLpS9Qx
	 thNEw9m1lGlRg==
Date: Fri, 20 Mar 2026 10:24:55 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rustam Adilov <adilov@disroot.org>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/8] dt-bindings: i2c: realtek,rtl9301-i2c: extend for
 RTL9607C support
Message-ID: <20260320-serious-noisy-ladybug-bad92b@quoll>
References: <20260319175753.32338-1-adilov@disroot.org>
 <20260319175753.32338-8-adilov@disroot.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260319175753.32338-8-adilov@disroot.org>

On Thu, Mar 19, 2026 at 10:57:52PM +0500, Rustam Adilov wrote:
> Add the "realtek,rtl9607-i2c" compatible for i2c controller on the
> RTL9607C SoC series.
> 
> Add a clocks property to the properties since RTL9607C requires it
> along with the realtek,scl. And because RTL9607C is the only one that

My previous statement:

"Other devices do not *have* any clock input?"

And second one:

"If devices *do not have* clock, you set it as false (see example schema
and even line above!). Clue here is what I wrote "devices" and "do not
have"."

So why are you using completely different wording "require" with
completely different implications?

I did not leave any room for interpreation in my statement "If devices
*do not have* clock, you set it as false".


Best regards,
Krzysztof

