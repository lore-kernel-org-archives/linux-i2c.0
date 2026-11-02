Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606613;
	b=HA9Q6lPTV3+l2209lNsBSb2yTaoqcSEPpc/iL2ljDP9fXY/wSnQGU68O9i6DZubTaLdF
	 qnq/DRDQadWPZxPSt2tatgxGzCLypIZU+TwvGf0o9tNG3NmWk0fE/Wv2p3e/dEGU9YJGv
	 Vrlwsbml3YMgNwRMqaFFazZ7D2iryymqcC/LsfVusnnOcJDGfiafPd9YvZFWQ6U0MILsl
	 mBnVqs55hBtjkbgmMzJKupnjVoSzJlDb0Vtb/gahEinWM84Cs4UKahifBe2g1wW+9PsbX
	 799/WJu1Kgelau3iGB/K6ObnP89wfXp4UOXrBF8kW66haNetyfm2UBm5gAqxSeiAjdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606613;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=QnTjaKjV/Eb5lwtCkCJI2zpKofDOjZaAyQUoBY2T2Qk=;
	b=E2GW7cl/pgKBs64A3NwyU78VsMMpTV+n48AMb7xsEmTPX06XUHT9xnKEMgK7Wm/BNLnT
	 oAr+L3R6DzvqotLKVV0B9V+9k8ZeCgbD6g3jvGGkalnUF6aI/5QH9jlmlmBJczDsExz1R
	 pG6HsJJpDafAc5lDz1j5yFyyD6CuCYWrVOZL/I4Vm9eTTcyIBJxfccfpljxNbgXVysiwm
	 b+j0Oiy5EIC0x3NyfZNhPicMOkjva8peLra5zVhvcQe/dRcVPa4gBwXAkg+QYRtk3t7dj
	 CHI/t1zov1phUaY541ijvqD6ubwqoFk48yL6InKQ95VcIcxPYt6JbUamEUo9jPl4imA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OWkwfKfA;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B881E606A326
	for <linux-i2c@vger.kernel.org>; Mon,  2 Nov 2026 08:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B881E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OWkwfKfA
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a07078200fso889642b3a.2
        for <linux-i2c@vger.kernel.org>; Mon, 02 Nov 2026 00:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793606612; x=1794211412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QnTjaKjV/Eb5lwtCkCJI2zpKofDOjZaAyQUoBY2T2Qk=;
        b=OWkwfKfAsXbbKJz7QLwcb3/OvbnhOZV+OWnHFr38rZMHRX+U2tUJixFagpNooNi8af
         JHlhPFxZpAxbzU7WntTbHVvsDhNB1wsBqXuaiP6mQVJ/c4w5mjKWNMAoG9iiuu9Lh35Q
         qj511tfZLYKlZFmC0TWA4JYVtZ4yydCtlk/X+O4tHECac+/SIGQ77W6KGxE4PcGNLPqo
         7JfGUTjFD+yCKqxvsWaKOW/muvzvmLf00SMDtTfNZt9UO0n6HiUL+gXJS5XAjiTsTmOj
         SwU7D92XSXts20RO4D6jb6kIu/Pr+O8A7G6Qsh85bgdeElGcFkzE2tJRBmT2u2RkkYlo
         GMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793606612; x=1794211412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QnTjaKjV/Eb5lwtCkCJI2zpKofDOjZaAyQUoBY2T2Qk=;
        b=lDVooAqTa2yBQq2XorYodIq3QUm16dbUqewLGrA1XSa49WI6lbX/OY0EMOzPqzf/gb
         74nD+lRMXQPQl8y3Fg+C6afvNeKipO/cKbAmpqk3oBNavdvKbZBgQtK9qfRTuAVqqS2u
         Qfjpk5q1A76/2rvKJsON5Yq6orTuDbFE1rUJD8cR3o3RToCIKneqr38rO7alJGk7Ijon
         ACk6nOPev/yHlfA42Z/AISwDvwD+FxymfymVm8kDWa6GRPN/iZTxQVBcfH2cFmSrXkaD
         9AXYM6SOJSVLfK/HLAcv6lVewT9FsVdhKU6i/ggbEp4z4GnZQOIIJplHGkf+VNdglyZc
         scdA==
X-Gm-Message-State: AFq9FYITuXXFit1ZHuBZgo8ijEQ2fYU25QY5vKuglzOy+uDwcI9c/2af
	wsEH2BH3pMU1qG8Tht99nAd+NGzcWnQ2tyuZakDVbPIpPURBSNrMbJb/
X-Gm-Gg: AYBFou2we03jP70D3+raoiOkoZZy8ylXpHeZ5nJJnsS9CMCOmKDSgi1S+gf7csLGlHC
	uU+k6Ai/rwuNTXh26itl/aFOf+FgrdoBL6WipV30q9NInrVlzRLZRxvONmYQsE7cK1vu1B0AdXz
	zfiwQRflF0LiQItFm4FRdc1iohvszWOCRr9/KXHwl0ym8kfgjYk3l9zJaVKi+PRvebyclOahptl
	8OgXRKo9UQr5qn/ACF6LtMdMTOs8F3lDDUeFFyI7pGO2fV3S56h8b/0rAlALQnDExgrZPmIVbJi
	bptlF3fcohpq+YVUftwWmVcngkx40LpPz0mGEmvVCps5sWvGJdUkajEKRcZRSFcqzj9buvsozqh
	v9s1HareZCleyLRCBYpm5bDhjovuLtbM87Dk2IfBpqPtfIoeUblmiEw7OvbRog2fncMqbUTA96F
	rMteqGRQmD85xhUswTt0dztPGAzBtAttkUzZmulAma8dYArUxcnU9aOVotSk2IaDI2SrggUa0tY
	I6v/pK9wVJQtK4fe6eu0cswfYL6DgFPHCTt4eT3jorgy7jYUyCZl2U5b+fwBsBF2RZX15Zvvkn7
	TwKfFSIY1YeLD8J+Z4nDe9huANDTA2Sj1NArJwD/XOKCWuQqtYOcDrHX789RMnFbPslRW/XUHs/
	GK4nOt0kDwJhLMSLRNUCXqt4RLGEX+Ekc6/BOaZgLmSFDFjaB66r55sAYAUZE3qyA+h9PiMvdo3
	G/VmUGVtXedOwKbw==
X-Received: by 2002:a05:6a20:7343:b0:3e5:6c93:2500 with SMTP id adf61e73a8af0-3e9290799a3mr8561614637.57.1793606611852;
        Mon, 02 Nov 2026 00:03:31 -0800 (PST)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb096b8323sm2937039a12.6.2026.11.02.00.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 00:03:30 -0800 (PST)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Peter Korsgaard <peter@korsgaard.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] i2c: ocores: delete adapter before disabling controller
Date: Mon,  2 Nov 2026 16:03:27 +0800
Message-ID: <20261102080327.1466598-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ocores_i2c_remove() clears the core's enable bits before it calls
i2c_del_adapter().  Deleting the adapter removes its client devices,
and some client drivers talk to their device while being removed:
lm75_remove(), for example, tries to write the sensor's original
configuration back.  With the core disabled, such a transfer cannot
work; in interrupt mode it times out after a second and the write is
lost.

Delete the adapter first, then disable the core.

Sashiko, the AI review bot, pointed this out while reviewing an
unrelated ocores patch.

Link: https://lore.kernel.org/all/20260813153155.3953577-1-ruoyuw560@gmail.com/
Link: https://sashiko.dev/#/patchset/20260813153155.3953577-1-ruoyuw560@gmail.com
Fixes: 18f98b1e3147 ("[PATCH] i2c: New bus driver for the OpenCores I2C controller")
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
v2: v1 went out before it was ready, without my Signed-off-by or a
Fixes tag; sorry about that.  This version adds them and says what goes
wrong.  The code is unchanged.

The other ocores patch from v1, "i2c: ocores: synchronize startup with
interrupt handling", only narrows its race: a STOP that is still in
progress when the next START is written can still raise its interrupt
afterwards.  I am reworking it and will post it separately.

v1: https://lore.kernel.org/all/20261031033240.2491016-1-matthias.goergens@gmail.com/

 drivers/i2c/busses/i2c-ocores.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 2d18c1035837..ff024cf5f92d 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -720,14 +720,15 @@ static int ocores_i2c_probe(struct platform_device *pdev)
 static void ocores_i2c_remove(struct platform_device *pdev)
 {
 	struct ocores_i2c *i2c = platform_get_drvdata(pdev);
-	u8 ctrl = oc_getreg(i2c, OCI2C_CONTROL);
+	u8 ctrl;
+
+	/* remove adapter & data */
+	i2c_del_adapter(&i2c->adap);
 
 	/* disable i2c logic */
+	ctrl = oc_getreg(i2c, OCI2C_CONTROL);
 	ctrl &= ~(OCI2C_CTRL_EN | OCI2C_CTRL_IEN);
 	oc_setreg(i2c, OCI2C_CONTROL, ctrl);
-
-	/* remove adapter & data */
-	i2c_del_adapter(&i2c->adap);
 }
 
 static int ocores_i2c_suspend(struct device *dev)

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
-- 
2.56.0

