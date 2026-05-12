Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42947304BDE
	for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571202; cv=none; b=sLTrNkk1vdkvMEH4lhpzFOy8yPOtDTU8sHjZQ1kiTS3JkJvOMCvCWuKBGj9vqq6Vs86l3YlFgAdCMDnH5PsXk8CzJunZ8sKz3yIYstoQu9FmHq2YpZeoB1iQ/OqVLyR60b8msLlbwEFWAWOJtVz6LtCmvRA/hl5ew3N3MilOAdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571202; c=relaxed/simple;
	bh=fLX8jpqBMoJy+3qY8px/tmQLuGUPFqgNKBc9tQ6BBkA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxHp3yz8AAU4Amf1YeERtksjLkNB3qEfLmTrvsT7HwkWShBiJiz5z7U93gzcaz4wZoSsdAlhX9Pbow0LJLYU5vfmK4s6b3EC8hJHF9ddEIJI/kM/dR1hM64LRvPKiXMQXFya0jeXLRyTHthhbBeNra0/egwxcAMhEgQbEiKbRto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kIxTQgth; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7OBIz6eI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kIxTQgth; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7OBIz6eI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kIxTQgth";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7OBIz6eI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kIxTQgth";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7OBIz6eI"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 87EA76BFB8;
	Tue, 12 May 2026 07:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778571199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZsVwEj8ctaSJtFRTP5kDYYJum07kuyUW0PZ5DfyRFI=;
	b=kIxTQgthfVY/Qvu+YddQyQPu2o8yEsjU1MuQ5hIr9zeLjemnAujMGXTsDEMITsgHy5gIxY
	aJT6KM/Pp19ARw2EamU2uCaRctTBrL3r3fKuJFsFC5cQ2j3yn+fC8tP5RTPQVzjm1OtDyD
	7vy6TsPsjp+/YG7vwd34IYTJWZll+Bg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778571199;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZsVwEj8ctaSJtFRTP5kDYYJum07kuyUW0PZ5DfyRFI=;
	b=7OBIz6eIpMhUGJ5jiIUCLWIl9hX0sI/okVFBeJC4jFbO6whV52w5RTjUhtTmNU/tORwPFn
	ixckMGZiid+2idDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kIxTQgth;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7OBIz6eI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778571199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZsVwEj8ctaSJtFRTP5kDYYJum07kuyUW0PZ5DfyRFI=;
	b=kIxTQgthfVY/Qvu+YddQyQPu2o8yEsjU1MuQ5hIr9zeLjemnAujMGXTsDEMITsgHy5gIxY
	aJT6KM/Pp19ARw2EamU2uCaRctTBrL3r3fKuJFsFC5cQ2j3yn+fC8tP5RTPQVzjm1OtDyD
	7vy6TsPsjp+/YG7vwd34IYTJWZll+Bg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778571199;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZsVwEj8ctaSJtFRTP5kDYYJum07kuyUW0PZ5DfyRFI=;
	b=7OBIz6eIpMhUGJ5jiIUCLWIl9hX0sI/okVFBeJC4jFbO6whV52w5RTjUhtTmNU/tORwPFn
	ixckMGZiid+2idDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 487C7593A9;
	Tue, 12 May 2026 07:33:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S8+sD7/XAmpGRAAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Tue, 12 May 2026 07:33:19 +0000
Date: Tue, 12 May 2026 09:33:15 +0200
From: Jean Delvare <jdelvare@suse.de>
To: w15303746062@163.com
Cc: andi.shyti@kernel.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: Re: [PATCH] i2c: i801: Fix kernel stack buffer overflow in
 i801_block_transaction_byte_by_byte
Message-ID: <20260512092822.6b403fd5@endymion>
In-Reply-To: <20260511150005.305818-1-w15303746062@163.com>
References: <20260511150005.305818-1-w15303746062@163.com>
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
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[163.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	URIBL_BLOCKED(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Queue-Id: 87EA76BFB8
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

Hi Wang,

On Mon, 11 May 2026 23:00:05 +0800, w15303746062@163.com wrote:
> A kernel stack buffer overflow exists in the
> i801_block_transaction_byte_by_byte() function due to a missing bounds
> check on the user-provided block length.
> 
> When userspace executes an ioctl(I2C_SMBUS) with the
> I2C_SMBUS_I2C_BLOCK_DATA command, the user data is copied into a local
> stack variable `union i2c_smbus_data temp` (which is approximately 34
> bytes) in i2cdev_ioctl_smbus(). This data is then passed unmodified

Approximately, really?

> through i2c_smbus_xfer() and i801_access() directly into
> i801_block_transaction_byte_by_byte().

This is incorrect. i801_block_transaction_byte_by_byte() is not called
directly by i801_access(). i2c_access() calls either
i801_smbus_block_transaction() or i801_i2c_block_transaction(), which
in turn call i801_block_transaction_byte_by_byte().

This is important because both i801_smbus_block_transaction() and
i801_i2c_block_transaction() already check the value of data->block[0]
and reject invalid values.

Therefore the stack buffer overflow you intend to fix, can't happen in
the first place.

Out of curiosity, what amount of AI was involved in the discovery of
this "bug" and in the creation of this patch?

-- 
Jean Delvare
SUSE L3 Support
