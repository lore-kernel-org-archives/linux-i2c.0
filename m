Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9320D3DCDA9
	for <linux-i2c@vger.kernel.org>; Tue, 29 Sep 2026 04:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790655294; cv=none; b=C1FYUoK7lqoHFSKbEWtRW8AwlrGO4g3R7NLbppD6tQtnjIRIVebW17rMeUgFPbDewWosFRi5vf/HUR5ggwzKZMHjlq1G3204tgvLd7lg94mKnpHm2qtJoSQe88B7g0Vu7d9O2ryL4LUks3lV6NFDmw1RARw/zJ3DHg2xhjN2kII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790655294; c=relaxed/simple;
	bh=cFXjq2JXCSfmvvjsjl7kaIwIGpfd3uICNYyzTRRVr6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OU7WvCOf+Jo5MljZe7XBs7XZxB9tfWQX0RGY9OmtBzUETNfaCvb+ln0PbIQLHLTg3dUorbUgt0Dr8Q088GM5/k8/N7S/iuJFM1MfT8nOzOa3owCW5R1PYi6dEaTwO6em6YWg0viBAONaHf7D2w2cE6d+JxxhoqtXGGdCFyJT1Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org; spf=pass smtp.mailfrom=quora.org; dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b=U2qJSkGL; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quora.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b="U2qJSkGL"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747eb79f7so16831005ad.1
        for <linux-i2c@vger.kernel.org>; Mon, 28 Sep 2026 21:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1790655293; x=1791260093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z/00Ko7gZUPuAiTpJB4dBnk2KXfjE/uS38djV/L4NvE=;
        b=U2qJSkGLwVHNC75N3D7jHJg6yXV34LZXxTC1qYxxz2WxEbXt/G4Ai8Sb6x18hcbyDj
         UJWewIbqzQCXsom078jmIevHvMWaTLYNWnkPBGzhxEWYl8ozBK85lzx77xxTxo2O7aUS
         axhS7hTfDqSp1CLVlYUw0ryWS3cMozc7uD+iI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790655293; x=1791260093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z/00Ko7gZUPuAiTpJB4dBnk2KXfjE/uS38djV/L4NvE=;
        b=DGcHDwjzsGEUJ9BGgWbPKrPLyn/z0XFX3P2kz3NFsIov1WbMxwXptZKBoXDz41unkh
         hnpdz6x0Pum+MGLhCOF2JRDsltGjBXIE0WafZfZQL+TDhFIpHlXV+/Al/bmSo+xrSz2H
         0GcG6IYfS1RyZ60X08OtzGmgxi2EMimKvrhge9g2ojES0LPGbZX+k52MkrvyXZtS+mfC
         aK1n+WbzieVSy+02HtKERomEL9FYRuDpx50QU1VmaupbWWvBPwFkfQAmph5mgUqH93+d
         iFXowFqANIRJmIjQpuYCclNGVGcuBMZUvaAPcHtE+JTi99m/9bAsz7YDW5yaHlPlG2c7
         DCBQ==
X-Gm-Message-State: AFq9FYLutNdD4kSCcz8HieE2knYkrOExQ5TQ63iSEbI513oyicBbmMDe
	4G8stMuRahGOnD9l/MX9L+OgJm9Yu0WQF6WjYpFAa/lVzqICTYvFjG2sLIhHzsr1QEQ=
X-Gm-Gg: AYBFou2PEY84ASkc1xQie1ZsgueoKSnWEMx4AAP84yQ84bR4I/BjM2lby8KbTWQvbH6
	lhMQtT87IctMCBNLEbW1Ue+YiBMAvld1C1P2FGl7d1FxMZRyzGRnFy7NJ/2rVvBx41lZeOjhsC0
	YQatnNyUnNuezZ2x+9ED/CSrwyCsixPFZyqmgvb6zCGsnaV6RfQIS3c11a/C3wt4cRB3Y8esMCu
	ouQAP6rMe/+o/9aQVE6hB9vV/KPEgLtUG8lwlFum5MmXeXjBGDAezqrtPIywxsaQCiksHEbC9XF
	SCOyXYEpTcPjxKvpc/SmsRhLvb/72IXJyiuAmRFjyjkSk148fqF56fW5dsAxPAuS/9s4oII4Ujg
	agUq4h+L1//kXP7qrZlnh6N7/ChrXH9mZT4vBq/DjNSJ4TxLZx3MxrXQ8MxeFRiizdtL8PHUHIO
	cLM38BkiC0lX1YsquIe4EqjtBQO+XI6PQyAv4Tp+CltMeup5EtKYlaGzbDuO5K3WM5ftxxz1nO9
	DkbX20NXXuFGEBxqfzNmb+3Ylt9cSgsIN9OWAqfHV8fomjHkGRx1fZK7Pjw9n59KRQIUF6XCmmz
	u+uSIzP8QHeb+h6NtokXgMnbk1qdgo4+NYEXZ2qZvRqfgUHG7WMD57FmBq5PvO+/hu5id/Inmig
	qpsUlOi+piq4JHTIOL58ts0YFrzSxNtJwCKwjfFq4XDs=
X-Received: by 2002:a17:902:f544:b0:2df:98a2:a2e2 with SMTP id d9443c01a7336-2df98a2b3b0mr90144685ad.30.1790655292825;
        Mon, 28 Sep 2026 21:14:52 -0700 (PDT)
Received: from aegis ([175.158.243.214])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e2c6f46976sm3192895ad.22.2026.09.28.21.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 21:14:52 -0700 (PDT)
From: Daniel J Blueman <daniel@quora.org>
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Daniel J Blueman <daniel@quora.org>
Subject: [PATCH] i2c: qcom-geni: restore tSCL with 32MHz I2C fast-mode
Date: Tue, 29 Sep 2026 12:14:43 +0800
Message-ID: <20260929041444.9837-1-daniel@quora.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit cb97bf3d4f91 ("i2c: qcom-geni: Fix hardcoded clock index in
SE_GENI_CLK_SEL") allowed GENI to use 32MHz clock. This changed I2C
timing, making the Yoga Slim 7x keyboard (ITE 048D:8987) unusable
on all boots, and touchpad unusable on some boots, resulting in:

  i2c_hid_of 1-003a: unexpected HID descriptor bcdVersion (0x0000)
  i2c_hid_of 1-002c: failed to fetch HID descriptor: -110

With this change, t_high_cnt 3 and clk_div 4 gave a tSCL of 375ns
versus the previous default of 521ns, however the I2C spec has a
minimum tSCL of 600ns.

Restore tSCL to the spec with t_high_cnt 5 giving a 625ns tSCL,
verified on Lenovo Yoga Slim 7x X1E-80100.

Fixes: 506bb2ab0075 ("i2c: qcom-geni: Support systems with 32MHz serial engine clock")
Cc: <stable@vger.kernel.org>
Signed-off-by: Daniel J Blueman <daniel@quora.org>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 6a39e21d5ed4..1336a09ca183 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -193,7 +193,7 @@ static const struct geni_i2c_clk_fld geni_i2c_clk_map_19p2mhz[] = {
 /* source_clock = 32 MHz */
 static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz[] = {
 	{ I2C_MAX_STANDARD_MODE_FREQ, 12, 9, 10, 26 },
-	{ I2C_MAX_FAST_MODE_FREQ, 4, 3, 9, 19 },
+	{ I2C_MAX_FAST_MODE_FREQ, 4, 5, 9, 19 },
 	{ I2C_MAX_FAST_MODE_PLUS_FREQ, 2, 3, 5, 15 },
 	{}
 };
-- 
2.53.0

