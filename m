Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FD642C51D
	for <linux-i2c@vger.kernel.org>; Sat, 15 Aug 2026 18:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786817575; cv=none; b=g36OHOQyTcCPfx0KjiOsrLB5iJdZ3eAzkh1qm93WeBUb2YZDQNQtDG5kZHlEfrlIJIAWQwoJd/YqriZ1I+TQ5T7PTYLgdPrq0W7kaQGJjqp9tx9ffm+nJq51D/vydHfo8PISd62e84zUlpPoTN8ViQYHY9ZYvVfrifh3/vU+jZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786817575; c=relaxed/simple;
	bh=g/8fGhqkCV7RQstwEmzMAoWTNxRnB/a8B7+vfAI/r7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3+zjE//4WyP+zGSHroYCLG/EcVdwlLgdL1Ckephya9BTYu+K1R4dqm9+b0eT3ceILazrX4RJkK5rQ3aU/aowjtZIpvOD6cVNy07LPRYDpeaX4l9fua2ptnquPVeR+27UIMqJ6N4U/dox9GzKYVysB0tGj2e+GpTd3aKg43av5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOlgOvj+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOlgOvj+"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cc61541f8cso38948235ad.0
        for <linux-i2c@vger.kernel.org>; Sat, 15 Aug 2026 11:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786817568; x=1787422368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uq/zXomRaUtmPVU0X/7Fe7/2pJ+viXdEE1hutqkzih4=;
        b=QOlgOvj+whoo5+ZxgIL1l86V/C6PeXlWEPKfaD/ynydtTue1vPvXIjwkmm3KYi5pg1
         Kf74xnr4RE7DVn2kgCk1M4802tAMKT5PhikJdUv9iLSP2Waf5zF4NAhuest46wqmtsta
         ZbLaGIgYuqMzuoOtnrejqYNb7SBkBsNywvo3VdImF6o4vEltAnyzVbZgfjSA9NiN6+mw
         wZCu+Fe+UmWxGPeOzcvzfd4vt8ZrT/8lzrhyodezjMwfpDej1U5vVrZeKdcwUjU+Ygaz
         N1NQ5g296iyrWSCFEMb5qSzDnoKsve8Qzw9X7SKXSRaGOLvk1hmkGVOaiPdPpo/z0vpk
         3g1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786817568; x=1787422368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uq/zXomRaUtmPVU0X/7Fe7/2pJ+viXdEE1hutqkzih4=;
        b=ThqHHNMcd+G8hrqPU0+Tsz/no71ZJvn9kvKsStSBmyHCPJHxSCXX+GQPMoqPF9bBJh
         L5amjDMquNZ620MheMkYLfFohxvF+FhuNR6S+8J9miEML8CcT+/J10NRVhEiVf275WJu
         aFPnFzQnheKUl0vZe4f1FT6CZAEyn89u/umAAGb+BBPSSegyGum/5yX8B1YBJYRnEXaV
         OnnofGH1w65tmohrwqSyKVBefK1w9dYrd/I8fNOK2jScHhXJrDiEAI2l8SDR8gQuJ4dy
         5ZbgkK3IB/zui2QNV1mtIPi2XjcGr1rN4g1HXOJGkkqzOuvFWhABvh8H6P8BadvaPOnx
         c44Q==
X-Forwarded-Encrypted: i=1; AHgh+RpXYm7UNA1RxNt4mfz+Tjn0Z9UHasfsvsk1ifWI5NIFV0iYJntdlGMTl2AtjzBD/uRN56EYBHQQPtg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5wCSqtjMq7pQ4tUuLX5seyqyFIpXow0kMBo17xGza4FzeVAiV
	NezrzOMrnvjl4ScoqIjdiV74tGhg363WkA2mZ4on7aiIkzz/vycD0orX
X-Gm-Gg: AR+sD12YMOG/mf5j9Uw8q4SY3A6HOErH7hz0POKLYjNE8DffYQvVIsRYcgR7sfF25e6
	2ce0kKgLgBQzJQPcHLJ/gugFzV7XmBLz3zbXKxSKWfbiOSXce1GK7KbYi0AFtlW7jZq2BydDkOf
	HYhgTLd9vlUmjlCZLvDQDU9tHds4GHGucMKU5HTOmPXhtrFbdEUdDzU5fmb7lLurEbvd5e5n0or
	ZmXap70fSAO/FpaDJUyYyKlkmVh1iKshhs9I6v/cVsnwdBd4HfrgfPeqOJPUga0bGFimMTC3BON
	zfAAcWHL3W+oEAWPwIKDQJF9SQ1fStcork5WGfumyQnN3z3kioJTx4O1Z6Z6bVJr0JDgU+EiYtd
	XVrTKBDFjVRLBMM3N4Dg5jw1BFQzLs1+ceoMGUrFmT9JOHyLGSEZR0Mzwf0fvSAanKqoIOLaR0w
	Ow68u0ucp9pY0oLC458iIIZOcWKDstHIBIWGNwLvhvFuRD9YehFlL7XKp5yV6QGsZxp1iU5uqEI
	jBRLOzfenz9dwyINpuS8yPxqYg=
X-Received: by 2002:a17:90b:1b43:b0:38e:9ca8:e99 with SMTP id 98e67ed59e1d1-3933af8b5d7mr10385225a91.5.1786817568272;
        Sat, 15 Aug 2026 11:12:48 -0700 (PDT)
Received: from localhost.localdomain ([240a:4280:4800:6ace:25e8:2607:e94d:caaf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394eb7539d3sm7304254a91.15.2026.08.15.11.12.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 15 Aug 2026 11:12:46 -0700 (PDT)
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
Subject: [PATCH 1/5] i2c: mpc: fix device_node refcount leak in fsl_i2c_probe()/fsl_i2c_remove()
Date: Sun, 16 Aug 2026 02:12:00 +0800
Message-ID: <20260815181204.2321-2-dragonliu2018@gmail.com>
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

fsl_i2c_probe() calls of_node_get() to take an extra reference on the
platform device's of_node when assigning it to the adapter device, but
neither the probe error path nor fsl_i2c_remove() drops it.

device_release() does not call of_node_put() and i2c_adapter_dev_release()
only completes a struct, so the extra reference is never released, leaking
the device_node on every probe failure and every adapter removal.

Add the matching of_node_put() to both paths.

In the probe error path, i2c_add_numbered_adapter() failure does not run
i2c_del_adapter(), so of_node_put(i2c->adap.dev.of_node) is safe.

In fsl_i2c_remove(), i2c_del_adapter() clears adap->dev with memset() at
the end (commit bd4bc3dbded9 ("i2c: Clear i2c_adapter.dev on adapter
removal")), which zeroes adap->dev.of_node before of_node_put() runs,
turning it into a no-op.  Cache the pointer before calling
i2c_del_adapter(), the same approach used in i2c-mux
(i2c_mux_del_adapters) and mtd (commit 56570bdad5e3 ("mtd: core: Fix
refcount error in del_mtd_device()")).

Compile-tested with gcc-powerpc-linux-gnu on pmac32 defconfig; no
hardware available for runtime testing.

Fixes: 9fd049927ccb ("of/i2c: Generalize OF support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Liu Zhenlong <dragonliu2018@gmail.com>
---
 drivers/i2c/busses/i2c-mpc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index a21fa45bd64c..8182f7dc3d0f 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -867,8 +867,10 @@ static int fsl_i2c_probe(struct platform_device *op)
 	i2c_set_adapdata(&i2c->adap, i2c);
 
 	result = i2c_add_numbered_adapter(&i2c->adap);
-	if (result)
+	if (result) {
+		of_node_put(i2c->adap.dev.of_node);
 		return result;
+	}
 
 	return 0;
 };
@@ -876,8 +878,10 @@ static int fsl_i2c_probe(struct platform_device *op)
 static void fsl_i2c_remove(struct platform_device *op)
 {
 	struct mpc_i2c *i2c = platform_get_drvdata(op);
+	struct device_node *node = i2c->adap.dev.of_node;
 
 	i2c_del_adapter(&i2c->adap);
+	of_node_put(node);
 };
 
 static int __maybe_unused mpc_i2c_suspend(struct device *dev)
-- 
2.55.0

