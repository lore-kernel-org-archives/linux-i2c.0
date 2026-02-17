Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A963382FD
	for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771330434; cv=none; b=m3QpLnwVzD+6NFwNQ4v8mqKnJT6WiiYK/+v+S1zeKrIQeBTPb+yrSFNRxfmj3jxz2YlHLF7iM5x9+oqCWqZAOkLWl9IutUR5KH0gh6Ds5N4Q7gxvnCpBSxUpwbtL/l5GOTaQCdJUqDtmSKYsimQzbpt+reGFNB/Lm0nYrBuWhg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771330434; c=relaxed/simple;
	bh=1KKwZRBOki3lvqrYOEC5WsNneg5HW92P6qbZM37GtTk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OHlJ3C1GzNwEdFzL0P/Oh/yH+wdIFFWeGUbL51IAYNPsJhGFj+fGlanFUZ4+CIL2HtvYffmihJJMcrOli1TSZHJkR+Oo99Tl9VP/FOG3A0301wKfRsSq6S+cUGgG1zHf4SsT/FAuGaM7ke8K23R+Wlnsf+fGViEPhuSy9vWpb+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FZGMGiLt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ii5Uale6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FZGMGiLt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ii5Uale6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FZGMGiLt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ii5Uale6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FZGMGiLt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ii5Uale6"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2572F3E6E3;
	Tue, 17 Feb 2026 12:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771330431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OWkLmL1B7ls0uAzqNEUBkxSenPtJKaq5MmI13HUZxJE=;
	b=FZGMGiLttUOfjd3kMeKZTnsuCEe66tFRbTS9ley7oA/s3x0qLDYHHneT7KxaFGmAk4eQZw
	Tp31Coiob/B0lFz28BCiYx41VacvYLGc8GqhYvYnVqsV/k8BInX9dHSCzY+svxyxd/Iy2b
	qA2x9HKi1+VpxeRIcMbnnzbZ9uuoTcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771330431;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OWkLmL1B7ls0uAzqNEUBkxSenPtJKaq5MmI13HUZxJE=;
	b=ii5Uale6WHLNlYrwTnlgz9IfZopI5s6FtVVeSMTMR7LnsmFE8W+0u9+1/SPMbuvmkd9fuc
	ktN6IjvS1DWxK1Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771330431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OWkLmL1B7ls0uAzqNEUBkxSenPtJKaq5MmI13HUZxJE=;
	b=FZGMGiLttUOfjd3kMeKZTnsuCEe66tFRbTS9ley7oA/s3x0qLDYHHneT7KxaFGmAk4eQZw
	Tp31Coiob/B0lFz28BCiYx41VacvYLGc8GqhYvYnVqsV/k8BInX9dHSCzY+svxyxd/Iy2b
	qA2x9HKi1+VpxeRIcMbnnzbZ9uuoTcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771330431;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OWkLmL1B7ls0uAzqNEUBkxSenPtJKaq5MmI13HUZxJE=;
	b=ii5Uale6WHLNlYrwTnlgz9IfZopI5s6FtVVeSMTMR7LnsmFE8W+0u9+1/SPMbuvmkd9fuc
	ktN6IjvS1DWxK1Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA4AA3EA65;
	Tue, 17 Feb 2026 12:13:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dVVLM35blGndVwAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Tue, 17 Feb 2026 12:13:50 +0000
Date: Tue, 17 Feb 2026 13:13:48 +0100
From: Jean Delvare <jdelvare@suse.de>
To: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@bootlin.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH i2c-tools v3 0/2] Add support for message modifier flags
Message-ID: <20260217131348.007dde93@endymion>
In-Reply-To: <20260127-msg-flags-v3-0-e7539945db2b@bootlin.com>
References: <20260127-msg-flags-v3-0-e7539945db2b@bootlin.com>
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
	BAYES_HAM(-3.00)[100.00%];
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
	RCPT_COUNT_THREE(0.00)[4];
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

Hi Beno=C3=AEt,

On Tue, 27 Jan 2026 10:25:56 +0100, Beno=C3=AEt Monin wrote:
> I2C messages can be modified with a set of flags covered by the protocol
> mangling and the skip repeated start functionalities. This series add
> support for such flags to i2cdetect and i2ctransfer.
>=20
> The first patch shows the support of protocol mangling and repeated
> start skipping in the output of 'i2cdetect -F'.
>=20
> The second patch adds the parsing of optional flags to i2ctransfer
> message description. Those command-line flags then set the i2c message
> flags alongside the read/write flag.
>=20
> I wrote these changes to test the insertion of I2C_M_STOP flag in
> multi-message transactions with i2ctransfer, but the other flags may be
> useful for various test scenarios.=20
>=20
> Signed-off-by: Beno=C3=AEt Monin <benoit.monin@bootlin.com>
> ---
> Changes in v3:
> - Use ifdefs to check that the flags and functionalities are known
>   at compile-time.
> - Check that the adapter supports the requested flags before using them
>   in i2ctransfer.
> - Add a warning in i2ctransfer man page about the risk of using these
>   flags.
> - Link to v2: https://lore.kernel.org/r/20251223-msg-flags-v2-0-8d934a436=
6e2@bootlin.com
>=20
> Changes in v2:
> - Document the flags in i2ctransfer.8 man page.
> - Link to v1: https://lore.kernel.org/r/20251128-msg-flags-v1-0-6353f26fa=
6bc@bootlin.com
>=20
> ---
> Beno=C3=AEt Monin (2):
>       i2cdetect: Display mangling and nostart support
>       i2ctransfer: Add optional message modifier flags
>=20
>  tools/i2cdetect.c   |   8 ++++
>  tools/i2ctransfer.8 |  28 ++++++++++++-
>  tools/i2ctransfer.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++=
------
>  3 files changed, 141 insertions(+), 14 deletions(-)

Both patches look very good to me. I was able to test the i2cdetect
patch and did not find any issue. I can't easily test the i2ctransfer
patch though.

Wolfram, can you please give some basic testing to the i2ctransfer
patch? Not necessarily with the mangling flags, but at least test that
the changes do not introduce any regression for your own use cases?

Thanks,
--=20
Jean Delvare
SUSE L3 Support
