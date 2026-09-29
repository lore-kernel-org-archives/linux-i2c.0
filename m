Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98274E3784;
	Tue, 29 Sep 2026 21:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790719147; cv=none; b=jiOggFY66Z/hXaDqMCLj+DP2JP7bzhSZJleJ1xGx6MEUVMe15nHe6pqSH9a0gEkKabhecNBqxa0OkTpJxfvDTnbyFFP8qx2E0B2zexdOsnaseFmcyDwnhlKY1xg+NlSNWi4ULZMNgFu4JGHFOpqNwE+paDcuTWvPruLaKgtfrXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790719147; c=relaxed/simple;
	bh=cr5V+n/greApI8Zyhw+2u0aNrf/2IvsBktudjqmiqro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4FjYxEbUIsGvLCaKY8ZuOH6dBZ21Ou23js3Bb8qKc343dYS1rgWbKHHDXG6Rsuf/oFGtXR6c/OC0xWOBsEsqDEcV6dthnyPAjgM3Z/eb4vo7+M+r7k4SvYJ2uP8WwrP2zWyINUH2bQ/BNbKOLKppMyIpUjuIJU0vwpkwzpzNH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=BNoPtG9a; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="BNoPtG9a"
Received: from L30177.local (unknown [IPv6:2a01:e0a:ac2:22b0:fd38:7b91:be5e:6aee])
	(Authenticated sender: vjardin@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id 7B1C95FFAA;
	Tue, 29 Sep 2026 23:58:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1790719143;
	bh=cr5V+n/greApI8Zyhw+2u0aNrf/2IvsBktudjqmiqro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BNoPtG9afk89bIDpSSwZpYx+lHCVs9Wsyv/laS8KKM0eqRGAjxlZleqPa51jjBBU5
	 CY7Q33HOgnqUtHj8opAsuXscshB9tSe+jXDsh+/IBv/vcGHmMqdN1bYjb4DteSNDPn
	 B9GDCmqWXGEAaFsiqKB6SN90MGeJKcqebtZORXaAGOryOrUupiWaLlc0JY3LkixbwL
	 ok5AJ2D+qJ/7MYK3yUMeKDeiAFz73Xpqj78QcL1TN6WCvq87mwuHEBaKYE3apNoPkK
	 E2prVdLk25A63Wb5VrAMU4px5KRDXSwyLkmnnsoNC+U20BeWfKKrlKF+G5RXl9sj2P
	 VzGB14XiP14Tg==
Date: Tue, 29 Sep 2026 23:58:49 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Carlos Song <carlos.song@nxp.com>,
	Haobin Jiang <lemonoutput@foxmail.com>, linux-i2c@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: imx: add I2C_M_REV_DIR_ADDR and I2C_M_NOSTART
Message-ID: <arw0mVbacAXv_1H7@L30177.local>
References: <20260812-for-upstream-i2c-imx-lx2160-reverse-v2-1-f1343714c5a9@free.fr>
 <apcYp0Zc7CrJMiOh@lizhi-Precision-Tower-5810>
 <aqO9SMvI89rqoEGb@L23803.iliad.fr>
 <arMUxCW5ZTzLT3VN@L30177.local>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arMUxCW5ZTzLT3VN@L30177.local>

Hi Andi,

Sorry to ask again: could you consider this patch for i2c/i2c-next,
so it can land into v7.4 which is coming soon ?

It carries Carlos Song's Acked-by and Frank Li's Reviewed-by.
It still applies cleanly on your current i2c/i2c-next.
  https://patchwork.ozlabs.org/project/linux-i2c/patch/20260812-for-upstream-i2c-imx-lx2160-reverse-v2-1-f1343714c5a9@free.fr/
which I checked few minutes ago.

Haobin Jiang's
  "i2c: imx: honour I2C_M_IGNORE_NAK"
v3 is based on it, and waiting for it:
  https://lore.kernel.org/linux-i2c/tencent_342A87BFCECA70C9982E68A79AAD878B6909@qq.com/

If you prefer a v3 rebased on i2c/i2c-next with both tags, I can send
it too.

Best regards,
  Vincent
