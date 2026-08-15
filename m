Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B680F42A789
	for <linux-i2c@vger.kernel.org>; Sat, 15 Aug 2026 18:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786817599; cv=none; b=oZjE2ws8oi+w37x321XGx9qYqZf2xjpT/MiUvm5MTS142ZXVUFiA/OvwDH08BgZlPlLFi29SbRlOxrM9gqvvPV0e0XERBtPdo18GMI18JUQIVLKFpbyuQtGDfM7mACum6Bfj/filCKGreWZdtXk4/dYFwOc7g5d/MpXXK+/D1xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786817599; c=relaxed/simple;
	bh=AEno/8kJE1dDO+zyyZE4ZuQtK5pId1vsBKGwv9wYw6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDOLQWZePorP/78inm/t3fqxJD9mYtlpDRD7geigaQ8yMUbj6VpNIjTlGyo168nymTMSgJ7zWvlC02AM7IYyTq5Z8m8ujCmDFi128QpjggD9FN5FlwmD4ic/MpFM0vXMpl9vCAjGRkA/A0QwmA1QjDWiu9f5TAXQgdAuLtfs+q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPNEHXWc; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPNEHXWc"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so2214500a12.0
        for <linux-i2c@vger.kernel.org>; Sat, 15 Aug 2026 11:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786817597; x=1787422397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hn1w8vtbj9zAmfIr6OtJvXMx3Rjgqtv0x/ZQ8XLdFkg=;
        b=bPNEHXWcL3cTBBHq/xuIj4vGgxmCtkNecbf5R+bYLpfAV8l8zQdZ2kJdslFq3OwF/K
         JFfKABreQjaJFEl6BAJe62vbz8mkC2CKfmDtxGRl/XF0F9cOnwipqBBe29n3TK5fODVT
         rs5VL9yDTO+SFa2pfvsYeVZyaBx/ukCuFiOee99QOdhT024SoFeEvOUvbWsp4etdpCj0
         Lpp15VlJpmWDBr+t9mpZ+eU+gig3+khiHWK4lbl3eLzAPjpR7BtE5YoU9zGt1loUg3n/
         PiAjgH8wsKhFJ0OR0L0hd/pJ9DidigVS8tZPb7lbd53xKrhMIF0sD/OlE4rnahPKBvY/
         3moQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786817597; x=1787422397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hn1w8vtbj9zAmfIr6OtJvXMx3Rjgqtv0x/ZQ8XLdFkg=;
        b=IkqZkIt8WlJG2EVRbhrDe3M5+PvZYmlKL38RmHp/zHZMC/Zr/rFFUVRU0qyFLL5pPx
         nyPJWo9LNcFGdBT1WJJoVwcdSKEwxbk1WXtqCW6dfrn4Sq8ay/8Aj4H2kNxPZCaUcyIh
         1+9OzGTEI0w8Z+2tAsq/4/pI9NZ7ZSCTYgBYFcFRHBAgLj9HkwSxAqXGWEHwqSX2EDll
         7WVxkOZAwIX4zhif3jst3zBmxSKyjXa97yIu/XoiL4PoE5ZBuv1HAgaQoSk+yU/wJzbQ
         hwoQUHBQm8EpdJDNG9nEscRsC3xNzk6xkn2oAzz8t2U8UFYa8FLoPWZSz4PsLuLukn2a
         mo8A==
X-Forwarded-Encrypted: i=1; AHgh+Ron0NL1YWtvmL5sbjg46PGquaJWf0ayPCx15ImWH0Ls8vDJcrFT7PTfThs4PDL1kwhv4NgX0OItZP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YycFNq7PhG8+xgwfPyS95xlKqCnTk6SwdhxupAjjufCnzWtcqcn
	4gOJPoySwau8JEgMFAQyye/NeK6Su1lRERz/cZiUGqLJUy5WHoJbD4+W
X-Gm-Gg: AR+sD11ThBtaTnGy7lWjlxtoXfAAbEcCP8Mn7JRlMCfBANrZvJwKc3OfTHX2ywRVpo/
	/ccQ5hNudUsK+vI8eCA0WvzBvdqNOcKCTzhF73DlZ+JNsEx5zR1gm0b+QmcJd1b4YF2n/SFzZQr
	BFSYpj89wErFwdLM/zYCwMNMcFQuLoJ6zpVK59GCe8Evqa6zvUJw043Hncy+OjZloBhFiXKRi0L
	+ez5IgO+h164By2xYvc94paxKz2KPSacC+2owVWWD9YDjNo86Ld5/UD+GGeml5fCB5rKdL7P0zv
	aTorjOSCM3KDuYebIkrRO7GIyYj2Cxae5mqbfuNSLv0yPq9L21t4Md2TZZMIgnX8Gj0dULTJH+K
	M/AuXFljy3KYkO1q0FAFI3a1R6YQTxi7/P6rOFfVefhhjQZ9U+4V7Agg9/+bdT2jbhARlqaYJLL
	e6Z2zD8ph2SmSE8SGWOOdXWNbnnsmHJrjFLfRvK4M0KsFdB5o7a5qUMVZB2sQdwlvQaD9Zr5hSd
	0PftI+PT3eT+0+7q+Urd2XmJto=
X-Received: by 2002:a17:90b:37c3:b0:390:84db:888e with SMTP id 98e67ed59e1d1-3933afb4ba2mr11589304a91.7.1786817596734;
        Sat, 15 Aug 2026 11:13:16 -0700 (PDT)
Received: from localhost.localdomain ([240a:4280:4800:6ace:25e8:2607:e94d:caaf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394eb7539d3sm7304254a91.15.2026.08.15.11.13.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 15 Aug 2026 11:13:16 -0700 (PDT)
From: Liu Zhenlong <dragonliu2018@gmail.com>
To: andi.shyti@kernel.org,
	chris.packham@alliedtelesis.co.nz,
	jochen@scram.de,
	maddy@linux.ibm.com,
	vz@mleia.com,
	piotr.wojtaszczyk@timesys.com
Cc: mpe@ellerman.id.uk,
	npiggin@gmail.com,
	chleroy@kernel.org,
	grant.likely@secretlab.ca,
	neelegup@linux.vnet.ibm.com,
	benh@kernel.crashing.org,
	wsa@kernel.org,
	stigge@antcom.de,
	linux-i2c@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Liu Zhenlong <dragonliu2018@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/5] i2c: ibm_iic: fix device_node refcount leak in iic_probe()/iic_remove()
Date: Sun, 16 Aug 2026 02:12:02 +0800
Message-ID: <20260815181204.2321-4-dragonliu2018@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260815181204.2321-1-dragonliu2018@gmail.com>
References: <20260815181204.2321-1-dragonliu2018@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iic_probe() calls of_node_get() to take an extra reference on the
platform device's of_node when assigning it to the adapter device, but
neither the probe error path nor iic_remove() drops it.

device_release() does not call of_node_put() and i2c_adapter_dev_release()
only completes a struct, so the extra reference is never released, leaking
the device_node on every probe failure and every adapter removal.

Add the matching of_node_put() to the probe error cleanup (error_cleanup,
which covers the i2c_add_adapter() failure path; the earlier error paths
jump to the same label before of_node_get() runs, but dev is kzalloc'ed
so dev->adap.dev.of_node is NULL and of_node_put() is a no-op there) and
to iic_remove().

In iic_remove(), i2c_del_adapter() clears adap->dev with memset() at the
end (commit bd4bc3dbded9 ("i2c: Clear i2c_adapter.dev on adapter
removal")), which zeroes adap->dev.of_node before of_node_put() runs.
Cache the pointer before calling i2c_del_adapter(), the same approach
used in i2c-mux (i2c_mux_del_adapters) and mtd (commit 56570bdad5e3
("mtd: core: Fix refcount error in del_mtd_device()")).

Compile-tested with gcc-powerpc-linux-gnu on ppc44x defconfig; no
hardware available for runtime testing.

Fixes: 9fd049927ccb ("of/i2c: Generalize OF support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Liu Zhenlong <dragonliu2018@gmail.com>
---
 drivers/i2c/busses/i2c-ibm_iic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 7c70e8bda24e..5c3b973c40d9 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -751,6 +751,8 @@ static int iic_probe(struct platform_device *ofdev)
 		free_irq(dev->irq, dev);
 	}
 
+	of_node_put(dev->adap.dev.of_node);
+
 	if (dev->vaddr)
 		iounmap(dev->vaddr);
 
@@ -764,8 +766,10 @@ static int iic_probe(struct platform_device *ofdev)
 static void iic_remove(struct platform_device *ofdev)
 {
 	struct ibm_iic_private *dev = platform_get_drvdata(ofdev);
+	struct device_node *node = dev->adap.dev.of_node;
 
 	i2c_del_adapter(&dev->adap);
+	of_node_put(node);
 
 	if (dev->irq) {
 		iic_interrupt_mode(dev, 0);
-- 
2.55.0

