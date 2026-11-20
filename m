Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795153327;
	b=eZsc8xeBf3zp4ObOCWWv09r5xM/+bWS1Bl328a2RaqlFKU4FtNs224Z+51Q/exJnI1/P
	 USC48mz3up3uyUxZgRRokLiQENqaAFixV8h5APQc3AN6fg8ey+9+TQ6Xz3Y3HZyCst6b8
	 pF9YAGvWG7OD06o5AnHylpsmHa53NkgVn9DeynRt09l0LQlirgP3vtBPnVMrqCFR6L1PQ
	 jFeiSisunMriELDePrTteZCj/pKaIBYULAnxVshZuODkT1vcc20R/hd8dVyWbfalUTcwb
	 BOiokUz2RwOTlPEijHdGetqgsXePSL6WZ0Goe/WZTdNpyoGFomhBbvJ6JzQQ7fDxMNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795153327;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=qg66As88L7D+ejFnkRW364NrY+XWuQ72Fp7ONjEgBVs=;
	b=Lg/TucCXXF4lWYRT9tGhMXJCUsYG+LGFbWSfZjeytB9dAQxHmlC238QkCn1RqDrqCqPd
	 1Qq+M5vCxs7ZBcre/YA6iEW/GgJ6exXCl4CBpkZMcOQIGd0upFrAW5NTy3NTj4bAbcGUk
	 Mqp0q8+jVEkItkqPHlEyDwa1BaRxyxeQgEDEQ/FZ8OjmuP7ncxLsvcdgndcSKQqJ07EWe
	 fW0bk1eBNm5J2Z4zix9dZo3K+CXFTwOD8OuD18fzA9GbX4WIH41bt4PQ6vrMbj9APoUta
	 OyOhcStlB+UUZHF8aPtOmSvA1nSD3GaTKgRdgfJIAEM8pBWKqOThDT+Nz3hJGUGZtRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ObKmv8K6;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5A6606A320
	for <linux-i2c@vger.kernel.org>; Fri, 20 Nov 2026 05:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B5A6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ObKmv8K6
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1b3ada81853so597363c88.0
        for <linux-i2c@vger.kernel.org>; Thu, 19 Nov 2026 21:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795153326; x=1795758126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qg66As88L7D+ejFnkRW364NrY+XWuQ72Fp7ONjEgBVs=;
        b=ObKmv8K6gmkJWtEjdBAWb7j3COSE/CtSWyImikDHfSRx6vXrDTPFVmbUCL/gGX4vEB
         As0xISIpu88Wguo+NW3O37lxEtFNFUrHCOxgHv+Eix7dvEHbkkns3BAExvgyae7eRlyS
         UW7t0igdOI9Yr6m7KRryj21LejRBhU3re+etHV16nXBm5q8rTzDjsO0Ko7jAbuB4sgrK
         d8lU11s+qVEtIs9BJBOBsdRBIgeaDvR41kKufznc8bEbXBbiWR/cq9E+zSHJdSlY8An5
         p4sgYh87KugFa59YHNXeUsf03VlBZGxmeKY+yPda97a103nL5ZJBAv4ZaG8mZyTQeWMm
         70QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795153326; x=1795758126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qg66As88L7D+ejFnkRW364NrY+XWuQ72Fp7ONjEgBVs=;
        b=gW96WzA4WYKtPOmIfG9Q7A8l0lc//cy8paBmFm9N4yL+U2ZO1Pnfm8GXrDI2lsVhdt
         gKibc1QeqODObz9HliIyuwmFiLhfWFORGobaz8PvwGRvv3lFWeVhTUZITO0mLFyvvdDQ
         UVWob2dMswGKlOXJydKxu0Olz4Aj7a8aDOMtH65wxokLlKYrw/EHf7rGhU+aIb1yJDeg
         qC6Q/H+F2xX4Mxf8XMmkAyMBHBduB2GRDTEmr6jjIQ8I1oITz14i+oUCDL8QC2zqlZXN
         Ebfe9PWnPUvu9Wgj196bGpiEk64mpy29RODgRyBNzKb08Fmk6y4oRcv7izZSqrSji0Yh
         S/4A==
X-Gm-Message-State: APuU4Z80fEcpMjh9YqGxSgZX2So5JU/86yALrA5xuebnKcn3X8Hk7uU0
	jfS/X29uh/4mVO/gnSmhL3de8h2ivwtOErJVD5iunq/diaG6txSXzBWQ
X-Gm-Gg: AYBFou2AO72gZdMH70BwRR6mr70ea2Z8y1mHv8AmKzOg8bMVldyFvbGRapsfSps37hz
	x6fk5MzxrbqFDQ7a6kejFlKkv1KzsDIEasNREOk3TVtUtnLn3u10sic6MYKDdoslHGinfaCTMQL
	ZQy2xcHtaxO/rMxBhKvzVfX88F6ag3noLaKasZZsUO6hSK/z9e1b4CkBmk90t8/fStxX4fh8ChH
	+l5AZXTRicJxBnA6kXpwMPr9+t0HKrx0oEFy7mklFNAHsZp5fMwYkGOXljvrJyszbxDt8PUgZNW
	L4lAIw/2Q9rsLybJ17+ieQJ6VS+toUUBbmaTP82zBffcPcwyBMc7g5y9HN/maiRR22mhDluX2NW
	mLioh0Q+0uxenDc5w9ZslH3DRKcaYBpcetbzeHdWoTXHL5c/HKF1olOBhmxQAQBbwAyzuAqgT+6
	nAy/XQi0Gd2DiIj/CyQBiIWBxvFr45qTOD/QBOin93mrYFV62+x0efVXuljo7mXuSNMOKqi0bRc
	+UiQ08RfELQWnWQPuBxTz0yoMeIgZ7GN7nCt5Yh1MSt4qtzbOFAu5SuMCA6hbpJmCvLCEj7Dvan
	sOUi+D2zOhJCyyXvNVCUeMY3Olh9
X-Received: by 2002:a05:701b:4510:20b0:1b5:595f:4236 with SMTP id a92af1059eb24-1b5595f4800mr728992c88.35.1795153325979;
        Thu, 19 Nov 2026 21:42:05 -0800 (PST)
Received: from ubuntu.. ([2405:201:8026:213e:2c81:3ed2:5653:bdbd])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55681301asm3807956c88.8.2026.11.19.21.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 21:42:05 -0800 (PST)
From: mdshahid03@gmail.com
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH] i2c: scmi: fix memory leak on invalid block length
Date: Fri, 20 Nov 2026 11:11:38 +0530
Message-ID: <20261120054138.194076-1-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Mohammad Shahid <mdshahid03@gmail.com>

When the returned block length is invalid,the function returns
-EPROTO directly without freeing the ACPI response buffer.

Use goto out instead, so the allocated buffer is freed before
returning the error.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 drivers/i2c/busses/i2c-scmi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-scmi.c b/drivers/i2c/busses/i2c-scmi.c
index 37442c9ee222..b65771d31a28 100644
--- a/drivers/i2c/busses/i2c-scmi.c
+++ b/drivers/i2c/busses/i2c-scmi.c
@@ -248,8 +248,10 @@ acpi_smbus_cmi_access(struct i2c_adapter *adap, u16 addr, unsigned short flags,
 			result = -EIO;
 			goto out;
 		}
-		if (len == 0 || len > I2C_SMBUS_BLOCK_MAX)
-			return -EPROTO;
+		if (len == 0 || len > I2C_SMBUS_BLOCK_MAX) {
+			result = -EPROTO;
+			goto out;
+		}
 		data->block[0] = len;
 		memcpy(data->block + 1, obj->buffer.pointer, len);
 		break;
-- 
2.43.0

