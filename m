Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038C833BBD9;
	Mon, 15 Jun 2026 21:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781558113; cv=none; b=QzHPDxGKvwakzaI5ilpxSW7Gnrz86JeCpUMa1vyQiMoBTAZFyJ4NiWW6qoaT3WTK0jO3hHmoC7JFdrL+SD3UFEL2hscjQYls32koJo39pINq0IyjpswSEnWAelJRDMdtNTHpFUSB0kKawMjPZiS+wRzFIeCfHmgD7k3g1wRt6sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781558113; c=relaxed/simple;
	bh=S1WpUMOEPRN+THgJTlL+7X75kgLTtijIEKOOxaDy4AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7yOS+LrI+biHqO1RkdWJnzVYfAAgvOiB8EN32Trmpdhz6XTxE28tYYGZlFrkR+YLr0MnzRYchBfQdMp1kFaoI6qRwKD0/KDhqxJM/ln4o/T0IcBWRG5GSYucxfe0JW0ICfn6/tuldj0ySLbYmaXRc13vc8aUnDSRI8xqadLHwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELwF1Yei; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELwF1Yei"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3CD1F000E9;
	Mon, 15 Jun 2026 21:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781558112;
	bh=v1F2ZzzT1p3w0X8otzyBIUwMYdx0HypLdu4oZbFgfuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ELwF1Yei7oqYXgY0gwiKte1dZgGVEmw5mkICcQ0YX4nJZ+EhwZQt2oK65GqxAJfgt
	 KemtZYQw54YN3Xh32ZwVvTsJDsbVtlUsXqv7Hh4bZ0oq8Z/8nR3GzqMLhos6QL6b4q
	 FHUwzNIwDSkLUYmJQpAiR8ngHAN0SWWO4JPKdDIKq8fsDkhHIX6G1Vm9Gy8G6HXD+M
	 8VlYXdgBhmnpDoaDxHxBBkGsurQjjQALM9LJGseD1WSSFxNiN/uxnHOYtbRWcJIQ0P
	 1yJb3OuzTItnuD0DuhYdJYPg1mRja1o6pPkMnnabNKr2j6tlpdRdKHvqXoIeOG3RFS
	 k9aIxokuOlZWg==
Date: Mon, 15 Jun 2026 23:15:08 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-i2c@vger.kernel.org, Thierry Reding <treding@nvidia.com>, 
	Peter Rosin <peda@lysator.liu.se>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: i2c-mux-pinctrl: change maintainer
Message-ID: <ajBq_yjuV-LeqgpI@zenone.zhora.eu>
References: <20260611122704.7559-2-wsa+renesas@sang-engineering.com>
 <ajBGibftf679T6P4@arch.a226c7d-lcedt>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajBGibftf679T6P4@arch.a226c7d-lcedt>

Hi Thierry,

> >  maintainers:
> > -  - Wolfram Sang <wsa@kernel.org>
> > +  - Thierry Reding <treding@nvidia.com>
> >  
> >  description: |
> >    This binding describes an I2C bus multiplexer that uses pin multiplexing to route the I2C
> 
> By default I used to list the subsystem maintainer as the bindings
> maintainer if the binding wasn't Tegra-specific, or in this case the
> original author wasn't active anymore.
> 
> I'm fine being listed as the maintainer for this if you don't want to,
> but I prefer to use the thierry.reding@kernel.org email address for
> communication.

Just to be clear, are you saying that in this file you want your
kernel.org e-mail or are you referring to generic communication?

Andi

> With that:
> 
> Acked-by: Thierry Reding <treding@nvidia.com>


