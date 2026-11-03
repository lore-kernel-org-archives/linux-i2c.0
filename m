Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742021;
	b=itcvf3jpHPIAah4P2lUfoRJZaOafTVSZqnJECSYY23UHU6+UYhITC9L9wYll6/ZnOSX8
	 Kr2U86pd2XK/VUkxyTWLzuicWVvBvNX5TNmnu5BDu1bDXQzhLAdn+/A/aVUNbeTFqZ/oQ
	 s7A54U+K8P9IiN0s7hpA6aeGQV+rbYViksDdcK/lehJonB+586nOu6caDzPCX6Uuc5nK4
	 hg8ajajVOZQqhxuoCvnozbyDvgCXvncJyXu4Ogh+dVcPqlk0EUUVuDKk/N+LecQmdrJxu
	 xsXyaWeoXGC5OD+bAP8ZFtrldbug3duT8e0P41jWuZinOe9l9GpxN+56QkId37HNt3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742021;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 Organization:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=TbyusItIiqqCVPGxLIricmusLHTWCwQLigs1s5Iokkc=;
	b=A/9Qp8tkc0sEcjrQhh4WD2RVOrDXlYDHh4HTmtK1ceJBlfx9QAU3Vgbgm1K8N2Ea3ymp
	 F41BVxWGHjsa7tw3Y/Z8k0rH+VQMJyrQ+cNP9Odj9ZaXqCU/kLFjj42bRMt+Y9XNGfjIw
	 WB/nYc50NVt4mT5YK3zCzNsDzOkTuA6JVGo6vZZBGz+14Kbpn8scpJIufY+f/5Nyo5EUb
	 zc6/6Yvp4B4MAX0GQr9rXBTvDFnX0ZXmCsBVkkchBX4ncVNXkoL7MO7R+7fad/7jEGwQc
	 mvnS7adnIWy2bcGBJKVmqtEATeCKpTL3toSvpaZyujd1Z9euKZePI1zZ6Z8pulTMNNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gn4An0Fp;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=whJSQP2f;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gn4An0Fp;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=whJSQP2f;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BE3606D83E
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 21:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84BE3606D83E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gn4An0Fp;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=whJSQP2f;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gn4An0Fp;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=whJSQP2f
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A267A1FBA7;
	Tue,  3 Nov 2026 21:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793742018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TbyusItIiqqCVPGxLIricmusLHTWCwQLigs1s5Iokkc=;
	b=gn4An0FpGAdiD4LH2bJBeeQK7r3H/NYLoljcR6vjfjq8dVBoLntbA8wYNkeMCt6QcaM/Ih
	r+xZLKpA1eNUSKl5Pe3X/HPI2vRVflyL4xu1OoTur66l15/8SubeLTXCbOtav/6WYNffWn
	rodK3lY9qIFDS0eWMmaL/I2YAQPHKZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793742018;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TbyusItIiqqCVPGxLIricmusLHTWCwQLigs1s5Iokkc=;
	b=whJSQP2fAcfi7y04G8HX0pzIZ3XWgbe38bIV5LBlZ2Rm3MiZ2TqE6xWdj1gDZEuOXwlqO4
	1bz/wvVd5OuDJBDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gn4An0Fp;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=whJSQP2f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793742018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TbyusItIiqqCVPGxLIricmusLHTWCwQLigs1s5Iokkc=;
	b=gn4An0FpGAdiD4LH2bJBeeQK7r3H/NYLoljcR6vjfjq8dVBoLntbA8wYNkeMCt6QcaM/Ih
	r+xZLKpA1eNUSKl5Pe3X/HPI2vRVflyL4xu1OoTur66l15/8SubeLTXCbOtav/6WYNffWn
	rodK3lY9qIFDS0eWMmaL/I2YAQPHKZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793742018;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TbyusItIiqqCVPGxLIricmusLHTWCwQLigs1s5Iokkc=;
	b=whJSQP2fAcfi7y04G8HX0pzIZ3XWgbe38bIV5LBlZ2Rm3MiZ2TqE6xWdj1gDZEuOXwlqO4
	1bz/wvVd5OuDJBDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C9D01350A;
	Tue,  3 Nov 2026 21:40:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4IWmBMJU6mr3OwAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Tue, 03 Nov 2026 21:40:18 +0000
Date: Tue, 3 Nov 2026 22:40:05 +0100
From: Jean Delvare <jdelvare@suse.de>
To: Linux I2C <linux-i2c@vger.kernel.org>
Cc: Xiang Mei <xmei5@asu.edu>, Weiming Shi <bestswngs@gmail.com>, Wolfram
 Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] i2c: smbus: drop redundant block size checks
Message-ID: <20261103224005.014c3a53@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.50; x86_64-suse-linux-gnu)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A267A1FBA7
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-11.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[asu.edu,gmail.com,sang-engineering.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -11.51

Commit 3051cd060fa4 ("i2c: smbus: reject oversized block transfers in
the common path") added a block size check in __i2c_smbus_xfer(),
before the tracepoints. Such checks were already present but later in
the call chain, in i2c_smbus_xfer_emulated(). Thus we now have
redundant checks and the checks in i2c_smbus_xfer_emulated() can no
longer fail. This is effectively dead code so we can drop it.

One difference between the original checks and the new one is that
the original checks logged an error message when an oversized block
transfer was attempted. Restore this behavior.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
---
Another difference between the checks is that the new check rejects
zero-sized block transfers. While they are uncommon and were not
valid under SMBus 2.0, they are now explicitly allowed by SMBus 3.0,
so disallowing them could cause problems in the future.

While I can see how oversized block transfers could cause an
out-of-buffer memory access in the tracepoint code, I fail to see
why zero-sized block transfers would be problematic. Is there any
actual code path that was found to break with block size 0?

 drivers/i2c/i2c-core-smbus.c |   29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

--- linux-7.3.orig/drivers/i2c/i2c-core-smbus.c
+++ linux-7.3/drivers/i2c/i2c-core-smbus.c
@@ -318,7 +318,8 @@ static void i2c_smbus_try_get_dmabuf(str
 
 /*
  * Simulate a SMBus command using the I2C protocol.
- * No checking of parameters is done!
+ * No checking of parameters is done, block length has been checked
+ * in __i2c_smbus_xfer() already.
  */
 static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
 				   unsigned short flags,
@@ -402,13 +403,6 @@ static s32 i2c_smbus_xfer_emulated(struc
 			i2c_smbus_try_get_dmabuf(&msg[1], 0);
 		} else {
 			msg[0].len = data->block[0] + 2;
-			if (msg[0].len > I2C_SMBUS_BLOCK_MAX + 2) {
-				dev_err(&adapter->dev,
-					"Invalid block write size %d\n",
-					data->block[0]);
-				return -EINVAL;
-			}
-
 			i2c_smbus_try_get_dmabuf(&msg[0], command);
 			memcpy(msg[0].buf + 1, data->block, msg[0].len - 1);
 		}
@@ -416,12 +410,6 @@ static s32 i2c_smbus_xfer_emulated(struc
 	case I2C_SMBUS_BLOCK_PROC_CALL:
 		nmsgs = 2; /* Another special case */
 		read_write = I2C_SMBUS_READ;
-		if (data->block[0] > I2C_SMBUS_BLOCK_MAX) {
-			dev_err(&adapter->dev,
-				"Invalid block write size %d\n",
-				data->block[0]);
-			return -EINVAL;
-		}
 
 		msg[0].len = data->block[0] + 2;
 		i2c_smbus_try_get_dmabuf(&msg[0], command);
@@ -433,13 +421,6 @@ static s32 i2c_smbus_xfer_emulated(struc
 		i2c_smbus_try_get_dmabuf(&msg[1], 0);
 		break;
 	case I2C_SMBUS_I2C_BLOCK_DATA:
-		if (data->block[0] > I2C_SMBUS_BLOCK_MAX) {
-			dev_err(&adapter->dev, "Invalid block %s size %d\n",
-				str_read_write(read_write == I2C_SMBUS_READ),
-				data->block[0]);
-			return -EINVAL;
-		}
-
 		if (read_write == I2C_SMBUS_READ) {
 			msg[1].len = data->block[0];
 			i2c_smbus_try_get_dmabuf(&msg[1], 0);
@@ -576,8 +557,12 @@ s32 __i2c_smbus_xfer(struct i2c_adapter
 	     (protocol == I2C_SMBUS_BLOCK_DATA &&
 	      read_write == I2C_SMBUS_WRITE)) &&
 	    (data->block[0] == 0 ||
-	     data->block[0] > I2C_SMBUS_BLOCK_MAX))
+	     data->block[0] > I2C_SMBUS_BLOCK_MAX)) {
+		dev_err(&adapter->dev, "Invalid block %s size %hhu\n",
+			str_read_write(read_write == I2C_SMBUS_READ),
+			data->block[0]);
 		return -EINVAL;
+	}
 
 	/* If enabled, the following two tracepoints are conditional on
 	 * read_write and protocol.


-- 
Jean Delvare
SUSE L3 Support
