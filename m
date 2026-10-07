Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5B9346FA8;
	Wed,  7 Oct 2026 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394989; cv=none; b=Nfz667HUH2pYWjGIXNbHLlcvkfD2ca6vUQrsAE+ocNr74NeZRbYBpuwupfbXHIAQ7sx37SNmyBkeX78xwRxHUDM+Fi6GUL594W34Zhhg9Yp/pknox1+fKSM25WbFVxOM6XWsvS+BTRLSpw7VT5T8MGCYCzaDZ5BYX/TEx55hmQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394989; c=relaxed/simple;
	bh=pLfXra5Jo90UbwTBsB9NGQ3f0bIBVXsiTTgt1LOnb6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3BJFOYz8AjB2oejfBI8xtkwJ3vjpToFbrfZTZUdCh5kM1fztT+BkY8xP2Mp5Af+WG57+rTGMJkdC8HGyi9lIypW50h54zwYhOvIEYqhycuHwu3g9NdTeCLDd/YHstTs85L6dBBN+6oJe3ORIdfb6KlsQllPfslCFTFvKjAb3sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=eGySEcTv; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="eGySEcTv"
Received: from L30177.local (unknown [78.242.246.191])
	(Authenticated sender: vjardin@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 1B23B780505;
	Wed,  7 Oct 2026 19:42:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1791394985;
	bh=pLfXra5Jo90UbwTBsB9NGQ3f0bIBVXsiTTgt1LOnb6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eGySEcTvLGf1K4n+0/B5s8ni5lHAHsIVa8gSTFnQpWZoKM2Bu0g3wom+bNh55IjmH
	 i3PPKg+dy5xd6+1NpM3E2cpVDUw7jxHsi86+3I3Ipez3E42KgssjqmXE5ggf2IBwvu
	 D4D+vWa/TKg2wKFm61IQrLQlpjkyaPhpFiaqCdcr4e0dMNf0Dcp85Cmnx3KrSQf3HQ
	 fjLB1VzTmpLeK47WFQPOivfQRUetQLqfl66Wm7NIplwAIzhv5SDwPPFlcC6I6GtZzB
	 1IIiMLM0TzkX0nZiYEvyWYDozke9WLCWoqoOAW8zqR4uX1xZ/lH0AdZqaWIemBeQKg
	 4F+zBWY+mrDLA==
Date: Wed, 7 Oct 2026 19:42:45 +0200
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
Message-ID: <asaElUqBu5ht6amB@L30177.local>
References: <20260812-for-upstream-i2c-imx-lx2160-reverse-v2-1-f1343714c5a9@free.fr>
 <apcYp0Zc7CrJMiOh@lizhi-Precision-Tower-5810>
 <aqO9SMvI89rqoEGb@L23803.iliad.fr>
 <arMUxCW5ZTzLT3VN@L30177.local>
 <arw0mVbacAXv_1H7@L30177.local>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arw0mVbacAXv_1H7@L30177.local>

Hi Andi,

Sorry for the noise and resending again: with v7.3-rc7 due this Sunday if
I am correct, could you take this patch into i2c/i2c-next for v7.4 ?

It carries Carlos Song's Acked-by and Frank Li's Reviewed-by and it
still applies cleanly on today's i2c/i2c-next.

Haobin Jiang's "i2c: imx: honour I2C_M_IGNORE_NAK" v3 still depends on it.

If anything needs to change, tell me and I will send a v3 right away.

Best regards,
