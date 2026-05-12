Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCEE4A33E9
	for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 08:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778575318; cv=none; b=b7GlefHEjkYez1hT7HG+OGmKub7VIiQP1Wvs382tL0G4AANc6OQO+RanJARlywtw7OkiVGgg5sX6KYBjLA78BG4E3oxkEl1P017tNgEHqywUCGdTPTwAehsNxQQlGzJPXhA33mJQJ88G8+wlTjpO6IC3ek4MptlcDfE0gEWvCag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778575318; c=relaxed/simple;
	bh=JBxOd7oyYPiWABH0n6eT+RyFKuvU92kiRzR/NCSheQM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uxC2rHrUtojbaybm1W0QCHIQzkkVfWB/agcL9g0YRPuUMsuOKHWtx1HPqzUQWb9HWW7ecABQz4oAUTQMlBrh3ZpmNGBt2HI4u3TFSw2lca/EHxhJD74cR1vz2su7xtmHwfRR3JzslsqXl8RzT9HWg83FLlToDXLKDuKTSpqPkUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VIi1VUxb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nQNSRVQk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hmWzwV5n; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BS/RdBWM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VIi1VUxb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nQNSRVQk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hmWzwV5n";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BS/RdBWM"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AF3C66C030;
	Tue, 12 May 2026 08:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778575305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QuWLFv0AzQ6J5I7jl+R1EvrMXtBFt2+2eqlih62SSS4=;
	b=VIi1VUxb4WRR9SfG6ETIM30Q2uAV/n1NkT32mgG+tNjnMoKet9FkOkKVucCVCl9/5ezNW8
	DAXu7Y1DRNwRz3OEBdetbBYpDnLiwko/i4/gVSVpPoZ3DvjHEwqjmkru9KVNAdkHd/oaQA
	736mohbN7FdH91Gin/+BPMgy2LuZB4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778575305;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QuWLFv0AzQ6J5I7jl+R1EvrMXtBFt2+2eqlih62SSS4=;
	b=nQNSRVQkflxMVhy940qjOzig9N3HZ5cu56ADv8cpKXr9dsBmMbGJICAJi4oGagaQ+agHXL
	SIxByOaNVQEix8CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778575304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QuWLFv0AzQ6J5I7jl+R1EvrMXtBFt2+2eqlih62SSS4=;
	b=hmWzwV5nm3yK+VOtzHvv7ZGQ/Vx9I+xej1n5SlgGY8KvvLWnlYXFrADf2iRuUG/y+ILUS8
	ErJm2QGGdoF1nyspYwuMHJotBWkiCFIy1AUg41ojHVge7CPsUriKjNn3upVbrjmS4zGQKO
	963rHc4ICBpfrmKcA9qYDTdanqolBxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778575304;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QuWLFv0AzQ6J5I7jl+R1EvrMXtBFt2+2eqlih62SSS4=;
	b=BS/RdBWMvCaPH0U2HL62HWgjydHqKebdsO/o1nI/f31N4a4sQqlcss5aXc1Bz0UDB6aS/T
	2Xna9MDWMOOnRoBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FD53593A9;
	Tue, 12 May 2026 08:41:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tL9WGcjnAmouCQAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Tue, 12 May 2026 08:41:44 +0000
Date: Tue, 12 May 2026 10:41:43 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-i2c@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH v2] i2c: stub: Reject I2C block transfers with invalid
 length
Message-ID: <20260512104143.6146af9b@endymion>
In-Reply-To: <20260414172338.110830-2-bestswngs@gmail.com>
References: <20260414172338.110830-2-bestswngs@gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: *
X-Spamd-Result: default: False [1.20 / 50.00];
	SEM_URIBL(3.50)[asu.edu:email];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	HAS_ORG_HEADER(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,asu.edu:email]
X-Spam-Flag: NO
X-Spam-Score: 1.20

Hi Weiming,

On Wed, 15 Apr 2026 01:23:39 +0800, Weiming Shi wrote:
> The I2C_SMBUS_I2C_BLOCK_DATA case in stub_xfer() uses data->block[0]
> as the transfer length. The existing check only clamps it to avoid
> overrunning the chip->words[256] register array, but does not validate
> it against I2C_SMBUS_BLOCK_MAX (32), which is the limit of the union
> i2c_smbus_data.block buffer (34 bytes total). The driver is a
> development/test tool (CONFIG_I2C_STUB=m, not built by default)
> that must be loaded with a chip_addr= parameter.
> 
> A local user with access to /dev/i2c-* can issue an I2C_SMBUS ioctl
> with I2C_SMBUS_I2C_BLOCK_DATA and data->block[0] > 32, causing
> stub_xfer() to read or write past the end of the union
> i2c_smbus_data.block buffer:
> 
>  BUG: KASAN: stack-out-of-bounds in stub_xfer (drivers/i2c/i2c-stub.c:223)
>  Read of size 1 at addr ffff88800abcfd92 by task exploit/81
>  Call Trace:
>   <TASK>
>   stub_xfer (drivers/i2c/i2c-stub.c:223)
>   __i2c_smbus_xfer (drivers/i2c/i2c-core-smbus.c:593)
>   i2c_smbus_xfer (drivers/i2c/i2c-core-smbus.c:536)
>   i2cdev_ioctl_smbus (drivers/i2c/i2c-dev.c:391)
>   i2cdev_ioctl (drivers/i2c/i2c-dev.c:478)
>   __x64_sys_ioctl (fs/ioctl.c:583)
>   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
>   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
>   </TASK>
> 
> The bug exists because i2c-stub implements .smbus_xfer directly,
> bypassing the I2C_SMBUS_BLOCK_MAX validation in
> i2c_smbus_xfer_emulated(). The I2C_SMBUS_BLOCK_DATA case in the same
> function correctly validates against I2C_SMBUS_BLOCK_MAX, but the
> I2C_SMBUS_I2C_BLOCK_DATA case does not.
> 
> Fix by rejecting transfers with data->block[0] == 0 or
> data->block[0] > I2C_SMBUS_BLOCK_MAX with -EINVAL, consistent with
> both the I2C_SMBUS_BLOCK_DATA case in the same function and the
> I2C_SMBUS_I2C_BLOCK_DATA validation in i2c_smbus_xfer_emulated().
> 
> Fixes: 4710317891e4 ("i2c-stub: Implement I2C block support")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Reviewed-by: Jean Delvare <jdelvare@suse.de>

> ---
> v2:
>  - Also reject data->block[0] == 0 (suggested by Jean Delvare).
> 
>  drivers/i2c/i2c-stub.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/i2c/i2c-stub.c b/drivers/i2c/i2c-stub.c
> index fbb0db41b10e1..04314e3ed24c9 100644
> --- a/drivers/i2c/i2c-stub.c
> +++ b/drivers/i2c/i2c-stub.c
> @@ -214,6 +214,11 @@ static s32 stub_xfer(struct i2c_adapter *adap, u16 addr, unsigned short flags,
>  		 * We ignore banks here, because banked chips don't use I2C
>  		 * block transfers
>  		 */
> +		if (data->block[0] == 0 ||
> +		    data->block[0] > I2C_SMBUS_BLOCK_MAX) {
> +			ret = -EINVAL;
> +			break;
> +		}
>  		if (data->block[0] > 256 - command)	/* Avoid overrun */
>  			data->block[0] = 256 - command;
>  		len = data->block[0];

Thanks,
-- 
Jean Delvare
SUSE L3 Support
