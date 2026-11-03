Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724571;
	b=dskqdnNyLZ5QbHXpEPQyCtGw2cz07xBFOtu+frdLQg4oh//av6NyXbyePwxAdfgLGMYC
	 AIBTNXDr8rQcnLT1hg3uJffJsMB2Q5lDObA83v8SAYXjkqnvhaZSUcKZdJXyLEstCv+La
	 VE54F+iL4ME6+FKA75xgaowQ8JDm5PzDULNeX6UXZKFsLVZxRHubbjrchFrxY63Bh9Xph
	 LYEp2RwUHJhR/0nfcNf/RGid7foC4nxczY+lUQA+7XKUGowNw3PDbbLOuIMpX6TKihg5n
	 JwHDpALgLnZkXIeMNqcLf0sv7h811EPEiz8axNi74MV694dDdzNis4fhwmV3s6X2OzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724571;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=ENJkHkCfpFwdQvw3umeRws6G85S/Qq8yf5a8h/OQL8U=;
	b=QK07yJW9qanN6M+uE9/hMcTm+3T6n0rUQA6ZeB39FPvCAq50iEXIHii6LbGBrZjSU/QF
	 pQwVZ07PYyU1/poI3VsAWGKOTO9ldpOr6SfnSeE2YI4s00B5rryjF3eKLAwRjH47yZHzA
	 rVzytJ3eoxQxHBlv9kMMdBBLkw4wzs1yAsKwN/Lb5jeYyY/zepCf7q1uXjBjaA4LEvsZL
	 DuadMrdbXTEOlDu7/s5rjsvBk58giGEH0qL2SwEbwz6bikvt/Kct39VpX0cTDtaozhLbR
	 5qCChMGQaoIkrINw068yqST16eYSLb15/B+Ufn6iztjrjWrKP+521FjSRThsZHl0DKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=NcSfNv4c;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03AE606D802
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 16:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B03AE606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=NcSfNv4c
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5E9774E413E7;
	Tue,  3 Nov 2026 16:49:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 340506046C;
	Tue,  3 Nov 2026 16:49:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6FF1010329123;
	Tue,  3 Nov 2026 17:49:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793724568; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ENJkHkCfpFwdQvw3umeRws6G85S/Qq8yf5a8h/OQL8U=;
	b=NcSfNv4cNiP0umd6rQiY6FaHSP0DxqMF7EEpB9VLEmr6kTGBIrSZ9AoedIN8oqrV27VcTi
	CMAt4qLCh3FcXjDT6UP+JwWIj82J5+2KA1IeZ3b88GUsVguJE+JPDFGDOmS/ePqq69Ck7Q
	91LB1BdHYRKc/4CsA8Ut42N3Kor4v1HK0PMG6CC+dJa+/5Ob8unqMZ4/ymgmxQjYaocTaB
	a2LhIbcgOTL8ICw+ZCk+RRobpYcHAgDJsKJkVUCg+9PfE4HFnFzRRWVFB+eOimfEdAu0ey
	5eEdcjpETgiSeFy6vzc/3uLKXfr1PLI7b5KNDrOSvZNtvWeFLf3gpgRb8LYuVg==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Tue, 03 Nov 2026 17:49:09 +0100
Subject: [PATCH v5 1/9] mfd: cgbc: Fix use of negative error code as valid
 session handle
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-cgbc-i2c-storage-devices-support-v5-1-ac11f23fae51@bootlin.com>
References: <20261103-cgbc-i2c-storage-devices-support-v5-0-ac11f23fae51@bootlin.com>
In-Reply-To: <20261103-cgbc-i2c-storage-devices-support-v5-0-ac11f23fae51@bootlin.com>
To: Lee Jones <lee@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>, 
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

The cgbc_session_command() return value was directly cast to u8 and used
as session handle without error checking. Casting a negative error to u8
produces a valid-looking session handle. So check if return value is
positive before to cast and use it.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260713-cgbc-core-fix-cgbc-remove-v1-1-79274ad62b3a%40bootlin.com?part=1
Fixes: 6f1067cfbee7 ("mfd: Add Congatec Board Controller driver")
Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
---
 drivers/mfd/cgbc-core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
index 3460c50047ea..02a8c0078287 100644
--- a/drivers/mfd/cgbc-core.c
+++ b/drivers/mfd/cgbc-core.c
@@ -103,7 +103,12 @@ static int cgbc_session_request(struct cgbc_device_data *cgbc)
 	if (ret)
 		return dev_err_probe(cgbc->dev, ret, "device not found or not ready\n");
 
-	cgbc->session = cgbc_session_command(cgbc, CGBC_SESSION_CMD_REQUEST);
+	ret = cgbc_session_command(cgbc, CGBC_SESSION_CMD_REQUEST);
+	if (ret < 0)
+		return dev_err_probe(cgbc->dev, ret,
+				     "failed to start a session with the Board Controller\n");
+
+	cgbc->session = ret;
 
 	/* The Board Controller sent us a wrong session handle, we cannot communicate with it */
 	if (cgbc->session < CGBC_SESSION_VALID_MIN || cgbc->session > CGBC_SESSION_VALID_MAX)

-- 
2.53.0

