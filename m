Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B7F334690
	for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771330774; cv=none; b=rzDIgvi1ASZjheRXzWJlucrZw47CdUucWFtg0Kk6T3Nay0TZcQvi0No2GtsjgVtqAWcTxjiXXHuxlcbDtOpWLUZHt74lCGarBmQoVS+bvrDl34fUKBmFyQR5kaMyyWNGavMDZcS2MiGvelf07cRlbTiZJsx9WNwXC9NTymJGqtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771330774; c=relaxed/simple;
	bh=3b3+A1o5iycO3D1EYtyheo3LCKW8YhTYYlS8oEuM36U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hCRbJg9Ke+trNBm3cQo/6whYPy2bOzECwtzuBVHyZxnATvpK7ZwNVVZbtETFSSx5I0qgRp9xuZnPGnDc8AzaKUgaI0u81wp9laNvqDaDOF5H0BL0Okw/wGIdgyorM0/2QX04nHELoZ4vNqp4qsTKw9SLT5SOEoBp+E+MxxSIrCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E8HS+w72; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uxqwPZc6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E8HS+w72; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uxqwPZc6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E8HS+w72";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uxqwPZc6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E8HS+w72";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uxqwPZc6"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3AC3D3E6FA;
	Tue, 17 Feb 2026 12:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771330772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3b3+A1o5iycO3D1EYtyheo3LCKW8YhTYYlS8oEuM36U=;
	b=E8HS+w72FQRhpaIPbvlZ8OVzo7pVQTo0jet9Hnwtrp6BArgZs+5ORZK1HL408QLNm7JShD
	konw2FZjxsWN1pyB8VwTrZ75w4yMRv6DIGt5eEjhlkWT+8dvKwQX9X5e04jTOHlrzLHytO
	Vk8biI2jNZjQD3OKKZnzEobvWqgW3qs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771330772;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3b3+A1o5iycO3D1EYtyheo3LCKW8YhTYYlS8oEuM36U=;
	b=uxqwPZc6QQ0aEr7ljzv5TZrI9OGmlHwKMhACiJco8KkfNHsXZf5wNdryAa+RrB6Sxbm2sg
	x0zVGf4tT4OtLKAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771330772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3b3+A1o5iycO3D1EYtyheo3LCKW8YhTYYlS8oEuM36U=;
	b=E8HS+w72FQRhpaIPbvlZ8OVzo7pVQTo0jet9Hnwtrp6BArgZs+5ORZK1HL408QLNm7JShD
	konw2FZjxsWN1pyB8VwTrZ75w4yMRv6DIGt5eEjhlkWT+8dvKwQX9X5e04jTOHlrzLHytO
	Vk8biI2jNZjQD3OKKZnzEobvWqgW3qs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771330772;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3b3+A1o5iycO3D1EYtyheo3LCKW8YhTYYlS8oEuM36U=;
	b=uxqwPZc6QQ0aEr7ljzv5TZrI9OGmlHwKMhACiJco8KkfNHsXZf5wNdryAa+RrB6Sxbm2sg
	x0zVGf4tT4OtLKAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAB1E3EA65;
	Tue, 17 Feb 2026 12:19:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2o1QN9NclGldYAAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Tue, 17 Feb 2026 12:19:31 +0000
Date: Tue, 17 Feb 2026 13:19:28 +0100
From: Jean Delvare <jdelvare@suse.de>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Gero =?UTF-8?B?U2Nod8Okcmlja2U=?= <gero.schwaericke@sevenlab.de>,
 linux-i2c@vger.kernel.org
Subject: Re: [RFC][i2c-tools] Accept device-node path as alternative to bus
 number
Message-ID: <20260217131928.177ad081@endymion>
In-Reply-To: <aRIPsOOgs5jtxv9D@shikoro>
References: <DE53PTBTBBBY.24N093ZM03IKQ@sevenlab.de>
	<aRIPsOOgs5jtxv9D@shikoro>
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
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

Hi Gero, Wolfram,

On Mon, 10 Nov 2025 17:15:44 +0100, Wolfram Sang wrote:
> On Mon, Nov 10, 2025 at 03:57:34PM +0100, Gero Schw=C3=A4ricke wrote:
> > I'm working with multiple hotpluggable I2C adapters and have the
> > following proposal: =20
>=20
> From my side, this all sounds reasonable. But we need Jean's opinion
> here, too.

Sorry for the delay. The proposal sounds perfectly reasonable to me,
and I'd be happy to see and review a candidate implementation thereof.

Please make sure that any piece of code which is common to all tools
ends up in i2cbusses.c and does not get duplicated.

Thanks,
--=20
Jean Delvare
SUSE L3 Support
