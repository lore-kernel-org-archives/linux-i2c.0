Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309117;
	b=pBuuSdI/Q1H4bg2RcGXA5dBUc4DQnvu9PGsPlFKLBDZO46SvTWL1WhHTzrCqS915BYO6
	 NUuj84LaBADmsJ/76CvFm4cv2NrMTpDC0icmcEB7zKFsYfOEPuJZXfU4//1MVDMEjLEOq
	 4D4xJhgWSYPpc9eqB+UdE/Wl+iqTRKXW9H2L5KAB1bOP7zWNjxhdCmxHXKWS7oCslVE6k
	 c1oE8YUJ+iy9z6zO2sNpFGKC5E3V93S35IqmKOgS4PgJckxNlxbuk9gL1nesule+uGjqk
	 LVqbyi+l3QIo57TrnBxCNPED7Pb/ka17MHcamHFY7jpoYe8WbkZA27YBE0p9IYjwEuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309117;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=KwOMqReEGh0Ih1HTKwwC8fhh61cTvDF88ZgrH8p/zw0=;
	b=0fqIFpV3NlfVJTxuQKDpPuopPlILa/5S2r8BSxFzxuQmtVQMK7raOiGFPRc5+xKyFIUi
	 1T77GfuKGRm0j4tNnhDl7mcufGneWfdDGJL5J5CVl+AOmCTVy/3SnYsIeFXULQo1ICGhD
	 iP/pXrDlgRxuMLKqiYTarWF4ZHQH6QygVMdExugPJ5wR499M0MePT8Vug7ZaxasoVpOaU
	 EEj80lfICSOIMxnG/XJtl5Eu8c1CuhSKxrXJ2pcyp6GXrIoIMTes8IA4/Y8E69VJQKzaQ
	 blhz96RobDTUqrE8UithU4HOVj2u0GQIUSEnAqrPWpFUmReX9wJjx7tBHUQ6ieoSOQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=QYXnx+aS;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CDF606A326
	for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 11:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6CDF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=QYXnx+aS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=KwOM
	qReEGh0Ih1HTKwwC8fhh61cTvDF88ZgrH8p/zw0=; b=QYXnx+aSkafOzcSvfg84
	+n0fhAQDf3znURYRalx2f6M7bcGzQ1rO+qluar0Ep4W2h6OFl8gOwAewJx0+Pan3
	dPMe1MxRPZ7GptCOkWB1qxv3al+97t/CtWcAQd2rwNK4SN31coneVoF7c4Adg3Yt
	gjPiWxmJyiCiFCkRcntx1RMZz0fGxk07DTTb4IAKaA7cT1NrtdjpMpnEl3n9yj75
	TXCQEDCNmNc4ZChAPy/JbPan56r3xGYqrQEs4/6b+bgCYhCzmpY7L5AvzDCfczxV
	v/NUt5zgVO5JIccXDh7wM/ajsOEbKxNgEWYNGFRUPkrAGbfokTDlSZfJf19fcT6O
	Zg==
Received: (qmail 205390 invoked from network); 10 Nov 2026 12:11:54 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Nov 2026 12:11:54 +0100
X-UD-Smtp-Session: l3s3148p1@u8pgJepf4p8ujnsO
Date: Tue, 10 Nov 2026 12:11:54 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Stefan Roese <sr@denx.de>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 2/2] i2c: mt7621: limit SCL_STRETCH only to Mediatek
 SoC
Message-ID: <avL7-gfNNvO0s_gw@shikoro>
References: <20261103210542.15965-1-ansuelsmth@gmail.com>
 <20261103210542.15965-2-ansuelsmth@gmail.com>
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
In-Reply-To: <20261103210542.15965-2-ansuelsmth@gmail.com>

On Tue, Nov 03, 2026 at 10:05:41PM +0100, Christian Marangi wrote:
> The same I2C driver is also used for Airoha SoC with the only difference
> that the i2c_reset should not enable SCL_STRETCH for Airoha SoC.
> 
> Introduce a new compatible for Airoha and limit the SCL_STRETCH only to
> Mediatek SoC.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Will apply it to my for-andi branch.

