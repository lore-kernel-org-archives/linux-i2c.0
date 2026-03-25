Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E4A2D8DA6;
	Wed, 25 Mar 2026 17:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774459947; cv=none; b=Lomn5c64bwdBo5UIlLp8x7Bd30G2enoJffc6E5AUqgvlxa9ulQzLfZYMNpAqc2AxGocwE0prPG4slmI0p9ptMB4nIC7Wi9qTSq1ESCDsonhcm8QDbiIMXviGagoT4tGJRA0OREBCVOVNrB2H4+E7Yetr3pDwlWsW+8tnUJR4aZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774459947; c=relaxed/simple;
	bh=8GqO3HvzzJYkW4x/N8W7oxwcQYGvUt7FuGhmUNDQxF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAOjsw2BlEzEo9QWD4WJLhQoxN1uFPyPNAT9PnFV2nwYv+To2Yv4Qf4HjroxbyhpCRWi2Nbq909yaIPWylSlJrzYedj27F4C+EXBpTZHBXRo6AwBIewmFPJ7J89Y7S0Ng41AgpXPpgwaxES8wThXhxoKIpBQCp6FDjNHQjvxo6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEwG51+B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEwG51+B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815ABC4CEF7;
	Wed, 25 Mar 2026 17:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774459947;
	bh=8GqO3HvzzJYkW4x/N8W7oxwcQYGvUt7FuGhmUNDQxF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QEwG51+BxvWtX4QW7gjq6ZbpQGJBo/T9WUazsM124tztml1mRxFCKiPQE7sz81ytU
	 Dw2uXcRldpqql82RqvHzfQCGuoLlO1YIRBDVvtWTYwo2jkoJ+bPXYXDVAPYdlOHt0C
	 vFAhk6sYsKKik6IrFri2uKGLn4nftG5d/sZGMbokmfkNAkbGky2M7kv+UoAsNltX6U
	 YhsZr1YQUcSyUk6MUvLmcGRTeBMEsviv2TlUcaBrY4CiLFRlfejjb2eaTgZxOA3JzQ
	 B42mGbPARNyVrMy2ASSvRqpL4vK8aOfOkdVK3jnZgDrHL56ztiWNUb7OyNlFrtOvkX
	 dTfQxRElWzGNw==
Date: Wed, 25 Mar 2026 18:32:23 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: o.rempel@pengutronix.de, kernel@pengutronix.de, Frank.Li@nxp.com, 
	s.hauer@pengutronix.de, festevam@gmail.com, stefan.eichenberger@toradex.com, 
	francesco.dolcini@toradex.com, linux-i2c@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] i2c: imx: fix i2c issues when reading messages
Message-ID: <acQcEtaTU-8KZlFn@zenone.zhora.eu>
References: <20260218150940.131354-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218150940.131354-1-eichest@gmail.com>

Hi Stefan,

> Stefan Eichenberger (2):
>   i2c: imx: fix i2c issue when reading multiple messages
>   i2c: imx: ensure no clock is generated after last read

merged to i2c/i2c-host-fixes.

Thanks,
Andi
