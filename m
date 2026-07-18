Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0357A28466C
	for <linux-i2c@vger.kernel.org>; Sat, 18 Jul 2026 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784363364; cv=none; b=dDGq+fzqgQOyP9ZTlej+r2h/RYqyOvjMADPIaK+RCAvnEcentNCyBc614BgXAQ3MreJgStzUQRitaydW6ncTUE3nnx6NMlHz/LpkVWOYSUjPeH+7Js/yOMDJjUsLV2Eez6BWlxxEdP18BBb6Dsm8bJoUb/MVrqijLNfNZ5g/m/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784363364; c=relaxed/simple;
	bh=cFRdYJQ9DUesk8N2/b/6uB5QoE/r+87nPyzHhbww9sA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YfohZ/0RcG1xvC++eJmrbN8pg2S94m4pcnEUfYWHcQOur8nL+BWMX7iwTt6Y0nXlCIbj1E9gobnrDsk0SRTteJyAW4UKp9GjTupT+dr4CKyqzwg8TNxGY3c7T0Os0QGAPLuBDn7Y+Dga+hjDf2hUfHztJmHNcyQFfuGT5NuF0y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnz7TtNg; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnz7TtNg"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38e041ea211so6287065a91.0
        for <linux-i2c@vger.kernel.org>; Sat, 18 Jul 2026 01:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784363362; x=1784968162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4BDHRtDWbYPF+cmLCV698xypLp+xxdwFOzev9CgqvlM=;
        b=mnz7TtNgUQduymo1Oe/0fx5lcZ+bEAxAHn+6mRJiBggv7Wnd4UhThVcUvJu2e9Kwz+
         9DAZec1zZddA7pF7dDGrC5kB1B1yOoqrmeidR/VIDT7ee/aLhCy7tAiLMLjbKICWiQYh
         X5vmOKBD3aulOatEdwDNvVrM5SYurPbO3dVTimrlodmUnCvWBDnAlwvcqcgdePP8mggq
         9Cym4KYR6Y4j0aBLWLDnnXm8U4wPfsbIgEh9kI0Iat6eAqOkoa05RwAKXFBFXSmLCMD/
         nwH8RPOkLLXHaj8bMshaeynstBCp26DueoXZrN3RZumYwy7Skza7C0Q+ZlSsZK/XkLIM
         quFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784363362; x=1784968162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4BDHRtDWbYPF+cmLCV698xypLp+xxdwFOzev9CgqvlM=;
        b=WD8ztEOVCa8CMNbuyBWokUyICHHPapl+smFBP7oCgQne8B9hpNxjlbQ2ex8k/Bo8xU
         MrygrVtBm/hETwILDmF6xumUPIt7ObhyhwIHnukA9o5bNzUQF/zVpBV2A14K3Dn5DF+n
         WXeYRoT+oGJpzyy2AWDqjvXtkHcsUAZyMGim1MF+Q3JHr//wRaqX2Jt2Zg/Sb281pD/k
         gMf1NbaWfC3CLGmUADb7mXkEEP4+sjyq6CnZXpnigsX623WtUflWgrqY1EfSoZZ2x5uq
         oXn0enqXWnOGc++sNk3cdRe/dGvBSWi6C7+u3fxuIwJpsCt0kTXIUkL03pRbCa7wZjva
         EMsg==
X-Gm-Message-State: AOJu0Yz1tkFwg9R9ms69ZnvuHFr9ftaK0Zk/pcaUjqG958afYKQupOZ4
	4lgAbtJedGTjpSXfrmNT9DGGy+FqRe+bTFygHWx9LXfTT3vnTFeOkCCV
X-Gm-Gg: AfdE7ck0m7Qjbqi/Lm4s++MVhYYVkYBkHzSPgVGIU70mCdkoareucK8O7+LQ9ws+SlJ
	+EmP4/x12KdfhtkwOJx7XDSfA5BNbC31ef06oybNyimNIANq99oaSCUwKr982UqmC/ZltutNWOO
	Kw93Inz15DEhsO3+2aNXzUZ7FTyIqIHEbITAgQVxCZp09hgLd4Qz4v74VeZv3DuAx57ltCL+3vJ
	NTCNc/MOh8l0B1HQREd52q2vDrReI1HmhVSj7FrTYXyLK4V6WIf0zHjGgw4aAQWTq4z7KyUwLP0
	/TpZ/aHc5kF9/HXiwbAlbOMi5Z7s/hsbr7valmDh6jizVwOVBvxexYw5B747pvIH9zaiHDjjpcA
	jseWZIR/Ovas+yvX+oyMD9DgeVu8LQNcN//zDeeLf2UZkujSwFvsUqa4TcadeZS7Kf3Zp5I1n/e
	mNUNG+IbHkv6dDIxJTWRBaL3L3RtVO1+cDVvEAj5C/dYUCfMY=
X-Received: by 2002:a17:90b:2684:b0:38d:f5bb:e0f4 with SMTP id 98e67ed59e1d1-38e4b3e1473mr6213134a91.1.1784363362183;
        Sat, 18 Jul 2026 01:29:22 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2ddfb35sm12522523c88.14.2026.07.18.01.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 01:29:21 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jean Delvare <jdelvare@suse.com>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH] i2c: i801: keep the byte-by-byte ISR buffer private to the driver
Date: Sat, 18 Jul 2026 01:29:05 -0700
Message-ID: <20260718082904.1561226-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xiang Mei <xmei5@asu.edu>

For interrupt-driven byte-by-byte block transfers,
i801_block_transaction_byte_by_byte() points priv->data at the caller's
union i2c_smbus_data and lets the BYTE_DONE interrupt handler
i801_isr_byte_done() fill or drain it one byte at a time.  In the i2c-dev
ioctl path that buffer lives on the caller's kernel (vmap) stack.

On a wait_for_completion_timeout() the transfer thread returns -ETIMEDOUT
without fencing the interrupt, and a BYTE_DONE that is still in flight or
fires later then writes a byte through priv->data
(priv->data[priv->count++] = inb(...)) after the caller has returned and
its vmap stack has been freed:

  BUG: KASAN: stack-out-of-bounds in i801_isr
  Write of size 1 at addr ffffc90002a2fda9 by task exploit/5144
   <IRQ>
   i801_isr_byte_done drivers/i2c/busses/i2c-i801.c:546 [inlined]
   i801_isr drivers/i2c/busses/i2c-i801.c:613
   __handle_irq_event_percpu kernel/irq/handle.c:158
   handle_irq_event kernel/irq/handle.c:195
   handle_fasteoi_irq kernel/irq/chip.c:661
   __common_interrupt arch/x86/kernel/irq.c:263
   common_interrupt arch/x86/kernel/irq.c:240
   </IRQ>
  The buggy address belongs to a freed vmap kernel stack (task exploit),
  created by kernel_clone -> copy_process.

The completion-based paths (i801_transaction(),
i801_block_transaction_by_block()) never expose the caller's buffer to the
handler: they copy to/from the hardware block buffer in process context
and use the interrupt only to signal completion.  Give the byte-by-byte
path the same property.  The handler now fills a driver-private buffer
(priv->data_buf); the transfer copies the caller's data in before starting
and copies the result back out on success, so a late or spurious BYTE_DONE
can only ever touch driver-owned memory.  i801_block_transaction() already
bounds data->block[0] to I2C_SMBUS_BLOCK_MAX, so the buffer cannot overflow.

Fixes: d3ff6ce40031 ("i2c-i801: Enable IRQ for byte_by_byte transactions")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 drivers/i2c/busses/i2c-i801.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index c8cb5ed55..37741fdca 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -279,6 +279,9 @@ struct i801_priv {
 	int count;
 	int len;
 	u8 *data;
+	/* Driver-private buffer the isr fills/drains, so a late interrupt
+	 * never dereferences a pointer into the caller's block buffer. */
+	u8 data_buf[I2C_SMBUS_BLOCK_MAX + 2];
 
 #if IS_ENABLED(CONFIG_I2C_MUX_GPIO) && defined CONFIG_DMI
 	const struct i801_mux_config *mux_drvdata;
@@ -671,12 +674,23 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
 		priv->cmd = smbcmd | SMBHSTCNT_INTREN;
 		priv->len = len;
 		priv->count = 0;
-		priv->data = &data->block[1];
+		/*
+		 * The interrupt handler fills or drains this buffer
+		 * asynchronously and may still run after a timeout, so keep it
+		 * in driver-private storage instead of pointing into the
+		 * caller's block buffer, which is freed once we return.
+		 */
+		memcpy(priv->data_buf, data->block, len + 1);
+		priv->data = &priv->data_buf[1];
 
 		reinit_completion(&priv->done);
 		outb_p(priv->cmd | SMBHSTCNT_START, SMBHSTCNT(priv));
 		result = wait_for_completion_timeout(&priv->done, adap->timeout);
-		return result ? priv->status : -ETIMEDOUT;
+		if (!result)
+			return -ETIMEDOUT;
+		if (priv->is_read)
+			memcpy(data->block, priv->data_buf, priv->len + 1);
+		return priv->status;
 	}
 
 	for (i = 1; i <= len; i++) {
-- 
2.43.0

