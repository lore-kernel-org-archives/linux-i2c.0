Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A181422576E;
	Sun, 30 Aug 2026 04:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788063288; cv=none; b=vFMVoAKqHP2fABVlzco+aqr1OYiwkgU6lAOl4EtFMFsrqKoU0eqHZ9IceKPGgWTq5w5tEUc4FrPVnJvc5Wzii3CO3IbMx9VV8g7zU0cyBexCY2+RlXYCWqzDXRMvCq36WGqdxuo8b/16rE8I3bDi5N1sLN/qjU4Kf05zFs2K0hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788063288; c=relaxed/simple;
	bh=JgLmuNqOABMCr5GDys3TUduok5ZAV7xV1C131vSQDKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMdiMV6Rpdzm0LK4TmxEQuQ9b/5vquWeys2j7OTOgcSWHKASY1ZnX+nrg1UYP0zJbErfL7AEeWoE99GpuMzBskRrnDNBDpjFMQDGCDH2wA6WtGuDYmy2j8TksroFLHKRlUZTVJRJd6I0c5OQsZtYQTrVOHoENPy6UB13iIyg3Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=k3Krpgma; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=k3Krpgma; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=sJfsMnJU; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="k3Krpgma";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="k3Krpgma";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="sJfsMnJU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1788063279;
	bh=JgLmuNqOABMCr5GDys3TUduok5ZAV7xV1C131vSQDKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k3KrpgmaRywQXrvgGMKHwOwfKX8jQvPf6UqL0JDbtNs0WJ0FnWD2uszVmztasTBN6
	 6vAQ9ipzZmyKbUxKUoR/XN2qm5W+ZBSeFVUbrZezCOmej7NII7oBJFq8b17uO0MH4l
	 VMO4l8d9fN72qH1Y5rB5ct7DVaWdLUKPIbv64rwpfDuOA1bDvWFJrZpt0XTTOz+dIk
	 aNUPZZLzBBQc6ablkOyh4hR3Ouc7UsrKoNeNsN8m9eDGs4UdhDsdFvIBfWj751zlPd
	 4lC7EaaryViolyuKanDEUQ7KGKoTMJMlwxKK+M2Y61L34Hj13AyW6XK+58XsPnE9v0
	 zmh0DgjpsPTmA==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 95FEF9A7C;
	Sun, 30 Aug 2026 06:14:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1788063279;
	bh=JgLmuNqOABMCr5GDys3TUduok5ZAV7xV1C131vSQDKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k3KrpgmaRywQXrvgGMKHwOwfKX8jQvPf6UqL0JDbtNs0WJ0FnWD2uszVmztasTBN6
	 6vAQ9ipzZmyKbUxKUoR/XN2qm5W+ZBSeFVUbrZezCOmej7NII7oBJFq8b17uO0MH4l
	 VMO4l8d9fN72qH1Y5rB5ct7DVaWdLUKPIbv64rwpfDuOA1bDvWFJrZpt0XTTOz+dIk
	 aNUPZZLzBBQc6ablkOyh4hR3Ouc7UsrKoNeNsN8m9eDGs4UdhDsdFvIBfWj751zlPd
	 4lC7EaaryViolyuKanDEUQ7KGKoTMJMlwxKK+M2Y61L34Hj13AyW6XK+58XsPnE9v0
	 zmh0DgjpsPTmA==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
	id 6BE349BAB; Sun, 30 Aug 2026 06:14:39 +0200 (CEST)
X-Spam-Level: 
X-Spam-Score: -1.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1788063276;
	bh=JgLmuNqOABMCr5GDys3TUduok5ZAV7xV1C131vSQDKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sJfsMnJU/0xjWImynALsGv310MT1rAo8pkyd+/cEpMJXArqdq4ff2L3pj7neZ4hsX
	 PdpHtoFWBPBPHwLuc1c/mAs59EKXTFUQKbXfC+iYPMrwcoW/nXajuz2DaygRZgl7Vu
	 oTX82Vxh6tpshYLZIwme+3Z1vKVvUXIL1dssp3vodLWrdKcjc9DTC75Az73KJaPQev
	 +YKsTuXkukYYRT5QwKcMBcKNqCZQb7tQx9ncQH2IrdnTlCkflbWDEAvM9+aY/ugyS6
	 yWazBG7X86KYN+BGzFKhaJ+/aAi6dIiWvArmKX1IZjm3pqRy+q7pTZ3Fheohz76wUR
	 iaLGmhVZdPdXw==
Received: from gryt.home.arpa (81-225-28-11-no2391.tbcn.telia.com [81.225.28.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id C25789B32;
	Sun, 30 Aug 2026 06:14:35 +0200 (CEST)
From: Peter Rosin <peda@lysator.liu.se>
To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: falemi@asu.edu,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Rosin <peda@lysator.liu.se>
Subject: [PATCH] i2c: mux: avoid WARN on benign symlink creation failures
Date: Sun, 30 Aug 2026 06:13:03 +0200
Message-ID: <20260830041303.1934825-1-peda@lysator.liu.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CA+0ovCij3QDLRzt8CwpjBy-BbJ5Zf5SV9w9QZXz8uD3Agws31g@mail.gmail.com>
References: <CA+0ovCij3QDLRzt8CwpjBy-BbJ5Zf5SV9w9QZXz8uD3Agws31g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

WARN() is a bit harsh and causes a crash for panic-on-warn users. Degrade
the error reporting to ordinary dev_err() calls.

Reported-by: Farhad Alemi <farhad.alemi@berkeley.edu>
Link: https://lore.kernel.org/all/CA+0ovCij3QDLRzt8CwpjBy-BbJ5Zf5SV9w9QZXz8uD3Agws31g@mail.gmail.com/
Signed-off-by: Peter Rosin <peda@lysator.liu.se>
---

Hi Farhad,

I assume this patch helps?

Cheers,
Peter

 drivers/i2c/i2c-mux.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 681a201c239b..52cd8cdf2307 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -393,14 +393,18 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 		}
 	}
 
-	WARN(sysfs_create_link(&priv->adap.dev.kobj, &muxc->dev->kobj,
-			       "mux_device"),
-	     "can't create symlink to mux device\n");
+	ret = sysfs_create_link(&priv->adap.dev.kobj, &muxc->dev->kobj,
+				"mux_device");
+	if (ret)
+		dev_err(muxc->dev, "can't create symlink to mux device\n");
 
 	snprintf(symlink_name, sizeof(symlink_name), "channel-%u", chan_id);
-	WARN(sysfs_create_link(&muxc->dev->kobj, &priv->adap.dev.kobj,
-			       symlink_name),
-	     "can't create symlink to channel %u\n", chan_id);
+	ret = sysfs_create_link(&muxc->dev->kobj, &priv->adap.dev.kobj,
+				symlink_name);
+	if (ret)
+		dev_err(muxc->dev,
+			"can't create symlink to channel %u\n", chan_id);
+
 	dev_info(&parent->dev, "Added multiplexed i2c bus %d\n",
 		 i2c_adapter_id(&priv->adap));
 
-- 
2.55.0

