Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4C0334C2E
	for <linux-i2c@vger.kernel.org>; Sun,  7 Jun 2026 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780842978; cv=none; b=fuK4omg2BYk9KovYS40Z16cAHEl4l2Wl4XYelceWa95L/k3MJ+zDt2KspDx5awVgY7YJF8P+nzuRwH+M5J4ERVmA6XRyVDL1uF07qoAJYq8wHoG0RWH0Ps7agbM8k/MbYJiJLOHfZrCJQWQguojdmhIm9FfR0sxT10H2C+XVsZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780842978; c=relaxed/simple;
	bh=feUHH/LEp6u8/oHXbL8P6YPJHTZzLSmRNvRm45rta6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gI6NOC5ESLU/N/j+rlzfVJ4PBQLt/cPjTVGKDfqp94i5NCKMi59r71JyL4BPdQSSjd3JbrLhUUZe8d+y5RWQ8TUr2sZFbmUGr5UB7N2S2fMzbUxazv3t4iuZkJsAaUauMITykq+R4ZG7F9Qc/KyBF5Lrq1O2OWDVagN4+VWQFqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=samsara.com; spf=pass smtp.mailfrom=samsara.com; dkim=pass (2048-bit key) header.d=samsara.com header.i=@samsara.com header.b=TIsk1vBJ; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=samsara.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsara.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=samsara.com header.i=@samsara.com header.b="TIsk1vBJ"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ce9df48e1bso34177186d6.1
        for <linux-i2c@vger.kernel.org>; Sun, 07 Jun 2026 07:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samsara.com; s=google; t=1780842976; x=1781447776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DbW28oB1oSvzSZjZ+FNiYrjtjQr/zqCs0wyMZfyjnsw=;
        b=TIsk1vBJVmGszqlDMbgByGcmhAK1N+LZFf9Mw1wsBhnz7vf9+KxwQzbjmoDu8uZAuU
         ZC2XB7gh9T0m8clUlLOVUN3wYab6xbQ+Rs8ID+QjSGj7bp2oD3Bfx8VInRlw1JI2y1yu
         kuXPbC6uWaOjbJ6FBdjTa5dig0nHbsLZPgjsqeH82mfYW3xbPJUejj4kCsF6cjyTrHFe
         zDQpDJVX5hbKd3HQIPcQrlaExJmGVMfh33tqmXf+veeUHKdYHHkV3TylxNpnafwd+pSK
         TSdeoNYNWsU0TfLF2TpEA7Y/K4Icl5ftDJvGwkjzBQ4AZmKBA8vvC5RhhJjJ2kK1YPUO
         RO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780842976; x=1781447776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbW28oB1oSvzSZjZ+FNiYrjtjQr/zqCs0wyMZfyjnsw=;
        b=U0GQJbANEEs39BHGMFSwVNnJKSpIxPTbgsd4mJdCoAEU8v91cvwJ8fzQyvW1Jm4MlQ
         jqH+ykH4+TaW/3D9zwT/FH+C00IqNRCxO5MPhLY+rGWP/LeQOzFdpELporfflSPAXW8H
         Fa5zdIKXcoquXtEx0BUJSPEvtJAwy55tH6fbnLNfoirWTJlt2tyGSyg5eGZAPrqcT8K5
         rZxpnMeg0K60MLvO583CEG9CyCvb4Io+ZpKpZLfTbOysUOwgVdiIVopPvp/NN/sVcyA8
         mrn+YxdHubfdgJ6Yz+ONExQyHqI9jMqt9cdHmsyOQ4W1nTH1m/vi4FO0rQbyawOvwC1b
         DTRA==
X-Gm-Message-State: AOJu0YyDOFmTVOLhOtNBPnIMB6YJ6LwEuO4dr0/imof4/otb6gjcUPaF
	TBkKkLidYblWawtNiPeyW+IlcLXYOXuBAyYSngVCVQX7hsTpkcD7YRMHiTLXJa3eZjAvYWhaZm2
	u+wc=
X-Gm-Gg: Acq92OHnqthHXVeE24hK6nKD/gcAazJwL3gUpDVULvOSsWjkke830DnvHyRagMVF8nd
	ZsTzinD5lssi3XB00zK0TKC7AA94ckB5Yp9YqtNOwVxaVjpo/TRo/If6OP3lKWEB+Qezx6ruowX
	1y0h7w/FGOg2Ok9niUuYTWufg23E7uaIZPhDU/uak0xsUZoEjKAT5ad+hpiTC43rqa0JZ4Qk4hT
	Hlq20CDwskL0eMIXYQuhIv4XRCnAvfEycZZvyC1o7wwa92eCLRRfP7niG0aUcFgGFZ1CtIQZBQg
	zrLvz8JQ5QmSp2vvpDqYelHPvUjp+M998zy/fD59sSCraAqlKkH0o+TdUNjjMoU1ehI27y4tnzN
	z1N62vi01AGVOIY1Gd4ii5fFEuswajudm5Q6tFnszphT6DgIaOecF+x7nYEFFvOVKQS05VUtko6
	nAUYIQSnoFzSJiBw0wqX1fKPpKXRn0yhFqA1VjvB216+aj79mhsv2sLH0zq/SKIsFECZZECAakL
	6JQ/6jiuurWfmE=
X-Received: by 2002:a05:622a:188b:b0:50e:6182:b4c with SMTP id d75a77b69052e-51795b8f843mr169612541cf.25.1780842976194;
        Sun, 07 Jun 2026 07:36:16 -0700 (PDT)
Received: from localhost.localdomain ([170.85.72.194])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd2629cesm133827566d6.41.2026.06.07.07.36.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 07 Jun 2026 07:36:15 -0700 (PDT)
From: Gavin Li <gavin.li@samsara.com>
To: linux-i2c@vger.kernel.org,
	viresh.kumar@linaro.org
Cc: "Chen, Jian Jun" <jian.jun.chen@intel.com>,
	andi.shyti@kernel.org,
	virtualization@lists.linux.dev,
	Gavin Li <gavin.li@samsara.com>
Subject: [PATCH v1] i2c: virtio: wait uninterruptibly for completions to avoid UAF
Date: Sun,  7 Jun 2026 10:36:08 -0400
Message-ID: <20260607143608.76122-1-gavin.li@samsara.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_i2c_complete_reqs() uses wait_for_completion_interruptible() and stops
waiting when a signal arrives. virtio_i2c_xfer() then frees reqs and the
per-request DMA bounce buffers while the device may still hold virtqueue tokens
pointing at &reqs[i] and DMA into read bounce buffers. Additionally, when the
device later completes those requests, virtio_i2c_msg_done() calls complete()
on freed memory and can corrupt the slab freelist.

Wait uninterruptibly for every completion before freeing reqs. This
matches how other virtio drivers retain request storage until the device
completes it. The virtio spec unfortunately does not provide a way to
cancel an in-flight request, so waiting uninterruptibly is required.

Signed-off-by: Gavin Li <gavin.li@samsara.com>
---
 drivers/i2c/busses/i2c-virtio.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
index 5da6fef92bec3..12acc049f5999 100644
--- a/drivers/i2c/busses/i2c-virtio.c
+++ b/drivers/i2c/busses/i2c-virtio.c
@@ -116,14 +116,13 @@ static int virtio_i2c_complete_reqs(struct virtqueue *vq,
 	for (i = 0; i < num; i++) {
 		struct virtio_i2c_req *req = &reqs[i];
 
-		if (!failed) {
-			if (wait_for_completion_interruptible(&req->completion))
-				failed = true;
-			else if (req->in_hdr.status != VIRTIO_I2C_MSG_OK)
-				failed = true;
-			else
-				j++;
-		}
+		/* Wait uninterruptibly: device still owns token/bounce buf until completion. */
+		wait_for_completion(&req->completion);
+
+		if (!failed)
+			failed = req->in_hdr.status != VIRTIO_I2C_MSG_OK;
+		if (!failed)
+			j++;
 
 		i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !failed);
 	}
-- 
2.54.0

