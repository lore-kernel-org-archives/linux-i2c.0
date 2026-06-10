Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FAC34AB14;
	Wed, 10 Jun 2026 21:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781127470; cv=none; b=XmMsYAZpcmXOUnPb5vz1vlk6r7422mQY7catmg1gzd5POA/r+BELVPlacqUtvXh8CFLZxsnKyufj6CaZIIlodpajZbj7WQUzRqM5NDPXHHbKftmAUuSX2rNGyR0/H6KEF//FqpA6kjkwD4eXCm0mLYALK3o0i04DyIBJhe8ppK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781127470; c=relaxed/simple;
	bh=D3eladpRX2T9aUosswCxBwXm5G5RvwItS/rendtIFcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMBJjfZM+9GaCgTkBKOjBcXEYh8nkstXYO30CmblqT1ZY31Q4GQwPocKJWrQ3F90aWK2HZz9TYQZ5mUzsMPoOnRZhf8BB0RQzOCXRzYKjW6f10kWf4zOJ0g28sNKMkmL3RLVxgvEosIVxPxhMPsAubuP6Fvv+0eP893drnEIJt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Om5A2xhl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Om5A2xhl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492EE1F00893;
	Wed, 10 Jun 2026 21:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781127469;
	bh=nGt91+dMFFcqLfhyCWmDaNG3xcM0Hx0F3rWqydEivn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Om5A2xhl5KwVp7mPn4hdvC5BfS1Z1hCnc2M3RhRXShuh+nrBcISslrhzOMPjZaheT
	 ID1Wj0ln+ZYyUZTrl2XwAUjgn8dQ753KtuRZt6eSTtB/FtOqwp8nm0fZ7OYNEF5a6t
	 R/2xLwDU3aETqJzhCoBwa8JlgvO9C8mXaSlUY3zLe6Z9YRNqWcTQ0KCEfS8uqQPxxD
	 3jewCyTQJoWlsiVXJuUdUiceVWri2BK97aJ6MtLLV/5rDzBKsA2dTYMOw/RRNaTs6k
	 Z3vAtR/HNhuxx6xKqKY35t8typHgL9T//E7f8QUcE53+kjqRBnT38d+mrGNmlD0u1i
	 QYiC1309FD/9A==
Date: Wed, 10 Jun 2026 23:37:44 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-i2c@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, 
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] i2c: mxs: add missing kernel-doc for struct
 mxs_i2c_dev members
Message-ID: <ainZEIfM6-cJxzO6@zenone.zhora.eu>
References: <20260603031135.289302-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603031135.289302-1-rosenp@gmail.com>

Hi Rosen,

On Tue, Jun 02, 2026 at 08:11:35PM -0700, Rosen Penev wrote:
> Add kernel-doc documentation for the struct members that were previously
> undocumented. This fixes warnings when building with W=1 and ensures
> the struct is fully documented per kernel-doc conventions.
> 
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

merged to i2c/i2c-host.

Thanks,
Andi
