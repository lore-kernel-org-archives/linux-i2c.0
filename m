Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D1C4DDB55;
	Wed, 14 Oct 2026 10:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791973800; cv=none; b=Ejw2XhlV2NoRd7ca+AAbxDIMXmqS35kkgqXFFkIsoj3dmWlNDNmYIX65RnmVL7B73y69aYuI8qiXrhtLBfE1tH/y5/sGas2ynvxFNFTdKIEJQA34dAo31qHrIEA9VggkE7jqDshlniUjaVa95YMZ07SGrweyKO0bnkKUzp+HMxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791973800; c=relaxed/simple;
	bh=a996mkzmjLc7/sl3ririSXFTuCFP4TwTArT4kcrQ1Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+Tvx1Zq09PzNJThqambZGSlIyjNliTrq3Lfq5V7Sf7W1vYFYZKgf8Q+bKqQTyIncwrq06szZ2d64vQ1JUF+rlb6qp+g6ZvJv+r8six/m7V/qMl1mVcG4S/SzGRZeQ3FCfNo2yE6vY+W0jpuO7rU7YQhCWobmzjLqPF6kQvDJR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1zB3pOE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1zB3pOE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BA71F000FF;
	Wed, 14 Oct 2026 10:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791973798;
	bh=ms0PTxP6Fn+7FduT+1LZGX/NpLoqIlaekHwZSpzjspc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i1zB3pOEleb9x/mxtYAh68IHFxwsSKwzeONf4sjGYZq0WwOhNRHLAwpb3dY656SL7
	 goNuT1uiTz74GLQTEeUDZhn3+t/UZIwpkGQFLL9MVJxSs5DzeeIazCp54zqeJ/ms7q
	 Z7sVR/uIYmPfkCR5hko2ps/htsw5meltKzbRld0o1t7rF5YxLemb77ejc+d+Bv+jZL
	 /GOBSjS7qxSkAsCaQrVCbe+9KiEc12z8q2A/ZZnKKi+8fbURKBXhjNw8ES15wQwjSy
	 yAkEiRJ/yf62K38IGncKcbZedM6a4C0M5FWZjHjaNeyp0SddMQDe1buhZFNaEbrrBX
	 LoEsRtiMGUmtw==
Date: Wed, 14 Oct 2026 12:29:53 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Zi-Yu Chen <zychennvt@gmail.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: Re: [PATCH v11 2/3] i2c: ma35d1: Add Nuvoton MA35D1 I2C driver
 support
Message-ID: <as9ZVx9TV5NpW1cK@zenone.zhora.eu>
References: <20261001075101.489660-1-zychennvt@gmail.com>
 <20261001075101.489660-3-zychennvt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001075101.489660-3-zychennvt@gmail.com>

Hi Zi-Yi,

On Thu, Oct 01, 2026 at 03:51:00PM +0800, Zi-Yu Chen wrote:
> Add I2C support for Nuvoton MA35D1 SoC.
> The controller supports standard, fast and fast-plus modes,
> and provides controller/target functionality.
> 
> Signed-off-by: Zi-Yu Chen <zychennvt@gmail.com>

to me the patch is fine. Sashiko has pointed out a few things
that require device knowledge. Are those concerns valid?

Thanks,
Andi
