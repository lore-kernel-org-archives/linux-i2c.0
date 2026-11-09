Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794207796;
	b=Vb2uDUOBvX/oRVu2jIqF3SCodoUH6xbw85rOwyOB/RcBc93aTpz2zVimH8nUsXf4eiK5
	 n1dmpHTYUJRXFXbn1poI4z+3AmQepOcubOsnKj231PgQnBsNQiUbFJnmN7JWvgO+QJbHG
	 jKjMZSma6ELkCu6cu5/NOYIMbSDgHI9JqYnUaKtfr9RVfWptg16ivVNpef10rJpSP7jvv
	 Z4/Bs7vFwufjh1taoAuuLDcUC5WIzMy7kVrN6rWDT3ptnYsXDvfQiogUFVS9Eix0qUMEv
	 /JMu0LJgni7GHZ5lR0HJDxpu4DUy8Ac8FGtPAB8iMTKQ88QN+Cj7djnZ3aVuUFioKTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794207796;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=n6uuG2uPB07i0EMDMp6389WOiI/04+FhVXHCP2g9r7o=;
	b=QH9EH30aPEH7zL6Nz9GgekyeoUqEH8EBbvmHukpvMevZvXqpZEY/H+2bmqB1PEAUXiAG
	 2ZFp2/rLi7DMn92fgq/C09I8aq8yNuZS2E8GBmr8sAryxmCXGJqBnjmc+aKv7akLugy3+
	 ymaUTQO3d5MqCAKyLHxHrtu5W52JZVlchf6Mm92/TAZyCklRU4QD4PRIN4qLosfcNVDQ0
	 y/yTJinAV8YrSBa6+V3BJyOzzNhDLt6mr8uC7Rf0JFJ0r4TlGF4d8gDW7kDNN5ajG6LiT
	 W9+gGnZConxaCzUHABQ7tYxWdVUuLy9awMoIy15Fg/a5HUGaOuQNZtWuoLimvx0sVQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b="FUI09/nk";
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B32606A321
	for <linux-i2c@vger.kernel.org>; Mon,  9 Nov 2026 07:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30B32606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=FUI09/nk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=n6uu
	G2uPB07i0EMDMp6389WOiI/04+FhVXHCP2g9r7o=; b=FUI09/nkUWlAuWPONUzm
	PBpyFxvz/uvZaoBZMiRROWtgh4kAXo/iNQpNNBHmnyoC5VOoayHkypsy9YXg8p5R
	doZHakc+1UkQUcclrwYqT4Dw7uLw1AKy/Ol4DoPqIin7IBrDx8K78ga4JkQQDJ5j
	4WpS/zSLvQD58t/WiZgnEfwnzhciwGhgfuoLUzum5a3pyYKNu16F6EgCxc12OR4M
	oO1zfTqPBzFPXG8DgNMdNwNJq2WJA/J4Obkxc2oIryygANbp8/ngx9cdlmg+B7Sj
	baY6vQ3riQZuriQDZcCMmzCODNaqzY/Dny0LEAXeuL/ZlHyB1/pnABJfMLWL5QNd
	qQ==
Received: (qmail 3132570 invoked from network); 9 Nov 2026 08:03:09 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Nov 2026 08:03:09 +0100
X-UD-Smtp-Session: l3s3148p1@qpDxjdJfkNoujntg
Date: Mon, 9 Nov 2026 08:03:09 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Cc: Linus Walleij <linusw@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
	srinidhi kasagar <srinidhi.kasagar@stericsson.com>,
	Ben Dooks <ben-linux@fluff.org>,
	Andrea Gallo <andrea.gallo@stericsson.com>,
	linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] i2c: nomadik: handle pm_runtime errors
Message-ID: <avFwLctRcnJHtINQ@ninjato>
References: <20261103-i2c-nomadik-fixes-v1-0-655c6af2cb70@mobileye.com>
 <20261103-i2c-nomadik-fixes-v1-6-655c6af2cb70@mobileye.com>
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
In-Reply-To: <20261103-i2c-nomadik-fixes-v1-6-655c6af2cb70@mobileye.com>


> -	pm_runtime_get_sync(&priv->adev->dev);
> +	i = pm_runtime_get_sync(&priv->adev->dev);
> +	if (i)
> +		return i;

Testbots revealed a smatch warning:

drivers/i2c/busses/i2c-nomadik.c:737 nmk_i2c_xfer() warn: pm_runtime_get_sync() also returns 1 on success

I will fix it here.

