Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309103;
	b=QyfLE46jC7zM9M4F3VJcBUIIPhOOqYISuOZlLGceZXRjdqf9AWzWgitOMqerxNKJPycv
	 Y+7FPCH8f3hE3J+HVpJz/yvqBf6O9e/eHtBwg7Ow5KKtWLjTvKhkdwPRcOIdME9JQFczQ
	 ni7nGR1ws85iW/2t9ljBkL6pQ5YoQ5cpaOnBI1RzAvQ0owhYUC2IDuPgf+6BIfiqaHIKH
	 8TgHyeRaeSdb05Jb3zFTw+CIxXW4Cx3AxzcaUF107iATbEzfOe1/RotcqqJZjaQkoR1rW
	 eVjqVO8pTlBh5l0Z/eqDzy2HMxNFC8DvHy1lNI8KIlXvxJ2+hjr0tTLJH7/cfsAytFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309103;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=URNm3AaV7OhkF+44lQ7GzK8Lve00n5qQDwL4NE/x4Rs=;
	b=x9LQOqSbUPYl+uMU3GsNH5ZpvXI/WY37sHp48n35aGcFmKB6qrB43gugV29NRMKT9B8u
	 UtxaOYSpNlhq7/infFaeJWaDXyPxa8DOd/A5Rf14y9FdUaX33ybfvuCplRDiEiusgEVcq
	 FsbuCKtcoPnGymjG0QYEm8gHI9Lk5WR6E/pGu3YWlXX918LX1gXSGxdV90CwdYeiOLNeV
	 MBlK9pogYbNUpbOBFFP+RlGkIcivZM9bhu2fuxpjuybI04HAvPsWuSDq5XbChihGCiilz
	 GM+ZOe2is9JIRKfAr03TU0ZPYELHstv/u4IU7WaxqZOUUUaXA1xhO9xqg9k7cTTBbzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=i02rXB+p;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5F0606A32A
	for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 11:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F5F0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=i02rXB+p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=URNm
	3AaV7OhkF+44lQ7GzK8Lve00n5qQDwL4NE/x4Rs=; b=i02rXB+p+ezyY+T9IzNM
	Qg2/TbI2j1IeV/mdj4IIhfjWhMyv16kR7h8KHBe7WvPbbRwzqIAO6kKL5kZt7SZu
	l8RDOCA24sMzfes2GshnBEOLdXameStP3o59qX/+Fe3mhbk1zso39dc/Sz8KGEof
	d6Tmlb+fvXpfodwK581vA53aIjzj/iPeIiTOeeDAWbIVodLaK6Z50EozW3xTO8Yv
	6vH01sByRlmBMYbHfbO9bvonGnvVwVkUCFwaKQ4DH5v6bDS7JWuys49PF+PFul4g
	zt2GzSbpMy7NGESJRKYoTmp0GnbAX9IreOiLjSNgpHp4jU1Wr2ZC+7GibPjFCJ7g
	RA==
Received: (qmail 205301 invoked from network); 10 Nov 2026 12:11:40 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Nov 2026 12:11:40 +0100
X-UD-Smtp-Session: l3s3148p1@FtiBJOpfzIQujnsO
Date: Tue, 10 Nov 2026 12:11:39 +0100
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
Subject: Re: [PATCH v3 1/2] dt-bindings: i2c: mt7621: Document an7581
 compatible
Message-ID: <avL76_zF5NizIRMK@shikoro>
References: <20261103210542.15965-1-ansuelsmth@gmail.com>
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
In-Reply-To: <20261103210542.15965-1-ansuelsmth@gmail.com>

On Tue, Nov 03, 2026 at 10:05:40PM +0100, Christian Marangi wrote:
> Airoha SoC implement the same Mediatek logic for I2C bus with the only
> difference of not having SCL_STRETCH bit.
> 
> Add a dedicated compatible for the Airoha AN7581 SoC to account for this
> minor bit variant.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Will apply it to my for-andi branch.

