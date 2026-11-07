Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794090558;
	b=F9K0zVh/883JzYB6M+m4nOTZFdIkNGg8cAGa+y071CAydBPs+x53Brbw5sLnQY82HYp9
	 JKNZ9wIcc93Ts7gobxUycI1yAzO0YLz8WAGWt9ncZVlsRSAVIfwdJlZ3XC9x41sISAC9W
	 OLo3yt7HfINxPXeTjVlcT5scXIz0yDFwie885/ePb2CMnL2fZCs63DHNIOOiEKSMKlibi
	 sJ4DR/HeLAaWxXTt9v6yeHcqTzsC1YjQBgaVBNvh13LIU2NhPZpSkXyoziEeLbzwEJxSq
	 fH9vLUy42N+k6OjZUet1yUn9zpFiBHSpfdPRbDCR0X6Sb8v1/tnAVUXH4CgGU/fsDQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794090558;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=KvQWvyI2fchS5QUJvQUusL+zVyULOAN7zOj800KT/nw=;
	b=KgQg2betg4VutCdHrmiKRLzzgoTFB4ZPqWbDuq3I0zPEou0S07oxOojEEKT9yLpII3XT
	 KvfnFaDCSGS0YLZON0cJ87e+4wK1rfkqndulFjOcBSavOWMiBRLQsvHIHBX5d/RRM3LPo
	 PYh1Be5Wvufd80Lzx93TdOjDwQP1Fh06BCBCc98mAsdZAmGmSZUiSySmTyA42lwePuIyR
	 du6vruWIgM0rd9WZ23jQRqN24OSTaSrZkdYCKU17mJNeiDrwDppgFc3bvpgif36W5IUV7
	 YtI+LrOPCsKJSO6MQTgKd2lp2s75bQPLGvjSCWHG+KKvWX+5a+AYkdfzAiuSlHy3A6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="IoaAsWP/";
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D2D606A32C
	for <linux-i2c@vger.kernel.org>; Sat,  7 Nov 2026 22:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85D2D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IoaAsWP/
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso465725e9.1
        for <linux-i2c@vger.kernel.org>; Sat, 07 Nov 2026 14:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794090557; x=1794695357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KvQWvyI2fchS5QUJvQUusL+zVyULOAN7zOj800KT/nw=;
        b=IoaAsWP/pTw2LzfYyx/H4mQV7TJzafmyY+pY6/Tj0QEvE72j8v/Uz/uIxN0lvS2ZPt
         P4FXkkVl7tO46EX8MWs6nVaDrdDvwvmaPv33M59IdeRXzH35+s9tMNaUfIKPQvZHwFYN
         cuEhU/ELOtijI9VXZAzMfVkciKgYKElz5VsPW3BgWiSNA8T0+kXlsOGm7pNiQbS/ssHQ
         Rz4scclE/Gou3Zfd80lt7U1oZbbKA68LxRYknP7MbGhiyNM/84Am6KyNvKo17P9BkpGE
         qvvkgY7//JKDBK8uDOWCbgI8hInRfsVa6hGUdcp57j+Fh4Dyi1DWMVIONFoIWwPYdT89
         2QjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794090557; x=1794695357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KvQWvyI2fchS5QUJvQUusL+zVyULOAN7zOj800KT/nw=;
        b=kFNlB9ubS/octMYFg84lwldERCPUTUXH9w18EnFO9S0jjSpKMAhZfhky415R0vMg8g
         jZ63CtXkwu5rUniYyliyuEN4w7tIEfrVY1ZmrFsQ3S3ZOxfe827WZiF2/zd0Kg9U0QZX
         eNf2NNfNdk3+ITppzkq4mjhOZH9bsT3QPTOQ0j827HxTSLsEwhi5Hz+PLgFWj4W2wDZQ
         PG1BWNq+7DbYIY5sWICZsayPW00ROLbLfVEzWl58gSF6g+l3buNb1VFMytixpzGDxdZj
         WmSrRn2n5G9hWcwjrOWTG5wINeduZ02m1fr949M32qKsZJya8TmlpVi4uhousNnp5YRU
         NtHA==
X-Gm-Message-State: APuU4Z/U3bIEinFrY4GHftht4sCiY/ywc9LlVjXkWmEpC19jjK/FR5Km
	kvC1q1wtlG+uYuF0BV5Bm4VJ7gT2ZYRQpdEJN9k74b9XqsLtX23P4Tbx5BHjgJC+4/Y=
X-Gm-Gg: AYBFou33HZkpmrEVRcVXOaH3P2xtuP1wDnVyWeoFmTBpYFNMSRSVZee/nMvQ5A+8Y4c
	dMTphaxFLrIMEDMD5ouMlz5gE/x7p5w7BF5dNNg8m+yrW3FyhD0CeaqwsyxOvksbE3ma3aYx3et
	lofIB+olSM4r4XvHxBouMVeSkxGEFtwtThjQO6VIPVedC037t+pO2Uts+8Uad6zMhLQXq4lR7Ti
	Q/yrh+u9y8/hsXfb5X/Qsm0HN1Vnakt+XCZ+loFDq+DEXjKU/YHucfTD4qdyZM1HuXCMaLA2SGC
	bNEFRES+6GWNU5zbbcDVU18S03tda84+rNvAlPj25JZgv0uosCq//Ndso+juBP0j4u+op0f3cb8
	4aEdrqhSoC+G98SYaCsu8kwBWPYm1tkckQ97r7zmVyn1Iau00nJar5OVJBr3ZU6vrkHbv06fvFv
	heMgTcJ/dNjgUKZB8RajcnqjbB8JLQS8CLWkHWKwwZe9LGglBvQLs+1N3iWWTS7mNauHGwTe1B5
	7qyLFRmHzIjzHlgTLpbHoAYLOhfLGfZDgyNaiXsk+TzMo6J4U2kxaR2tNZlXdBf9+KLWfIwMz03
	OH+0rxHQAnHOu98XgzMxnBsdNOwZRT1UJzFDVtZWLZq2952++M0=
X-Received: by 2002:a05:600c:6095:b0:4ac:86c9:b09c with SMTP id 5b1f17b1804b1-4b960e9a37amr1720575e9.13.1794090556743;
        Sat, 07 Nov 2026 14:29:16 -0800 (PST)
Received: from localhost.localdomain ([78.240.29.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b96cd012e1sm3538205e9.8.2026.11.07.14.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 14:29:16 -0800 (PST)
From: Luc Bertho <luc.bertho.kernel@gmail.com>
To: jdelvare@suse.com,
	andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luc Bertho <luc.bertho.kernel@gmail.com>
Subject: [PATCH] i2c: i801: Add Dell Latitude E5510 to accelerometer allowlist
Date: Sat,  7 Nov 2026 23:29:11 +0100
Message-Id: <20261107222911.36830-1-luc.bertho.kernel@gmail.com>
X-Mailer: git-send-email 2.39.5
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

Add the Dell Latitude E5510 to the i2c-i801 driver's allowlist for the
LIS3LV02D accelerometer. This model features the same accelerometer setup
as neighboring Latitude models, enabling proper sensor initialization and
functionality on kernels ranging from 5.15, 6.1 up to 6.12+.

Signed-off-by: Luc Bertho <luc.bertho.kernel@gmail.com>
---
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1248,6 +1248,7 @@
 	 */
 	{ "Latitude E5250",     0x29 },
 	{ "Latitude E5450",     0x29 },
+	{ "Latitude E5510",     0x1d },
 	{ "Latitude E5550",     0x29 },
 	{ "Latitude E6440",     0x29 },
 	{ "Latitude E6440 ATG", 0x29 },

