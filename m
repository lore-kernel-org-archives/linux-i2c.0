Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AC9455611
	for <linux-i2c@vger.kernel.org>; Fri,  2 Oct 2026 21:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790977463; cv=none; b=YbWJtuC8L82DEEzKNayO5Ks2I7+flX1oTOxYLdBiFSGOxJ6p27chRGDgmR/wT/761FohWwDHaZDGT08QroUr5osviMjI2qG3cC86kWAErgPqMdAjtdty8nd6eDJSm/er70t7ekJ7+j4PhGP5hU4NiIuQ1uOZ/UMFX2K/iAzyVVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790977463; c=relaxed/simple;
	bh=ZCaeiEXn07+Csr8kWh7m58CfL0dqAr0onVKjEQ2TCUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V2OcfeL43KhPrUS+uYUBtffiojvzcWb/kRzjRbHR/lbmgQCLebNq9C0Z0p2BWRH+0mGtn37n9p3a9Jzbe22akAp5a2Dw/rrp227xGTi1HD6f2QR07RPNoKnILMNI3dWRkK0bC165PgaiSrBnoipP9cQvPf500W+CGnmnNISCH80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTpEq5QY; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTpEq5QY"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5332bc442ebso149551cf.1
        for <linux-i2c@vger.kernel.org>; Fri, 02 Oct 2026 14:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790977461; x=1791582261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=731GWBd8bmU4NH2SwdaToIMYTPusA7UXCs0lvTfehWE=;
        b=aTpEq5QYLS6xiS4P0Qjvjklm+3wdDQqV1rXFmSgeQNcLXmLqmdrThNDBRmd/fEzoyZ
         xnjg8u44B5JaKFwTaAKDvfJEm0h6R3De5UP7p1QDVu4ResjqClhtv2tL3RQ6qDWocgmD
         47GEpowVFAb2lI4bl895oBqdDQtgniBk0GzU9bdoEI0FC2Flkd3P08SSrYX1fcGXZ8Yd
         srQ4uWXGSQyn/XIeuW8KzuhfOfyrIQxkZaMzjGVhU/TnOL6L4UrTLDNFzP8ACHEsKDoV
         ycJ9o01EsGNl7T8CYp/PdTDYKYw4kMyJGfy2JPnkThErGaTAEHW2fPf2evdEkS32uaW7
         Kyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790977461; x=1791582261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=731GWBd8bmU4NH2SwdaToIMYTPusA7UXCs0lvTfehWE=;
        b=DtKgpk4d0PPAmUI+qIWU2WF2PgxcA/0TGJUvgEGKTKUCvpErYr9rp3zZjIDNY5IclO
         r5k2o4FNdBIo7rsw7DOx0xOV0TaDrgltPRcTpkfY2LQve6BJ/8zAhhSw5KA8x/DGoFO9
         eTcMCoIS19MZKVH8c5hx9iLXAQo39TKPVGPwy/z5uP2tY8nPE6N5DzkEkkA8lN7APPtN
         K7YoXPa5bw8ldSp6uInR4coQunL01RdXWh51lrW/Bujb76sMcRpKSmtaA4rKU5KCDDkv
         4f0zrdRLFCsTSX0/pwlA6DU/tAN8gbpqnz/zD5QTANLq7eZozc+TYxqYXLelGcTjDqBR
         nxrQ==
X-Gm-Message-State: AFuF++kxNDzeBEvFlNUjYL5vjxUe+QuOfD7nq7FMc16G6uzsWunEDpxU
	Gf9/efzFNYE4ox6oRGI5zoAfUx7/ozVaScXd92heh8f4wi3aBXjbStU=
X-Gm-Gg: AYBFou32PZQu404E33BAkU7aqClzTHydfjSKt11W0Kd9syKSQE7B3Glk+z0HNCc3bEU
	3RyKpL0OY27/0TSyDivY7634oYwvc0IXkR+E/QiuLIbp+8+7XisUpjSC7Av25A+NqWkUZQfPojO
	0ni6ZHuyeK8MoCsrsT76V4DOZez2INkq6IZIxs2G8WdxpalMyARAyj0nmvyDR4hV5ISmHN/0cmX
	iD8AmC78dmk1t5xVvlWZER8OL4l/dNLUr4n6wKYhoPOgzA6PtXlUPDGHgBAdGuXVA/JL9VARDOg
	66j3sobuOlzq8/AgI8AZOu2Z2XFAfeA2fUjCb2Mcp/G9kzSlYe3dSohVI/SEb64K4ULCtBpV0CF
	Ua9cqGgdV5X02qgrUIg9p5+tAVyM7HbV9jSbg7XNyUO941MzlUcRfCHiB1kRwuO9I9t857k/qlT
	SzsohoMGusv2/B8WwN+SySJCI6rKSL6VtoYFn/C2TBxqywnP6kYbgDnyo7G4tw19595dB6VjLfc
	fztPCZ1KE18ndpJD/xkb0G7lUmIBUsiVnStZaeCy8/Mw7RD5Ji1z8zuvxuHPAu8oAIjrCa0XIGp
	Zw51kf/ccFVoODT3aBPn315RTLUNVwtjPpCvrug=
X-Received: by 2002:ac8:5a46:0:b0:535:958:b9c1 with SMTP id d75a77b69052e-53511d18e2emr12544691cf.11.1790977460535;
        Fri, 02 Oct 2026 14:44:20 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53398aa36e6sm36669261cf.15.2026.10.02.14.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 14:44:19 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Rishi Gupta <gupt21@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] HID: mcp2221: always initialize and cancel init_work
Date: Fri,  2 Oct 2026 17:44:16 -0400
Message-ID: <20261002214416.459795-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The writable gpio_mode_enforce parameter can change between probe and
remove.

If it changes from false to true after probe, remove skips cancellation
of init_work. Pending or running work can then access devm-managed
driver state after teardown. Changing it from true to false can make
remove cancel an uninitialized delayed work item.

Initialize init_work whenever IIO is reachable and cancel it
unconditionally on remove. Keep the parameter check only for scheduling
the initialization.

The false-to-true cancellation gap was previously reported by Sashiko.
We also encountered this issue during our static-analysis research.

Fixes: 200e6c6e94fa ("HID: mcp2221: Add module parameter to enfoce GPIO mode")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/linux-input/20260715143415.916A21F00A3A@smtp.kernel.org/
Assisted-by: LLM
Cc: stable@vger.kernel.org
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/hid/hid-mcp2221.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index d52ce3531ab706db8ec908d57ad0383af9fafb1e..6515692b408ee7b6ee318cfa3f240321c133f2c4 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -1072,8 +1072,7 @@ static void mcp2221_remove(struct hid_device *hdev)
 #if IS_REACHABLE(CONFIG_IIO)
 	struct mcp2221 *mcp = hid_get_drvdata(hdev);
 
-	if (!gpio_mode_enforce)
-		cancel_delayed_work_sync(&mcp->init_work);
+	cancel_delayed_work_sync(&mcp->init_work);
 #endif
 }
 
@@ -1347,10 +1346,9 @@ static int mcp2221_probe(struct hid_device *hdev,
 #endif
 
 #if IS_REACHABLE(CONFIG_IIO)
-	if (!gpio_mode_enforce) {
-		INIT_DELAYED_WORK(&mcp->init_work, mcp_init_work);
+	INIT_DELAYED_WORK(&mcp->init_work, mcp_init_work);
+	if (!gpio_mode_enforce)
 		schedule_delayed_work(&mcp->init_work, msecs_to_jiffies(100));
-	}
 #endif
 
 	return 0;
