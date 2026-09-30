Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40043C109A;
	Wed, 30 Sep 2026 10:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790763079; cv=none; b=X1bImJnoFCSE5wE4YBcAd4bPkNMgpg1ZwOGexKcT7VzT5y9IA/iyIDthK/6b+51mj0UAdViHOlwtAv5GZfypDI4lK/jKfRsuZ+FvKQl4iaFu/RB5yxmhTY7ptJtXfU0dnI+mCvETa8msR0+c+SUU+NBesJJKiiL16vRaHXeDBVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790763079; c=relaxed/simple;
	bh=HzZRiePTb3YNRIx/koLTtd6xpE+14537wN64ebMJ7eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKiFl/mr7Qn+K/DQ5mIaaAXOnvQpqy4bH5y4edlknigxtYrvxfllngLGFe7f8BXpzaVwd4yLTLDifeSvmtDn9vI4Lnf5RhkN7RfhnvXJdk3MBlGPr8y/23QEv3YhWD17Mgtl7AEEb91Yjma9f0RYPnXJ3zDNKsOubCDYNsV2c3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d04wMb1d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d04wMb1d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911521F000FF;
	Wed, 30 Sep 2026 10:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790763078;
	bh=goV0/frG7y4cYBdGEnbNUilQr6kFmD3qvwBP8+Lts/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d04wMb1dKMCwxs24ggMKIKg7HGQ4wSoLN/TkfRQhgPAeoyyNvehm0FoX0A6fmx3H6
	 Q4stXvj9gkSkf845BZrQrZ4WxpBClFgFjHEmTk+I/7r35Rr+6raR7IcQQoIY+Nv3Zu
	 foE8V8VX267w7vA6lEzZngr8qBkQ5nGZTrp7Nt1zG0vSjNnIJEVt6L0GWItZqPxmvA
	 BP7RAsRj+CbfiluJFT33H3uh75opQrfZCFFeQWWlXtZzjkw5Tnvslf/5ZYuk7S+uuP
	 BhzpIVSCX89Grz4sQS5XLR6o4KuvmGSC6eKzNtSgIegLg0DQEn5HXjMR9Owm2Q20dh
	 ExrTIks0zdaSQ==
Date: Wed, 30 Sep 2026 12:11:15 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Pablo Mazzini <pmazzini@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Gregory CLEMENT <gregory.clement@bootlin.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/11] dt-bindings: i2c: mv64xxx: add Allwinner B288
Message-ID: <20260930-cyber-marten-of-apotheosis-ce8c6a@quoll>
References: <20260927151016.186493-1-pmazzini@gmail.com>
 <20260927151016.186493-8-pmazzini@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260927151016.186493-8-pmazzini@gmail.com>

On Sun, Sep 27, 2026 at 04:10:12PM +0100, Pablo Mazzini wrote:
> The B288 controller follows the existing Allwinner variant.
> 
> Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>
> ---
>  Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

