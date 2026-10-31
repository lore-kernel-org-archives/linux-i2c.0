Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793417569;
	b=1ykqKUdxtwcSiUAbu6la0kg9wKAza8TK2FexRR6phTTRI7698CZS6msznbruvNmjQJv7
	 AtDGPvhdMwB6CQStY8QNHAKHLVLIBZ1nv0pYKa54x9RYVGbG63/6ymi/jhq8cvXGqoCbp
	 mTaZwa9WAePPdfFQ88cDtSnqaAYNjVFNFs/r3JjIq65yN4e3BAh4OzvAxH9iXJg+jq/cH
	 llOgiC7dgrP6j4LFKHDHCx8I7E4GtKsZX7Fp8OwggMPM9a8TNv+4JHmK8Ihbd4lAr3/g5
	 n7GvcMKLpmR35CLbB20SaarGytXSFLSsecPOWfoBY+lA4mZfmQc0RlPiCFuFRwNS0mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793417569;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=r/9Kh4W/8PI+qzZKkkw2QxQ/oWXZymvvuRJwD8jsr+Q=;
	b=k5kDxarxXkSoxjkAmk8rGyLznF73eQaf2F4PrzpHAWiQFYoXu1OUKCA2U5SmoOzFTwAj
	 LGqunGCHTvbYniO7+W8wCjIGzyQX+IGLgfTlAyP0cqaJCZx+CXCWd29J7opugaDOGksVP
	 paHFw6L3ghzj/RJzK0q5qbRjccgoHwJWuCjwp3dYhaHaI5dYchg3/1BllcdKD08f1yFlE
	 4BEdJkpwb0eVi9Q98I/vGcD4aQOxG4BvMIb5vyckhUQuipP0kpmWWI0s1WZc/zDo11EK4
	 rwhLk7T+WJzbWAuk2wgHdK2Ra5bNa4YbqBML1P3bGRPB74lplZdzGKtuBQZCKL/R7bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zACTxJbl;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCAA606A31F
	for <linux-i2c@vger.kernel.org>; Sat, 31 Oct 2026 03:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FCAA606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zACTxJbl
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-353804b591eso2138913eec.0
        for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 20:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793417569; x=1794022369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r/9Kh4W/8PI+qzZKkkw2QxQ/oWXZymvvuRJwD8jsr+Q=;
        b=zACTxJblE0Mehu3WtPTJNLO92nlM0Lj3YcICh+SmKit1AUIS1jYuUwF9/Po318tV7w
         fOeOLh7EulHmVYi6igIAMAcCUpLHuEzN3IA10JyBfxJlgVETscQTFSeF+6GB+IoD/QkB
         bgfcTXvZYZUP3VcBgPR/p8Nd0hYSij5kRpOF8RREJyM/a6xwbcwEToCU7rWQ9d93sh0k
         vJzAXRxfFUkIWu41lPHgU3DcJzE5g7p9cXGMLmYoXGn1AXVJXvtoHOuIVALCAixSqiKp
         ftBb4Q+7hgHDXaXlZ+uxcRLJjlxrBIdbvxTJOZ79CYJwKdGp/vZUqD6e2djTPG0gQXtJ
         3Krg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793417569; x=1794022369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r/9Kh4W/8PI+qzZKkkw2QxQ/oWXZymvvuRJwD8jsr+Q=;
        b=1WNPmXMMLfWq7tNQGvxHWb19ce8MJpQznVeJ4ySetubIrDHo/239hr3IWbUcD/M9aD
         tchoTpwBCtKdCo7BcJW7ujUj4L0b3ADLg+kzI85fhY86CzxUkQoY/QHeqnWGN5w1OXHP
         qKqTcb2jeTulyG9Q9LF+lb/oJzBgpOjDHvN01l6FcVxz6IuwG527dPQBvq53swGRsbkY
         94/4umlzHBaIjcFdS8ZcEwErat4Vy5i6sbX9qMI+p4UFUGT2tSuAZucd/OLs3FPH8Pxq
         BAMCMP+UhMjlYPID+uVMvyleNLsiZ3u4sU8fXO3ihFeQr5ugYG5OEafM5pnxkHJZ/RLS
         TWXQ==
X-Gm-Message-State: AFq9FYIgsQ8ygcMFMoY89JFcrlBZxwlEaLjHcKzPW/RrGJ+eyxJl6zlN
	YalclaI0ovZT/BeOW5Ux1MHX4+UcXAEoeAuv8nNNRN1D2Nz4s21tV8jdQXbXbykNM+Q=
X-Gm-Gg: AYBFou2SC6rCzkaoeD+Cm/iLNkkgUspT1VBB5oQeIIWZ78oHs9WDrEae7XOwthr7lyf
	w3MFU5Ct9SwVhvhmzboX4UOYkviEYIs3pVk4lsGo+gkafrxkQBbVk96xyKRb9EIMo35tB3BLfQa
	cxj940BGMmKSSVkPA/uZmYJhKOlOnK5cqiZN8NR4oV0EOwQOpA+PmTb8RNaxtwPX/mbQuSofroO
	bvn5Yfd0O4Vwlynoz8L8vb/4mBJFSiuSPPoMGbCITf+SgH7TqAskhlaF8kjp3XSPZ9kuIHJ6luf
	yJEOm9k5lbUsLubdgQjN1vFipIT60f9SRPlO8wyBF3ZFgxDh/ZXlrGqIq8wteMc7ezoa486Frf/
	p5R594qG1g2lwfJaf6HGdf4sNzmX+yxk0z9H/CVL8HR2gVwBQSSjbakAUzj+GHMa6CuiNfzFjUf
	fIUoW4XRCSMoLVpl6Sf//kQpmswHrI++Qu8n1rFmXv9HedhZsclMLMMUBDg8Zv6Dtwj2PhNUAQg
	sKXt9wbrG86rx1HbwM2BdQ/W9J/vtiWvubG5oyXxTOJ9g0bacoE7yIzGpm1/ZKSoKGpiQQq9Hf4
	gN2AscKio6UgxAkIFUX399IVSh7f6/uQh0GlbXmKxlMftAAER4W4Z52Xwz639tp8dQ+egEvKaJq
	xhEHFipBpstpG17SOSSH1RS60dMIMIx3uqQwKigE3/XFnVzBnT1aVL2whjkT1cs7c/qwoyMrBD9
	D4JmhR12T2fW/sEQ==
X-Received: by 2002:a05:7300:f793:b0:35d:2633:ff79 with SMTP id 5a478bee46e88-36a4245944cmr5726332eec.40.1793417568286;
        Fri, 30 Oct 2026 20:32:48 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428ecb61sm10544826eec.10.2026.10.30.20.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 20:32:47 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Peter Korsgaard <peter@korsgaard.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: ocores: synchronize startup with interrupt handling
Date: Sat, 31 Oct 2026 11:32:44 +0800
Message-ID: <20261031033244.2491032-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A delayed interrupt can retain the previous transfer's pending STATUS
and message pointer while the next transfer is initialized. It can then
advance the new transfer before its address transfer completes.

Hold process_lock across control setup, transfer initialization and the
START command. Read STATUS and snapshot the message under the same lock
in the interrupt handler, and run transfer processing with the lock
held.

Found by Sashiko AI review.

Link: https://sashiko.dev/#/patchset/20260813153155.3953577-1-ruoyuw560@gmail.com
---
 drivers/i2c/busses/i2c-ocores.c | 45 ++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index ff024cf5f92d..e661693827c5 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -28,8 +28,8 @@
 #include <linux/jiffies.h>
 
 /*
- * 'process_lock' exists because ocores_process() and ocores_process_timeout()
- * can't run in parallel.
+ * 'process_lock' serializes transfer startup with interrupt and timeout
+ * processing.
  */
 struct ocores_i2c {
 	void __iomem *base;
@@ -148,27 +148,23 @@ static inline u8 oc_getreg(struct ocores_i2c *i2c, int reg)
 
 static void ocores_process(struct ocores_i2c *i2c, u8 stat)
 {
-	struct i2c_msg *msg = i2c->msg;
-	unsigned long flags;
+	struct i2c_msg *msg;
 
-	/*
-	 * If we spin here is because we are in timeout, so we are going
-	 * to be in STATE_ERROR. See ocores_process_timeout()
-	 */
-	spin_lock_irqsave(&i2c->process_lock, flags);
+	lockdep_assert_held(&i2c->process_lock);
+	msg = i2c->msg;
 
 	if ((i2c->state == STATE_DONE) || (i2c->state == STATE_ERROR)) {
 		/* stop has been sent */
 		oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_IACK);
 		wake_up(&i2c->wait);
-		goto out;
+		return;
 	}
 
 	/* error? */
 	if (stat & OCI2C_STAT_ARBLOST) {
 		i2c->state = STATE_ERROR;
 		oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
-		goto out;
+		return;
 	}
 
 	if ((i2c->state == STATE_START) || (i2c->state == STATE_WRITE)) {
@@ -178,7 +174,7 @@ static void ocores_process(struct ocores_i2c *i2c, u8 stat)
 		if (stat & OCI2C_STAT_NACK) {
 			i2c->state = STATE_ERROR;
 			oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
-			goto out;
+			return;
 		}
 	} else {
 		msg->buf[i2c->pos++] = oc_getreg(i2c, OCI2C_DATA);
@@ -200,14 +196,14 @@ static void ocores_process(struct ocores_i2c *i2c, u8 stat)
 
 				oc_setreg(i2c, OCI2C_DATA, addr);
 				oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_START);
-				goto out;
+				return;
 			}
 			i2c->state = (msg->flags & I2C_M_RD)
 				? STATE_READ : STATE_WRITE;
 		} else {
 			i2c->state = STATE_DONE;
 			oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
-			goto out;
+			return;
 		}
 	}
 
@@ -218,25 +214,31 @@ static void ocores_process(struct ocores_i2c *i2c, u8 stat)
 		oc_setreg(i2c, OCI2C_DATA, msg->buf[i2c->pos++]);
 		oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_WRITE);
 	}
-
-out:
-	spin_unlock_irqrestore(&i2c->process_lock, flags);
 }
 
 static irqreturn_t ocores_isr(int irq, void *dev_id)
 {
 	struct ocores_i2c *i2c = dev_id;
-	u8 stat = oc_getreg(i2c, OCI2C_STATUS);
+	unsigned long flags;
+	u8 stat;
+
+	spin_lock_irqsave(&i2c->process_lock, flags);
+	stat = oc_getreg(i2c, OCI2C_STATUS);
 
 	if (i2c->flags & OCORES_FLAG_BROKEN_IRQ) {
 		if ((stat & OCI2C_STAT_IF) && !(stat & OCI2C_STAT_BUSY))
-			return IRQ_NONE;
+			goto out_none;
 	} else if (!(stat & OCI2C_STAT_IF)) {
-		return IRQ_NONE;
+		goto out_none;
 	}
 	ocores_process(i2c, stat);
+	spin_unlock_irqrestore(&i2c->process_lock, flags);
 
 	return IRQ_HANDLED;
+
+out_none:
+	spin_unlock_irqrestore(&i2c->process_lock, flags);
+	return IRQ_NONE;
 }
 
 /**
@@ -356,8 +358,10 @@ static int ocores_xfer_core(struct ocores_i2c *i2c,
 			    bool polling)
 {
 	int ret = 0;
+	unsigned long flags;
 	u8 ctrl;
 
+	spin_lock_irqsave(&i2c->process_lock, flags);
 	ctrl = oc_getreg(i2c, OCI2C_CONTROL);
 	if (polling)
 		oc_setreg(i2c, OCI2C_CONTROL, ctrl & ~OCI2C_CTRL_IEN);
@@ -371,6 +375,7 @@ static int ocores_xfer_core(struct ocores_i2c *i2c,
 
 	oc_setreg(i2c, OCI2C_DATA, i2c_8bit_addr_from_msg(i2c->msg));
 	oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_START);
+	spin_unlock_irqrestore(&i2c->process_lock, flags);
 
 	if (polling) {
 		ret = ocores_process_polling(i2c);

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
prerequisite-patch-id: 44b1c2680cb029871e123eb11eab7764a807ef24
prerequisite-patch-id: f4dfbbaaec2d208ac255451cf032c22f0e7fed2d
prerequisite-patch-id: ff6a574f35399a0059df3a759cbd2a558d24300c
-- 
2.56.0

