Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792773166;
	b=ZcG+MAZvEC08scN/co//+tafl5QOKMP1iiKKCW5qNlwHaFLqS4WQ5bQI4UaV3QD0Q+X+
	 /qc2pgXBWPSPvJrdR4BLfFF+Kfk97Jhgxo153NW7VWqdhkM0B0UzYUxmcQHmxbbXMg5ei
	 qx9q5CF/r44nMyNdx8YrUg9BFR/r+XVnZ0hKWmSNwNxHb8UCLiZMle1c9WJ4xrDdXpnpK
	 0YfoexjN6xckXbN4svxK5PhuF1pCVH583i/ZLutcRmOYI7Ghs9+7vEGu6ZOwq9PJTwfFS
	 aKCtMkJZVTl/qEUtX6RoMTIzuuEVCPVE7m7NmPi1rqNahMpDFavAv8ivn4ff/pftEMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792773166;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=b5iTkwSOZHA0NMgeve9AVcmRA7avz9vnNSokzShuXNI=;
	b=ksH44IrHbobdhCgFA1ydDfR8wWhCdXDcSeZNhAoC5y80W5sWDO0j0XgiCiL2ydpU/8vA
	 lOi73XpWwnRNfaGN6JyN3usJLXTGSNDRsnv5XewtTWllgmQhKCIysvDVhQk7TREbdXKyz
	 3hfDm/Yos/4d6XdRLyPucecmvBU3/cg7tbXutqxK0sNr4Z0Mre7luyHVnxJCWo9a8IKJV
	 YNPJjsdMiJrLwOGmvTLDIn6fskLmOpLf1jv1/PI7nC8Luwavp6VSBI5dklKHfYsHkeRrs
	 9eZTi9ObY2N0TnD89kqBkHtOFyGpCA6/0Kq0cH/B7Se8v5u9f4UPGb9gz07qOuUtEnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZDroGC+x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69239606A31B;
	Fri, 23 Oct 2026 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZDroGC+x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9E91F01825;
	Fri, 23 Oct 2026 16:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792773166;
	bh=b5iTkwSOZHA0NMgeve9AVcmRA7avz9vnNSokzShuXNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZDroGC+xpkkXkLSz9nuI+opuu5tNARVn8NQVHvBGJ39Wcu5xwGoNJMMCuYl0xpk2S
	 unEbIF+IzanPKZcNUTshlOcL6t3fv1xF8cO5Hjpj9/BUYOX1ZMLKuGBcPPLj/b5BRX
	 dAxWyqRJKfRWVaiL5netmNJNdeuyBFRid9M+kHjzAoHsFtrW3x8NCMnJntoxsuVwkd
	 ADM6h5a0wWiiJqNXcaoCWfeVHSxoOqefKY8gG7CIjE6ZX/zK+DowM8kj5B6Flg7Is0
	 pwVCAYcQVIOd68eVAnx7t6ySwcE5/D5CYepQn1InkIirF0wWUyrQLFupAkddsWxMER
	 dFvoPAcadEk5g==
Date: Fri, 23 Oct 2026 18:32:38 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Vincent Jardin <vjardin@free.fr>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-i2c@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Carlos Song <carlos.song@nxp.com>, 
	Haobin Jiang <lemonoutput@foxmail.com>
Subject: Re: [PATCH v3] i2c: imx: add I2C_M_REV_DIR_ADDR and I2C_M_NOSTART
Message-ID: <atuMDUXq64XhQgqM@zenone.zhora.eu>
References: <20261023-for-upstream-i2c-imx-lx2160-reverse-v3-1-a07b249df381@free.fr>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023-for-upstream-i2c-imx-lx2160-reverse-v3-1-a07b249df381@free.fr>

Hi Vincent,

On Fri, Oct 23, 2026 at 04:20:19PM +0200, Vincent Jardin wrote:
> The Realtek RTL8366SE SMI read frame per:
> 
>   S Addr Rd [A] reg[7:0] [A] reg[15:8] [A] [data[7:0]] A [data[15:8]] NA P
> 
> Linux support it using I2C_M_REV_DIR_ADDR on a write message
> that inverts the transmitted R/W bit, and I2C_M_NOSTART on the following
> read message that continues the frame without re-addressing.
> 
> This NXP i2c-imx is missing such support, so on an LX2160A the Realtek switch
> could not be used.
> 
> Acked-by: Carlos Song <carlos.song@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Vincent Jardin <vjardin@free.fr>

pushed to i2c/i2c.

Thanks,
Andi
