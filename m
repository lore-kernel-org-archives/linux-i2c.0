Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D01374A0B
	for <linux-i2c@vger.kernel.org>; Sat, 18 Jul 2026 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784365420; cv=none; b=uS3QPc0fhGg0O4KtC6z/2d55ygPulxgyxN1RL+qH2SqyiwiuH+S5GyJb3FwqlsypzsdkdgCw+jMZdGFAXtVzm3z9t6dwIBkPUwdV9Qh0vpdyzBZkYgsJ3iIQOvxhOlxch/Ci7b9ucxU9JdFXfBhG/09BpY6WloZRAK7YIaOPDGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784365420; c=relaxed/simple;
	bh=wxLNkNVEM+EW0Q1B7ghLRQXzeadsZ5crecqVlqI6M34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MSn25ildwwyRlz8C2FkUd6TDofJPw3n7SvtREyYMazw1VRP/G49MvAXI4aIWvq7LfVB95LGJ/BDRU5QgDRwKsaS64MJrVfFivhQH8Ob7Mj1GMmqE7n/PIpE3yWKHFk7M0+OKHudR0DQAKDj7rWOghc06zadUk6tLh3FdFJy79oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdFhlmlh; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdFhlmlh"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so6559936a91.0
        for <linux-i2c@vger.kernel.org>; Sat, 18 Jul 2026 02:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784365419; x=1784970219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DcZ1SQGu/N0fFPEiHGk0VNuvuqYiBFKMIZfbviUQEsU=;
        b=cdFhlmlh5CUGrLn//aYiR5bNGADDUce8ZSBBMiwgSxYT4FGfzTd3N0zR72JPf8yI9F
         /5QOkVlqRtnzHPVnag/+JMrWecLP52ixZ8K7y4DJgLWmNxHmQ0EIVAPf3gwB+AqV/+fb
         nLoWU2sqOfZnXhTfM0pkcH1kfrbM2OJOc6JacVaKDfg5i9y12YiZ/uTWKEZgisnIOgCb
         /UFafo/sqjF31x+/YhIKFiqCeS2q+kXSkxfHU9k1XSJ02iyfSTUPupTvKIyozWHyZdxM
         hiXZdkfQqUup/mnWp8SNf4eE29bk60rKU+g+Ip7Paz5+JrBrzQXgvP/ZBriRz+v8+OLT
         EWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784365419; x=1784970219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DcZ1SQGu/N0fFPEiHGk0VNuvuqYiBFKMIZfbviUQEsU=;
        b=Ma5fTzviCGt+AhIiEASM9J2K528tgy4M8xIOuPITB+Dt0rBP9ok/ASVnzFOevQMfE0
         cwTauQ1FQAbCyUWb3nWRXo4TWZHLH1Hc4mpvXxK7yJ8SHTiUVTdjWBy9oWNM+09mwZTK
         kdzYurCbbjPz7lvz5qZvkDhvky6zZrlRgv3eyMYVvu13XJmrnXUCNW/Ohsu+NG0NDLku
         s/apjanPjnmvZQ4rN4OJXF8/atos1n8GJRR8T8bchZKyWah5BXQGMCsRfW9C1FEinjsA
         An9q2CvWNC7qfLwxY4pesSwYZSNRRKKXWGFQl4TrpXPjD5he2Sf79swVBr52Rb9cNjYA
         er6w==
X-Gm-Message-State: AOJu0YxDSOZpJBHvbNqJvJJZs98wSVirJupHDdVBhCziYQbyPAhKNURN
	tcjse0BBE9kES327am9D5h+BnLhzppuniINj0nRprgllt2Tpco9ZeoR8
X-Gm-Gg: AfdE7cmXboCHFnmG2XMTzgsV2irK/FmUtILUI6F2WU61dJe2emMJR1He3FKaKprB96/
	eGLvKOCFh6qGhyqFhvztinpoCKHaoXdwxWgugJL+RfjEupf8BdNOMpCGAptZHowUrMgh3gtq5RP
	QwSpEyHXuX5R2j2gxADfcIk0CijfQbnlWa1Xv/s7mRclsE956wmSe8wazikRVQlRMTSCeHPL+pm
	e6wlOjkDcAeRG8WJfdWdAyumewOP/p133C6EttUIipTPSMBxTP46/0zB+uP/vW37bfTIWEyCHtU
	Rkz0We6Q61halSGGbsw9x16VxiBMDASaGjZ7B9luorGiWnWZvDiPEkwDwfk7EircTm4A25wRO3x
	bBnTUFK+jNMFay/tiWqQXhJVE4Oa5W2UOYOf+PT3mgZokneVFDga86L3NAKvwtczski1ZtzIbrZ
	J+NA/rGMGX8q0sc+w2VgvkaIqf9IeqiVBWewmo5dpPtgD0H+g=
X-Received: by 2002:a17:90b:388e:b0:38e:475f:810c with SMTP id 98e67ed59e1d1-38e4b5e8a53mr6610509a91.41.1784365418538;
        Sat, 18 Jul 2026 02:03:38 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20b037sm16580102eec.27.2026.07.18.02.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 02:03:37 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jean Delvare <jdelvare@suse.com>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH v2] i2c: i801: keep the byte-by-byte ISR buffer private to the driver
Date: Sat, 18 Jul 2026 02:03:30 -0700
Message-ID: <20260718090329.1622366-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
Changes in v2:
- Fix the author: From/Signed-off-by. No code change.

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

