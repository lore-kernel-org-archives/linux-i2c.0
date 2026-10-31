Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793408826;
	b=ReFRDVsNxy+p/RyxaEdbShq/9SWtbeaY/vRNrZPDOIrsJ2keu5EDlmOy0oLudEnpRA4w
	 gYQtoDcI9D6aGWmFGkncpFtmMNff8rQW18PA3UxmMtRQH9LRnnj+XkcVcaeSXO84T2UQa
	 lPyt9SejiqP8zTIkGdu/DslCP8BnrBD6G7wDlxJKhb8Pu+raQ2aK/7VnbcHJLQI/JIIyi
	 Ve5dNIN/45zkHz0BT9Z5LlYgxACaX5803prNidHnEkC2Oo7MZXPWhF/tiPMu2YJNt7gqi
	 Eyc4UdDYBKB7jC3DyvZXv9fPg7iJeou6c/gzDUDWmhverzPmw+3uVH0bB7W/YMThU1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793408826;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xT9iMK/3RSde+zBTAQleC9VvYEhHkZyaWiIqI8wE2FM=;
	b=OsOB1i+Ma9UcdsN37Kejfzha2MvyJOu1/1n8rOk2f1zkp67zFMHbilE+fwAW9rh7b23B
	 dxHvuHNWAhena54oimoQhcL7BjTAQ8W439phrraxVzQZTW6GVT2ZKEqH2xNZ4Sfxdd9Zo
	 VMJlImAsoIdkRzGeLg2IkDolM7PU3PBwLzi8hckmGWwF5oA5GpIx6e0kGh+KslcKFS5ig
	 UtENfhQcMyiAnWqD402TlhQmELF3+q6SwQPdOu5ix/OG/c11OVGVm9qiJsDNzn02bQwBz
	 HOx10GHAykEC3KgoRgkbdmnWfmxifVe08P3tJKQ+cBuuvU96jysOU6f6TrvBwqUzOyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cOAbD30s;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D76606A31A
	for <linux-i2c@vger.kernel.org>; Sat, 31 Oct 2026 01:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9D76606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cOAbD30s
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33fb4680717so546713eec.1
        for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 18:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793408825; x=1794013625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xT9iMK/3RSde+zBTAQleC9VvYEhHkZyaWiIqI8wE2FM=;
        b=cOAbD30sbP8coqbY7WR55KoVfEL18HRW3wWa9x6tJnKxqfOtVa5AlUoIhAH75tardk
         +job3cpt7i2RGlW5se1Jlprl9fWpfuaO0gXJkLo8IvbKGye6jDkY2FRHovToyi8f/B1O
         T5O7lSxK7tpgYN8UQLf5ox55xEuZBYQ3FwIxBHI60SP55rP9WNfMp16GkAia+Df0EOi9
         1Izd9bJzG4h89Y+HqYy+v1Tq7UPqkR6xYJS3hDTFfhfqSafuMEylCM0cV0lvCJNO1SVv
         FBNIV8/5DPJ28eZBntCWlMSdSpn4Egef1z5vHmFReH9CjMXfHYXZAdnDAwe7NY+LAzh6
         VJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793408825; x=1794013625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xT9iMK/3RSde+zBTAQleC9VvYEhHkZyaWiIqI8wE2FM=;
        b=qYOP1wf7GKLERHq+n0pbTBKAf7iSkywUqZiF6PzvS4jQ2AywQ4rdcxZpiaPwSIuqd5
         Ai4x9aVHJPoyiqm7pabQyz1sw11jTT9YSs7w5MnJGwOFVgkx+jI0OrarEQET3C3hUpf3
         8T1XFVyp8BBLjIzXCoauwsovx3Nw/iZzzYXiCXFd60kfUyWRA7FyNxPmyHcVDEipgqpN
         3PLa6wyFJIkZFnO/trD6W0hPUCcuSlnOoSSYECaC0VRbQGJCAxMciZIvyk2ycOR0UQsI
         S0prR02sybw9fKTo94AtpAXOYAT25qlLvFclsyMDknOnGjNttYwdU/U0GwLQUQYJ0GIp
         nkhQ==
X-Forwarded-Encrypted: i=1; AKwUvByjA1BBMA4rpf8UOPoMyA8B40PDYXAfDytq8h0lU08lS0V7voUoLiWHv0yq5uy/F9SK2RoXg2Tr9kc=@vger.kernel.org
X-Gm-Message-State: AFq9FYICIYCZvgtqlPlePZvQOx+WfPMvfJAI5NVeRGYNT3uioNAZaaKS
	CyyvSfWSdwnHUscPKm7bdtvw5Mt7iObGQ0KYYUdhJcwJfhU19VIUuhmI
X-Gm-Gg: AYBFou1sjI+BpjnKDX13r342olSdSPNj3hfuPOHm+tHVuW0+UybVqqhHkKDM6kqrCrw
	j3mD9cIez2aXeRftGguQRlg2rowh9NFtPJxe7Ksd4+xL6cuK4bc/JGj9Q+vqzogmnPnLL17o1yj
	mqWr4m4gwMSl10DhZv4YpOBgHPbHfpEdKYUIkZj1Cfa75CnR3sCu1CcwLth/jE4F3h+qa6qU1Co
	p4E5yHGuqcDnVUcTLp0irES19bf8pj/2tq9B4Gm1xZTpVJMlNGiHbYVV9AAT9kmxELIdMjv1rOe
	+QP23Ez1saeM1tNEvGbac0aBDjr53hnSMdi11h+gczgst99OriQ6ue8mWv4B22GSLX7euFCAAhT
	n86ipZc+61nOpKYzPR1GID1jrWvBp6cJT67WCo2WzjDVoPP4QVxNt+mHIrUoKZzq2hb2yFreQq7
	UPXckh7zfYBeZP9XD8Chzf0/2ourAtA9TyXGC3+k21msOrWlzYx2M/2TLO8QGRwuufRWd9N/b+u
	gouP6+dABNQpIayiRLzt9ViXSh5OBxYAl3Ue8oaOuiItg4lMGgtkfFwPX4mDRKMek7NJCRyA+aR
	feFVoFjK6LDQEbLDptp6aaM9dU8YDqFS7M+XQAIxqWQRFWKrv7VJ32Q08NnqFKAHZ1nDDcMaFVY
	fLAtsX0tR5oFqIA7Ne5YAnp2jJ7FRY+kxefr1snvXxD/Isj3QTIL58DlmvhQTelAmptT9Qow/ok
	RN2ntUGeylPlIt8pOj
X-Received: by 2002:a05:7300:4353:b0:369:fc93:eda5 with SMTP id 5a478bee46e88-36a42434630mr8230258eec.39.1793408824646;
        Fri, 30 Oct 2026 18:07:04 -0700 (PDT)
Received: from brev-9gdpyq8lp.ap-south-1.compute.internal (ec2-3-110-210-194.ap-south-1.compute.amazonaws.com. [3.110.210.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a429018casm9876477eec.14.2026.10.30.18.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 18:07:04 -0700 (PDT)
From: Samarth Narang <samarth.colleges@gmail.com>
To: Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-i2c@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Samarth Narang <samarth.colleges@gmail.com>
Subject: [PATCH] i2c: stm32f7: synchronize DMA termination before releasing the buffer
Date: Sat, 31 Oct 2026 01:06:58 +0000
Message-Id: <20261031010658.3366395-1-samarth.colleges@gmail.com>
X-Mailer: git-send-email 2.34.1
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

stm32f7_i2c_dma_callback() is used both as the DMA completion callback
and as a cleanup helper by the threaded IRQ handlers for bus errors,
arbitration loss, PEC errors, NACKs, and DMA completion timeouts.

The helper calls dmaengine_terminate_async() and then immediately unmaps
the DMA buffer and releases the DMA-safe message buffer through
i2c_put_dma_safe_msg_buf().

On the error paths, DMA completion has not been established.
dmaengine_terminate_async() only requests termination; it does not
guarantee that the transfer and its callback have finished when the call
returns. The DMAengine API requires synchronization before memory
accessible to the descriptor is released.

Although the driver calls dmaengine_synchronize() from
stm32f7_i2c_xfer_core() and stm32f7_i2c_smbus_xfer(), these calls occur
after the IRQ thread has already unmapped and released the buffer. They
therefore cannot establish retirement before that release.

If the DMA operation retains access after cleanup, a late RX write could
modify freed or reused memory, while a late TX read could access data
belonging to a subsequent owner.

Introduce stm32f7_i2c_dma_abort() for the threaded IRQ error paths. The
helper disables further peripheral DMA requests and calls
dmaengine_terminate_sync() before invoking the common buffer cleanup.
Since these paths execute in threaded IRQ context, synchronous
termination is permitted.

Remove the redundant termination request from the genuine DMA completion
callback, where the descriptor has already completed.

This establishes the intended ordering between DMA termination and
buffer release under the DMAengine synchronous-termination contract.

Fixes: 6aae87fe7f18 ("i2c: stm32f7: unmap DMA mapped buffer")
Fixes: ffdd20555cc6 ("i2c: stm32f7: support i2c_*_dma_safe_msg_buf APIs")
Assisted-by: LLM
Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
---
The issue was identified using a research static analyzer for DMA
lifecycle ordering and subsequently reviewed against the driver source.
It has not been reproduced on hardware. The patch has been
compile-tested on arm64 with W=1.

The practical exposure with the in-tree DMA providers may be narrower
than the API-level ordering violation suggests. stm32-dma clears the
stream enable bit and polls for it to clear, while stm32-dma3 suspends
and resets the channel. However, neither behavior alone establishes that
a concurrent completion callback has finished. The stm32-dma polling
operation can also time out without propagating a failure through
device_terminate_all().

Consequently, this change primarily corrects the driver's reliance on an
asynchronous termination request as a final-retirement guarantee. A
physical late write would require an outstanding access to survive the
provider's shutdown behavior; that has not been demonstrated.

Remaining concurrency issue: this patch does not resolve a separate,
pre-existing race between genuine DMA completion and threaded IRQ error
handling. If both paths invoke stm32f7_i2c_dma_callback() for the same
transfer, they may both attempt to unmap and release the same buffer.
Establishing a single owner for cleanup would require an additional
change.

 drivers/i2c/busses/i2c-stm32f7.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 6bd281a9e..891b0eebe 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -736,7 +736,6 @@ static void stm32f7_i2c_dma_callback(void *arg)
 	struct stm32f7_i2c_msg *f7_msg = &i2c_dev->f7_msg;
 
 	stm32f7_i2c_disable_dma_req(i2c_dev);
-	dmaengine_terminate_async(dma->chan_using);
 	dma_unmap_single(i2c_dev->dev, dma->dma_buf, dma->dma_len,
 			 dma->dma_data_dir);
 	if (!f7_msg->smbus)
@@ -744,6 +743,16 @@ static void stm32f7_i2c_dma_callback(void *arg)
 	complete(&dma->dma_complete);
 }
 
+/* Threaded IRQ context only: terminate_sync() may sleep. */
+static void stm32f7_i2c_dma_abort(struct stm32f7_i2c_dev *i2c_dev)
+{
+	struct stm32_i2c_dma *dma = i2c_dev->dma;
+
+	stm32f7_i2c_disable_dma_req(i2c_dev);
+	dmaengine_terminate_sync(dma->chan_using);
+	stm32f7_i2c_dma_callback(i2c_dev);
+}
+
 static void stm32f7_i2c_hw_config(struct stm32f7_i2c_dev *i2c_dev)
 {
 	struct stm32f7_i2c_timings *t = &i2c_dev->timing;
@@ -1552,7 +1561,7 @@ static irqreturn_t stm32f7_i2c_handle_isr_errs(struct stm32f7_i2c_dev *i2c_dev,
 
 	/* Disable dma */
 	if (i2c_dev->use_dma)
-		stm32f7_i2c_dma_callback(i2c_dev);
+		stm32f7_i2c_dma_abort(i2c_dev);
 
 	i2c_dev->master_mode = false;
 	complete(&i2c_dev->complete);
@@ -1617,7 +1626,7 @@ static irqreturn_t stm32f7_i2c_isr_event_thread(int irq, void *data)
 			__func__, f7_msg->addr);
 		writel_relaxed(STM32F7_I2C_ICR_NACKCF, base + STM32F7_I2C_ICR);
 		if (i2c_dev->use_dma)
-			stm32f7_i2c_dma_callback(i2c_dev);
+			stm32f7_i2c_dma_abort(i2c_dev);
 		f7_msg->result = -ENXIO;
 	}
 
@@ -1635,7 +1644,7 @@ static irqreturn_t stm32f7_i2c_isr_event_thread(int irq, void *data)
 			ret = wait_for_completion_timeout(&i2c_dev->dma->dma_complete, HZ);
 			if (!ret) {
 				dev_dbg(i2c_dev->dev, "<%s>: Timed out\n", __func__);
-				stm32f7_i2c_dma_callback(i2c_dev);
+				stm32f7_i2c_dma_abort(i2c_dev);
 				f7_msg->result = -ETIMEDOUT;
 			}
 		}

base-commit: 83f32c773255720a661aa45d83e36278135f23f5
-- 
2.34.1

