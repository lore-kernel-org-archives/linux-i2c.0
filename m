Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5181429ACCD
	for <linux-i2c@vger.kernel.org>; Sun, 23 Aug 2026 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787502883; cv=none; b=aIFHTH42Zi7qRVEcw26SgAy6g89Tryll60GWE3xxXR4EL2xSzV0dMd5QAcFUf2awg7RySSnWPy/3dHEAY+VoIl+0YEn8009cOdm1sKdsfO0HQ5Yh2Fm75en/gWcL6zDBL+Jafu13JIGzZAQEAUrbekMdCe8DgLXdEnaLG1lp30k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787502883; c=relaxed/simple;
	bh=02ybAsaiwsvWoQcNLX0GyaEbVxLKweh93ot9JkZWSS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FB3SJxHau29RBNoob8whK38EZamGw1izPg6kMJ9fnphSu/zp5d5wST2Sxqr8SPjOangnaNOMhplD+ZN8Y+pwV2PqmIARMI2PkWTZ/6lA76CVfdYAkT8xN/vDsQ0zv67sZ0Rh2KtozX31nGOyPkv+i6tEWRicG4mn7+OVO7w07EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bxh28NaE; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bxh28NaE"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e7109321dso1725940a91.3
        for <linux-i2c@vger.kernel.org>; Sun, 23 Aug 2026 09:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787502882; x=1788107682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8sTClNBlu3puMMXbF+SQ5upo6RgBShUKol0pOMHxtJA=;
        b=Bxh28NaE3pZmwYRPHlFnO0NJjlRoBW6i7MJTKXjWYJeZg7H5rItuAXsbWfUjtlEwLL
         l7M5JnVUwdlj7U+4zfIeqOD3Cr+x0f3Q5yzGxa2kitvN/BHlvZNpSPcjQ9Wo89fV2z0V
         9BlAeL5GgGoRv0puyS3IZ6dHhiiLod53PErWCiEdCkwXfkW3oqN9xuz2E6IPOVHhlQFn
         X3BCVEuSF53EDE78fqvtIPR9zjuEvofvhrKS/emlHAJc+p6qViczQFWbbyXbE6JqdEwS
         FwKswdnXW8g9zZaClVu2x1dUwXnm5UTWlhdKuXjHloyTnXxIJy8x3SCuUFdAptIBtXFk
         toPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787502882; x=1788107682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8sTClNBlu3puMMXbF+SQ5upo6RgBShUKol0pOMHxtJA=;
        b=p27Uk+F3a6n9ugr4DD2n1zyXCOl5rfnWpatIG2Y8RFd97gUbXcJbpY+jaSyRdvk0sj
         JFMMvfB/7MEN7TOKt4bBBdX09gTOkzqseoilG4nizeWwQtMEgXEa89B67GstCfI05+EJ
         ngS+wTzK7ksvZk/lgMCDwr8xYBZ1DWRX9vRBlqZwitimy6uvCueKY36k3bpTg54LxpBP
         jmLXJUYzmC0mVWKAFkF1PgmiWmi3BioLpX+w7wRBj0fwMe/puNrs1iBaMXzjJHH3S7S2
         qdLOvFIoDPa/av/ecdmmuWMnaTmvsex1nIql+hQMW26Uwqlsd/JxgyvcHfuruAzhVl80
         /d+Q==
X-Forwarded-Encrypted: i=1; AHgh+RoJ20b1YhZpm4bms+wUclhLPXZ/cYA1Z+sH3U9QTuakeNne3Fw9vn2b58hzszZekSd7wYfOyzJVtLs=@vger.kernel.org
X-Gm-Message-State: AFuF++nUGE6lHTdpz40r21sBVLoB5QtbEzhmTg3H7mDP2S6nhqhyEwJU
	yA4uwwQs6FsHQQvEG2Gm8LKWLHAWYfMH47JxaqkGKG3qQBh8C8p3G8nB
X-Gm-Gg: AR+sD13cSswDId4pZL2et54ya3K84yukPWTKmIoXiCXY8g1fApPCJtyuaYc5T6ugW7/
	3MCroVkGRi9Od4vN26GxPuri/VV652d29n/ea4mPPLQSsOyYlqxemU0NH3HFlLGg6iUZdrja77b
	TZrYceu/laRMShk8xgiM20yylou83xUgPc99l8loFAZLfPO36b4AR4R69iBbZKqkesOnuD/8hA4
	HcdQw2YMQC9oUNIU9+x3LYHnmXXMe/r8Zlw4/oCB/VWLbiUWvmZdt7PENTEldSKNyl4Qq29xpdY
	yJfk27dIEhNCOZ6ZYnxnRBukw2jiYUj6BZkzZXtjEGjapmqei+lPKAtOi+L026mL9+GmmJ22vCA
	/DatM44X7Wk6Y9pCgJ0gBH5g1sSO7oTAHszFX1UEHN7/er2427DAnO8aRMH8l7BSg1JrS9ZLE0Z
	ESgz56hD09nhwWVU4GKATEKgcpgqVpVAgRRR4T98bwljF9i81KMP7jRMuY9lpagICoQr1z589OG
	5voxQKyACMYXjsMbh1fjyA+kSuU+9QemsjR+8P6SckRpzj4pRHO+/X36tgFXHYVDs2fQdeXcCF/
	cTws9pQGGHYumK0qg5Tw
X-Received: by 2002:a17:90b:1b0b:b0:37f:e1b6:4c7d with SMTP id 98e67ed59e1d1-395c35ac458mr32281415a91.6.1787502881613;
        Sun, 23 Aug 2026 09:34:41 -0700 (PDT)
Received: from Mac.net (198-27-228-154.fiber.dynamic.sonic.net. [198.27.228.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141860ef75esm17084319c88.7.2026.08.23.09.34.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Aug 2026 09:34:41 -0700 (PDT)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Peter Rosin <peda@lysator.liu.se>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ahmad Byagowi <ahmadexp@gmail.com>
Subject: [PATCH v7 1/3] i2c: mux: Fix channel node leak on adapter add failure
Date: Sun, 23 Aug 2026 09:34:36 -0700
Message-ID: <b3e46bbee781b3cb4029aca9a71316cc5e36dc17.1787502619.git.ahmadexp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1787502619.git.ahmadexp@gmail.com>
References: <cover.1787502619.git.ahmadexp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i2c_mux_add_adapter() takes a reference to the Device Tree channel node
before registering the new adapter. If adapter registration fails, the
error path frees the private data without dropping that reference.

Release the channel node before freeing the private data.

Fixes: bc45449b1444 ("i2c/of: Automatically populate i2c mux busses from device tree data.")
Signed-off-by: Ahmad Byagowi <ahmadexp@gmail.com>
---
 drivers/i2c/i2c-mux.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 681a201c239b..68a4c34b5987 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -408,6 +408,7 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 	return 0;
 
 err_free_priv:
+	of_node_put(priv->adap.dev.of_node);
 	kfree(priv);
 	return ret;
 }
-- 
2.50.1 (Apple Git-155)

