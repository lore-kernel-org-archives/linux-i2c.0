Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794306288;
	b=zI9iUcDM/ig/oelDb2ZgC7gkAUzQJsGTGr2Q37YDruYUT0LpqbFWp2bX8x9nVrCkhVRX
	 dbyOcY/aaPvTOvnM7pXbGh63rSR7g2kCeDG3wb34SKflqDuK2+fOT1JQP90J5Zl3UBZpb
	 BpsQaGZSVzZwk+26kdrn1vXMjNrD+5Wr2QT5s9TUoyLQ4ajAn/s4HGaBkvPeXMKSnm0bU
	 OtEDOkE5gFlBnKOkXHMDmrpRjz7Ux6hXmdPHJSm0AodxKDPtSy4tbr+rzMGCa108undSS
	 gQIFHMm2RTJY1NDGZY5ZKURvepWyv0uOYvWfPkg2+fCOHmZX31u5HInomjOc0ThVIkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306288;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=EhDjNoe3/JC0Wvq34jTb4Txp8C72674LsLZBKo4ri38=;
	b=EyG6CoTIVfVOMYeEvGP2RUUf+duf6nuvTs9LLXlVSW6aIAPTchv+rWmb1O9xAHzeFHgx
	 QvZyGgDo1amL51lc4F0AqWmMHum8g9yJc8xf96+7VPWAxHJW4wcvtJP8cmjBv8EaQZaKI
	 dnCMKp7GCE/mps/GrDe5tGkxi5rAi6SUeL1aHXe5q+kn9ktUYiFVWQjKXv+ndi//6QyVI
	 xiHM1HADpzSlH8gyyvdDrD5Dd1eLnEwcafWydJGVdvBscKVzV0rk+sq04NsD6eW/GmgNc
	 /2Oo9DSsN5diVLr9y6EY2aCsMDaGt8jW09dqwfIQNRVcs7Mzzj7PmJj6hwMQrZTB9pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=TNCFRS9K;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35C6606DE19
	for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 10:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E35C6606DE19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=TNCFRS9K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=EhDj
	Noe3/JC0Wvq34jTb4Txp8C72674LsLZBKo4ri38=; b=TNCFRS9K+hFp4Rdn4i0u
	ltnPkaWkMoaqydg2WtduSpQ34JwM3o5hAunPza0rJ0+Me/aJc+YUUUTteWx5vBbd
	xJ/MXF2iC+/sZixjVWv8RYDMNNAv/M9bF1H/w9KGgdPI9cCGt6jEp5h/HXhbLMn4
	kuAzNSsaSyurbxWzChy+HzOiG6uPrhsqvhsq2UbLqLqiNlgpxie/aVPduwzN2PJ5
	+jMwd8HXrVynOZ3V2fPayIXM6jiTno2QTKRGI9+fDqJn4Q7/Z5ZlP/hSmPxUcllT
	NMb8ibdtlIDHaEz3yXy5ucxgIRJvcOWi2Lygae3YKRB6MZNzQAJImk56YbPuo3uF
	1A==
Received: (qmail 188051 invoked from network); 10 Nov 2026 11:24:44 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Nov 2026 11:24:44 +0100
X-UD-Smtp-Session: l3s3148p1@tqO2fOlf8JsujnsO
Date: Tue, 10 Nov 2026 11:24:44 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev, linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 6/8] i2c: of-prober: Defer regulator_disable() on
 successful probe in simple helper
Message-ID: <avLw7DllX_VM7wex@shikoro>
References: <20261103043734.2179858-1-wenst@chromium.org>
 <20261103043734.2179858-7-wenst@chromium.org>
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
In-Reply-To: <20261103043734.2179858-7-wenst@chromium.org>

On Tue, Nov 03, 2026 at 12:37:30PM +0800, Chen-Yu Tsai wrote:
> When a I2C component is found, its device node is immediately enabled.
> This triggers device creation and driver binding. The prober will hold
> the regulator enable reference across this part. If the driver probes
> synchronously, then it happens within this window. On the other hand,
> if the driver probes asynchronously, there is a high chance that it
> happens after the prober's cleanup function was called, in which case
> the regulator would have been disabled when the driver's probe function
> is called. This would then require the driver to wait 100 ms for the
> hardware to reinitialize, even if the probe function was just a split
> second late and the regulator was disabled a few milliseconds ago.
> 
> Recently, some of the drivers for the components that are targeted by the
> I2C OF component prober gained the ability to skip waiting for hardware
> initialization if the regulator was left enabled. This happens when the
> PMIC has them on by default, or if the component prober left them on
> after probing the component.
> 
> Tests on the Hana Chromebook showed that if the prober and trackpad
> drivers are both builtin, then the time between the prober enabling the
> device node and the trackpad driver asynchronously probing is between
> 5 ms and 30 ms, though sometimes there are outliers exceeding 100 ms.
> 
> Wait 100 ms before dropping the enable refcount on our end so that the
> actual driver has the opportunity to catch and increase the refcount on
> their end.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

