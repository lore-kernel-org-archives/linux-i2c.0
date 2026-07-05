Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275F7380FEB
	for <linux-i2c@vger.kernel.org>; Sun,  5 Jul 2026 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783267188; cv=none; b=OZKviZJ0cNrWLLzZEhHS4lrZpDZRVBz9lN4OlEzVWNrP2pjfxuYoF/nFySHK0C+x0n8Njf8QZpVVhYAsyQ2qsbCYCKN6VkKb6WJF8vMsh0eKNmiPs06YuYPWL+JRdrm56+mSXNgQCEJFewHYnAGjxPQENeCUqLcqs9X5Z4D0HSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783267188; c=relaxed/simple;
	bh=xPyvtKmNvExaeH5iOJF/u3wmRDZK6SHOgH8krALFXzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oGAJA9E+4Zkw5Mx2VbVuMFDg3vpDUPi3Lj+EnmkPmc2q8XUniTarQ7JuEWs6MHaZ2ookl3PUbNlX7CK3+K4VdF9mA+MJPDrV/Y4QRqZ7XaRjeuh7Uu+lVmiZIxjh48FiFKaVChIh2iB/VXH+jdUsj5jDtU6Xsy5tsaCBEAv1xJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDqM/I/d; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDqM/I/d"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ca70925c25so26676725ad.1
        for <linux-i2c@vger.kernel.org>; Sun, 05 Jul 2026 08:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783267186; x=1783871986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2h3lN4661rhNBRpzqyqQ47ADQ5d9ZH08acIhfwExsJ4=;
        b=fDqM/I/dyFWYPGIB0fmjdV7FKjbFCOQqGM/Jc6AGOkM9fG0VvzuTsckITDeMBPg20n
         r42Xj7rkyqkjmu5gIwWDu/nkCXux3/22GBszCEmIuYkGtAwDFjeMt4PQY1JOTk/stM5f
         iuwcc0fhh8p5Iaz79f813tbeNL5VUu7pq9BMBa9oHwyGnbOpoRed9doBdTY3Gdcohp/1
         0PItCYOkOroSkEwewk6IG/LAs+lwMUPHBEQIn1zaQUpuU7WfC8ut1Ikyen42/1ApnuGs
         dhzZnzAN7cAftlOye2bbvfBPwU0bZ3eEvufAYYptr/cIJgz4es8ZlBABCexKUWu0ZuC2
         reTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783267186; x=1783871986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2h3lN4661rhNBRpzqyqQ47ADQ5d9ZH08acIhfwExsJ4=;
        b=hozXZNgKAq388uHSph27QGrjfH+Vl8RfA5QYPXvajjXHT6vl28A1HR42FmwyDu53TQ
         hZ62hEV+F7UbCtX72mFlHFLIEuOLafAeb05OEVelho1luuDWPELDJveGARaRbc0vDdhc
         LCWbb1JkKCWQq/RoStV3iic7/eQF40kuNJyhJNMjl0Ps/ZUZKhBqanBiHnvZOlxdPAIC
         mUPV+eucdF3Mz2z2DV3ezx6I6lngTyfFMz4lOmyLIWKS1Vm8gxVkusIfXmad6nKdQZUf
         xHiRJedTXzZVeMSSe3GqHCdDSPI+85KZJ+WKdUkUEEpQZluROBZm+WBwjHxGSDqmBs1q
         kJjQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp5/j7dLESas9id6Rk+vZCrXpH5LxUIfabElhv34BmuIMmswF5zuYac6Rug9XtKWUHczynxCjC+07c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5eZEKBhYCY4n6wxBO/WlCECtCwvczpfaGUWHtGFOLRIP/qc+B
	ZzMOE4cVAg4Oei1FM6A0QI42Us9HjyB+DfYGcNzImLA65E6r0vnMxRiE
X-Gm-Gg: AfdE7clFcbqVONlpsYlWOrlYh1Cw5s1TggmIrga4DyEE9Bjzp34GkiBmlNNrDckN5yq
	5AcUYaGwysJeCFOd2FerByiam5wF6DEEB+VaAyVwknSU9GHedZ3c2gFht21fmBfhfLcp7Q47JNB
	N1IW7FYGPcTltUmSffzNeRcNBN2Df5yo9Ue4fw8m/tDvUGinUl4muMVZNP+XWF9QCcRLlzIiAu1
	O9mUZvKmrP2ZxJLnXUQLn5kWtoMOOpKPe7/+QVrG7vfJMqedyaIeEayAqwWKz0trxJtdncSSYsN
	oe29PyjmzMfQJzuoCnv2U1jV1/XW8VbNnqa1GSmjrUMHfS4AAVmdoyH/NCXbXXdrDLe2bw6bYXn
	1EopGg7X/I4OpqbUqvrBnee2Mohkcxk2ZwW7NZMgjhFVNsiKPePoTg8hWZmtGXAx8xZOcAP6Ieh
	Obgw==
X-Received: by 2002:a17:902:f788:b0:2c8:1c05:16aa with SMTP id d9443c01a7336-2cbb7511947mr65538905ad.19.1783267186422;
        Sun, 05 Jul 2026 08:59:46 -0700 (PDT)
Received: from lgs.. ([101.36.111.22])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad78aa06bsm35281165ad.84.2026.07.05.08.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 08:59:45 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Viresh Kumar <viresh.kumar@linaro.org>,
	"Chen, Jian Jun" <jian.jun.chen@intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] i2c: virtio: Reset virtqueue before freeing interrupted requests
Date: Sun,  5 Jul 2026 23:59:25 +0800
Message-ID: <20260705155925.292765-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_i2c_complete_reqs() waits for each queued request to complete
before releasing the per-message DMA-safe buffer. The request array is
then freed by virtio_i2c_xfer().

After wait_for_completion_interruptible() was introduced, the wait can
return before the current request has completed. In that case, the
request and the remaining requests may still be owned by the virtqueue
and may still be completed by the device later.

The error path nevertheless continues to release each message buffer and
virtio_i2c_xfer() frees the request array. A later device completion can
then write to freed request memory or call complete() on a freed
completion object.

Reset the virtqueue when the wait is interrupted so that outstanding
buffers are recovered before the request array and message buffers are
freed.

Fixes: a663b3c47ab1 ("i2c: virtio: Avoid hang by using interruptible completion wait")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/i2c/busses/i2c-virtio.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
index 5da6fef92bec..6ef09eda3ed0 100644
--- a/drivers/i2c/busses/i2c-virtio.c
+++ b/drivers/i2c/busses/i2c-virtio.c
@@ -117,12 +117,19 @@ static int virtio_i2c_complete_reqs(struct virtqueue *vq,
 		struct virtio_i2c_req *req = &reqs[i];
 
 		if (!failed) {
-			if (wait_for_completion_interruptible(&req->completion))
+			if (wait_for_completion_interruptible(&req->completion)) {
+				/*
+				 * The remaining buffers may still be owned by
+				 * the device. Reset the virtqueue before freeing
+				 * the request array and message buffers.
+				 */
+				virtqueue_reset(vq, NULL, NULL);
 				failed = true;
-			else if (req->in_hdr.status != VIRTIO_I2C_MSG_OK)
+			} else if (req->in_hdr.status != VIRTIO_I2C_MSG_OK) {
 				failed = true;
-			else
+			} else {
 				j++;
+			}
 		}
 
 		i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !failed);
-- 
2.43.0

