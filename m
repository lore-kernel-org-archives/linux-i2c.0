Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088B838F94B;
	Thu, 22 Jan 2026 02:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769049752; cv=none; b=XjMLEXcdKDwJf04Z8jAw2ax0YtMnqJ/3A2x0+G0xorYDAcmqonaCBe/3TvAnY/0H1uq7ZHO0n+IoV36bqcV/fvjxSTBp4+Z9J+wXP4QyfOXQR30I10m+fxz6Zfhioec8DU5EDheF/LNwcjVuXbcBXK1/kW3ttHtgwIf1luEIL7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769049752; c=relaxed/simple;
	bh=OSp5I9nulPPxdvzFSVI3H8ywydl3nfy34JloJ6SMU30=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BEKARv27NfH8p3NCZfuR0KyCOFpIwwRGcc9fPcSVoUrIlVoaxS2KQd9j4A4beSqAW651efH4fgNPOEm8sEjfMMXX5XHjMVofp5hJq9/u1JmdW5SHoIGO0c7MIHvy1sjXUTQebFfTYdnTXhKAzt9YAH7oNGzL2w3cbnT/jTlzRBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=vVD2ezAQ; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="vVD2ezAQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1769049651;
	bh=OSp5I9nulPPxdvzFSVI3H8ywydl3nfy34JloJ6SMU30=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=vVD2ezAQeUXmoHQGfJduIJQjTI+k9pnnT9C2zdekHpCRLxsRz4jdogAXC02Ijtm9o
	 5sIryLBv3PKdPUKP4Fw79L/SWGERav0n/2Nbz0uBh5EyStAgnB2hss7Deid2vc5fnr
	 fYbdkKMyTaXUvDRH1im00U6CaHxvOcEtAr3fCwO0=
X-QQ-mid: esmtpsz11t1769049644tbb570909
X-QQ-Originating-IP: qF4nDzfkioILTV6w/tGbU85I+nTwtlrLpsw8UddWtnU=
Received: from = ( [27.42.87.212])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 22 Jan 2026 10:40:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15349338892100512281
EX-QQ-RecipientCnt: 8
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Jan 2026 10:40:42 +0800
Message-Id: <DFURREI8ELMF.M9ZXCQYVDMZO@linux.spacemit.com>
Cc: "Alex Elder" <elder@riscstar.com>, <linux-i2c@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <spacemit@lists.linux.dev>
Subject: Re: [PATCH] i2c: spacemit: drop IRQF_ONESHOT flag from IRQ request
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Yixun Lan" <dlan@kernel.org>, "Andi Shyti" <andi.shyti@kernel.org>,
 "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260122-05-k1-i2c-irq-v1-1-9b8d94bbcd22@kernel.org>
In-Reply-To: <20260122-05-k1-i2c-irq-v1-1-9b8d94bbcd22@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NEaes6yu2o+mX6JmLuK8H/PF/o8Uemax1hqblB/b9fu1NSWY5tqU1h3J
	qTTziNk4m67+BiC5yGiiQex3JcW6D087pQQ5mMLeVNeJcflaV9di9I+8t/m86byw18RD09S
	CdWPSOUBLwBqvIOKDy4FKmJxMwyx0S2hUsgtoeGLqRNkj4+cbOJJIqqWSVQY4XW5n/LCl6F
	rJWcByMBQlsEIhZ8z2SwjQS8xrf1up3mImmFNEFzu37K7kxDRFsV/SY6/khtYrWH/6hxD0X
	LQBjxWuKGoWdbPY11CBf6UlE04qh364cT+hKbYoRp0/soQmRUnwO3B/zGeuCy3gsC26BQ5T
	4x0GH0yZopgECq6jQo6/QBIdHxRMX9WmZW2PVW6YHC28E9GoR/HLaY+zBURUuQtN2IAVyup
	Z4JxSahRuO652uXxG6hXoi6vBh1Xojie+z3LNWiRuqvYuDU/NSEYq3cQAasvSpk9H5DAXUM
	6EXSTgcjvpnktRvrVgLJq77C4O50HwNseRcjDAn0x8HgvuOnVaXkh5MONp04QTw9tXOxvyx
	Z3fbYniOSpgwcG8uVus0sCYg8w0NmKStN6NpeSakJ91p9emovKZiaEj1tBwJBow5ZO5Io1T
	Oigtyeg0zHr+tkRONX48GbD5l7jcUmJ/7UakcoAVeJO9OPtk9jJLcWhBOq+lEgHJwzNdmf/
	Q2gY+OJXR1t4h3uGU5AqnvhnnC2oVRRqbzxf5x4wuP40nIFp5bQx+rDMxQ/cNp0NHa6eyTv
	d+pr/NroaYPEiO0wGf+iXwKe0A6yAYrFoGhTPjqUYzRuCGZXfGkSMQFNC0k7Rex+Yp53Dye
	dhDqKC1poR3TpKe6+uEB1ZmnQG2XIs9ZXRP7kmvsJmvoyCGyHqSxhonk48BONetxBhQuImG
	bw3kaJyCr5HwbHTjyzZy7bLW3PaE7ITIH6XIra9zSxu+xnsM44EOw3V6Ct6yUP/JHs3s0dj
	Sim14TNipOrqvceODLa7zoXFCKM34LnQn/470Qq9fb/xnJXMlLaP7ZldCfETpaNz3Jp31g4
	OSKEbTUAQ3Ho6vwEW4u9XtXlceOX0+yBfsEfM6luXXsjVfBf4gTd2S7XqtID5Je0qUwHRjI
	1ZroH8FkK/h
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

On Thu Jan 22, 2026 at 7:52 AM CST, Yixun Lan wrote:
> In commit aef30c8d569c ("genirq: Warn about using IRQF_ONESHOT without a
> threaded handler")[1], it will check IRQF_ONESHOT flag in IRQ request,
> and gives a warning if there is no threaded handler. Drop this flag to
> fix this warning.
>
> Link: https://lore.kernel.org/r/20260112134013.eQWyReHR@linutronix.de/ [1=
]
> Fixes: 5ea558473fa3 ("i2c: spacemit: add support for SpacemiT K1 SoC")
> Signed-off-by: Yixun Lan <dlan@kernel.org>
Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>

