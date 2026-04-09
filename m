Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F3A8BE9;
	Thu,  9 Apr 2026 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775752619; cv=none; b=tph5bD37gFnZLn0TdETSoVjEi/F5rf2V7SPp3OxgXV+0beuuvWx+MvddHbjpRIM1A6xJdVazD3OybdtbWViokqI2CAjJuyqM1jhqmCpONXBeGIDo7ZSZzCxfBXAgu+6hB2p1MbWP1JB/czw8RS463gFJvH/VY3Z2RRl3Ms6b57M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775752619; c=relaxed/simple;
	bh=KOqlFVVDPA8Z6Cqw5fEN1sKBxBwUNHbyg8QMlZBZyrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lp1oTYtcRdKWgqkIugFGYQgX+9GctOXBovO9EoAjMi+cr1TR9lOqjc2boUEbg7PpX0pZ2Ei8A7hVrWJJt4MoBoExtLTNays49k0z8fim32mXHRh9ufBnuDoNEE6kEVgITK9Re9nystSsMODjTtjAQuo6sGZr0mdqlLkfOsWgCHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tO3ctKOr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tO3ctKOr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F558C4CEF7;
	Thu,  9 Apr 2026 16:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775752619;
	bh=KOqlFVVDPA8Z6Cqw5fEN1sKBxBwUNHbyg8QMlZBZyrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tO3ctKOrVZJRL2kFL4/4QiCi7kgQpYRH8DHsDAjExEVG0fet21rxehQ7U/a013N79
	 txPwkC0SXW/3sECmTbpGrFJWXhE6UkSQ+sdCLl/Ex2orjqw/sGnQsWBXSrnI0DW1DI
	 zEUX820CBJKJOTJwmTGavTqwDwKaZr0atzyIMqHt3GKy3wp+OgK6g++w3Y5ysEby+K
	 eDYsNJlF6F0ZxGEKoUcDgnn0AilzsGZoJKiR3Gfi/KwSBxvpdXfnO+fqFRgmdxnIVu
	 w9C5JZLKcrIiJC4cGiu1FgBXMaRW4wOq73cVlzB1i2nTRB+Bmv9O9lhwavEoJMPf61
	 U40a0PcHRSnNw==
Date: Thu, 9 Apr 2026 18:36:55 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Yixun Lan <dlan@gentoo.org>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	Aurelien Jarno <aurelien@aurel32.net>, Alex Elder <elder@riscstar.com>
Subject: Re: [PATCH v7 0/2] i2c: spacemit: introduce pio for k1
Message-ID: <adfVk82OC1c3Zn8a@zenone.zhora.eu>
References: <20260207-b4-k3-i2c-pio-v7-0-626942d94d91@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260207-b4-k3-i2c-pio-v7-0-626942d94d91@linux.spacemit.com>

Hi Troy,

> Troy Mitchell (2):
>       i2c: spacemit: move i2c_xfer_msg()
>       i2c: spacemit: introduce pio for k1

merged to i2c/i2c-host.

Thanks,
Andi
