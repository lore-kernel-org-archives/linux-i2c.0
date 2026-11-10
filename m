Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311439;
	b=171Ia25d6nIpSKM1BXtQemzG2TICWr6nUNWLGicm4p2KoIK2cMZpZ1xj/FOUOu0vi6o6
	 mbRkNnVpGCaL/v/NL+Gqch8AM9aA7rmqkaxYSsgK4VcmP4EhXoqS8vnqGJ+qaEfNwxCzf
	 4MnDD8CBY81T5uHt7JDn0Q0rnK2vT514H0fwS2Vv6D8MEFBGI6kZecaM0V7+GKFG/2Q38
	 CLI622C3HnqxEEoSFD0FbN2IfMw8zTpSj3wtk1B8nHFpkMS/V433yLM/QtiwOds0Us0nA
	 sHx5plo7fOKs2uK3j942wWMrcTp5JpdBysVyCfFWpCYNvsHw7K2kCr5/7PnpOytvX7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311439;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=bcbyBpfKFotUtkK3419Whkt3ZqxnZWFJhglCb1Z/icY=;
	b=e4yvMNA6xTjfhZYRcZZOlbSvZsnKt2lfZIAK5AFvsgZ9wNGgIKgJbG2H9wkPvJqFwA/N
	 k5dGcClK4IC0hWND3bhV1R4SICxrKo7YoSvHLnPo4V7sc5s2vrolnNLF79ygqQe8xer0b
	 yYsspy/DQB7n72llqMUN7KaM/ldiSmdsLVfX3GkLrzi60FK8brK8L5IJF8D6CuQKPctCf
	 Md/95PPExmk0crp1hO5qLjGtdCq0PgOdqKG3R599oatKA/GTpLE416qYq3Y4CtrtB5tPL
	 QW7B+TOVv78hS5LqUkCCqoyyuGrVtP+1Ue8GyoCSwlWNMWmzdFDkyn2ZnAlQVhs+AUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=BNYYiQQY;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823D760A3806
	for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 11:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 823D760A3806
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=BNYYiQQY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=bcby
	BpfKFotUtkK3419Whkt3ZqxnZWFJhglCb1Z/icY=; b=BNYYiQQYi75l6d9KoGPk
	Xp1iXzkmcUefxSNr9uIPQ5qfsWv/8sstBqUKea2N4o7mFa6b/bUalZQeRV6b8MDm
	2cg9PQPuA+V6dOO/eEguVjRreV4ekcHRPAAiI7EX8JSz7+bkIVxxNsgJgHkK+xMo
	+RWkRICJ5lvq9XSpjDUs/nIGzRrDHpPGUotTBS3AT7SZLui+axZHnxBz7p+vv2JE
	T23rd45mgIFA4cvClo4W/vUgnYGA5iWK2GR2MPtvihTKwxrXQ+V1vq1yyGiMJRfL
	k3AT57+twO3gFf2jp4JmyXmCyEdbgdKgF0m+h2QDAWfVcZafygalp4StUlKEUJ6m
	OA==
Received: (qmail 217250 invoked from network); 10 Nov 2026 12:50:36 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Nov 2026 12:50:36 +0100
X-UD-Smtp-Session: l3s3148p1@vc2+r+pfBJQujnsO
Date: Tue, 10 Nov 2026 12:50:35 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Johan Hovold <johan@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] i2c: dev: clean up registration
Message-ID: <avMFCwqx2X6pl4hP@shikoro>
References: <20260827102043.673273-1-johan@kernel.org>
 <20260827102043.673273-4-johan@kernel.org>
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
In-Reply-To: <20260827102043.673273-4-johan@kernel.org>

On Thu, Aug 27, 2026 at 12:20:43PM +0200, Johan Hovold wrote:
> Drop the get_free_i2c_dev() and put_i2c_dev() helpers and do all setup
> and teardown directly in i2cdev_attach_adapter() and
> i2cdev_detach_adapter() for consistency and to make the logic clearer.
> 
> Note that the device list is only used at detach so the i2c-dev can be
> added after registering the class device.

Can we have the last sentence as a comment in the code, too, please?

> Signed-off-by: Johan Hovold <johan@kernel.org>

Other than that, I think this patch is an improvement. The logic is more
explicit. I didn't like 'put_i2c_dev' having a bool parameter, for
example.

So, only patch 1 needs a bigger update, it seems. Rest is looking good
to me.

