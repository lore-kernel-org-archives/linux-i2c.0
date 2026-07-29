Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7B33F54AE;
	Wed, 29 Jul 2026 20:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785357311; cv=none; b=TViiHJiUgKUGUjAdwtBgi4E7ik5ZHVDGv2Ytd7jKBzvaerpWLLe7oXGcdPGrlpIEXudUSB8Nx24Tlzx8VmYLjkbjfae3XDvn970nsmeIKdOMgRb1+q5Vm4KJPZIwPr3UstgA74iWHTjRu+Ab22e2bbZKG0tebQSze3NoB2vFYj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785357311; c=relaxed/simple;
	bh=/RGnp7OmJ4LZ20kzuZvL+DzjWPjT5rvzDk4qgx8e02M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h73241C1xI/AIUJxOBvmZsZW7KBFpX5yrU8kO7i/iy7Xd3OhszLIB+aGNnSBp+A3pPsyVTEk6UCEg3fltiGlS4CtjPdsC+ZQo0xESFXQ0uC17Y5jrgu8uHcY0UYzL6cPGfFMUqo9OM3lRUAhHv29nIvNtqY/yOePl2Zy/eGWNsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPHAqCup; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPHAqCup"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D051F000E9;
	Wed, 29 Jul 2026 20:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785357307;
	bh=bto8rv2FaMQDpuwxk3eSkSagKPYhiCfH5t3YXCQjLrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DPHAqCup7PptR3ZDwY6mAwEuxxFmyVUVGVBodD7FQThM10DfdtGTDudwtp7h/IMlC
	 ql1ErMbeBCHJOsd39VAcFI4iU6TCq4l5ipjyBh2KKaCRhdI5zhT6WaiGEuePOb4qZI
	 tGD0izrhzisuWFr23SK5Jrp4DxQDaJUVzXDenXEdI04Mh7hAn+2i8XOEv6E+Fzf9So
	 nsIsRgFpVhDB2N1ExgStkwpCBkjDxmT6wj2eqfAfD038qg+0YgZWypvRxZ7TLUMpO0
	 hgzJ2YNn2yJQd8YEIFS7CwwuN1RbRRM/xroMXIkBsFWoUvHBSLnLilS+JAqG9xFL/Z
	 /e94pB7mx2YBg==
Date: Wed, 29 Jul 2026 22:35:03 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-i2c@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 0/2] i2c: rcar: add Gen5 support
Message-ID: <ampjt581jhaB4qmn@zenone.zhora.eu>
References: <20260727122546.4232-4-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727122546.4232-4-wsa+renesas@sang-engineering.com>

Hi Wolfram,

> Minh Le (1):
>   dt-bindings: i2c: rcar-i2c: Document R-Car X5H support
> 
> Wolfram Sang (1):
>   i2c: rcar: add R-Car Gen5 support

merged to i2c/i2c.

Thanks,
Andi
