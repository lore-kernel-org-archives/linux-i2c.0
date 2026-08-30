Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B217934CFCA
	for <linux-i2c@vger.kernel.org>; Sun, 30 Aug 2026 11:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788088145; cv=none; b=RCCyMxcGH1kfIGbNGCtqx6ftT7HnPPXHRyMgpZuuJcoYVKfOa9GE3iM0nwaE4SdAR13N3Hos3yo5RdsALSu6NV/7lZD4pwpoRd8jhEVekK52bZE078WtE0bMmB0i5ZQ/z/cBMomV/j1Zt89VibZ0ZtsQVfsuBodEVejty89mw9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788088145; c=relaxed/simple;
	bh=1aOyLPQpfoM78l4qqJgE1l/n8qVjgRb/Atf44DFrIgI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OVc3QZ17AF8z8+MWE0ZuCYiWYsLnoDKtuRIY/WVo9CloH7ZnrXd9dETkHmU9ZRIvcUlLIXSRHQlmd8eihqJGZcCsGv5Q/U8cYPjTxeAVtz3aWNEXSKSzwyDzpE7jGUW/kuQpT9oMQbNYJa5Dh1fstCwEpCYQ9K1U7WUAYLRffts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YNx1Zwfg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=e4myhg2c; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V6e3IMa5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OZLYEcPP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YNx1Zwfg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="e4myhg2c";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V6e3IMa5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OZLYEcPP"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E4BBD1F892;
	Sun, 30 Aug 2026 11:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788088132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1aOyLPQpfoM78l4qqJgE1l/n8qVjgRb/Atf44DFrIgI=;
	b=YNx1ZwfggBSHsEJJFoIkgvAOLzbtFViZEXJ+AOJdu0HMLKS2Q5b8HY5q1zaoi/04QYx1x/
	92gqMiieZ0SmC1yDvB1btOz/AwKsTY5xQXfN+4s/tnl0lBirlHoaqxQRlDnA05G7GQdkD/
	yyK3pnwbGej+KeKv4kUs6TpYiNpdD3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788088132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1aOyLPQpfoM78l4qqJgE1l/n8qVjgRb/Atf44DFrIgI=;
	b=e4myhg2ckmMJZI6YD6ZbSzBwIajEpaN75AO/XhU2qvUhHCBLMdonBJ34cj57CYhmSi5T2d
	QcEe64AG719YnFBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788088127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1aOyLPQpfoM78l4qqJgE1l/n8qVjgRb/Atf44DFrIgI=;
	b=V6e3IMa5dmFyP/zu9MuW85nO9PeuZfyUgyZk1DM4/hCAKkscuvNUJD0u8Sw8rNTKTtCfxk
	yGSREG7Shlicx092dDzm0tsawLDhlXvMepZS52l/QY2AcHaEN/ayxD4Mgt9aKtA54jkyrt
	9felAXC9gxf+d/onVa3+dhMSFYQx8EQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788088127;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1aOyLPQpfoM78l4qqJgE1l/n8qVjgRb/Atf44DFrIgI=;
	b=OZLYEcPPc9KG9LqHxjlcpBT22ojbnMR3rpCfX2Dx2Bk66JS25SrR7V8Kqn7eWP+XAZTJdX
	udh3JJVhx70Jp4DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 775B613515;
	Sun, 30 Aug 2026 11:08:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +c8bGj8PlGonbgAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Sun, 30 Aug 2026 11:08:47 +0000
Message-ID: <ac700b24578663492aecd6d544bfc205b060c948.camel@suse.de>
Subject: Re: ee1004: DDR4 SPD cannot be read, decode-dimms fails,
 =?UTF-8?Q?=E2=80=9CFailed?= to select page 0 =?UTF-8?Q?=28-6=29=E2=80=9D?=
From: Jean Delvare <jdelvare@suse.de>
To: Al Ma <AlMa0@ro.ru>, 1110749@bugs.debian.org
Cc: linux-i2c@vger.kernel.org
Date: Sun, 30 Aug 2026 13:07:54 +0200
In-Reply-To: <9ed6f717-a04c-425f-945e-7fe8fe3b5d7d@ro.ru>
References: <ff6982d3-cf60-436b-9107-420924cdabe3@ro.ru>
	 <handler.1110749.B.1754853823932687.ack@bugs.debian.org>
	 <9ed6f717-a04c-425f-945e-7fe8fe3b5d7d@ro.ru>
Autocrypt: addr=jdelvare@suse.de; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[ro.ru,bugs.debian.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[ro.ru];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Flag: NO

Hi Alma,

On Tue, 2026-08-25 at 02:31 +0200, Al Ma wrote:
> Control: found 1110749 6.12.101
> Control: retitle 1110749 ee1004: DDR4 SPD cannot be read, decode-dimms fa=
ils, =E2=80=9CFailed to select page 0 (-6)=E2=80=9D
> Control: X-Debbugs-CC: linux-i2c@vger.kernel.org, jdelvare@suse.de
> thanks
>=20
>=20
> Now tested with two equal 32 GB RDIMMs Samsung M393A4K40CB2-CVF installed=
 in DIMM_A1 and DIMM_C1 on ASUS WS C422 PRO/SE with BIOS 4801 with kernel 6=
.12.101+deb13-amd64. The SPD EEPROM is detected and the ee1004 driver is bo=
und to it, but the driver's attempt to select page 0 fails with -ENXIO. Con=
sequently, the driver's sysfs eeprom attribute cannot be read, and decode-d=
imms fails. Here is the excerpt from boot time:
>=20
> [=C2=A0=C2=A0=C2=A0 8.550652] ipmi_si: Trying ACPI-specified kcs state ma=
chine at i/o address 0xca2, slave address 0x20, irq 0
> [=C2=A0=C2=A0=C2=A0 8.596883] input: PC Speaker as /devices/platform/pcsp=
kr/input/input5
> [=C2=A0=C2=A0=C2=A0 8.608418] ee1004 0-0056: Failed to select page 0 (-6)
> [=C2=A0=C2=A0=C2=A0 8.608532] ee1004 0-0056: 512 byte EE1004-compliant SP=
D EEPROM, read-only
> [=C2=A0=C2=A0=C2=A0 8.774836] videodev: Linux video capture interface: v2=
.00
>=20
> # decode-dimms
> Cannot read /sys/bus/i2c/drivers/ee1004/0-0056/eeprom at /usr/bin/decode-=
dimms line 2455.
>=20
> The SPD device is instantiated at 0x56:
>=20
> # dmesg | grep "i2c"| head -1
> [=C2=A0=C2=A0=C2=A0 3.138736] i2c i2c-0: Successfully instantiated SPD at=
 0x56
>=20
>=20
> The device at 0x56 is claimed by ee1004 (=E2=80=9CUU=E2=80=9D below):
>=20
> # i2cdetect -y 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0 1=C2=A0 2=C2=A0 3=C2=A0 4=C2=A0 5=
=C2=A0 6=C2=A0 7=C2=A0 8=C2=A0 9=C2=A0 a=C2=A0 b=C2=A0 c=C2=A0 d=C2=A0 e=C2=
=A0 f
> 00:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 08 -- -- -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 30: -- -- -- -- -- -- UU UU -- -- -- -- -- -- -- --
> 40: -- -- -- -- 44 -- -- -- -- -- -- -- -- -- -- --
> 50: -- -- -- -- -- -- UU -- -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- --

It is unusual for the EEPROM to live at address 0x56. The valid address
range is 0x50-0x57 but they are usually populated in order, so if you
installed your memory modules following the recommended order, they
would show at 0x50 and either 0x51, 0x52 or 0x54.

I see that your motherboard has 8 memory slots, so it is possible that
the whole address range is used, however, considering that you
installed 2 memory sticks and only one address in the range responded
to the probe, I am reasonably certain that the device at address 0x56
is NOT your memory's SPD EEPROM.

I have some SMBus development experience with Asus server boards and my
bet is that the SPD EEPROMs are not connected directly, but instead are
behind an I2C multiplexer. The first set of memory modules would be on
a first segment behind the multiplexer, at addresses 0x50-0x53, and the
other set of memory modules would be on a second segment behind the
multiplexer, also at addresses 0x50-0x53.

> Direct access to the page-selection addresses 0x36/0x37 fails:
>=20
> # i2cget -f -y 0 0x36
> Error: Read failed
> # i2cget -f -y 0 0x37
> Error: Read failed
>=20
> (...)
> Could this be related to the way ee1004 attempts to select the SPD
> page on this particular I2C adapter/controller? In particular,
> =E2=80=9CFailed to select page 0 (-6)=E2=80=9D appears to occur before th=
e actual
> SPD contents can be read.

I believe this is an incorrect detection and the ee1004 driver should
not bind to address 0x56 on i2c-0 in the first place.

Please try unloading the ee1004 driver, then running i2cdetect again.
If addresses 0x36 and 0x37 do not show on the map, this would confirm
my theory.


--=20
Jean Delvare
SUSE L3 Support
