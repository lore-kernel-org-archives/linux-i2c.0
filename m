Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1971747DD7A
	for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 08:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778575097; cv=none; b=toaJTaQt8wloXGbvvXyhL/faN4F9SK4Du3lZ9cptwLq6C0lkrINggyykWVlZ7suao4u4rShj9mBtdnftRy9hscBWVOiOpuiZG5DzV62em5gTeS7T2qQKJZTHteiEn6trcMmeNoDtjtbo+UUalmW865fVxYXZQCr8kYPfoCCNr+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778575097; c=relaxed/simple;
	bh=gqUgM2vPHMYwkk+OWSdUiWTw1HrKN9Uqd8IAs/2FFpY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WaIwOcOHdOLl3i0ewr4OXE0Fs1Tqy9Wksu2DUFxBKb8jsy16GuyVwvCGJrjz03PhgD05KCX4JlbIWUmBox++N7rCO7TE5k+wdEUJvp7J1HRQV2ouf7U5ucoYcVXea1szm+PHlZFsRVcxx4fDX4d0GUiA8f6dZrpBEz9E7MnSOQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NXdZbAuE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/FDI9FvL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NXdZbAuE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/FDI9FvL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NXdZbAuE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/FDI9FvL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NXdZbAuE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/FDI9FvL"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 365296BF57;
	Tue, 12 May 2026 08:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778575092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bhx/XHsVkTjBGVBXPQmKAjRd9F16GSQolZRhAhmtKsY=;
	b=NXdZbAuEwDuJcu+33oyHwSTI7Vt8fH1oo+844QGI6pZcBxPKPxxYLy4+l1WqHlfnQOb6B/
	w1ra895HNIEvVENx/HmZN4q7f161MCIt1eqed5r+v6yxgBDWV4OOhoAm+3KMo57ImjSylQ
	OeUXgSK+04V/rnXdUT/trQQKrLIiCaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778575092;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bhx/XHsVkTjBGVBXPQmKAjRd9F16GSQolZRhAhmtKsY=;
	b=/FDI9FvLfVcKt0ddtj8Nc7ivjQEpxFhsxwIqfakmPN/R+XbK3ypW43zdgh1I/1Q9U29xrl
	mnVitH7c5B9P0UCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NXdZbAuE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/FDI9FvL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778575092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bhx/XHsVkTjBGVBXPQmKAjRd9F16GSQolZRhAhmtKsY=;
	b=NXdZbAuEwDuJcu+33oyHwSTI7Vt8fH1oo+844QGI6pZcBxPKPxxYLy4+l1WqHlfnQOb6B/
	w1ra895HNIEvVENx/HmZN4q7f161MCIt1eqed5r+v6yxgBDWV4OOhoAm+3KMo57ImjSylQ
	OeUXgSK+04V/rnXdUT/trQQKrLIiCaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778575092;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bhx/XHsVkTjBGVBXPQmKAjRd9F16GSQolZRhAhmtKsY=;
	b=/FDI9FvLfVcKt0ddtj8Nc7ivjQEpxFhsxwIqfakmPN/R+XbK3ypW43zdgh1I/1Q9U29xrl
	mnVitH7c5B9P0UCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC8D8593A9;
	Tue, 12 May 2026 08:38:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tR3BN/PmAmqaBQAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Tue, 12 May 2026 08:38:11 +0000
Date: Tue, 12 May 2026 10:38:09 +0200
From: Jean Delvare <jdelvare@suse.de>
To: w15303746062@163.com
Cc: andi.shyti@kernel.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: Re: [PATCH] i2c: i801: fix hardware state machine corruption in
 error path
Message-ID: <20260512103809.7d5008d7@endymion>
In-Reply-To: <20260507114356.247525-1-w15303746062@163.com>
References: <20260507114356.247525-1-w15303746062@163.com>
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
X-Spamd-Result: default: False [-0.21 / 50.00];
	SEM_URIBL(3.50)[xidian.edu.cn:email];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[163.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	R_DKIM_ALLOW(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 365296BF57
X-Spam-Score: -0.21
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO

Hi Wang,

On Thu,  7 May 2026 19:43:56 +0800, w15303746062@163.com wrote:
> From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
>=20
> A severe livelock and subsequent Hung Task panic were observed in the
> i2c-i801 driver during concurrent Fuzzing. The crash is caused by an
> unconditional hardware register cleanup in the error handling path of
> i801_access().
>=20
> When i801_check_pre() fails (e.g., returning -EBUSY because the SMBus
> controller is actively used by BIOS/ACPI or another thread), the kernel

This can't be "another thread", as calls to i801_access() are
serialized.

> does not actually acquire the hardware ownership. However, the code jumps
> to the 'out' label and executes:
>=20
>     iowrite8(SMBHSTSTS_INUSE_STS | STATUS_FLAGS, SMBHSTSTS(priv));
>=20
> This forcefully clears the INUSE_STS lock and resets the hardware status
> flags without owning the controller. Doing so interrupts ongoing BIOS/ACPI
> transactions and totally corrupts the SMBus hardware state machine.
>=20
> Consequently, all subsequent i801_access() calls fail at the pre-check
> stage, triggering an endless stream of "SMBus is busy, can't use it!"
> error logs. Over a slow serial console, this printk flood monopolizes
> the CPU (Console Livelock), starving other processes trying to acquire
> the mmap_lock down_read semaphore, ultimately triggering the hung task
> watchdog.

Analysis looks good. We indeed should not write to a register if we do
not own the device.

> Fix this by introducing an 'out_err' label. If i801_check_pre() fails,
> we safely bypass the hardware register cleanup and only release the
> software locks (pm_runtime and mutex), strictly adhering to the rule of
> not releasing resources that were never acquired.

This fix introduces a build-time warning:

drivers/i2c/busses/i2c-i801.c: In function =E2=80=98i801_access=E2=80=99:
drivers/i2c/busses/i2c-i801.c:930:1: warning: label =E2=80=98out=E2=80=99 d=
efined but not used [-Wunused-label]
  930 | out:
      | ^~~
drivers/i2c/busses/i2c-i801.c:930:1: warning: unused label 'out'

Am I missing another driver change? Or did you not test-build your
patch?

There's only one goto in i801_access(), so you don't need 2 labels.
Instead of introducing a new label you should move the existing one.

> Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>

I looked into the driver history to try and figure out when the bug was
introduced.

The label you are moving was re-introduced when the call to
i801_check_pre() was moved to i801_access() in v6.3 by:

commit 1f760b87e54cf56a25ab68f8dc625e339f6e46d5
Author: Heiner Kallweit
Date:   Thu Feb 16 17:14:51 2023 +0100

    i2c: i801: Call i801_check_pre() from i801_access()

However it existed already in earlier driver versions, until
a3989dc0b059 ("i2c: i801: Centralize configuring block commands in
i801_block_transaction") also in v6.3. As i801_check_pre() was called
later back then, we already wrote to device registers many times before
the check, so fixing this bug in older versions of the driver would be
much harder.

So I think your fix should be backported to stable branches v6.3+, and
if anyone wants the fix in an older kernel, they will have to backport
1f760b87e54c ("i2c: i801: Call i801_check_pre() from i801_access()")
first.

The first relevant commit in the driver history seems to be:

ommit 065b6211a87746e196b56759a70c7851418dd741
Author: Heiner Kallweit
Date:   Sun Jun 6 15:55:55 2021 +0200

    i2c: i801: Ensure that SMBHSTSTS_INUSE_STS is cleared when leaving i801=
_access

Before that, we did not touch SMBHSTSTS at the end of i801_access(), so
the fix does not apply (although the bug was present in another form, as
we were writing to device registers before the busy check back then).

The status flag clearing was added by:

commit 4f7275fc7e570dfc46f733ff8ae131cb128a4758
Author: Heiner Kallweit
Date:   Sat Dec 4 21:04:40 2021 +0100

    i2c: i801: Don't clear status flags twice in interrupt mode

but then again it's only moving the execution around, not introducing
the bug.

Anyway, this was for information only, I do not think the issue is
worth fixing in older kernels where the driver code is very different.
Concurrent access to the SMBus controller by the native Linux driver
and the firmware was best effort originally and we are well aware that
it was not 100% reliable back then. Anyone who cares about this
scenario would have to use a newer version of the i2c-i801 driver.

> ---
>  drivers/i2c/busses/i2c-i801.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index 32a3cef02c7b..068b9ffb234f 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -905,7 +905,7 @@ static s32 i801_access(struct i2c_adapter *adap, u16 =
addr,
> =20
>  	ret =3D i801_check_pre(priv);
>  	if (ret)
> -		goto out;
> +		goto out_err;
> =20
>  	hwpec =3D (priv->features & FEATURE_SMBUS_PEC) && (flags & I2C_CLIENT_P=
EC)
>  		&& size !=3D I2C_SMBUS_QUICK
> @@ -938,6 +938,7 @@ static s32 i801_access(struct i2c_adapter *adap, u16 =
addr,
>  	 */
>  	iowrite8(SMBHSTSTS_INUSE_STS | STATUS_FLAGS, SMBHSTSTS(priv));
> =20
> +out_err:
>  	pm_runtime_put_autosuspend(&priv->pci_dev->dev);
>  	mutex_unlock(&priv->acpi_lock);
>  	return ret;


--=20
Jean Delvare
SUSE L3 Support
