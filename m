Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98CC299A82
	for <linux-i2c@vger.kernel.org>; Fri, 13 Mar 2026 00:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773361409; cv=none; b=q0Flw6iipLqAHZh9XobPv2Ndyr6MG4C9cOHCfyXX0RQ+TdnYdcSWJLhfUTUaqove4YZuHyhwYVZeCGyNq4bvYXARRadVs9W75qz1ITwyAUznp0S1R4K/IGYr8baaZAoYl2xLm+YlFYYLRsE7GvJBfnFK0vKBOPJ1LtfCxSM0r3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773361409; c=relaxed/simple;
	bh=DAOotS0+fJKT3Knk+MeZ7HSRumsv/xP9lPM/rU63+iE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CVTVH3+tZ48BDeIEw6oh9StPXsmaVPgX0FqcXZ9Vdfu4O6aVkhA29K+7u5APuJU4BI4QKlaq25cjmRHsm8OiJC1dXsCdV0KX0ZYBtddGnYYXw5bu1+JWm0S8LW20t9LKA6cHR31xFP8vAdnDJ4g/f+8T+RBhqfqUzo6T0bMipOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBbm3S5X; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBbm3S5X"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-799569f6e9dso18090987b3.3
        for <linux-i2c@vger.kernel.org>; Thu, 12 Mar 2026 17:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773361407; x=1773966207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bpGg8KlAOke1kfXQdKS/v1oPTBpVb3phcbFoPsToyyw=;
        b=kBbm3S5XfkOimj5j68nNMgRHRssj72ZnCsTjJGIPBtmQ+uRo3fBIHz7BbTMChu1hV1
         X10KojimkhYYp82RwZ3cKhnkFuxu+IJ51oECy6cJr2ntxYwzoCVtBvhFabfODfzUrobp
         gS/zg/q6fMz9gGS7v8aqFlqvL/PX2Ov41xnGzAkcSKOrP9HriaGICwQ+znLdEMJa9p2Z
         ggr3b5IEaboFi+v6dLG+jA/BMEexXxDS/kntRWV5BwvqgQCr1zTnV9k/hJg0+vj2hpSa
         fb9PYWrsgD+mOG/5SCYLRmL4Ov/LszwmqIJjbMnOfPW6wueVcz+SFhGqEzadpNo65K+J
         58+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773361407; x=1773966207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpGg8KlAOke1kfXQdKS/v1oPTBpVb3phcbFoPsToyyw=;
        b=MlFKNw9NiZrr2aJzZ5k4e7P9NOZq3QS5/znFStTBBpvv5EFDCwqApQDS4ihOyZUDSF
         ME3yJEOf7vZ1/kG3WnLoScb0KZBP383zPYBVkFrjOrohyIn9pNVgRQK8ni7+RXJQnmg0
         Cljpv34LjuxBg+vgxbgNz+NpjX25/TI+67fFDmNfPdnIKPb+gTTCjvjyuD+FtMyQq9Xa
         5fPkuy0jfrcquzpTTrqasVxaoq2IT/jkBiaxslPqMETQFCk62U23n4L+VD+aoHVfcd0H
         pfDaSuJtVeMYv5uo1Ly1euyuh4E6Qv0PbEUvLVABRMCRCt8H7dlQ+SPFsx6CRdiHhDC1
         vswg==
X-Gm-Message-State: AOJu0YydgbOMN+1EQp69bUVbEiNiA7ru9AZb/Rg3L82RK7ZmFeYEpcdV
	dvqMhNTogykQL+wIUoWJ1DsiO3qikDyOZmR0oudZVfUyLAj/vUhKnCKlqYe9i+gf
X-Gm-Gg: ATEYQzzbgZr6EBoH9RbQbkHC2+wtUriebMCeKQd3m5JjRzV1xflO5t8N1HQTkN4RYb0
	0zkbgG+Knc/vGsjvMefaWUK6R3NP+VQOitCdeFXQ+WWiA55pXY1JSV7iHRvD9vgmzFSUnEdMNQA
	0lrMoF9QZ7y0U1gatKxrTq1CzLx9grwQBliTcZKKk7IS72g61cm0Ef7SZM0i3aNlL3pq31v+gcS
	JyLtDvZwpRjUV9QR1Cjo1jl3EdX/I4hb/fvaeNkD/cP1/O9Q+KM/MKscmfHw7ZxAk5QS5/0XPea
	GB0NQFcluCfnROWkixkVVUn42UxpwbuFNM46kxOeBjMrQ7Yi7IONKgQ1oZZuTQI5ZuxPs0+UIm9
	TzNAyopFSCz/4yP89HTNPCx66ObMtEFWzKpS+SK0Bez9CPeGUnFG/9egqTjA+XJLwhls113/T0U
	VjoVIn7mDaE9v2dgkVzRJeTwurEYlL72S6KzwjrgetW9oAkS5kyT1o6g==
X-Received: by 2002:a05:690c:ed5:b0:798:ff7e:96a6 with SMTP id 00721157ae682-79a1c23cd40mr16090467b3.63.1773361406680;
        Thu, 12 Mar 2026 17:23:26 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e65b67185sm152768d50.19.2026.03.12.17.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 17:23:26 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] i2c: atr: use kzalloc_flex
Date: Thu, 12 Mar 2026 17:23:08 -0700
Message-ID: <20260313002308.119343-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.

Add __counted_by to get extra runtime analysis. Move counting variable
assignment immediately after allocation as required by __counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/i2c/i2c-atr.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/i2c-atr.c b/drivers/i2c/i2c-atr.c
index f9fcb4793aaf..b0aedcf0bf71 100644
--- a/drivers/i2c/i2c-atr.c
+++ b/drivers/i2c/i2c-atr.c
@@ -58,8 +58,8 @@ struct i2c_atr_alias_pool {
 
 	/* Protects aliases and use_mask */
 	spinlock_t lock;
-	u16 *aliases;
 	unsigned long *use_mask;
+	u16 aliases[] __counted_by(size);
 };
 
 /**
@@ -137,22 +137,16 @@ static struct i2c_atr_alias_pool *i2c_atr_alloc_alias_pool(size_t num_aliases, b
 	struct i2c_atr_alias_pool *alias_pool;
 	int ret;
 
-	alias_pool = kzalloc_obj(*alias_pool);
+	alias_pool = kzalloc_flex(*alias_pool, aliases, num_aliases);
 	if (!alias_pool)
 		return ERR_PTR(-ENOMEM);
 
 	alias_pool->size = num_aliases;
 
-	alias_pool->aliases = kcalloc(num_aliases, sizeof(*alias_pool->aliases), GFP_KERNEL);
-	if (!alias_pool->aliases) {
-		ret = -ENOMEM;
-		goto err_free_alias_pool;
-	}
-
 	alias_pool->use_mask = bitmap_zalloc(num_aliases, GFP_KERNEL);
 	if (!alias_pool->use_mask) {
 		ret = -ENOMEM;
-		goto err_free_aliases;
+		goto err_free_alias_pool;
 	}
 
 	alias_pool->shared = shared;
@@ -161,8 +155,6 @@ static struct i2c_atr_alias_pool *i2c_atr_alloc_alias_pool(size_t num_aliases, b
 
 	return alias_pool;
 
-err_free_aliases:
-	kfree(alias_pool->aliases);
 err_free_alias_pool:
 	kfree(alias_pool);
 	return ERR_PTR(ret);
@@ -171,7 +163,6 @@ static struct i2c_atr_alias_pool *i2c_atr_alloc_alias_pool(size_t num_aliases, b
 static void i2c_atr_free_alias_pool(struct i2c_atr_alias_pool *alias_pool)
 {
 	bitmap_free(alias_pool->use_mask);
-	kfree(alias_pool->aliases);
 	kfree(alias_pool);
 }
 
-- 
2.53.0

