Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3001D3E9C11;
	Tue, 22 Sep 2026 23:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790121174; cv=none; b=aD5lYwAkV/dD7fDjPfWSB4L28qskyaStNtZHKSAddRUf+Ya8PC/aTBxgNIUt9o/v5PKQ9fT88MIWkED0w4RSzmgor9pWaTKt9enKe1D36rWBk4a1ONQA+5+Bm4uq88tLdJqz0x29j9KAMe6Q56H9i2wwXXzWsofJxJtpHJp9yM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790121174; c=relaxed/simple;
	bh=fOkL1hSKJnjCwTHhXl0OSRfcdCEWcoIUhfY9FGgJdzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3O9ibhZ0kzgwKNwjLdseZXX6QPv8EIxG4YU3Rk8aupRZ8edSdSdg9VOlrBxHF+qOA55KXmegxE+/b6NCqOlip3l0zhWqdTtNv4ZIl+wJ2KPhnT+npmSIE4LA33SvEHSrRpGYu+kdKrlybu2+fh7YayxupNgYSntJ60ernneil8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=TLu/vrpE; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="TLu/vrpE"
Received: from L30177.local (unknown [IPv6:2a01:e0a:ac2:22b0:2cdc:bbe:fc6f:48d1])
	(Authenticated sender: vjardin@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id 3A3835FFAA;
	Wed, 23 Sep 2026 01:52:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1790121169;
	bh=fOkL1hSKJnjCwTHhXl0OSRfcdCEWcoIUhfY9FGgJdzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TLu/vrpEkcMTNJsY870IVqM8YtkjChmSCll7W9eE2ihzus8ps7aq8ma9xQL2wwGuQ
	 rdUUASiduU2FQZL10+kQg6QbsBMQanF9pHlczbJaORSdxeEIaWChzac3GavMoXkvyy
	 t0gm8oWh8pgmdlRK5OXS03JnhuoWk9XM45oXRSKpAi6wrHcs5oKSUTK2YCW5miikEX
	 pbu5khiOMfxx9h2H6X5O+22UxRUNT3uvbBsqC9KIZ81e4Cm8sRBnV7Bh+IzFKmHSUv
	 a2R1bhXF6sBb+epqCHrO6brXNf6BvJ1d+ijWwsJA3hWESgXwPbu8RrnKfbV9pSEjNL
	 VHvfDukBW4Y5A==
Date: Wed, 23 Sep 2026 01:52:36 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-i2c@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Carlos Song <carlos.song@nxp.com>
Subject: Re: [PATCH v2] i2c: imx: add I2C_M_REV_DIR_ADDR and I2C_M_NOSTART
Message-ID: <arMUxCW5ZTzLT3VN@L30177.local>
References: <20260812-for-upstream-i2c-imx-lx2160-reverse-v2-1-f1343714c5a9@free.fr>
 <apcYp0Zc7CrJMiOh@lizhi-Precision-Tower-5810>
 <aqO9SMvI89rqoEGb@L23803.iliad.fr>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqO9SMvI89rqoEGb@L23803.iliad.fr>

Hi,

Le 11/09/26 10:35, Vincent Jardin a écrit :
> Hi Oleskij, Andi,
> 
> It is a "gentle" keepalive on this patch. It has been sent last month and
> it had been ack'd by NP (both Carlos and Frank).
> 
> Is there anything else you need from me to have is applied on i2c/i2c-next ?

Please ?

Best regards,
  Vincent
