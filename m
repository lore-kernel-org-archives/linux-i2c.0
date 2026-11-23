Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795436304;
	b=Xi85xtqygMApqk9L5/KUmdxx/aHSIRkcYF3YrRwAVFK1DzUeqZughcTbawkLZ8MJhmlV
	 EmS87fvDH5a6d0KurQNskPddKLiQ1ZK7yt5ar2DS2qSgzqfJap2si+44OQNTy4ph8tZmt
	 ozCxmf0lSXUh0bUPlDcEJjmZpnHAZTB/n5d08sdJOt5gdqlqyNtu8dculGh4DU/Pjp4qF
	 3hkNClNghPA13JJQj5+cKfpZCsKSyDGodbqiYT5bcqbaWU0HnEX07LwQ7vauG8J6wjDP+
	 b1pCDkk4Sk3rlQkd+Y4nMECiZqqBml4t5as21ii2QWozizHkpdm2b0uB47xzpD/MXsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795436304;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=nDQKcjtpU4Mc9F5vO28jPkVxWyLnt2x7pB2+Ugd4q9M=;
	b=eQPcLUhf1MTxc1V0W+tSPYgw6czNd94iscNZBjS9v2ubtzG24uSsTClgyfTTAhce+tM6
	 ZuPUPfAMb1SxkZGCx0gBQv9GqEOw4UpcsvTozx1wzZZgJffQZY1vfpHBlmDY4bpZBPv6C
	 1kM0yQQjmGQQSGelUfDYHpNsPhoZEdl6v0b5dfEmJBPYUxt9k/9382Grog/VVbdI+DWOW
	 xaaqWOpgxqQVDq5uppijdGFS+OvIHa49PHTgobeYwdxFPoWiL5FsiwVduS9DYY9pr303y
	 wDoz5KCLa/MrZmiDKmqQE1+uZlsdyl56iCJ85TnPzMbhSx8ABQDz4KWwXQK4T8ft5Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b="Ii4It/vF";
	arc=none smtp.remote-ip=79.135.106.118
Received: from mail-106118.protonmail.ch (mail-106118.protonmail.ch [79.135.106.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BF2606A332
	for <linux-i2c@vger.kernel.org>; Mon, 23 Nov 2026 12:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40BF2606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=Ii4It/vF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1795436302; x=1795695502;
	bh=nDQKcjtpU4Mc9F5vO28jPkVxWyLnt2x7pB2+Ugd4q9M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Ii4It/vFtAR6cd/92SvMXUd1vag9V58CzROuG09ocQHPVRSzpeWK9asOGiI+yb9yV
	 zwe/68fJc6qNaQtNUWOMa37cU9TMF/7ouoDCXAbt0Cf3b1vDqZmy4J15ZrTzExS8T4
	 GiKJibV2idyJ/HW+9ubwGK6OgRk29drIALeLY4m5sF3SlBYVI3ynHiF3Zs4Bj2SyLY
	 Y6+N5bKXtX0K1zVOv7so0LqzWsYO5GQKAl1VoeLCCk/xW444a+IfGNU5WlIUXdegT8
	 nuujGsaEaF5Eq3bI1c85ZBIMXOUkHje1gqxi5TtzRiwwA5n5UKAxWi3kghIe+YoW5r
	 i589XDuH+oONg==
Date: Mon, 23 Nov 2026 12:18:15 +0000
To: Rosen Penev <rosenp@gmail.com>
From: =?utf-8?Q?Eren_=C3=96zen?= <erenozen@protonmail.com>
Cc: linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, Andi Shyti <andi.shyti@kernel.org>, Guenter Roeck <linux@roeck-us.net>, =?utf-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH] i2c: piix4: don't register SPDs on the AUX adapter
Message-ID: <Hxio4OISO4BpzufY_-NQWwSXJzWvlUG_t4VkubEIIcUHv9gDTwCKAn048_LYdOjwS23i87a90jQV4IINva4LzMPOev18nF0Orh9MrKVYbOw=@protonmail.com>
In-Reply-To: <20261123041947.9411-1-rosenp@gmail.com>
References: <20261123041947.9411-1-rosenp@gmail.com>
Feedback-ID: 19860221:user:proton
X-Pm-Message-ID: 9f2658b2426444a6c25ebf447c4018e2ec12ad11
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Rosen,

On Sun, Nov 22, 2026 at 08:19:47PM -0800, Rosen Penev wrote:
> piix4_add_adapter() intends to skip SPD registration on the AUX bus,
> since on some platforms it reports all devices present. The check uses
> "port =3D=3D 0", but the AUX adapter is also added with port 0, so SPDs a=
re
> still probed there.

I hit the same bug on a Huawei MateBook 16 (AMD Cezanne) and sent a fix
for it on 2026-11-12 [1]. There, the AUX bus ACKs addresses where
nothing is connected and every read returns 0x00, so ee1004 binds to
two all-zero "SPDs" at 10-0050 and 10-0051. It's good to see the same
thing on an X470 desktop; that shows the bug isn't specific to my
laptop.

The two patches do the same thing in different ways.  Mine skips SPD
registration when padap is &piix4_aux_adapter, and yours checks
hw_port_nr. I've checked the callers, and hw_port_nr is 0 only for the
main port 0 (SB800 and pre-SB800) and 1 for the AUX adapter, so your
check is correct too, and I think it reads a bit cleaner.

Jean, Andi: please take whichever you prefer.=20
If it helps, I can send a v2 of mine that uses Rosen's
hw_port_nr check with a Suggested-by for Rosen, or test Rosen's patch on
the MateBook and reply with a Tested-by.

[1] https://lore.kernel.org/all/20261112-piix4-aux-spd-v1-1-5b23f779122e@pr=
otonmail.com/

Thanks,
Eren

