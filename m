Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D73D37B027
	for <linux-i2c@vger.kernel.org>; Fri,  4 Sep 2026 10:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518531; cv=none; b=kcWHQnYwHt1fjF18SWvqS5Zt6V8Nb/nWZf18Y1+A8FqJepTIkeCfNrj826UMMcPDLqtMkpy9ctss8EAV84wArt7C0ZrV+iRnTmijeqqZxXtOY8pOsmFoh4ERbHLVuM6l3tTtvgoJ8fpISv8HikqYdBVY/Vag0gPTxQn+ftQxVsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518531; c=relaxed/simple;
	bh=Rt4wPYHaXj12lxhPfPZKif/o+A0GOC+v3ilWBQKVVJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LJ52xdAfh+isYYTn1CNdqxAqhMX9REJfvPpoKMBtsUVQMaauHLwDCA/obS6yv2r2TPD55WyilaDYkQD5XQb+KUHZYHiFGE3upsVrw4buDSPqbaLr640YCS7CBZntsRCGuNAzb3SjWjpULAniYBXRz4RGJgrqi/PUP2wQJwV1P8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWL7fxOW; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWL7fxOW"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-853c401326eso434958b3a.2
        for <linux-i2c@vger.kernel.org>; Fri, 04 Sep 2026 03:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788518528; x=1789123328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fRB5x3mruocrsGhKdMFkiHzud4T/cpAEHWEqQd9LX9M=;
        b=LWL7fxOWSr55yKrtnkQs0n6mOg5ZE89Krth0tWp50yNjgpMW6E9tBb4UhtfvIj6iBg
         ovsmYET+x8Lv9pTC4j1mh3McGwO4CWrF1b4f2/zcvW3bsMrWxdAI929uaduelV2CTaur
         TjW/H75J+KtK4ZIGpSvHIvjDKnFTKnwOIXYDeGO042UjLwygrwkS44vhdErYhTszhhOV
         TAL1HtRnJbenShazhBSjjekx8blE/e8iQq1ntK/Vg9MqD241UPT2BEgo5qDpwffrpL5x
         r8En/IQEvpgrowKk1TeioaMJ3onpA3VMCnwOo0Pa1q554u1NgTMMniu1dulQsYgT49iy
         v9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788518528; x=1789123328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fRB5x3mruocrsGhKdMFkiHzud4T/cpAEHWEqQd9LX9M=;
        b=OqU8GXRd2Mst3fyefZVONWQrp8Xr5iNAvHoLWhIE5SPUDZQM/4Cxktv4CyERKwTaXb
         IDyVt58aaTM3jTAFAdbuEPNZsc1nkfhGcjcgFkAd4ezY1tb+NBvArBx2tbw/0pMMErMz
         l3Cy9PVgNZj/pbhDcFZJ3+82lMQguNN7IqUFtJSf5KzUUT58sB9mNcDreMXAWVLAq5uj
         meWTBtYB98KIPR36HUBUqTVuON+x01W7DECeGtMFcvTtEPBS7V2w7SWweKYsVUvKn0+2
         WMz3vuaLbDksyWAAFxfPcLBJhGO7axZfDFhWGqYlM4LijhQL0Z5w0sd98J0cLgfATsiW
         a70g==
X-Forwarded-Encrypted: i=1; AKwUvByHl+icptbglOHich6joUaIUiLxn339oNnDAFVCoD+JY4YLozNWbcQ8Z6RQaano5VboWvA6TBxScNA=@vger.kernel.org
X-Gm-Message-State: AFuF++l3Bi3K1bU8k9qI4X2X2yrHL2G7HawmnSFg8TSYsUCldZNzl9cu
	OIekPWCf/j9HZBHaNfpbeGIbxJC5kVZWuTFf0VeYEMVdJYnKFw7sn32E
X-Gm-Gg: AYBFou35+ZljrJjVndh/Fzi99LWIOOn4yAZ2h0EMfOdU7QeOhfunc4Zb6kcq2uZ/iM7
	DjWxRZQy9yooI6k6QnHLnVR78FxhyemZSKytneDGlU47gvfDyvyhfG8MCxzQNsBA5IrPuDqQL8A
	9+6un7O5WbV7dXOImYao1JgfiZMZcMUaTahEFE7AQIxd0RZ8LM8PLtyDBMpjz8CQxQyb480Nlm3
	u1s48EVEOkZJ6lOKjzCa6W+4vBspvYZdNCGD758I9mWGMAiD3crwEU7/mAtJh+wpSbVH7qGGYLf
	/qn8CpASu7IqPri/R17mWVSEDuurS9SdKJzf3Fp0ax9izUVPZwknCZr8FpG7nsZXqq3zrKann9x
	pQ2uj3rAGOzD6XwygFFX8ib18IsEkDY0w3CEmzRedCEy6hgkq7gGgsq09AM9JTzEFbXOWSIHPAA
	8l66chkD/lhSQeEKr2ed+Eac7CMUn0fj0xWAT7sZf4cccPPe6a/Vm+7neZcdce78/zyrPtYEDpi
	IovtXwUcjvG0bA/VKtjQ+63sQ==
X-Received: by 2002:a05:6a20:4321:b0:3d3:b02a:61a5 with SMTP id adf61e73a8af0-3da3a217599mr7290013637.28.1788518528223;
        Fri, 04 Sep 2026 03:42:08 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ca07sm6628278eec.1.2026.09.04.03.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:42:07 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org
Subject: [PATCH] i2c-atr: fix typo "accomodate" in comment
Date: Fri,  4 Sep 2026 16:12:02 +0530
Message-ID: <20260904104203.14539-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "accomodate" to "accommodate", reported by scripts/checkpatch.pl
using the misspelling list in scripts/spelling.txt.  Only touches comments,
no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 include/linux/i2c-atr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/i2c-atr.h b/include/linux/i2c-atr.h
index b52a7b9ec536..3f4d5dca5394 100644
--- a/include/linux/i2c-atr.h
+++ b/include/linux/i2c-atr.h
@@ -24,7 +24,7 @@ struct i2c_atr;
  * @I2C_ATR_F_STATIC: ATR does not support dynamic mapping, use static mapping.
  *                    Mappings will only be added or removed as a result of
  *                    devices being added or removed from a child bus.
- *                    The ATR pool will have to be big enough to accomodate all
+ *                    The ATR pool will have to be big enough to accommodate all
  *                    devices expected to be added to the child buses.
  * @I2C_ATR_F_PASSTHROUGH: Allow unmapped incoming addresses to pass through
  */
-- 
2.48.1

