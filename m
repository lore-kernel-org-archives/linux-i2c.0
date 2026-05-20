Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287AF3FD131
	for <linux-i2c@vger.kernel.org>; Wed, 20 May 2026 18:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302660; cv=none; b=WwFpjzaf3MeFJLgO9QjCg44ySZ7S/NsBL+zqx58/qCHpzrzby4P9tWgXX6Zm0dhX6vXQ9fe0BJcL4fjsOgSiXoJTtXoAGO0sq9yVCIw8Lq/gbc2IgAjvkI0B62MnhQ0D6f6DS9nBTh8gxAceG5Y11FxCFN+AX88lBGGqqjlKjao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302660; c=relaxed/simple;
	bh=LyHBGHh0pa8085eT7UHWuWdYRG7dAT6dfZHVJNoi4DE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nx8wzek29JeAOKli4qyjU6/SpDkSqRcdcq/kMokRyoY77KloAG0lXtZi380KfbOYzGvWpDV1amt4pn4n8Ldg7c/qZWHklyVB260KbwYrdKq1eTSOOO1/39+G1oI4SRo7ufhxNGhcC5Xh4DnQYYPbB1S3MvJrm1N1hvS4Nj2qqgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=1LX5NcJ1; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="1LX5NcJ1"
Received: from [IPv6:2a02:1812:162d:3d00:c381:7255:a866:916d] (2a02-1812-162d-3d00-c381-7255-a866-916d.ip6.access.telenet.be [IPv6:2a02:1812:162d:3d00:c381:7255:a866:916d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id DCC16785F41;
	Wed, 20 May 2026 20:44:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1779302657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LyHBGHh0pa8085eT7UHWuWdYRG7dAT6dfZHVJNoi4DE=;
	b=1LX5NcJ1cD+X6QFdPyfLllb1+FvgX/YCJb2c8XI+OeMjjkNivSwscgCxCmRCNVodVPVIM8
	odCuFIIEeDESCRgcl2FQrk1iUDDLt6hMZuN1693Fzt3XGJ3kNVWQ/sb9+HS9kjYxUddmZl
	5I3H+nW7jyX1MCL2ERzimNBhu/wIDRAMZHWGjuzZjayPp9uVy7Y7t4ua8xewJ9jh97ycXa
	XPyh2RGz2fcgm4P6bYWj8VfokchHBO/G+JexNrQXtLNqGWrlfJDddzfnqi8Uyl2VmPXnnW
	ype3WKyphpVcXRZSNft7N3PlJfOa9iz78QQUDkAct1G7CJcn9pNTgNHcO1PUYQ==
Message-ID: <bbdc75ed03f5af92a1dc16095ae5ea60875a774e.camel@svanheule.net>
Subject: Re: [PATCH v3] i2c: i2c-gpio: Enhance driver for buses with shared
 SCL
From: Sander Vanheule <sander@svanheule.net>
To: Markus Stockhausen <markus.stockhausen@gmx.de>, 
	wsa+renesas@sang-engineering.com, andi.shyti@kernel.org, linusw@kernel.org,
 	brgl@kernel.org, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org
Date: Wed, 20 May 2026 20:44:15 +0200
In-Reply-To: <20260520173129.1382489-1-markus.stockhausen@gmx.de>
References: <20260520173129.1382489-1-markus.stockhausen@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Markus,

Thanks for looking into this. It was on my to-do list for _long_ time, but =
I
never got to it :-(

On Wed, 2026-05-20 at 19:31 +0200, Markus Stockhausen wrote:
> Some lower end hardware (especially Realtek based switches) are
> designed with multiple I2C buses that share a single clock line.
> E.g. the D-Link DGS-1250-28X realizes 4 I2C SFP busses with 5 gpios.
>=20
> Enhance the i2c-gpio driver so it can handle such hardware designs.
>=20
> - Detect GPIOs that are used by multiple I2C buses in the dts by
> =C2=A0 using a unique identifier for each managed SCL.
>=20
> - The first probing instance allocates and requests the shared SCL
> =C2=A0 GPIO plus an associated rt_mutex. Subsequent instances detect the
> =C2=A0 existing entry via the identifier and increment a reference count
> =C2=A0 to reuse the descriptor.
>=20
> - All data transfers are serialized via custom lock_ops that handle
> =C2=A0 both the standard adapter bus lock and the shared SCL mutex. This
> =C2=A0 ensures mutual exclusion across adapters sharing the clock line.
>=20
> This patch was successfully tested on Linksys LGS310C that has two
> SFP slots with two GPIO based I2C buses that share a sinlge SCL.
> Test environment: OpenWrt snapshot ported to kernel 6.19.14
> including CONFIG_GPIO_SHARED=3Dy and CONFIG_GPIO_SHARED_PROXY=3Dy.
>=20
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>

I've updated my Cisco SG220-26 devicetree and it now boots with:


[..] i2c-gpio i2c-temp: Slow GPIO pins might wreak havoc into I2C/SMBus bus
timing
[..] i2c-gpio i2c-temp: using lines 565 (SDA) and 551 (SCL)
[..] i2c-gpio i2c-fan: Slow GPIO pins might wreak havoc into I2C/SMBus bus
timing
[..] i2c-gpio i2c-fan: using lines 567 (SDA) and 551 (SCL)
[..] i2c-gpio i2c-sfp25: Slow GPIO pins might wreak havoc into I2C/SMBus bu=
s
timing
[..] i2c-gpio i2c-sfp25: using lines 549 (SDA) and 551 (SCL)
[..] i2c-gpio i2c-sfp26: Slow GPIO pins might wreak havoc into I2C/SMBus bu=
s
timing
[..] i2c-gpio i2c-sfp26: using lines 550 (SDA) and 551 (SCL)


Four busses sharing a clock line. Nice! SFP detection works and "sensors"
provides meaningful output for the fan and temperature monitors.

Tested-by: Sander Vanheule <sander@svanheule.net>

Best,
Sander
