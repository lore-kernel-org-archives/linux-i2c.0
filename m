Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0323F9F5C
	for <linux-i2c@vger.kernel.org>; Tue, 30 Jun 2026 11:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818402; cv=none; b=GYJT2dhhXTcMGOj2UupCc0dwT+JA3GhRtALYjGKeaSdjk1NPKBG8Muo4YN40oaR94ozal1HYZIblzukXMBCc0n9w/2luLimXv5sl9Nq80dG08GbXlWlm5jQd7YlxscvOAh1pUcP2PRPGWWbZwoR/hmsGK+yAsyK0nN1uZaS2WY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818402; c=relaxed/simple;
	bh=PMfj8vAoLuXz4nZpWkRMuQeAoDUed2eQZFMQO3i2tNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FHcrGtBf65LbFsIhU0D1IaLm+YI+JLLrF/6VoKwNJxNxc1cO3BDLb910Hd808I6fCdDiypvAa66Kp59plBQe+vbR0DXvU+a569K/uO4k7fKp9r0npD4p8wf0wiat/C7dHy0YzLdYtW+fFxMlLYNUmJ7Pcixm01crXx1LPGq956Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aR3L4lB9; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aR3L4lB9"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c96bfabc8d4so865902a12.3
        for <linux-i2c@vger.kernel.org>; Tue, 30 Jun 2026 04:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782818401; x=1783423201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EMc4l7y/58xan7GJe/6NBJgIUEQeEH6NdAFiW8A4ij0=;
        b=aR3L4lB9EzyFNJYtXbgB22ip3F3ArSEmm4kXkuVflmNVEzdVxxwpj+Aa9A6qs2gf7x
         lCDeZyCy3rqKPKBGD2plgHsarkxNLQ492cQ6P2Ua5EsSUCMFKZpK9/NN7k1/MuGF/BdN
         x0E5ZB/Xqckz/lUz1q3oVUqE5KVlZLpD1GGySnKBPs+SIZBvKmTWqDspBO3UT478mzDW
         oig32x41mHA3X7YInyAZyMkqF1w/RazFIN7AR9rsuiDc/hM6rIBJ6hgf9rjNR+cSsibL
         799tXSXe1W/sm7eMg+AcWIhEgO3agXNzZJ5XNvgaDgPJZbhrj7JO1yS6MJOILOq7YMoW
         Qzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782818401; x=1783423201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMc4l7y/58xan7GJe/6NBJgIUEQeEH6NdAFiW8A4ij0=;
        b=EJo9TGtEjbVVJKEUdL1LJKfybS6OMvZXapaxrqObnmFj9w+l4nGYzvwEgfg9dsCVEk
         JfRWVEDDzrY/4RN2CvKpU02uI1sJPIIOYvH4CfAExZ1a5Htcm+TpWOhJUJskiAOkyFRH
         EbEwMDPf6a+wDJxIi7IC4qAkwwh9Rua8+ynv9uamthug3hMIKyiVZLFxblK2jaqMxqMW
         6zRhvOfjOtVNqHPp4hBatMZ3Vc1OAqk/xeMV5ErvfLCQC3jn0r9RJptQKu/oFOzs/Iov
         9wJ19iYcFqe9yC+zI+NZnznJmmydQdEYuPI/nJFQPDtjGlYc9trY90OuIkOnaUZhQY4U
         ut0A==
X-Gm-Message-State: AOJu0Yw/KggtSWG1wmW18IO3vVrRHePyaMUm0HVwC/htzXFzUob13LFu
	/ofe4Ds1n0FgupSLnb6KTHHo7lEHxLvQHhg0LpQLn5I+QUEHU7tF84KfDFvp5A==
X-Gm-Gg: AfdE7ckqRpAGwzqToL/WRxXMsZkXLxpAQWI8n54289PEy/IUn4NZ92DjDMwMrvmI30d
	qy3jtXKNQ2fTCzuXgQdIXxXC1GFlxEodpS1QAd1CzC/AMR4YwCkckvjCFvx1Qo+UvDeTELgTrNr
	oOhX3v0MpybBuslmS5JWl+y2RT/UiWxk7vMOYx49+NSolawXnGJpzXfHWuGDTO9610A46+AZp3g
	os+szkctx9zrVDCMWhuWiV2RSBny150ob+P/+tOd94s3SFI06APqxZz2QI8ZgTwMCf/gEGSyALA
	Ac9qnXfq6idjZo+TKM5E4N5TY1yUnrvnbEn4j3NcSl4+a5Pt5/bRRQPtd2MBW+rg6GM8v4v6AuT
	Ow9KXERcOoYKbxgg80EZWk7Fhi9ey9WxBMt1OIahHgjYtL/Cw6mgkxwedLIhFp+L72rgDIBmdrV
	hP6nm9dtRCRdjsH3Md0rY+/DLdZjq/9+MkElaYjTTaYX/ZJ4g=
X-Received: by 2002:a05:6a20:4304:b0:3bf:6d96:ac40 with SMTP id adf61e73a8af0-3bfc50563efmr2667483637.12.1782818400587;
        Tue, 30 Jun 2026 04:20:00 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9bbf95a3e7sm1323781a12.19.2026.06.30.04.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:20:00 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Stefan Roese <sr@denx.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH v2] i2c: mt7621: Use dev_err_probe() for clock acquisition failures
Date: Tue, 30 Jun 2026 18:19:42 +0700
Message-ID: <20260630111942.559932-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Use dev_err_probe() when devm_clk_get_enabled() fails. This correctly
handles -EPROBE_DEFER while simplifying the error handling.

No functional change intended.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

update in v2 : 
 Add the missing return after dev_err_probe().
 
 
 drivers/i2c/busses/i2c-mt7621.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt7621.c b/drivers/i2c/busses/i2c-mt7621.c
index 0a288c998419..8ab7a304a02c 100644
--- a/drivers/i2c/busses/i2c-mt7621.c
+++ b/drivers/i2c/busses/i2c-mt7621.c
@@ -280,10 +280,9 @@ static int mtk_i2c_probe(struct platform_device *pdev)
 		return PTR_ERR(i2c->base);
 
 	i2c->clk = devm_clk_get_enabled(&pdev->dev, NULL);
-	if (IS_ERR(i2c->clk)) {
-		dev_err(&pdev->dev, "Failed to enable clock\n");
-		return PTR_ERR(i2c->clk);
-	}
+	if (IS_ERR(i2c->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(i2c->clk),
+				     "Failed to enable clock\n");
 
 	i2c->dev = &pdev->dev;
 
-- 
2.43.0

