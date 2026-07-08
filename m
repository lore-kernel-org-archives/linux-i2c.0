Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251923CF96D
	for <linux-i2c@vger.kernel.org>; Wed,  8 Jul 2026 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783509236; cv=none; b=p12nn63mYljysB4poBfTo0SwTEYuwTWHgLAI1HcrMgje4HblCALFQFMffrWi/wiGA3rN3JXTfVN8VuETpD3dX7uOw1g+bNqbXO/AMs1R+ja5hO2OMV/D22NMPw0SI8r0h21AnhHv/ZS2NzyJyUEK+PuF7ufPoXCql7fFGzhM1kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783509236; c=relaxed/simple;
	bh=vyG3JFyipUQQZdW3L6wNp5Zvb2ZwjDwP/2Uy6e/4Lmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h79r4NZasD+5mTOCyTCOzeK4t+gQ5WxivM/Ek7IG+ApgTFu8/4Fq5Mhc8HaZxC9qhLFcLW9Tti7Vynp/ui0UVSMkDMEKwkNw8Rtxw9FdCPbuIfs56BtESJZhpfMR/i79UZJb0eqKPVyJFTVkBZPADg3yd6WIHeag0a5ROhWPCEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HP3YIJR4; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HP3YIJR4"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8478fe07f0fso497823b3a.0
        for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 04:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783509233; x=1784114033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=em41dlu4oQdZqWDduU5M4moJ/CYl/v0sl+4/AYrbgEs=;
        b=HP3YIJR46+r0L5myXjhipUR3QOp0DoWUMApq2u2ndFC60oTJtE1xiHp0yvXl5jKJJI
         p6e48SLCfvGI0DKfPebpllLMTrmqnpX2bSMiwrvh3EXNT8kASRVH3J4Fti2Bba9Zy6Et
         gilHI4Rq/k9d4tZLTHSt2yevGLRF3HhYBDrqUy6kKT65mgX65GpE52DOG3ZeYfqoiu9/
         IZKiA8IlRSb5ER5jmerekvX2MXaAy40S/m/Bg5TPU3sH6ihxG13H1dzCbWGqeqwMT0Yc
         RlWUAPH2G0uZaOcngx2YDJcbwvIc3fnoNg1+3+1h6MpWQ9cj/RjAT0mDfBmMjatXWW4l
         zs/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783509233; x=1784114033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=em41dlu4oQdZqWDduU5M4moJ/CYl/v0sl+4/AYrbgEs=;
        b=fdQcyTrQ+QNhiJaRgTybJRUnbLNZ3ZW2nFr8NBRN4OXmYE+yE9Dhn33m0blol1Usm8
         wTmy93Z85mFpw6Su2B/kOEbmdnlaJUpptcLOg/RfeyuBZEaT+xccuS2PoJV+uY07gIKD
         B5IRWycaDim1bjJo2lLrpzUbXX6pAU9YQnkoXBNiaz6OOofTWCryeB88P1qOWkxBwc52
         3Bz4aBFOB3S/413eZ5aEonlqFvki8njb1YQ9yg3ioLbRuNf9hd1LurYz3JvlLLxigvA+
         sGMo2OD5b7jc+btXKAsmvWnGvX/JtSq0cpwJ6vJxhalvqB7w4pPb0Eh79ZA8Y2nkyCKU
         mIlw==
X-Forwarded-Encrypted: i=1; AHgh+Rr+2IAXQCo2+WlsaaU7x8yDHWJRXQ+CmCycJtjGLjVybbEXQtB5lXY4GXE2/DWMtRPbE48Tr+zIAY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqqBAgvBKE48AnYRJ7eOMIVOXf4i+h+no3rkU4hz424yyga2To
	tBTr9FaymYjgP8eWYHmv4l27xmW8nLPgtx9rDdw+tBZBP5x3ytkeHikL
X-Gm-Gg: AfdE7cmwoXbqhfgQBBOOCg5NQX05PpXBAsx1j/cwnouSkOWAP+TviELcSHrk6eFHZkG
	MBxKKtnb+F1blogr5tc48DjW+upl631J71xuDXSGfiWhmw7n9KnWRJbmgASWowQUa1q5KXVQ0O/
	KVhSZ0je2uCLRrDxUSP8As661q4HB876MuS7ebx1BNNuaS6VzWx6BXdHqGfnRUb1LmUPiCaxoWu
	tPaMi11c1OBJfUZnZ33SwS47flcFN0pNrf7yukAqBMNezveAqRI0TdRVcW4Ix/LgC62OY8phKxZ
	wVoVP3CaGgZMSO75/szXo/9ZzZB1ks8yVaZr4h6/Od6MDnflHrYlxcEuXjpA4aFDwvgzumUBY9o
	SVBFEZWI2Mhqvodri3vnc9LVlekYxV/+FNXrpGh7EeYcJU2qZ0whBl++cYbapH1SQAvn66IJiOf
	v9vdNIhdXXj8ve
X-Received: by 2002:a05:6a00:66ce:b0:848:4f04:87ed with SMTP id d2e1a72fcca58-8484f0498a3mr214402b3a.34.1783509233351;
        Wed, 08 Jul 2026 04:13:53 -0700 (PDT)
Received: from lgs.. ([118.193.33.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d4edb4sm6912317b3a.33.2026.07.08.04.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 04:13:52 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Eddie James <eajames@linux.ibm.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	linux-i2c@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] i2c: fsi: put OF node on disabled port skip
Date: Wed,  8 Jul 2026 19:13:44 +0800
Message-ID: <20260708111344.749796-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fsi_i2c_find_port_of_node() returns a device node with a reference held
by the caller.

The port skip path added for unavailable nodes also handles the case
where no node was found. That case does not hold a reference. However, if
a port node exists but is disabled, fsi_i2c_find_port_of_node() has
returned a referenced node and the skip path leaks that reference.

Drop the node reference before continuing. of_node_put() is safe for a
NULL node, so the no-node case remains unchanged.

Fixes: 58031a26bf2b ("i2c: fsi: Prevent adding adapters for ports without dts nodes")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/i2c/busses/i2c-fsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
index b2dc5ae1d0e4..9ba6b1c59082 100644
--- a/drivers/i2c/busses/i2c-fsi.c
+++ b/drivers/i2c/busses/i2c-fsi.c
@@ -704,8 +704,10 @@ static int fsi_i2c_probe(struct fsi_device *fsi_dev)
 
 	for (port_no = 0; port_no < ports; port_no++) {
 		np = fsi_i2c_find_port_of_node(dev->of_node, port_no);
-		if (!of_device_is_available(np))
+		if (!of_device_is_available(np)) {
+			of_node_put(np);
 			continue;
+		}
 
 		port = kzalloc_obj(*port);
 		if (!port) {
-- 
2.43.0

