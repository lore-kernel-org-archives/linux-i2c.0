Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C378D42903F
	for <linux-i2c@vger.kernel.org>; Sat, 15 Aug 2026 18:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786817592; cv=none; b=ocTIaPJTGEZwSW0FleeynfMY2CSXs2QOxF2eC5Vnw669dkM3kZNAuL1w1DpgK/BeJzOt8GZePhdGp4ekmxcRdJP9WnzTSggTTTZBRyo7IRVPS0UGe+0IPiZaTlsdfUhv76YgHp4wZugPxwV2acrOfrJ3ICs3C0RstkLJ/Wk6+ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786817592; c=relaxed/simple;
	bh=t3t7eK6kze1JhppxfIkpcARg5SYY1S80ibdnXdinBHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqG7AiKBcDtH8N1MjdX/8a/Ik4VDe4BlbWrV7zMt66yqB60O2XisDPDK+QJ1FE6UXupvjvsDj7aDDhEkklwXwu6o6Mmus09X5CX3cNLxc/55x5vSQK2gh1CO0ygmFzw2velPxWqRiOFKYNgm7euT975pZAHoxGiFf2j1ontVW74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ha73oWMX; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ha73oWMX"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso3186613a91.1
        for <linux-i2c@vger.kernel.org>; Sat, 15 Aug 2026 11:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786817582; x=1787422382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i7/QgzN5wyVgDaVsVdjpFdimGVN0rJBMi0oSVa7MqkE=;
        b=Ha73oWMXcWU8QZFT0AT5zV4KcfoCPUdgWcozoJ7227IyIEcMOfy31xDO4GIG9/fHvk
         XOQrSpvi7EAdo3e5f0XI7VAbbyliI5+VdCp5Q2n/ZYp5lgdK554l3rWSuHjA9PXnsdRJ
         d2Wpzn0w17Kh37BYlLAiMNNvTnjOd7lImPYE2su7mzPs8YJTn/NEzoiK+haGiKCeqTfv
         mkOFXzrBudRr5RgZmAfn3LJHcpOZ/B1kHXdXUSdvuzq6lsQFwkOBB+dodLbxpjSDXoaY
         BvQ6bmeXUY5bMe3dzUZffdzfbueXlhVAwlLeo0cjgx273vHwisLi0Edi3eAwe8+YQ9vt
         AMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786817582; x=1787422382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i7/QgzN5wyVgDaVsVdjpFdimGVN0rJBMi0oSVa7MqkE=;
        b=T5/r+6nxTn9j715ZbSb1yMkYfIFDsLlPu+Q5UmitSVJEDZfLpEjTgKnURMpvDDtLOg
         ha9L085L9LbaMrkoD77Zov4RvvOCN2Kl/+SGHDVM4+6pZmx+6Po8k1UJsA5Ww3iOg5lm
         WqsYKnMH7hApFSTVH2qDFaH+KNKROPjrbz4/1p6hkkVJ1T0VpI/XeBEx0xbpJyXWLOKD
         mTmNu+kdRDWP4ThTdcwR8pT+yWCViZT5DTc5+b+FyNioNZpVhYMNijMQWiZrwYbV5QiC
         A1xaHj4B3vcx5Pbxpg5XbX7PQGISKw1dGAw8OVVFrWRft1v+9m19SFm3ITVBzjX7GNi/
         /Q7A==
X-Forwarded-Encrypted: i=1; AHgh+RpfQORF0fShWs5sRd0x4mmqOj8fUGh9G/IuWnw0VN8hoQrLdf2tDjpYJzRTSJ3QBMzm2stCtpGb2Co=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEOfvYDNox00sZoYrFLGc5GQU5h0MUa5QbPaXQXmmcg+phr/Fy
	yuwAS5BOoXrpeAhfqYq7db27p1RzPw4FwbHI0NSaNw9ooFkTtLXFkERe
X-Gm-Gg: AR+sD12SAW3zPJobqYlVs2aVA5nal3SrzwpjJH9yO9UKjCLJ/IaBwcsu/FQsBmxd2rz
	Sa0uXmVWBctP3sbXBfSpnfrAPJ4dHBodPIu+gwlhgDozdEFnx86xae6TDXscRgpZgV7jIFwT3Z8
	s4ncXnsO+ncL8FRdqRnioWe46PWOykHeSuyhY9u+b4jUyB86b2b3V7AZiVL+JLWCje35K8KMSZ2
	EKB1UkjIWcY7bBHr9mj6fmOd+o8o8ADagB+3bJCrAU01BdEHBegG6yWODRVBv838VqPfxN/dAeT
	kZwmTAgFFQ5mzpGIIdzqpEHcocoQuuSg9uzkIHvUD1CGUSsZfFzKnhFCNWKO7pBFocJdCq8VWkC
	fUzsm447BqiJV9AB2lZeUAdb4PUf9AvJqGV5p4oLuTEXteKeQuG1ZE8Vrrf2dWJ8mK10xH5XJDK
	8eI7JpLHC+Au4nI2khckDPU6904S0c4VOFBpXQX58dg07UNRWfyQSGjaBG+XsQRKR0LOnbE2LB1
	950c+UOvM1Ukq6oUThi3Rue0UI=
X-Received: by 2002:a17:90b:2747:b0:38e:2f21:3bb5 with SMTP id 98e67ed59e1d1-3933baa0da9mr17205808a91.21.1786817581938;
        Sat, 15 Aug 2026 11:13:01 -0700 (PDT)
Received: from localhost.localdomain ([240a:4280:4800:6ace:25e8:2607:e94d:caaf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394eb7539d3sm7304254a91.15.2026.08.15.11.12.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 15 Aug 2026 11:13:01 -0700 (PDT)
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
Subject: [PATCH 2/5] i2c: cpm: fix device_node refcount leak in cpm_i2c_probe()/cpm_i2c_remove()
Date: Sun, 16 Aug 2026 02:12:01 +0800
Message-ID: <20260815181204.2321-3-dragonliu2018@gmail.com>
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

cpm_i2c_probe() calls of_node_get() to take an extra reference on the
platform device's of_node when assigning it to the adapter device, but
neither the probe error paths nor cpm_i2c_remove() drops it.

device_release() does not call of_node_put() and i2c_adapter_dev_release()
only completes a struct, so the extra reference is never released, leaking
the device_node on every probe failure and every adapter removal.

Add the matching of_node_put() to the probe error cleanup (out_free, which
covers both the cpm_i2c_setup() and i2c_add_numbered_adapter() failure
paths, neither of which runs i2c_del_adapter()) and to cpm_i2c_remove().

In cpm_i2c_remove(), i2c_del_adapter() clears adap->dev with memset() at
the end (commit bd4bc3dbded9 ("i2c: Clear i2c_adapter.dev on adapter
removal")), which zeroes adap->dev.of_node before of_node_put() runs.
Cache the pointer before calling i2c_del_adapter(), the same approach
used in i2c-mux (i2c_mux_del_adapters) and mtd (commit 56570bdad5e3
("mtd: core: Fix refcount error in del_mtd_device()")).

Compile-tested with gcc-powerpc-linux-gnu on tqm8xx defconfig; no
hardware available for runtime testing.

Fixes: 9fd049927ccb ("of/i2c: Generalize OF support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Liu Zhenlong <dragonliu2018@gmail.com>
---
 drivers/i2c/busses/i2c-cpm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index 2cb6a233d313..08e33db32f14 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -671,6 +671,7 @@ static int cpm_i2c_probe(struct platform_device *ofdev)
 out_shut:
 	cpm_i2c_shutdown(cpm);
 out_free:
+	of_node_put(cpm->adap.dev.of_node);
 	kfree(cpm);
 
 	return result;
@@ -679,9 +680,11 @@ static int cpm_i2c_probe(struct platform_device *ofdev)
 static void cpm_i2c_remove(struct platform_device *ofdev)
 {
 	struct cpm_i2c *cpm = platform_get_drvdata(ofdev);
+	struct device_node *node = cpm->adap.dev.of_node;
 
 	i2c_del_adapter(&cpm->adap);
 
+	of_node_put(node);
 	cpm_i2c_shutdown(cpm);
 
 	kfree(cpm);
-- 
2.55.0

