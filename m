Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795614306;
	b=uU2kLpsIeq8d9lHEDechVleZaZ96J8n/eM3JJLUdXFkJamC9xo5b/LlTLtu/xEaKUsn5
	 npwIW+mh4AAki8kqtI50Lz4BT2JMmb+zFIE0xbxR8cpHRLCwWq/UF3Jnib+zN80DgXXwu
	 rXkyEok6PnDLUelonewmNJ1rfUGm45eieIXti7ZykEE0IGAItEpfiFcCWcco644KUNG8W
	 rapoFfj3X+PPrjP2J6EdiX7F0VGNcDQYtabgosdl2C4eQhUajSFhmHIrlo/K4yOGqWXPh
	 XKMsU7FMlFcxo3wwWKH50Ri+yc6aov992J58lvBLZLi/6i9zFnTT9c1pMlbwyIzaZsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795614306;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=s0Od9VH9UpG5Ndkdf4jvk5NSEfMYmhVaO3t7hSReGUw=;
	b=K2PF50+lQFfumX5AEQyb1+VyJCf04QJoH+Jjc1W2nYrI/u1W7Hp7GByGbJJUBSC5gKsC
	 x9d1SodnyEywmkyRb66fPTTHNsww2EApKYeFoPLP7/kN9jbUTkWAfXM3U9Jwq5B5eYdHl
	 U5sg4OBzgb1eFprP1Zv7mCmHYoIgS2pbJy3BvqCI/4Ju1lZFnl7DN9D/JRSiqZ/5+mIDL
	 gsboTcVDXqrDFvHyoR/10644KUOQwj4G8sT/HiCsmSQx6K5QcWKYMjikuQuZo0dD/xyAj
	 Ry82B29wPrzLCGTwRHkiPbV5KSQV3BaZd/zVSnaqEPwR/q81msu8L0V78afqcS1kicw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xozhstFc;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3534D606A32C
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 13:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3534D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xozhstFc
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-386ab9ab619so6996028eec.1
        for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 05:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795614304; x=1796219104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s0Od9VH9UpG5Ndkdf4jvk5NSEfMYmhVaO3t7hSReGUw=;
        b=xozhstFceUDCgTCb5vaNUNE6gMRbBiSjCVklJuYVVgPuXRfzJBv59Wucpx59B7zIsK
         0jBXqTb700ESRMytDIinZGHF+Of7mgqeaIDE90RArg65rKARxuDitNkVtbrBV3ztlJUu
         Q6N6OFX0q7X+B2zJLEHTQsjqAWIpUV/pY1bWQ6k1senqGDAts8g8Nw9Z54VFUoYMQyHc
         OAMo35Dlp0aw2lvy+wp6XFX1qkd6ce6vICvoQAF2VJMpcuxeVMvlyEsi2/HVQFXF839o
         /vMZ3R8zDVzJk+HJw2bsN00TgklmzBv+MGeaiQQzzdKe3l3hvonENhGYhqM6huCpd/TA
         jqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795614304; x=1796219104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s0Od9VH9UpG5Ndkdf4jvk5NSEfMYmhVaO3t7hSReGUw=;
        b=ZQj5V5wZ5Tp3AlBG/xhGur+Nw8TqpzgdOdOoPfJPVJRsC5C8VuqggnrGoWKqWZ8BvH
         mPsB9B7ytYtM5yLNVzij/pGGfofFGRqNj1zamTkQSTOrg4ie2b3OfBRXXnatJfFxpbqv
         PcjoGMzQZvOyndsVHZDNROLKYWCX2Nc3FY6jg9hcFjnADYEGxudH9QzlUqKIBjJSnRxn
         2QFGgUhccyKOOGK9fz+OsoPkWeo73+pUYgN3uZTI+a+t2womNSg4zIFI7SCii2ntPvJ7
         nzI1IAu8mBJx01v7tFfl5eIjnWdmenGpBvMAfFM5kfO5nC+YWUkyusza+nYJQmDKOqBi
         kuVg==
X-Forwarded-Encrypted: i=1; AL+hErFeybNWJPo+0yIZvWppYKnG+bXwIwOUISpYgwg8EtLPn3BbSmmhe3GifdCPQxif38jw2GOJ9/mAp7o=@vger.kernel.org
X-Gm-Message-State: APuU4Z/wPocrXCS9nuIR4LboJ5oIahrzDUrgJd7bxD+NVa9WlulHz+Of
	ZdSA99G1RYh80BLLB1iqkJWk+R+bvivtau2i6Mwe8KKizzjXTw4uGIfs8Ol9ig==
X-Gm-Gg: AZFdTZcYDur3SDX7vEGU6qMUpSZPCJ85nRBBzmlBlRaoGLZkzprn9UhZp4OjRX1tX0z
	KHfanslJ+sVSNhJ8SertSyzgwQlkphYdvq2iidklSEBBxChI2UYs/34pJ4LAEizX2Fn0Cpusmm9
	IXc1y0Ob0MpxqcwKmuUYsokpW9iVFFkk3cEfGAYSmZ3AQENYQIg4ggKIeltqDoxkvAmjziIWeSE
	qnjiVPDepjgZzqdjp8u+vYgVD5aIryJg0D9lU563/IM031oR/lPWr14VTB8PUApgxh0ovRUmT8k
	DE2fsFZ9jaBO9WiP+qk6cMpF3fecbzGzONhxpCwGIs1GR48CQIplvru8b1B84p8NBFnUpgqrOZ3
	1BLEGSaPqfGmuJG+DdWYaYquygGrQdZbSja3Xey5kJMqAaamFIxeTORnoVNH24EDNeAdrEPSkJH
	eT1PGFI9kDrSC7kUaCelcWiM7C7Wq6wdSzPyfrxxvHEzUsYsRowUU4N3pVrCL/bruLUg4lLDqEB
	AndCGTx87GAEjoJ680g1JSdiutOO2p2KOS1goHfuc5ujOynpaVZRwexvVZC27p7j4h2FgnknXS9
	EEhGjvHF9coDKw/UWvwvvxksGxb6wH/DH35H/4yQcfb5Ayw=
X-Received: by 2002:a05:7301:46a3:b0:369:faa2:1fb2 with SMTP id 5a478bee46e88-3856f65ada3mr19391252eec.8.1795614304136;
        Wed, 25 Nov 2026 05:45:04 -0800 (PST)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e96bdsm51101413eec.7.2026.11.25.05.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 05:45:03 -0800 (PST)
From: Cong Nguyen <congnt264@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: qup: do not disable the clocks twice in remove()
Date: Wed, 25 Nov 2026 20:44:58 +0700
Message-Id: <20261125134458.2704674-1-congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
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

qup_i2c_remove() disables the clocks unconditionally. If the controller
is already runtime suspended, the suspend callback has disabled them, so
they are disabled a second time.

It also does this before i2c_del_adapter(), so transfers from client
drivers in their remove() run with the clocks off.

Delete the adapter and disable runtime PM first, then disable the clocks
only if the device is not runtime suspended.

Fixes: 10c5a8425968 ("i2c: qup: New bus driver for the Qualcomm QUP I2C controller")
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
 drivers/i2c/busses/i2c-qup.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 731bce9f9a92..f61ef2d3a10d 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -1960,15 +1960,17 @@ static void qup_i2c_remove(struct platform_device *pdev)
 {
 	struct qup_i2c_dev *qup = platform_get_drvdata(pdev);
 
+	i2c_del_adapter(&qup->adap);
+	pm_runtime_disable(qup->dev);
+
 	if (qup->is_dma) {
 		dma_release_channel(qup->btx.dma);
 		dma_release_channel(qup->brx.dma);
 	}
 
 	disable_irq(qup->irq);
-	qup_i2c_disable_clocks(qup);
-	i2c_del_adapter(&qup->adap);
-	pm_runtime_disable(qup->dev);
+	if (!pm_runtime_status_suspended(qup->dev))
+		qup_i2c_disable_clocks(qup);
 	pm_runtime_set_suspended(qup->dev);
 }
 
-- 
2.25.1

