Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794291285;
	b=ro+UrTE1G8Ai8q3Q+OOaO64cE6/0sXdpNey9CMewUy2VQWiaxLD1nZQTLNxxFndKkIir
	 WJX5DdeIlcdINCLaQkM5stKsZniMLdd9MiH1u8YJKV03gthpVQa163vc2TX6YyqrNbdZO
	 mPlffcVkyT5CpJmaS3z2iEK6vEUxtLOboFrFy28lGRVKRW65tL22DCSEJ9k95giwBmg8h
	 NXooMNLfH30M1vYjpSX5UcHWmYj5tG6pGZO3oehDAHY96k31WippZ7+e3Jrm2+J/Vc/Cb
	 caeRHUly/Mez9Y6+nJHrttNMCGUZctmVJT3fEC6t5micxQWKZ5S+x7S6V7+yLyEFnrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794291285;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+HOH7O4j20KDfBtKxtSGJ323bTE8G0lrShsobfiCmIU=;
	b=fgdYq6L5SjJcBwEyvlzuPEimNi5iIpYwliOFn18/rYxfZ4SOrbCocV/0TmQAUpVzCzNq
	 /OTVSPT1CimMfCNLAQbuvWynOkO28aI0nFRNxbXURpsEitSfudrw17rvLUkY+UN6jC27B
	 78C04QcFf7CADCfw2yvlC6+XGI4VGFAp7Q+oD4HoCUGun4cTDQXU6XfPMBtQ3ElHFtu1/
	 ubR6izxF4JlYTDipC/dhq1+uDtHwaH9MnwbZnFYx2Ai9JiUqaoY9tPowYqq4a3ATxfKvm
	 wwEfcu8X2k362rgaSMZ50r33wqOPCImj/uqyGXS6S+tjbyEoxxfd2mGa62znT8OaFKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="YHum3B/j";
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDED606A32A
	for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 06:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FDED606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YHum3B/j
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-33fb4680717so381491eec.1
        for <linux-i2c@vger.kernel.org>; Mon, 09 Nov 2026 22:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794291284; x=1794896084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+HOH7O4j20KDfBtKxtSGJ323bTE8G0lrShsobfiCmIU=;
        b=YHum3B/jKzFxCesg7+Ct7CPnwxHr0nrJAYz+jcYt1wC41y/pqChO3cemGyDqaU0WYi
         ZhrHQHR+K1Da9LhsBEUrVWbvL2gWmaQdaMgYKWqh17gYHHUD8+DkzHB+ntUDF2lRwVzs
         s3WQRy31A++D4hh081Nmn/QvCHW1XCaCsx0pWfJUmlKICljEo9YCuXefvQoUVmAznqfX
         gBPwUs7cOtjvTU37V6rBUVifr67VxETH4kcmTT6f4dl7uN1zLFST7CCg8pH8JgBgOZTh
         OZJffn8MWCr83MlMWrkJPuslh8yd5fuOebAj5cmk1UXJ6Gzb4JrryKbSpoGgyuaduvmw
         EzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794291284; x=1794896084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+HOH7O4j20KDfBtKxtSGJ323bTE8G0lrShsobfiCmIU=;
        b=lRvn2Zztrj1qJL+SjjyEeUyE4ejKXGI9iN+lcbQCxnCiXC+Z3SyUXEsfMS1j+bXT4N
         291VIriABADyJkvs8O1D4FetrY+uSwhekBqMXdDqgZIjLwD1ljOCP64pUkNoaROGvSSs
         RtplSgAAPejEKePNTrSWKhvtJdRYyRCmWDwTOKoDHmiySbDS/eASAVCW87vv/gjA2XZN
         zZ0XpmdUruqcuQrTP2FLqP2QxXTrxai0rTrD+9eXmrtfp/w/uvOJlKb6CB6/cdxCbPfF
         eys452qSy2wMs6YOW8LxX0Ukg42gJ7ekm/JbrC6hIXydaESsm8lCFDP7aYHjto/Xwa8p
         1Hmw==
X-Forwarded-Encrypted: i=1; AL+hErGOyUn1i3ReKCBQ9zkjNrux5+4vuxZttR/T6FpFyO98tHtggtnK1Q+6jZJdOjggjrrsS+yIa8Q8QUs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+E5Tzmq0kRJyRDr+VQOkYLKaFOZYKjDz2U/k7g90CnhKPG6Jch
	/WsiCZ0FDPyftI583NgHN/munjmYd1Wqdpaii2SFMKC8iqRWxs7ZI6jE
X-Gm-Gg: AYBFou0Bbbe8sbNPTn3CoVZ/uqqP0+97lUUzfZ3GjDw1+DyoOKQchWbqE02FHG7e92s
	h2jmubnmxrm7BsJRTkI5/q1rFKWdqNihyP3cbJC6/3vxCQ7fGVLHAIzTUvQJZ9+b223we/MZDMu
	az5nDv27px2SkWGdEtnmQtcaMvELcqmjp68pPDhJcfmN+jueN5514IfZgGqMoA1kzWHDXc8WI0M
	LA8zIOjo7H30+/Zo97hKYsHdp3WQxxnmIC1KUJ0RUtFN/k+4XE89sQzRsf2th8yBAzc/QJdiBSe
	ULplHg0Yw9/zlD22vzUjSDOCkBZq8ap9f9kR5t6e7F2j9Cfx+T/RdRJddCaruzSAeokNU/R7qAt
	MXlqqeRP2h5v3HoPNNY0zqpaLE6rOG1Qy6U//byPz0141K81dZ6mRCJCm1gVDhfdkPttFE/+NCH
	0aDEMsJN32pC+7q6PwhzifPwuJc9JYR8htYR9bajyG2Rd1HTSaF6InEoBIcVV2/2qXQcnCeuLbc
	690pszLnZAC+OJ5VMyPe7vb43Y7mA+Zo0faZBqTGxdE9cvX616HHtCEiMDrQpV3/eoI2jXJGZkb
	PYI8SYnK+UNshH3hXKMAy92qzFbfsc8l
X-Received: by 2002:a05:7301:488b:b0:36a:1e0c:e28d with SMTP id 5a478bee46e88-3751c53546emr2305164eec.4.1794291284219;
        Mon, 09 Nov 2026 22:14:44 -0800 (PST)
Received: from archl-rock5b ([45.112.0.182])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375218c863csm3802316eec.28.2026.11.09.22.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 22:14:43 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	Aurelien Jarno <aurelien@aurel32.net>,
	linux-i2c@vger.kernel.org (open list:I2C SUBSYSTEM HOST DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-pm@vger.kernel.org (open list:SYSTEM RESET/SHUTDOWN DRIVERS),
	linux-riscv@lists.infradead.org (open list:RISC-V SPACEMIT SoC Support),
	spacemit@lists.linux.dev (open list:RISC-V SPACEMIT SoC Support)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Alex Elder <elder@riscstar.com>
Subject: [PATCH v1 1/2] i2c: spacemit: Avoid sleeping during bus reset in atomic context
Date: Tue, 10 Nov 2026 11:44:26 +0530
Message-ID: <20261110061429.2036-1-linux.amoon@gmail.com>
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

The spacemit_i2c_conditionally_reset_bus() function uses usleep_range()
to wait after triggering a bus reset request. However, this function can
be invoked during atomic I2C transfers (such as power-off or restart
handlers running in atomic notifier chains), where sleeping is illegal.

Replace the sleep operation with the driver's internal helper,
spacemit_i2c_delay(), which conditionally uses udelay() when running in
an atomic context, avoiding "scheduling while atomic" bugs.

Assisted-by: LLM
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Alex Elder <elder@riscstar.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/i2c/busses/i2c-k1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-k1.c b/drivers/i2c/busses/i2c-k1.c
index ff32876e24d3..f4b21d7efaaf 100644
--- a/drivers/i2c/busses/i2c-k1.c
+++ b/drivers/i2c/busses/i2c-k1.c
@@ -332,7 +332,7 @@ static void spacemit_i2c_conditionally_reset_bus(struct spacemit_i2c_dev *i2c)
 		writel(FIELD_PREP(SPACEMIT_RCR_FIELD_RST_CYC, 1),
 		       i2c->base + SPACEMIT_IRCR);
 		writel(SPACEMIT_CR_RSTREQ, i2c->base + SPACEMIT_ICR);
-		usleep_range(20, 30);
+		spacemit_i2c_delay(i2c, 20);
 	}
 
 	/* check sda again here */

base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
-- 
2.56.0

