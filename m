Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A7737F01B
	for <linux-i2c@vger.kernel.org>; Tue, 14 Jul 2026 15:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042311; cv=none; b=XlbbKM8/2GNd3852smOODt3BjkGeHbV14MbhMahyXl3bqk/M/YIHW5rpkIuUQvPa31KsH75nRsM64NZjJiDu5YvmLBNTlQSl+HGat08kffEaqHdhTHAs049+5RX4Xl6/HWuBR1pwhH3BwhhtZ3K35hr882ZkVfgt1gMHIDDBSvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042311; c=relaxed/simple;
	bh=KZFmsRCRSQvYbRdnmIZb9m4Icw8GVMKVZP6cF94EoIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InNdm0kEkFm1SUTDycrQ4y+o8HfdNlmBfXwt7oAm+fOA0pElcOdp/29OMNvw+ce5n6waQ9X5Yaqh0ARSAIOJOjaaCLVrDp7YlBdw/x3abzxzp/e7aroD1k9kTqJ6vJzI72MCVDCvv94HDUnyBpT5UiiQBn5xdwCK5kXZR7iP+hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=oFdl4Wej; arc=none smtp.client-ip=212.27.42.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="oFdl4Wej"
Received: from l30177.home (unknown [IPv6:2a01:e0a:ac2:22b0:b030:e083:1959:2870])
	(Authenticated sender: vjardin@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 0A0B219F593;
	Tue, 14 Jul 2026 17:18:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1784042307;
	bh=KZFmsRCRSQvYbRdnmIZb9m4Icw8GVMKVZP6cF94EoIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oFdl4WejEPb9jOADJ9PERqIIxabMWactumv/UUU1OgKKwu16HP1AQ5igY8Pq6nGE4
	 hEryhlbObd5JXfhFLnFyHAv/onZ20DG5c7tnVu4Hejgpsd0yCu9tJsxgQMQqbXKo8g
	 fU+o3yDED2vRNoJNuJYXAoyXJSGOCqC0PPiY5O0RDiisjn75HGuLRLlNFoV44DY4/e
	 +czl0mrMnFrEDbdia/Lq3nXTsFlOv0RgXWLTeVLA+kexjZU9LPBop68IVZce6Zf4i+
	 kivuVbWUfyhC4zq2SO/qo/wT3ihRGheLBJTsYtYVl856YZFfIeWBJ0cR3HAywtZ1qr
	 KCs9U4F7QVL2w==
Date: Tue, 14 Jul 2026 17:18:13 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Wolfram Sang <wsa@kernel.org>,
	Kaushal Butala <kaushalkernelmailinglist@gmail.com>,
	Shawn Guo <shawn.guo@freescale.com>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	linux-i2c@vger.kernel.org, imx@lists.linux.dev,
	Carlos Song <carlos.song@nxp.com>,
	Stefan Eichenberger <eichest@gmail.com>
Subject: Re: [PATCH v3 0/2] i2c: imx: fix SMBus block-read of 0 locking the
 bus
Message-ID: <alZTNS7yq9cs7MSb@l30177.home>
References: <20260713-for-upstream-i2c-lx2160-fix-v1-v3-0-073ac9e103a5@free.fr>
 <alZO9GNx51oPBQuP@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alZO9GNx51oPBQuP@zenone.zhora.eu>

Hi Andi,

> merged to i2c/i2c-fixes.

big thanks
