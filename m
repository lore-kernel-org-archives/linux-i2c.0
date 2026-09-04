Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3CF46C822
	for <linux-i2c@vger.kernel.org>; Fri,  4 Sep 2026 10:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519027; cv=none; b=l1iA0WodHELmdDhSgCDZkqcqNMNEhum0sV6rs4vNZl9eJ6BW+FhL8z86wwNeI7HJylajeG8Vp3PnV7w6k7yXY2l4jWHGdJ/CfVSz1jLg3lAqcyfiHmi9uQsoMSoz4aWrjld/SrAiutqxA5Rwoi/wlkDASHSbHVRCJtwA51ub8tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519027; c=relaxed/simple;
	bh=od+ImMTt4C64EYwhe+EWTEU35dKdrFyxn4Bd2TFuh9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rN9+GrW70PJJiK9SgPIKON+/Vyh1WyBOyd2Q/V0D+tvu66NWP+2RVmcQzubbOYdhKkmalBTly2ni7MiEcMgkO4rsV1W+q0KocoahP1yK0ppUhcMSd5bgZgKGEaRBq0fHeCEewPPWi4AOS2qMjggejDPP2WN2KmCkXvuTfSamC+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oxDtO5uv; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxDtO5uv"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so1452892a12.0
        for <linux-i2c@vger.kernel.org>; Fri, 04 Sep 2026 03:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788519025; x=1789123825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FjCZfeP0EDpt/v1y7ef/1qHRIUkfgxbZIZOgx9/zeeU=;
        b=oxDtO5uvJpsdU8KyWCqbo7Ii920l+oL7s6ps0Vgq5mdBWJFq3IGfHyvrjWKo7jZvDC
         sFJswHMmHJSiABVSTeQ4ol6ATWil7yHZWBEy1wYlarhrGSatAYxOmduwMI5Gtnjlgzh0
         C6oZ/mRAB6CCg/WRhaQYLO+3NbVKt1bj1TL4FTAN3JkK4NX8+JtfYl7ycSbgMuQ953mb
         fKSm3EfRirjsD0NDWPQ+R8dVjpq1tXWJzSOn68cHZqt6QUzGCb3Dvl61Q9i9bcJg5UBo
         kBKUsAJ5VJAIBmsopnXQPboXX/tZVdIOsznsq7u225jsG1JT2jKzBTZX0i8PQLkbeT2y
         IkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788519025; x=1789123825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FjCZfeP0EDpt/v1y7ef/1qHRIUkfgxbZIZOgx9/zeeU=;
        b=Td3H3d+Pv7r4YTZlFUEEUg6EC5Kq4q2pI1oMIdxaEdovQ1tpC0A4WstxsH7v9L41c8
         iPF0RNRcMByVynTe5nsOkyYNbY5YqZBUdwW+3HCVCjYzpHH7jG5JbrK7PSmwzJVralVz
         ucjupTJe3UhVbX2do59VeIXk5vH4+tv266H99Fao7ZEw1ihxSh+5EEtzKPMzCa7Ew72a
         ipg8ygxgq4IA0wq5FGKoOTlAbIehvsI1LYnFRLoANwCkwj9/8LbpWbhMIDE4vXPmICVM
         iImOvq7kbS3PA/xsJ+kuVf8oZ1uV34k+avbvkHYgfCSqgmhIfPnAhCwYun81DLI6b8N3
         wEpA==
X-Forwarded-Encrypted: i=1; AKwUvByjPPaNK+gbO2aBu6/r63q6dnGvDNu9IcChDQNzwCg6swpxf/aSp/Njmmz6GI4bN8aiq0S4nUfilj8=@vger.kernel.org
X-Gm-Message-State: AFuF++k5WdUoec+BSv3rI3F3Dx/vJra5aZWBjQNUe3GyA+MPtrf+CHBp
	SkT+nXOhtGBeXK1JaYN/2XJ5UgzUQGDwWbepG2faLlveN8E/CbYkC73+KL2E/XP6P0Y=
X-Gm-Gg: AYBFou3rbeQNuxXWi0YuhhgSRzNl9gLJuk78apJzMkUz0k4c0ji3jPFMmNWnWKufZaF
	FYOe0WpXxSuGB9izviyGOfJs0fZCs+XO8QHZfS+GXI3hYKQlGGS//JS8dKg5PjS0dyQccDCyHEK
	tg8I3V9USRYo/eyLN4SS25cwYSB4l5XvvUDYDVnUcLCBudQIjwlhYyXiVuzUGXWz9hav1GJMyDM
	iz0+6HXRitQLITL6X1uQNPAOD+1u9XAF7xwWYWjpylfeZ7MNFBRSxcU/hLLovhQTMj/WlBbjdxd
	oc7YPGsWR8rV+2VbDhV6OKJtYZW3lGd4j3kNiu256usFfxRcxCPOxqREhJLpfDGaDz/ANzg7YZY
	EbpyXoAyOqDERpSef9U6dhSNWODnaopRxJpwRvdpLGl5Xhx+JsZKROng2vXVOlBpGG6cPxrcAXR
	zgtVwupTmh4jQtLAfw3tDhYUj6XwRTNQeaVm/ZvXShWp0Q3buSsYBBi53nNfFkDG5gUymZgfTmx
	Sy6AZCVKA3q9nE=
X-Received: by 2002:a17:90b:5604:b0:398:c6e1:dceb with SMTP id 98e67ed59e1d1-39b07fead40mr13435287a91.9.1788519025321;
        Fri, 04 Sep 2026 03:50:25 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b608409sm6421454eec.21.2026.09.04.03.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:50:23 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org
Subject: [PATCH 2/2] i2c: fix repeated word 'to' in comment
Date: Fri,  4 Sep 2026 16:20:08 +0530
Message-ID: <20260904105010.27405-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904105010.27405-1-hemanth.selam@gmail.com>
References: <20260904105010.27405-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the second 'to', reported by checkpatch.pl as a possible repeated
word.  Only touches a comment, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/i2c/busses/i2c-viperboard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-viperboard.c b/drivers/i2c/busses/i2c-viperboard.c
index f596efcc291c..859d9aa6fad4 100644
--- a/drivers/i2c/busses/i2c-viperboard.c
+++ b/drivers/i2c/busses/i2c-viperboard.c
@@ -317,7 +317,7 @@ static int vprbrd_i2c_xfer(struct i2c_adapter *i2c, struct i2c_msg *msgs,
 			amsg->addr = pmsg->addr;
 			amsg->unknown1 = 0x00;
 			amsg->len = cpu_to_le16(pmsg->len);
-			/* send the addr, the data goes to to board */
+			/* send the addr, the data goes to board */
 			ret = vprbrd_i2c_addr(vb->usb_dev, amsg);
 			if (ret < 0)
 				error = ret;
-- 
2.48.1

