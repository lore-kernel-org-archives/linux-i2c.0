Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7524570FE;
	Fri, 11 Sep 2026 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789115740; cv=none; b=pxsyjATzGV2A6nn0IyK54ElDRrZY8RXlCIzlpLS4eoLt1UjNgks6n5jKgqPGu1mYk/yNKlkftiqHyBy44UmwpHOHTmKCNQFVjdB1tlYmL47/TxWUzNqtv1mgX3iGWXM7KcBCiITDpWBSnhGtcCjkbkDpWeIH84VIL4bpAOPOgNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789115740; c=relaxed/simple;
	bh=ig7/VBNGQp4N6xzwFvEIbedNVsU144MO3YycJQR+XF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjy+qQFeCDHxdtzBHsUwfI6TrmjZ+JZb8YO9RL3wN1I8gv2ULAKW/ulWVboDkDSY4x4TjaIJStwjJTnJN7QFp+rY6ehRQRisnchpPKnXqXdX0iStlykOoBPV31JGYPG3GNk+dFbaI7nIATpbeeQVDfODCLK/CUg2P0j5cHCCm3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=sFuXVKC8; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="sFuXVKC8"
Received: from L23803.iliad.fr (unknown [213.36.7.12])
	(Authenticated sender: vjardin@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id BEFF278035B;
	Fri, 11 Sep 2026 10:35:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1789115735;
	bh=ig7/VBNGQp4N6xzwFvEIbedNVsU144MO3YycJQR+XF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sFuXVKC8gcz33vzI6iud7xnwtR8omZZp3V8ueO5FVefKCawC2bMckcOAoLHVCQxZu
	 STDdrciSt+1dY1QtAdusNQpJNyBvQryjI9LKTC5evbNxVtkhUIpqyUqWZ/wL8ZnIeM
	 nf+mnrjnpNmwUj9NTc2N2OZAVzqbf8r4LQsqjv36otaHyKNtcCGA8f+Fm8VuG1DZti
	 u9QhWinvUoMUiUOS9zyIamIVNfsjEFYjvcIlGx70Yj5qZQ8sKonivOTeDRZ1YSxxqB
	 xA7dRpu30XscryQaVmFIWPaIob8u1XjtkO1gJuXNrGNj3okA3X40HjHpZm7RY+HTVL
	 mvdgNt5W0QmnQ==
Date: Fri, 11 Sep 2026 10:35:20 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-i2c@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Carlos Song <carlos.song@nxp.com>
Subject: Re: [PATCH v2] i2c: imx: add I2C_M_REV_DIR_ADDR and I2C_M_NOSTART
Message-ID: <aqO9SMvI89rqoEGb@L23803.iliad.fr>
References: <20260812-for-upstream-i2c-imx-lx2160-reverse-v2-1-f1343714c5a9@free.fr>
 <apcYp0Zc7CrJMiOh@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apcYp0Zc7CrJMiOh@lizhi-Precision-Tower-5810>

Hi Oleskij, Andi,

It is a "gentle" keepalive on this patch. It has been sent last month and
it had been ack'd by NP (both Carlos and Frank).

Is there anything else you need from me to have is applied on i2c/i2c-next ?

thank you,
  Vincent

> Reviewed-by: Frank Li <Frank.Li@nxp.com>
