Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794306280;
	b=pg+ZNF8kQCEqO9HL/pW3EKDYAL51PshBlCms0Did6HfdK6wNZEnYO6Xz9zZdUvvdYmZP
	 svh2iz6dpljp69nuzfgqaDSpSjr+KUSminZ9YE8g1iYolQzTh8eoc6Fw1ZGKLHXdL1a95
	 z5dyU8dXd+4Py/xeRpsvfNHHRxCzHDsnCoANW/qRB10AYl3DWaHNeLIfxyhNl3S4pZr9/
	 8fscGa3vdww/7gKZsi2vEnltfoRnCcLExW+5jlU/+ignyS5tZIRm+kvwkI2bHzACQOUGu
	 f1Zi04BkkE78K2XGXTj42J+kW9kzg3NhZdP/VRg4+V/z7dhCDAWsnQmH/4IH0CN9r0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306280;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=132X4kEugYv0DZ68KeYi71Q6KKe1Gy7rUBXRX5SCGWo=;
	b=V3X2jVs/xl3RBX8ii4nOnhspjdgztO14qWnXki0ccHrthC+ZYwDOiACbGeIHPYOWSEnP
	 S7daS/5IFZ80mcoTNQQJl5QpBZN+ZRI7vh4O8Gixo2g8rzjczyAK9tGYGVQxR/i0Yii+C
	 Nr8gaMCap21ZEpVjfpTEoLpPp8VIUaqpGDOHJ/WX66E/xParK5O86GlWQhBhvny7bqWCs
	 mG6QQ9TgI7Qc/HzCV+lnTK0vgg8HZYcQuB3+FjG5qWisgQ+6glJqvZbG8EwYfQY60G1cs
	 CydDXmpptW1o+Npr8JNYwPpP3JzcX4LAX9y8CTHG3jM7thlt4RtUPO02FkOLil/zbvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=Xc1z0BjF;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78326606B9A1
	for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 10:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78326606B9A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=Xc1z0BjF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=132X
	4kEugYv0DZ68KeYi71Q6KKe1Gy7rUBXRX5SCGWo=; b=Xc1z0BjFQqgkvGOLnR9+
	OyhAU8VyWf7eyOFIGj24cvVLNQ5vmQv8+TXX1n8Ap2kUrVdmmYXmwMfah+ryYnuc
	+ekewvukinYw3GkscbrpWqCCTe6N/GbrNg2o4DwoUdGhFHFr83C4wRo+9xawVXrI
	BB/xRHXCHfBjwCuw/bUmUAMUQnZSs8nzEXDKUCIWBMoacmTMYS17z7jbJALehaeo
	I/Ysu2pq2oWOaxDfYIJHrE+Gj9X0XrmjQsr+uUA44BG7zgDNpv4OlvZu+9+zIbKz
	6N96RuRjCc51wBADleWnmTkT/i1wulxc+V7Tt5ClfKKyQL30Emu9u7Rx9Lo0y9bt
	uQ==
Received: (qmail 187945 invoked from network); 10 Nov 2026 11:24:35 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Nov 2026 11:24:35 +0100
X-UD-Smtp-Session: l3s3148p1@xMwtfOlffIIujnsO
Date: Tue, 10 Nov 2026 11:24:35 +0100
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
Subject: Re: [PATCH v7 5/8] i2c: of-prober: Let cleanup op know if a device
 was found
Message-ID: <avLw4zVtmr9WEQLR@shikoro>
References: <20261103043734.2179858-1-wenst@chromium.org>
 <20261103043734.2179858-6-wenst@chromium.org>
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
In-Reply-To: <20261103043734.2179858-6-wenst@chromium.org>

On Tue, Nov 03, 2026 at 12:37:29PM +0800, Chen-Yu Tsai wrote:
> The prober's cleanup op may want to do things differently if a device
> was found, such as wait for the actual device driver to pick up
> resources.
> 
> Add a parameter to the cleanup op to pass this information in.
> 
> Also fix up an incorrect reference in i2c_of_probe_ops's kernel-doc.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

