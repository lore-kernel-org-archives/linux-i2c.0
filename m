Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622423A0B01
	for <linux-i2c@vger.kernel.org>; Wed, 21 Jan 2026 18:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020635; cv=none; b=nFgwXtAl0c5qSAFCr5NWEMT53Ey9P32TprQffcMU91pt3wIyc0o+lRzNWCnic3mgPhCjPei6mhjad6oBTikD2Fyoxu2Kc5crlY/txnjF9z5/1d/VtiR+P4SU0c90ecP1h+511GdUzl9tpH9+bi8BM4Kn7kbTtWgu7jqN1xfO2DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020635; c=relaxed/simple;
	bh=m354juiiEVTXLMxIREULUvfxZvxIITQFrOfVp+j/UmI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujBsnQib3cW3bz8EDuowzcDtn0UFm9F08LlmdjTaUGO8VFb4ijL1YCbYCacAxhMVQ5rDGybELHaowtr9yrZPfCfzBwoY1Mrrz4dhVfhrho4FyVMl+NfBHZRw/eVGqkr4HwkbhgJMS5TWUBGyXSH/q7KH5QKafR50ozVEvy8fwno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Gt7Ag8Tb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZKClxiL0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cg+s/Nau; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HbN/bn0D; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Gt7Ag8Tb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZKClxiL0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cg+s/Nau";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HbN/bn0D"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 86908336EF;
	Wed, 21 Jan 2026 18:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769020629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SclObbcrFBJFlecEc69EkRTvUuJz0s/ONHR0S+p5U2k=;
	b=Gt7Ag8TbtxgIo7h5heRqq7YHtuLgxjdsN+ZUGTvODLf3Fmg+nDDzypoi3dU47iZwu+hsbw
	DYhF81JBnYMuIyZ+eFiMGDWGSGYFuCXbiZ72Y8LoF/Zo4kOwqyOGlkqf0Ay1viKIDenVzZ
	nlVdX40MTywodEWJTCi/2N7xH8bQL8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769020629;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SclObbcrFBJFlecEc69EkRTvUuJz0s/ONHR0S+p5U2k=;
	b=ZKClxiL00k1giYar/42QNhESzOAK1tLaAHIyinzi2CnOPXsYottsfO+xCDrgnohXbIET5g
	AQZK1pEOM8Zt6DBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="cg+s/Nau";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="HbN/bn0D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769020628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SclObbcrFBJFlecEc69EkRTvUuJz0s/ONHR0S+p5U2k=;
	b=cg+s/NauedVFdCDIwbZZMsXnUO9sLKtYUpIjFkrRQof58Jkj3MQbeadQJ9UTLMdWgXj2Qs
	fsCuDvgLzYXqVMJOGUF0wNezgUnG6cKZIjxIzk5hDvV+Bj7dAR6MFaY85RirOdQOpnI1bM
	rOFyZbqKXj7gqLEt89Y3+4tXk/eEHgg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769020628;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SclObbcrFBJFlecEc69EkRTvUuJz0s/ONHR0S+p5U2k=;
	b=HbN/bn0DvRi3OYfZW4KJGR6tCCQfZJ5GqwIEJ0BihRbKd4sz6nkKrvVX8aoKb9MvN0X6eh
	L53o5jmD9smGyyAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E2873EA63;
	Wed, 21 Jan 2026 18:37:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W8nGENQccWngXgAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Wed, 21 Jan 2026 18:37:08 +0000
Date: Wed, 21 Jan 2026 19:37:06 +0100
From: Jean Delvare <jdelvare@suse.de>
To: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@bootlin.com>
Cc: linux-i2c@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH i2c-tools v2 0/2] Add support for message modifier flags
Message-ID: <20260121193706.51135355@endymion>
In-Reply-To: <3571298.LZWGnKmheA@benoit.monin>
References: <20251223-msg-flags-v2-0-8d934a4366e2@bootlin.com>
	<20260120151536.7de21098@endymion>
	<3571298.LZWGnKmheA@benoit.monin>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -4.01
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	HAS_ORG_HEADER(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 86908336EF
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Wed, 21 Jan 2026 11:00:56 +0100, Beno=C3=AEt Monin wrote:
> On Tuesday, 20 January 2026 at 15:15:36 CET, Jean Delvare wrote:
> > Out of curiosity, did you have an actual scenario where you needed to
> > do this? Protocol mangling is supposed to be rarely needed and avoided
> > as much as possible.
> >  =20
> My only need was to have a way to set the I2C_M_STOP flag, but since I
> started modifying i2ctransfer, adding the other flags was not much
> additional work.
>=20
> If you think that some of the flags should not be exposed by i2ctransfer,=
 I
> can remove them.

I was just curious, I have no objection to including them all in
i2ctransfer. Maybe someone else will need them in the future.

It might be a good idea to mention in the man page that these flags
should be used carefully though. They are a deviation from the standard
and devices may react badly if they do not expect that.

--=20
Jean Delvare
SUSE L3 Support
