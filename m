Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E3039EF05;
	Fri, 14 Aug 2026 10:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786702890; cv=none; b=oRBtBuciLY9LbPCsYVWB2xbCxwvOj300O8/dJPZSmViQIrM1cQ/KLRHG2I7ih0hVdUknIE2A+6KXNvdu5xLj5+Wf6w8vN6IqwQSLDz+/tOEs1ctSTmL6o3UH7dMxbX/4ya2MX3rgMOlHv7m0iZsKO0fmYCmVWy4V+OAC2tiMQ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786702890; c=relaxed/simple;
	bh=qb/LiS0W/y7yHH9+e9qvnb8YEVHpUvl7FHRXw8WQl1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVYVxhU1ZI0xM1Iyi5f0R2V/dMa5X42Y24vYj8MfyaelLzhcyA2d/8Tc7JjAANhE0tObIYoUUeIEJIcZIJp8yDsIB8n7U1Omg3IA5VcBVn3LI/l5H1bD4o5+fqSTant6d543K6oNHLsWAN2r7NPORA2f3LK7j7CPXgJ5WzYMKuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOQIcoe7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOQIcoe7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03A01F000E9;
	Fri, 14 Aug 2026 10:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786702880;
	bh=qb/LiS0W/y7yHH9+e9qvnb8YEVHpUvl7FHRXw8WQl1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YOQIcoe74kRChWbmv/mXVEEfZslk1rIXehTZgx5CDMkKuRpWJu3eNzEYwCxAYDHIF
	 rGAeFTLXL624XJXehQIEv2NlHuZ1glC0iYB+OkXr7JUbFlccXhtpXVzjjRdQ0ajgZ5
	 cr4dc2//RkfO+zrYTLfzXFQOZUeXbjDJiMwplmREsy+myyWeOZOo7E/2+shinsbFyt
	 Btf73cOA/INOO6XfrdFBpa/W8kejnGUZ7lMDivb0RQIM4c8iqfaGnFvWa7o24ofMiL
	 pp5jkK0XYqVMhb+j/d3X1cX7tYM+HEyGYFGI0+KGx/Z9vNs223tNhnPanHcf3oQ0dQ
	 TpAMjIFvNQ3pA==
Date: Fri, 14 Aug 2026 12:21:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vladislav Leonov <vlad@zlab.su>
Cc: linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Simon Glass <sjg@chromium.org>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, linux-i2c@vger.kernel.org
Subject: Re: [PATCH 11/25] dt-bindings: i2c: rk3x: Add RV1106 compatible
Message-ID: <20260814-resilient-handsome-ibis-d5efdd@quoll>
References: <20260810121121.210040-1-vlad@zlab.su>
 <20260810121121.210040-12-vlad@zlab.su>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810121121.210040-12-vlad@zlab.su>

On Mon, Aug 10, 2026 at 03:11:02PM +0300, Vladislav Leonov wrote:
> The RV1106 I2C controller is compatible with the one found on RK3399,

Add RV1106 I2C controller, which is compatible ... /

One sentence, one line or two lines.

> so add the "rockchip,rv1106-i2c" compatible to the list of variants
> that fall back to "rockchip,rk3399-i2c".

No need to repeat obvious parts of the diff. Explain non-obvious parts,
though, if they are.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

