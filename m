Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CF8366548
	for <linux-i2c@vger.kernel.org>; Sat, 31 Jan 2026 18:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769884148; cv=none; b=oK+uRWykZWHi+c3DQGMV+UBDvGjs/3PZpMOk+3Py9IP4Q9R91Bpl/i1unW6fEeExBidmjvCUCsRHpWEgtP2sPekyy38ISoEcKKAy0lQ/1ApnfSCPqejFWNuSPqmTV4HFJFHXuwquOsuT/olyEVqLIcyNNKrw/ZuhXYFab/W6zrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769884148; c=relaxed/simple;
	bh=2cNAKnSczqFDvan9SEiFwFwLVMyWwTUFffTK66ZOIns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=D+nhbzGPpwcYxBnwNW2IuES/yAT35D5s6moph3GVypfdWswB9iWIIZkedH2VdpEw05TSz/D61ns8fQOEBMM7BTsMSYQZmzsWcztoEFm4Fdu1CCCTWoequZwAa6ssFNURxHhTCJbSDu83cYBmRCSLtaHfnmNn6T1ckIym/4/vcCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFgn/IpE; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFgn/IpE"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-81df6a302b1so2970369b3a.2
        for <linux-i2c@vger.kernel.org>; Sat, 31 Jan 2026 10:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769884146; x=1770488946; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qGPmhqBLmrhjnKRU3GP4xDYGE4lQQrm3+UpM5b+lZCM=;
        b=ZFgn/IpEeL/XPQKxht1PHyjNBBkZvMMBICwfhbWL+BqFyL1R5oyucWQ3m9J+rDMAJX
         xy81IZGRBSX756+xVWVU8NNN9l/xFzgPTP+rPK/Ba0ONqSgltjCHQ9yPP/M4mzlgvMGd
         46pHo2cUG3uRN5WppDi4TOkZjadGFTSGKe/Bs66fBlugJaKEzmymsLDsGdWsptDXJpDf
         HJWBJ8p3IKz6iSecxdKjPWJw0kn3LPmMoy57aj9UpyMhQtizdoMXAm3bnHOijvOOWFqx
         7ULQNRm36zxzR2mt7Ukau/yLQLAA+u8RAk+Wq6Dc8S504tsF91Y+9o+PdUT6olizyBvw
         Bi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769884146; x=1770488946;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGPmhqBLmrhjnKRU3GP4xDYGE4lQQrm3+UpM5b+lZCM=;
        b=Kt84O7Aa4lxuXHugmgoaRYPeQoos0ijrzAiLLOeYYfld/Hj5KjjoWEPNzHLa5pYST+
         /UJsTewKJ1fwHB28j5dX20qYYn/mf9sNJyI0vv7cMKcI3xqynbrEnSnYG2uvZYFaE+DZ
         GB67YrC5QXDU7Qazr4oZ5V20W7ZaxECxf1khXS0fjbi798ET5Eq1pqTqOK8kBdFR6EZb
         66Pu2fmraxyy5YHStZpl99erVA7vKWzA0jOUk7XHyBcTIUF/K4OD33UfGACOktoxzBbn
         2WrkeHdHmWDI8fF6ylGDwqSA24vfnpiV0G73HMehBByKjnQD3A77EHZAiCZJIGpuNwSp
         wi5g==
X-Gm-Message-State: AOJu0YyLgBRqRcAu3fIqNTUHWig6GPKNr/sJdGcFn7Wgw3HTutuooo+M
	/wXaWgPgIpHm+r+LWi3KTCg0uIHEbrtMVI6zxvJDaX8wtcHzn7aWxEj7
X-Gm-Gg: AZuq6aIyPoEgqSX5PVw76w6iE4hFtGAqolJ1a8cUEk1PdOE/icWsmVczMdEnjWWbrGI
	B871Mds38j949nX2pN4RK5McO4POaz6GM0aRwyz5ouHLgcE+HaYiDInAXQ7lA8UTMddClskkyI0
	PBXlMCvxTBomOYuHbnG10anbqIhVtmX37D179QqyL/RIswtcDHARqtudfzfIn7FGavmGgXl3Run
	2ukNusQ7Ev78ZUQjg0lepg3alh7OcnNslK3wtvdOy0FTkreHSDDZSHo2VsCSxjCKKJs3UMwobWU
	/H7MRBImDl7d1NntR0LaeZNMbtfojOUs+fFoCJVMPC7cJFXWf0ubak+Jt6gnAeqMDdi/ITp/FJO
	ZA2NCE0/xPqxJ6rPVeLsvlNzZTQh35CptmfBpJQW/SCPmcn74a4LZ9bZ//nebohwoRKtRikXvRB
	XPUY+POFs=
X-Received: by 2002:a05:6a00:139d:b0:81f:3b74:5812 with SMTP id d2e1a72fcca58-823ab6770fcmr6413801b3a.31.1769884146110;
        Sat, 31 Jan 2026 10:29:06 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9008:ba52::3a87])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c24083sm11433930b3a.55.2026.01.31.10.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 10:29:05 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sun, 01 Feb 2026 02:29:00 +0800
Subject: [PATCH] i2c: sun6i-p2wi: Fix device node reference leak in
 p2wi_probe()
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260201-p2wi-v1-1-e0ec9cda82b3@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOtJfmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIwND3QKj8kzdRENLy+SUtFQzy1QDJaDSgqLUtMwKsDHRsbW1AJIZ6Cx
 WAAAA
X-Change-ID: 20260201-p2wi-a199cdfe69e0
To: Andi Shyti <andi.shyti@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Wolfram Sang <wsa@kernel.org>, Boris Brezillon <bbrezillon@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769884141; l=1471;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=2cNAKnSczqFDvan9SEiFwFwLVMyWwTUFffTK66ZOIns=;
 b=yXCZwSuCzXzxPIwefJT/i/DC8MOkG6SO8j6MIGT4Msk92UzkC5uL4vvVgUv/M5Lw9apjSMJvh
 Q4ldLZdPsbsCiD3ZYP0udu9iKzAZUEIv/SV70Nhl5JD+qqF3qZdZuTA
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

Use the __free(device_node) scoped variable to automatically release
the device node reference, preventing a device node reference leak.

Fixes: 3e833490fae5 ("i2c: sunxi: add P2WI (Push/Pull 2 Wire Interface) controller support")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/i2c/busses/i2c-sun6i-p2wi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sun6i-p2wi.c b/drivers/i2c/busses/i2c-sun6i-p2wi.c
index fb5280b8cf7f..652b37b57159 100644
--- a/drivers/i2c/busses/i2c-sun6i-p2wi.c
+++ b/drivers/i2c/busses/i2c-sun6i-p2wi.c
@@ -184,7 +184,6 @@ static int p2wi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	struct device_node *childnp;
 	unsigned long parent_clk_freq;
 	u32 clk_freq = I2C_MAX_STANDARD_MODE_FREQ;
 	struct p2wi *p2wi;
@@ -223,7 +222,8 @@ static int p2wi_probe(struct platform_device *pdev)
 	 * In this case the target_addr is set to -1 and won't be checked when
 	 * launching a P2WI transfer.
 	 */
-	childnp = of_get_next_available_child(np, NULL);
+	struct device_node *childnp __free(device_node) =
+		of_get_next_available_child(np, NULL);
 	if (childnp) {
 		ret = of_property_read_u32(childnp, "reg", &target_addr);
 		if (ret) {

---
base-commit: 33a647c659ffa5bdb94abc345c8c86768ff96215
change-id: 20260201-p2wi-a199cdfe69e0

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

