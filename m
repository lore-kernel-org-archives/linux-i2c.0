Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343D041930A
	for <linux-i2c@vger.kernel.org>; Wed, 10 Jun 2026 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103769; cv=none; b=Agm19lMoNWC5pGJCDvON5I5DGwB9COtvTLhPLScsD1USKcAgE5i3e0QWnzQnlFm5u9uTYY+G52LxEYGHhCa18c0uYVMas4Znp+glMkN/N5BiGq4LZfV4s3hUJkFw4TPmEOaPoaAGhMlWuRm147ppsXWM0KK+NFxuQAtHE2BzTos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103769; c=relaxed/simple;
	bh=s1IQvU8HHnA13Gr5CUVhtckHABXiyrGoXTFymIYaNn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I95/qdxdAu/gN+5WwQNlIXwgjpRjuyjf/SDW0XyShyJf3pIbRnl71QKfT9Hh3f4sqLuINxBtmdKDAzbfJLRE+XNuW7c+dEtxlOg5wiAcYN1PyZfjbT8ofJY468MQTqn2iIi5BwiCV9R6Ig/9vR9tGin86BrrIYQsUPoSFqIfz4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=samsara.com; spf=pass smtp.mailfrom=samsara.com; dkim=pass (2048-bit key) header.d=samsara.com header.i=@samsara.com header.b=WuQT1pqR; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=samsara.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsara.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=samsara.com header.i=@samsara.com header.b="WuQT1pqR"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-9157b895c57so630888885a.3
        for <linux-i2c@vger.kernel.org>; Wed, 10 Jun 2026 08:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samsara.com; s=google; t=1781103766; x=1781708566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dzPN/wJoFEAsHFLJfhmBvnKMiFbFAl2dfBVz7PV0PU0=;
        b=WuQT1pqRE1MNByIx4TIsjWu4PMm7uPJfge2kjpc3lvw7vfppwUnj2Ir8tVoew5yC3T
         BkO9fWidXHjHvh/vSedAPJvkfy7eAzi77W45C3VmVb9GkAJ7PVE4cAK40akuW4SXn5VQ
         qT7QabuRD94F5M2/m1F2jfktNuWVcphDVYNVVH7U0uaQpk+qO9mjw7Kq2fghz/tfNJpH
         yO7DACqOIZjC6k+a8MdmdL5pkOCFoqWkwcgFhrnkxeRhIoB5Tt126f++jMFS8c0rwQKV
         oG6788egD6znvloIjOSI7rd/QnDLYKF2fyBuwD1ZzQFtuUjmNM12iXaEIr7WRixH9mr6
         idEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781103766; x=1781708566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzPN/wJoFEAsHFLJfhmBvnKMiFbFAl2dfBVz7PV0PU0=;
        b=Y7VIo/PvzbLqmTFMgaRTfSlUkW+9ixEN/OEEP2b5M6zUIgrgaNeD29URtZsMlsqT7r
         ucp6iu2Nqq/MOr5AVjmb3ks5sKrRY1fSrpUd1+Db4OGt1wXeTqChrA9fnb8raH/OKnzW
         HLwrg7cMj8mfrLweF1+iLguiHb9+5rEiDpJjzOT+NmKVRJEfF4BnKpvLznLvrxlY9mzH
         x44+MufAdydV1ryMC4qkb1YDwJsrxj4G4FrWU7iGfpm9+kNXFr1flEBCMMK02EXS7mDY
         pPW1p/udT63i1ar+m6oGuguZgUUCGSkYcR6yCs5k8xhJPoDmJ/DNhA2bO6ZMh4Z2+VHk
         Zfyg==
X-Gm-Message-State: AOJu0YzNIl62uBolwqNB5TDo3KhmkTRSKf9IB1CnDbIq+xnYk6ADB/8q
	p6WVpltgF4aq9AHQv3KOcOqCQ/fZdrxNyU7wYZXOnm6lfR+nDuYx4Ae3Wv4GKapFn/viGpI5uL3
	RxODcaA==
X-Gm-Gg: Acq92OH/bx1SogFCe7KjWrCuQ+tyn6OiUK7/1g3dcqfeW8OtC3K9jInSEo17axCtO+9
	ok62+WPGNkJN9k1ISV92dRU4rn1SHT9m8qSDOcVGIXUskBBLOHYypyJNEs1mmjzVevMGy4ZY6L2
	Ste9LQAZUSbhJ9h8+y6KD7VZd5gMJNz9gdfwF4cxO95h6G3uxZAiwmCNxzIuTIi9+j4P8yvSMzl
	7rg5Tn2N0AqbW7f/dFDJCKUmt8mRP2U/kfkIKH/cEt5j+4WfmOwSDHLmxApk2IiYU3IbO9UW1pX
	w/cAqioIBgt0Iaf4uOIlqLfbrlfxrxI+MM8nBGv2S1r8RTQR//dX/9dQjHAKDwQrNa4a6tB4/nM
	6O/sM7KdtGyK3/V8ZOrEpIBJjw5z0zxOvccLc/ZWRcPyV48RVMPVFFzx6E579JoRuAGjHntADYg
	37tHnAGxfRL/SNBE+4LuuoSEHNfszsjki5XZipD9gIEAzi6TVLgC9zwTriKG3hESy4mzQwOEtqY
	SGcI6wTylyPrTfq
X-Received: by 2002:a05:620a:1d01:b0:8cf:d804:456a with SMTP id af79cd13be357-915a9c9df20mr3929782185a.20.1781103765390;
        Wed, 10 Jun 2026 08:02:45 -0700 (PDT)
Received: from localhost.localdomain ([165.225.38.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9159cd628f8sm2124550785a.4.2026.06.10.08.02.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jun 2026 08:02:44 -0700 (PDT)
From: Gavin Li <gavin.li@samsara.com>
To: linux-i2c@vger.kernel.org,
	viresh.kumar@linaro.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: "Chen, Jian Jun" <jian.jun.chen@intel.com>,
	andi.shyti@kernel.org,
	virtualization@lists.linux.dev,
	Gavin Li <gavin.li@samsara.com>
Subject: [PATCH v4] i2c: virtio: retain xfer with kref to fix UAF on interrupted wait
Date: Wed, 10 Jun 2026 11:02:32 -0400
Message-ID: <20260610150232.24834-1-gavin.li@samsara.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit a663b3c47ab1 ("i2c: virtio: Avoid hang by using interruptible
completion wait") switched virtio_i2c_complete_reqs() to
wait_for_completion_interruptible() so a stuck device cannot hang a
task forever. That left a use-after-free: if the wait returns early on
a signal, virtio_i2c_xfer() frees reqs and DMA bounce buffers while the
device may still hold virtqueue tokens pointing at &reqs[i] and DMA
into read buffers. When those requests complete later,
virtio_i2c_msg_done() calls complete() on freed memory.

Waiting uninterruptibly for every completion before freeing avoids the
UAF but can hang the caller indefinitely if the virtio side never
completes the request. Performing a queue reset / device reset is
possible in this scenario, but adds complexity.

This commit manages the freeing of the xfer allocations via kref, and
ensures that each in-flight request holds a reference. This fixes the
use-after-free by ensuring that the virtio device has a valid location
to write to until the request completes. This will cause a memory leak
in cases where the device hangs, but that is much preferable to memory
corruption.

Additionally, force usage of a bounce buffer even if the i2c_msg buf is
DMA-safe, since the buffer passed to the virtqueue must remain valid
even if the transfer is interrupted. Remove usage of
i2c_get_dma_safe_msg_buf() since it may pass through msg->buf directly.
All bounce buffers are part of the single xfer allocation, so there is
no additional allocation overhead.

Signed-off-by: Gavin Li <gavin.li@samsara.com>

---

Changes in v4:
- Pack bounce buffers into a single allocation after reqs[]
- Remove per-request buf pointer and xfer->num
- Remove req.msg, track message direction with req->read
- Simplify xfer release to a single kfree()
- Restore using j to track successful transfers in _complete_xfer()
---
 drivers/i2c/busses/i2c-virtio.c | 121 +++++++++++++++++++++++++-------
 1 file changed, 94 insertions(+), 27 deletions(-)

diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
index 5da6fef92bec3..33b469ca39d4b 100644
--- a/drivers/i2c/busses/i2c-virtio.c
+++ b/drivers/i2c/busses/i2c-virtio.c
@@ -13,7 +13,9 @@
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/virtio.h>
 #include <linux/virtio_ids.h>
 #include <linux/virtio_config.h>
@@ -31,39 +33,74 @@ struct virtio_i2c {
 	struct virtqueue *vq;
 };
 
+struct virtio_i2c_xfer;
+
 /**
  * struct virtio_i2c_req - the virtio I2C request structure
+ * @xfer: owning transfer
  * @completion: completion of virtio I2C message
+ * @read: true if this is a read message (I2C_M_RD is set)
  * @out_hdr: the OUT header of the virtio I2C message
- * @buf: the buffer into which data is read, or from which it's written
  * @in_hdr: the IN header of the virtio I2C message
  */
 struct virtio_i2c_req {
+	struct virtio_i2c_xfer *xfer;
 	struct completion completion;
+	bool read;
 	struct virtio_i2c_out_hdr out_hdr	____cacheline_aligned;
-	uint8_t *buf				____cacheline_aligned;
 	struct virtio_i2c_in_hdr in_hdr		____cacheline_aligned;
 };
 
+/**
+ * struct virtio_i2c_xfer - a queued I2C transfer
+ * @ref: one ref for the caller, plus one per in-flight virtqueue request
+ * @bounce_buf_base: start of bounce buffer region
+ * @reqs: the virtio I2C requests
+ *
+ * Allocation layout:
+ * - struct virtio_i2c_xfer xfer
+ * - struct virtio_i2c_req reqs[num]
+ * - u8 bounce_buf[msgs[0].len]
+ *   ...
+ * - u8 bounce_buf[msgs[num-1].len]
+ */
+struct virtio_i2c_xfer {
+	struct kref ref;
+	u8 *bounce_buf_base;
+	struct virtio_i2c_req reqs[];
+};
+
+static void virtio_i2c_xfer_release(struct kref *ref)
+{
+	struct virtio_i2c_xfer *xfer = container_of(ref, struct virtio_i2c_xfer, ref);
+	kfree(xfer);
+}
+
 static void virtio_i2c_msg_done(struct virtqueue *vq)
 {
 	struct virtio_i2c_req *req;
 	unsigned int len;
 
-	while ((req = virtqueue_get_buf(vq, &len)))
+	while ((req = virtqueue_get_buf(vq, &len))) {
 		complete(&req->completion);
+		kref_put(&req->xfer->ref, virtio_i2c_xfer_release);
+	}
 }
 
-static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
-				   struct virtio_i2c_req *reqs,
+static int virtio_i2c_prepare_xfer(struct virtqueue *vq,
+				   struct virtio_i2c_xfer *xfer,
 				   struct i2c_msg *msgs, int num)
 {
 	struct scatterlist *sgs[3], out_hdr, msg_buf, in_hdr;
+	struct virtio_i2c_req *reqs = xfer->reqs;
+	u8 *bounce_buf = xfer->bounce_buf_base;
 	int i;
 
 	for (i = 0; i < num; i++) {
 		int outcnt = 0, incnt = 0;
 
+		reqs[i].xfer = xfer;
+		reqs[i].read = !!(msgs[i].flags & I2C_M_RD);
 		init_completion(&reqs[i].completion);
 
 		/*
@@ -82,23 +119,31 @@ static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
 		sgs[outcnt++] = &out_hdr;
 
 		if (msgs[i].len) {
-			reqs[i].buf = i2c_get_dma_safe_msg_buf(&msgs[i], 1);
-			if (!reqs[i].buf)
-				break;
+			/*
+			 * Even if msg->flags has I2C_M_DMA_SAFE set, a bounce
+			 * buffer is required because the transfer may be
+			 * interrupted, after which msg->buf is no longer valid.
+			 */
+			if (!(msgs[i].flags & I2C_M_RD))
+				memcpy(bounce_buf, msgs[i].buf, msgs[i].len);
 
-			sg_init_one(&msg_buf, reqs[i].buf, msgs[i].len);
+			sg_init_one(&msg_buf, bounce_buf, msgs[i].len);
 
 			if (msgs[i].flags & I2C_M_RD)
 				sgs[outcnt + incnt++] = &msg_buf;
 			else
 				sgs[outcnt++] = &msg_buf;
 		}
+		bounce_buf += msgs[i].len;
 
 		sg_init_one(&in_hdr, &reqs[i].in_hdr, sizeof(reqs[i].in_hdr));
 		sgs[outcnt + incnt++] = &in_hdr;
 
+		/* This reference is released in virtio_i2c_msg_done(). */
+		kref_get(&xfer->ref);
+
 		if (virtqueue_add_sgs(vq, sgs, outcnt, incnt, &reqs[i], GFP_KERNEL)) {
-			i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], false);
+			kref_put(&xfer->ref, virtio_i2c_xfer_release);
 			break;
 		}
 	}
@@ -106,26 +151,38 @@ static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
 	return i;
 }
 
-static int virtio_i2c_complete_reqs(struct virtqueue *vq,
-				    struct virtio_i2c_req *reqs,
-				    struct i2c_msg *msgs, int num)
+static int virtio_i2c_complete_xfer(struct virtio_i2c_xfer *xfer,
+				    struct i2c_msg *msgs,
+				    int num)
 {
+	struct virtio_i2c_req *reqs = xfer->reqs;
+	u8 *bounce_buf = xfer->bounce_buf_base;
 	bool failed = false;
 	int i, j = 0;
 
 	for (i = 0; i < num; i++) {
 		struct virtio_i2c_req *req = &reqs[i];
+		struct i2c_msg *msg = &msgs[i];
+
+		if (wait_for_completion_interruptible(&req->completion))
+			return -EINTR;
+
+		if (req->in_hdr.status != VIRTIO_I2C_MSG_OK) {
+			/*
+			 * Don't break yet. Try to wait until all requests
+			 * complete to ensure that the virtqueue has enough
+			 * descriptor slots for the next transfer.
+			 */
+			failed = true;
+		}
 
 		if (!failed) {
-			if (wait_for_completion_interruptible(&req->completion))
-				failed = true;
-			else if (req->in_hdr.status != VIRTIO_I2C_MSG_OK)
-				failed = true;
-			else
-				j++;
+			if (req->read)
+				memcpy(msg->buf, bounce_buf, msg->len);
+			j++;
 		}
 
-		i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !failed);
+		bounce_buf += msg->len;
 	}
 
 	return j;
@@ -136,14 +193,24 @@ static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 {
 	struct virtio_i2c *vi = i2c_get_adapdata(adap);
 	struct virtqueue *vq = vi->vq;
-	struct virtio_i2c_req *reqs;
-	int count;
+	struct virtio_i2c_xfer *xfer;
+	size_t alloc_size;
+	int i, count;
 
-	reqs = kzalloc_objs(*reqs, num);
-	if (!reqs)
+	alloc_size = struct_size(xfer, reqs, num);
+	for (i = 0; i < num; i++) {
+		if (check_add_overflow(alloc_size, msgs[i].len, &alloc_size))
+			return -EOVERFLOW;
+	}
+
+	xfer = kzalloc(alloc_size, GFP_KERNEL);
+	if (!xfer)
 		return -ENOMEM;
 
-	count = virtio_i2c_prepare_reqs(vq, reqs, msgs, num);
+	kref_init(&xfer->ref);
+	xfer->bounce_buf_base = (u8 *)(xfer->reqs + num);
+
+	count = virtio_i2c_prepare_xfer(vq, xfer, msgs, num);
 	if (!count)
 		goto err_free;
 
@@ -157,10 +224,10 @@ static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	 */
 	virtqueue_kick(vq);
 
-	count = virtio_i2c_complete_reqs(vq, reqs, msgs, count);
+	count = virtio_i2c_complete_xfer(xfer, msgs, count);
 
 err_free:
-	kfree(reqs);
+	kref_put(&xfer->ref, virtio_i2c_xfer_release);
 	return count;
 }
 
-- 
2.54.0

