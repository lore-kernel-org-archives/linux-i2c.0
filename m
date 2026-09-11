Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493723AFAF1
	for <linux-i2c@vger.kernel.org>; Fri, 11 Sep 2026 11:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789127763; cv=none; b=WlhqMZeDyXQltj4T8AI22byZuzQOQj5U7avNvbUokJqZaxK5uPbCGoMUBVPsBvofG6Ymv1auClehbweR7RfA61rf161TZLRehG/ArWmeJ2ZX+T0iV5cUVeQiuwUJvxmndp7tIbKd8BwQdAocBx2HEOMCky4dNEEVk4MKI59l20A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789127763; c=relaxed/simple;
	bh=H6PJGLOt4Lc3XTFDxIM1Hbc1rK+uVHCnkrFSBLtAuSs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6kJvTW1uQXU55QXQpEcdFdV4kLpxphGvqFkqoD/r/uT8SRBCS3X6f8Sv6jQLJ1dS3Ckz3UY68pSsu3GmuWDL1KUlXyOOirfKtg7KC8k9ETgkHVuQtMM2ihbMdcmzECuZaq64/U7DeyX4hzUHs1K1iugCDabB0a1uKUx/0rVSZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qc3gy2bG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7wnxeNtE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c9evp5C3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jz00yDQC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qc3gy2bG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7wnxeNtE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c9evp5C3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jz00yDQC"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 334C82199E;
	Fri, 11 Sep 2026 11:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789127756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LiXEmsCXwtNnqpryrHOVrdUxZGUyyp/DaPVryvWUBXY=;
	b=qc3gy2bGgye96++Dn/Yipi/7u82mfzVaxGgqWpDRfO8NQxkTN6HYrvvPaGGku9lxIinvLI
	NXrkA0KN5qmuRzCZso3t1dqxNhCVB9/wgdiNHSLYE/bHRS4RZa6xpxuJieWmoWsOWU6MRo
	oXPshn8Oo5CoDd+LmHG3FwmlzVDTzFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789127756;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LiXEmsCXwtNnqpryrHOVrdUxZGUyyp/DaPVryvWUBXY=;
	b=7wnxeNtEguTnhmPujwFocEEVBtmenZcYJX38NU8KC1qi3jyibWJcZ48hl18UNYhLXwvySz
	Sd4GmUDhjco3QSCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=c9evp5C3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jz00yDQC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789127752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LiXEmsCXwtNnqpryrHOVrdUxZGUyyp/DaPVryvWUBXY=;
	b=c9evp5C3VSCGUqNA7/FiO4MjKO00YfaLD5gaXaadkk9K4paBGzfzceePwP/8TNVSdg7bUf
	axMluQ5Rv4Fkwj0XQmF3LThwzkTjbIdWlGTJMbvBLPJVjUyCREeoRV9prFQrV5ghQpFv9+
	/rLDWTU5jCG85Z/8k3F03+oc4vPRTho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789127752;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LiXEmsCXwtNnqpryrHOVrdUxZGUyyp/DaPVryvWUBXY=;
	b=jz00yDQCdLz4EwCwuH4xmmAEE2vVbncyylgb0v2jHr93qYWUd7YQnQdPQ/hqDqo5tEYKt9
	29bTIpslTHs1xCCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0AA9136ED;
	Fri, 11 Sep 2026 11:55:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iuTzMEfso2o7XAAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Fri, 11 Sep 2026 11:55:51 +0000
Date: Fri, 11 Sep 2026 13:56:04 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Al Ma <AlMa0@ro.ru>
Cc: 1110749@bugs.debian.org, linux-i2c@vger.kernel.org
Subject: Re: ee1004: DDR4 SPD cannot be read, decode-dimms fails,
 =?UTF-8?B?4oCcRmFpbGVk?= to select page 0 =?UTF-8?B?KC02KeKAnQ==?=
Message-ID: <20260911135604.6c2451e7@endymion>
In-Reply-To: <812847a5-5630-4d26-8012-c816e6d1db32@ro.ru>
References: <ff6982d3-cf60-436b-9107-420924cdabe3@ro.ru>
	<handler.1110749.B.1754853823932687.ack@bugs.debian.org>
	<9ed6f717-a04c-425f-945e-7fe8fe3b5d7d@ro.ru>
	<ac700b24578663492aecd6d544bfc205b060c948.camel@suse.de>
	<812847a5-5630-4d26-8012-c816e6d1db32@ro.ru>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 334C82199E
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[ro.ru];
	FREEMAIL_TO(0.00)[ro.ru];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Sun, 30 Aug 2026 17:35:57 +0200, Al Ma wrote:
> > Please try unloading the ee1004 driver, then running i2cdetect again.  
> 
> Here we go:
> 
> # modprobe -r ee1004 && i2cdetect -y 0 && modprobe ee1004
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:                         08 -- -- -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 40: -- -- -- -- 44 -- -- -- -- -- -- -- -- -- -- --
> 50: -- -- -- -- -- -- 56 -- -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- --
> 
> What next?

This confirms my guess that the device at 0x56 is not an SPD EEPROM.
Next steps would be as follows:

* Short term, you want to blacklist the ee1004 driver on your system.
  It is not a good idea to load a driver which binds to the wrong
  device.

* Still short term, we should look into the ee1004 auto-detection logic
  and see it it can be made more reliable.

* Mid term, we may want to add a kernel option to disable automatic
  probing of SPD EEPROMs. I seem to recall some proposals but it looks
  like they never made it into the upstream kernel. I'm not sure if
  this should be a system-wide switch (handled by the i2c core) or a
  per-driver setting (e.g. a new flag in i2c-i801's disable_features
  parameter).

* Still mid term, we probably want to blacklist SPD probing explicitly
  for your motherboard (we'll need to know the contents of
  /sys/devices/virtual/dmi/id/board_vendor and
  /sys/devices/virtual/dmi/id/board_name on your system). Maybe this
  can be implemented as an empty entry in mux_dmi_table (as in, we know
  the board requires multiplexing, but we don't know yet to implement
  it on that board).

* Long term, we need the hardware vendor to provide technical
  information about the board so that we can implement SMBus
  multiplexing support in the i2c-i801 driver (if that's really how
  things are implemented on your board - that's only a guess from me at
  this point). Asus provided information about their Z8 series long ago
  and I was able to add support for it back then. It would be wonderful
  if they could provide similar information about the WS C422 PRO/SE so
  that a kernel developer can add support.

-- 
Jean Delvare
SUSE L3 Support
