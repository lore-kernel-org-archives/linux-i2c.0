Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AE6371CFF
	for <linux-i2c@vger.kernel.org>; Sat, 15 Aug 2026 18:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786817551; cv=none; b=QWM80+d5RfUiCN8qb8PU/FL2agXbr+KQDopk9CMIh44e9Qpse5mQ8avsC4evDtRxNVImBCvtto+PaBmff045ZFeFgXr6o/yVSljqzFopkkLqsgw5peoy7x07N29HOICF3hZUpR90msr7cB5UpMKuH+w6zBRaYn0uvBP8AgDmzQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786817551; c=relaxed/simple;
	bh=0lPA8fpgk92Xyi4hgB6/GLpBaTVSWp7tfnnMHrTba/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fDaeTUcmsp6uzbB24aqi47ivay3n6/c/7p/L159bJeoqFavMAbLvYijcPB7flzLxRtSJG4rteQfew/euJ7I9kYGI38hpKauFWggsdetfqQv4hFg9BMj20dux7VYBYbV54PHJpn3nAop81GsXEAB2C4EuhX+nRRJ3+cnOnlPCKTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qSdRmCOt; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qSdRmCOt"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38dcbade417so2149800a91.1
        for <linux-i2c@vger.kernel.org>; Sat, 15 Aug 2026 11:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786817549; x=1787422349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xW2LYIDQQYDFwK3J1a0pZQU3BluSHf7AesdfpfaEO4A=;
        b=qSdRmCOtbiFiBoTz7aW17qWt8nvfyWqyrx+DOkUxTn3C3BIM3101Zo60mPp5Sbhp5x
         +zPrdqLX74uiePJWnXoAKl9GzbkPdCgQx/qy1DM+nnfaGK8dsmpPV2Z2y0QCpZ3wdXPi
         BdN20Mu9intyoRARGlVNvJIhxA9A1n5lJryEGHSLORaDdU0Q6XX/BnUvXwDHRAlthYut
         eB4RvkULBqPejCsw+WUJKGUqllnNy6A/AgPPyRWof4Uq87fzU8MybnnRTu9VgIFeAyDx
         rI67ZdTKKEXdrDy2f9PYaFV1bJRpiDZbi4RntBKFLyyfqoWoAFzsyhMat9Y1JMsqKDpG
         S/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786817549; x=1787422349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xW2LYIDQQYDFwK3J1a0pZQU3BluSHf7AesdfpfaEO4A=;
        b=P3qaSzdxg4yhjS2ZGWOQJb/1sxVdHRL3LRqX0nlMVZEojW4s0133wrXq7bQ20AQSbm
         dwvNomGYCVg15u15l09PZqWq3qhkDhk15zGLEDTrpOMMvYJlon5hMrmt55vp/PCLTF80
         gHyhNGvgGBJfBAoU/tEczYeRf+DkmFbZKEdL3c9u71DgVxcoZ2XtNa0ASYCct1zfspOS
         Wbw6fcTP4IgnTgaYATjrYTkcT6AD/P0EtnRJPaM5kD8pozQzZgo0+G/D948GD9pGG9Ll
         fAIGjl+WrLmRs8VWZMdiIrUBPOEV1pdt8oppa6sFCl7b/tWson7g8sNrir+0cnNTO7j1
         pLOg==
X-Forwarded-Encrypted: i=1; AHgh+RrRA6A/JdyDkOjtF8Ktci4ug7Zn23uBPbO7uFh74kXer9g52VJqwUgIYhbWUDIqx4AUc/OHe/uWnSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt3WF53rUgg9+pS8aqBbHFWQQVc8VSnrp2JEgjcPc7AN3H+d5Q
	IgHQRNTL9uECvxH4HQAbfxUooC3M4ewpoo/Y6s4MJB5R4Jvy+Jko5Tn9
X-Gm-Gg: AR+sD11R1FjQHfxroiWtNXuCqbDg+l/UIsyfrRLpQ+cXLOv01sfczJiOOIxcnzdkNQV
	oZSi5qac/hXt/TtTd0z6XAG2QvPi9OwsbsDGZpFRzQ3rU77Y8fyhaU7XoCmp7cl/0gZ1W/YzerU
	CGVQ44Lzw+7SvF3I2ArKUZ5VMnScwNyiQJ4uCC44BjIiqfo8Das//V6KmobU/Y1ot9dBDnuLHnH
	lVUmMloEJNvNxnhGTVBPYw7XW7COJUl2WYtBMNG0Wez21Y66oWu/33/3LivxCpb583aKgjimS/R
	Z2TxKBAocuMT71ctFFXBVYCE9PQHrCYARiDdayXoPyhfjP9kASXxysAWJOEmVWhcBthG7qMwDBU
	SVHN7Py+jo9c5i/GpYbiHGGZQJOoMIDs5dso3hwXt5o5H2DJxGLLVAtMhe+U8P6J+hK5DTEugzS
	IUdECoboZfxHuSRg+whCvgiXKP/F5vZGGSvQ2HR2J5OL3WDbWOiNmL1JtHFoWxYKGI2iVKl7cfH
	w3vWg7vKDbaRweTQK7WOMnVEdU=
X-Received: by 2002:a17:90b:4ec6:b0:38d:e658:5959 with SMTP id 98e67ed59e1d1-3933b80052cmr15988255a91.5.1786817549396;
        Sat, 15 Aug 2026 11:12:29 -0700 (PDT)
Received: from localhost.localdomain ([240a:4280:4800:6ace:25e8:2607:e94d:caaf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394eb7539d3sm7304254a91.15.2026.08.15.11.12.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 15 Aug 2026 11:12:28 -0700 (PDT)
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
	stable@vger.kernel.org.
Subject: [PATCH 0/5] i2c: fix device_node refcount leaks in 5 bus drivers
Date: Sun, 16 Aug 2026 02:11:59 +0800
Message-ID: <20260815181204.2321-1-dragonliu2018@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes device_node refcount leaks in 5 i2c bus drivers that
share the same bug pattern:

  adap->dev.of_node = of_node_get(pdev->dev.of_node);

Each driver calls of_node_get() to take an extra reference on the
platform device's of_node when assigning it to the adapter device, but
none of them drop it in the probe error paths nor in the remove()
callback.

device_release() does not call of_node_put(), and
i2c_adapter_dev_release() only completes a struct, so the extra
reference is never released, leaking the device_node on every probe
failure and every adapter removal.

Additionally, in the remove() callbacks, i2c_del_adapter() clears
adap->dev with memset() at the end (commit bd4bc3dbded9 ("i2c: Clear
i2c_adapter.dev on adapter removal")), which zeroes adap->dev.of_node
before of_node_put() runs, turning it into a no-op.  The fix caches the
pointer before calling i2c_del_adapter(), the same approach used in
i2c-mux (i2c_mux_del_adapters) and mtd (commit 56570bdad5e3 ("mtd: core:
Fix refcount error in del_mtd_device()")).

A related fix for the i2c-qcom-cci driver has already been submitted
separately:

  https://lore.kernel.org/linux-i2c/20260815140931.53297-1-dragonliu2018@gmail.com/

These 5 drivers are the remaining i2c bus drivers that use of_node_get()
on the adapter device; all other drivers either assign of_node directly
(without taking an extra reference) or don't use Device Tree at all.

Each patch has its own Fixes: tag pointing to the commit that introduced
of_node_get() in the respective driver, and requests stable backport via
Cc: stable@vger.kernel.org.

Compile-tested with gcc on arm64 defconfig using COMPILE_TEST; no
hardware available for runtime testing.

Liu Zhenlong (5):
  i2c: mpc: fix device_node refcount leak in fsl_i2c_probe()/fsl_i2c_remove()
  i2c: cpm: fix device_node refcount leak in cpm_i2c_probe()/cpm_i2c_remove()
  i2c: ibm_iic: fix device_node refcount leak in iic_probe()/iic_remove()
  i2c: opal: fix device_node refcount leak in i2c_opal_probe/remove()
  i2c: pnx: fix device_node refcount leak in i2c_pnx_probe()/i2c_pnx_remove()

 drivers/i2c/busses/i2c-cpm.c     |  3 +++
 drivers/i2c/busses/i2c-ibm_iic.c |  4 ++++
 drivers/i2c/busses/i2c-mpc.c     |  6 +++++-
 drivers/i2c/busses/i2c-opal.c    |  6 +++++-
 drivers/i2c/busses/i2c-pnx.c     | 15 ++++++++++++---
 5 files changed, 29 insertions(+), 5 deletions(-)

--
2.55.0
