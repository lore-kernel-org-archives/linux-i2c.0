Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D99532D7C7
	for <linux-i2c@vger.kernel.org>; Sat, 15 Aug 2026 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786802995; cv=none; b=IwDq7nK9nHTKthWC+aHgMCGd+SlNxKzwwIP/aL9ZXkgXmJnpE6jE7JPPMFgrvbgMRx1YyX1zWnhhxcIkCiBEsdcCNUByoto+QanaeQt9bxFclWMwiLJV8YWFy8Q3zd8I0aVeU9G4I512Ist0YeMZtbJfj0ZK5pWMN2WrsjYfv8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786802995; c=relaxed/simple;
	bh=S1LKiqQSNMlXcxi2Yv2UEG7wi3iotbbEkUf1MkDP2wc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cAM77WtWgyukvFRonRDk9SVukbxXX7/rDEcn8xS3t+H9EoVfCeMqrN4hcgUr9TrpyqVb1pWkBth9e9UkAwdR4nFNx8h+7fTZYKFGCq/UNoPAT7EzvH2ujiA0cBvAxsiUHAA3NMpDph7sg7U0lQZeL6TKGZFX6gHy3OpxHuQtb8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIX0byll; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIX0byll"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so1567563a91.0
        for <linux-i2c@vger.kernel.org>; Sat, 15 Aug 2026 07:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786802993; x=1787407793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rk+TK55LIKRB93LVwwGii2OByDhMrzrdTRJzsNIADDg=;
        b=MIX0byll+ZOae0HS3sebYFKi2Mub5gXColQEUuIeFFiPYx9fbclCfMh9VVaIZ+eYzl
         nHomhK5W51AXjicsG4O5FoJ6BbOvUZWKfKK2UkEwYL50XVJIULq40i0XReGfTvShqjta
         1PwcIkOQyE9ifGvuwv4AkwWi1EXTUSLqHwC3x4hIJMtxfkDjEHrXxfZRKEUS8eOAUNew
         u6d82DUHSCFJa4z6OM1+0XRI8rhnvXNcxczYSK6wy2UCfF2Coftn42aWwdKndxg9xPSS
         mSc38rBMe6IgI3a964RQpWGBXDi/rYAIYOv3W7nstwYtTp2IE4Yp5pSGDjmdtnONPDh4
         T3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786802993; x=1787407793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rk+TK55LIKRB93LVwwGii2OByDhMrzrdTRJzsNIADDg=;
        b=caPwdwXFh8gS05i5JyqK8X5a2mGZQxWbwOZrgN0YcQ1vk9b8fQAeoHLAK5O9+LLOKi
         SwwohRdcieQdE/dg3KiFkGD+6kdVqOtLENEh47RcviP9a9JfqTed7/PIxnS85kevF4Sa
         OSCAAE06glJ04c+cfJj+zjlXkUcKLYGoMdaZmeZ9JJtPxLsuFElIBnpfPntgpvkwtk3y
         OqNFV1IS6XDOC1tCIFwPOkN+K0vLePE6lXHsFRZQRVK+i/v2ZRWc410Bx8ZrNW+Ucvtg
         s9SXiT0gvz7raBLQZVLgYrSj3DFO2ErjCBRNPOrDvDCaPWUPKGrRHswIATu7Hz2cmH0g
         fo2A==
X-Forwarded-Encrypted: i=1; AHgh+RooVMhyW5mIWVFcLtW0W8PB3Abr9X82xMiINibP+a7B14HcdJQ/TCvh4D5wmDSvRlXh8m1srzQWatM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws+/YrSJvapdCdXnMqQJUHK45kMKBZ6A+CAa+3IAN0pY/Z4gxd
	FD5cRho9g+XNNo73IZhqrvWKLm0YC46HeznomdrfWtZO0AJ+fvkXFhABg90IjfEm
X-Gm-Gg: AR+sD1256W7mY5HY6FmiklfkuBXwj7YgVphZ6EVFbcoYdieE2j+Okw0xKtyt9iDlJSa
	ISriK4RFdZgS9yYpjYE/uEg2H4Bqc1nSKIGtMBcipIH4TyR194tT9LbkREm+WRYwKWI9khGq3gC
	O7ipmNnmgf4zuappp5ymdXaooIT12V21cm7ga5FdmF7QOKZxZ6eTKRCtWTC3B1ac+64N6Ut/JdT
	qO7lox7H6YADrzkQuyNWx/dgrltQ6wnjq3c+1DKejA846a3nxzDGY9GAu6iexrd/ho20jSWXUQ6
	B0NcnJPTZZGeOcsjeUIR6XsxcjHlt+9BlpccndiJzfOULMt7IsGacMjuAQmdH0FnoQpnkldwgWx
	hLmB3Xsyq0SW78hZdRMkP8HbE3dBpt75oO+cMPFDR19wW3wRDS2pdSAq3wWJfgRSsOKLBKGnMNH
	7MB5QvW7bNCZPwEOvcz+h4J1eNVz13b8s9GM1Cnz9yCNcAGLUxDNMmBq0D/g1StuOLsj/kMqRLq
	R908FQ6vNlB0vP0mTla4bqtt44=
X-Received: by 2002:a17:90b:2888:b0:37f:a915:1c29 with SMTP id 98e67ed59e1d1-3933b95dbb3mr15321257a91.19.1786802993171;
        Sat, 15 Aug 2026 07:09:53 -0700 (PDT)
Received: from localhost.localdomain ([240a:4280:4800:6ace:25e8:2607:e94d:caaf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ea996575sm6327788a91.8.2026.08.15.07.09.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 15 Aug 2026 07:09:52 -0700 (PDT)
From: Liu Zhenlong <dragonliu2018@gmail.com>
To: loic.poulain@oss.qualcomm.com,
	rfoss@kernel.org,
	andi.shyti@kernel.org
Cc: vladimir.zapolskiy@linaro.org,
	wsa@kernel.org,
	andersson@kernel.org,
	linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Zhenlong <dragonliu2018@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] i2c: qcom-cci: fix device_node refcount leak in cci_probe()/cci_remove()
Date: Sat, 15 Aug 2026 22:09:31 +0800
Message-ID: <20260815140931.53297-1-dragonliu2018@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cci_probe() calls of_node_get() to take an extra reference on the
child device_node when assigning it to the adapter device.  The
matching of_node_put() calls exist in both the error cleanup path
and cci_remove(), but they are placed after i2c_del_adapter().

i2c_del_adapter() clears adap->dev with memset() at the end (commit
bd4bc3dbded9 ("i2c: Clear i2c_adapter.dev on adapter removal")), which
zeroes adap->dev.of_node before of_node_put() runs, turning it into a
no-op.  The reference taken by of_node_get() is never released, leaking
the device_node on every cleanup of already-registered adapters and
every adapter removal.

The commit that added of_node_get() and the matching of_node_put()
calls placed the puts after i2c_del_adapter(), so the bug has been
present since the fix was introduced.

Cache the pointer before calling i2c_del_adapter(), the same approach
used in i2c-mux (i2c_mux_del_adapters) and mtd (commit 56570bdad5e3
("mtd: core: Fix refcount error in del_mtd_device()")).

The of_node_put() in the i2c_add_adapter() failure path (before any
i2c_del_adapter() runs) is correct and left unchanged.

Fixes: 02a4a69667a2 ("i2c: qcom-cci: don't put a device tree node before i2c_add_adapter()")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Liu Zhenlong <dragonliu2018@gmail.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index bdeda3979c48..61c535b8196f 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -618,8 +618,10 @@ static int cci_probe(struct platform_device *pdev)
 
 	for (--i ; i >= 0; i--) {
 		if (cci->master[i].cci) {
+			struct device_node *node = cci->master[i].adap.dev.of_node;
+
 			i2c_del_adapter(&cci->master[i].adap);
-			of_node_put(cci->master[i].adap.dev.of_node);
+			of_node_put(node);
 		}
 	}
 disable_clocks:
@@ -635,8 +637,10 @@ static void cci_remove(struct platform_device *pdev)
 
 	for (i = 0; i < cci->data->num_masters; i++) {
 		if (cci->master[i].cci) {
+			struct device_node *node = cci->master[i].adap.dev.of_node;
+
 			i2c_del_adapter(&cci->master[i].adap);
-			of_node_put(cci->master[i].adap.dev.of_node);
+			of_node_put(node);
 			cci_halt(cci, i);
 		}
 	}
-- 
2.55.0

