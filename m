Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ADC37C916
	for <linux-i2c@vger.kernel.org>; Fri, 22 May 2026 08:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779438357; cv=none; b=On4kl/YhHuOgfsfVbWUzjS5P0xeBWgTGN8ss9hlWQfgsdtOoEhVglfpIVLeG0okdh4l6DoK+olyNHLgdwlWDJX7e8khXcPeGKJTKVQDSZIRIafpqJtWiHTE9jl7q9bduoPIgWtVHjshI1wrgbDFRdHN5dwVVStil1SBHqSWcVt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779438357; c=relaxed/simple;
	bh=/+sozcz181EIRWwNA+CTiUfxhcTOJFmQTNABJn85/Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NBk+O+aCQbC2rZln7xxMz6DJDdfOp5XeFBCW0/+quzwQ2EEbPWn6mVcxukCxce21ot9dCegx79f64ayLS4N4QUWIRuBxj7RQJReJ89JSCp34kWgz2krMT+It8wYcuZrAxVEjtkIxabVh8e+dFtkotq9pl5nXW5+mjrSbI2wLJ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ciTLXJoa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RVBBZhiV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ciTLXJoa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RVBBZhiV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ciTLXJoa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RVBBZhiV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ciTLXJoa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RVBBZhiV"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 868886BAA0;
	Fri, 22 May 2026 08:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779438354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YAvlDZlWfEZwrMbkGM0dwCB8+DhU9Q4SJ9AKpPJI0pw=;
	b=ciTLXJoaGn/YnD7WfKg2QNvyjUOQwY/uTFeNLDyJmnWOiWLCP64cWFC6kddkctTHQyywH7
	LTMbQ7xjhyoeScA/3Ur3WmaQ42IoFHvJo40CBReju8K20/f+ZaW7waeGchIhxXIuvFVojo
	LhCDxS3yrWdDVDnG+7KdsoIQAF8lfvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779438354;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YAvlDZlWfEZwrMbkGM0dwCB8+DhU9Q4SJ9AKpPJI0pw=;
	b=RVBBZhiV5k58O/HIbxcZgi2oL0cFqIN+f+L9U3fzFpezZRPY1TgtEHL1FnHaeu2G23Sat7
	SQKuPXceLGjgLhBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779438354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YAvlDZlWfEZwrMbkGM0dwCB8+DhU9Q4SJ9AKpPJI0pw=;
	b=ciTLXJoaGn/YnD7WfKg2QNvyjUOQwY/uTFeNLDyJmnWOiWLCP64cWFC6kddkctTHQyywH7
	LTMbQ7xjhyoeScA/3Ur3WmaQ42IoFHvJo40CBReju8K20/f+ZaW7waeGchIhxXIuvFVojo
	LhCDxS3yrWdDVDnG+7KdsoIQAF8lfvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779438354;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YAvlDZlWfEZwrMbkGM0dwCB8+DhU9Q4SJ9AKpPJI0pw=;
	b=RVBBZhiV5k58O/HIbxcZgi2oL0cFqIN+f+L9U3fzFpezZRPY1TgtEHL1FnHaeu2G23Sat7
	SQKuPXceLGjgLhBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E942593A8;
	Fri, 22 May 2026 08:25:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ajdFERITEGqxBQAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Fri, 22 May 2026 08:25:54 +0000
Date: Fri, 22 May 2026 10:25:51 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Peter Bohner <peter@bohner.me>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-i2c@vger.kernel.org
Subject: Re: [PATCH v2] i2c: i2c-stub: support for I2C_FUNC_I2C
Message-ID: <20260522102551.26ae6fa6@endymion>
In-Reply-To: <20260516095215.861174-1-peter@bohner.me>
References: <20260516095215.861174-1-peter@bohner.me>
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
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
X-Spam-Level: 
X-Spam-Flag: NO

Hi Peter,

On Sat, 16 May 2026 11:43:51 +0200, Peter Bohner wrote:
> Make the i2c-stub driver optionally minimal support I2C transactions, when
> enabling I2C_FUNC_I2C.
> I2C reads/writes act on a dynamically expanded buffer that is separate
> from the data of the SMBus commands.

The purpose of i2c-stub is to emulate a device so that an existing
device driver can be bound to it and tested/debugged. Which device
driver would be usable with this new read/write model?

-- 
Jean Delvare
SUSE L3 Support
