Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD272471264
	for <linux-i2c@vger.kernel.org>; Fri,  4 Sep 2026 10:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519025; cv=none; b=fK5EaG4RiCQRN4fXcQL9GvbUCCBLVs61wG1zSLZzpFu9aBiPUA1uz4PBLKYEjjofQO7suLtF4A+PY3qziXXdQLSCK/VXiYXmKRajUq8dbgY+8cQV8JNhnOkXh/SEkghgdGcGCC7Y0vugV6zYqKKh/DZnisTueVP+GxMIKqDvkVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519025; c=relaxed/simple;
	bh=cns+cFeR45F7QjQxLtzp9V9ghZwVMWKETKWU6WYz1WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jeb5I17LF5GzeIAZMFG/2t9W8rNSmbEUZetRgQeuzjFqOymHFWmKqTVjbln23Eu07T6tYjvolmfrYZlU3m0acyBNqmZwZkl89AhdbsiqIqE5h+qJh729bK+ETHu+xKDXWLDpH+MQ9vLOrQn9TlOXNGZxi9oC+zWhd9OjHJ2XXjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWwn0QyM; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWwn0QyM"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-39682983a0fso905060a91.3
        for <linux-i2c@vger.kernel.org>; Fri, 04 Sep 2026 03:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788519023; x=1789123823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JVe3j7HRHHIhbvIbEK+C2SoCEY61/0kcnS4nfccAWlM=;
        b=HWwn0QyMlbfCOWLi/UhulGU1ZM8UyEmQgtUt9vz0TVTgyAyWBjJp2WHlENuiceDjKK
         NsWAaDbV0euMphyg6G4FV7Qyc1URCiRbQnBbJcQ6noWXRgS6hI9p58hG4/JXClnBAvID
         dsIL+c+zf5dWAktW91A9rFUQkcM+TRHuZNW+s8tgaww8vYZHMgbFPtd7QHQDLU7pByxy
         bKQj8vDkJ5QcKN0JlvxDF+ebmDkYV7fL3avlTwlmMO+B8U+BvWaQdhSG3ZyUKSPH1lB5
         5dOK0RTG9vy3Tj95z4ltYpUDeqgwaA1BG+cA6DG+sLanDe6jrsf/OtiJrJOufZhW8vQm
         E0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788519023; x=1789123823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JVe3j7HRHHIhbvIbEK+C2SoCEY61/0kcnS4nfccAWlM=;
        b=kMMEuEttxvhH86B1G+mIwDo4fkwUusaXEljBcHBVfxNMTnvM+Q0mYDl2xdjk3S8jbH
         qsf+3lXXKCF5sbgaumvY1kwpJPhOrDsvBXrqcxFmaiAciKp6Nxmv0EEPabXyE/Vl0gDG
         9xTQn0daez7CMehp2thotA8RO0XQ8VWeeQk4tZwlCBjFdegVAOUqJqG+gvUC+PySq+za
         PDPpY5QuARZdOlMvl/9ilelaKapuIZjWRHrMpkHgq94Utn96m37ELso4KUUJysFLuoQE
         kXSWvSlt0u4UMHYJQh9EdkbzWCPwtLtQb7fskoJ7L8LPMAmdL7VT1lywQzORblxyf6Dg
         vIyA==
X-Forwarded-Encrypted: i=1; AKwUvBxqqh7kDLULBSsDyusn4X69DB+sPb2MTmx4mbj3hflOyJdwJD1xqJQ7Rz30iMOqi+I59u7OUXirads=@vger.kernel.org
X-Gm-Message-State: AFuF++lYERJ1jSD0Iu4GhLJmOfiX6P1UKq5hX5ofRZFg+r0MrUqI1/81
	SMsj5x19E+JLiRQZminDTAZXiWB5XkR4MWh03JtXHnC71uLDA3GQjxGP
X-Gm-Gg: AYBFou3XRI/IdvSKTS4OpnECPNq7X9Kyah+IeYa0VD3UbwhaW1ARl3zUQEIPqyHa+Ml
	cHUbsxfbExRJ9i03oObsLRcM6eiTgkatF1RFsYpTUHLY5TxcWSFF69N4DE5qF4dGNP6wTYvTsbQ
	96N0/QayR60dj00rk+c+4KgzA0f7ET/JSm+c4W7H7VvwYXGsb0USybOyUIO3Nr5ehMxpOmnQtUw
	9NrWng0dh0/dKq7pjwBJ9h8N2J9UbjMVyVnXaeNLOViS/2+DS+zEZYl+7tIscCPtZsp2/2wQkXd
	a/+5dzYz0FZVN8CiXyPrKvLOVsBaZqQNwv1wsILQLr4xCelxRWNUwk/CJH4DlVaUZbmpyPU4llY
	9E8B/Fy+iGarLBvL/ICII/EzZo+If7d4GIZPQ01RNBN5mXmjYC9e6Av+BUA32Y6LJQXOclhm9Zs
	b2VEXGIJWpLNLfmYloFHsGhR9StlcXuHPycfKgeb56V6u34M/XU9OlRgSf+UJH5iOUrtW5ZOjMR
	aOO1MB71cZZsC8=
X-Received: by 2002:a17:90b:3912:b0:398:c724:1bb1 with SMTP id 98e67ed59e1d1-39b26101524mr6786890a91.8.1788519021437;
        Fri, 04 Sep 2026 03:50:21 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b608409sm6421454eec.21.2026.09.04.03.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:50:20 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jochen Friedrich <jochen@scram.de>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] i2c: busses: fix typos in comments
Date: Fri,  4 Sep 2026 16:20:07 +0530
Message-ID: <20260904105010.27405-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904105010.27405-1-hemanth.selam@gmail.com>
References: <20260904105010.27405-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/i2c/busses/i2c-axxia.c    | 2 +-
 drivers/i2c/busses/i2c-bcm-kona.c | 2 +-
 drivers/i2c/busses/i2c-cpm.c      | 2 +-
 drivers/i2c/busses/i2c-st.c       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.c
index 0555eeb6903a..62dc55c146f0 100644
--- a/drivers/i2c/busses/i2c-axxia.c
+++ b/drivers/i2c/busses/i2c-axxia.c
@@ -60,7 +60,7 @@
 #define MST_RX_FIFO		0x44
 #define MST_INT_ENABLE		0x48
 #define MST_INT_STATUS		0x4c
-#define   MST_STATUS_RFL	(1 << 13) /* RX FIFO serivce */
+#define   MST_STATUS_RFL	(1 << 13) /* RX FIFO service */
 #define   MST_STATUS_TFL	(1 << 12) /* TX FIFO service */
 #define   MST_STATUS_SNS	(1 << 11) /* Manual mode done */
 #define   MST_STATUS_SS		(1 << 10) /* Automatic mode done */
diff --git a/drivers/i2c/busses/i2c-bcm-kona.c b/drivers/i2c/busses/i2c-bcm-kona.c
index d4f287b31fd7..0c30821e7b0a 100644
--- a/drivers/i2c/busses/i2c-bcm-kona.c
+++ b/drivers/i2c/busses/i2c-bcm-kona.c
@@ -12,7 +12,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 
-/* Hardware register offsets and field defintions */
+/* Hardware register offsets and field definitions */
 #define CS_OFFSET				0x00000020
 #define CS_ACK_SHIFT				3
 #define CS_ACK_MASK				0x00000008
diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index 2cb6a233d313..c8b72f14d179 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -334,7 +334,7 @@ static int cpm_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 		tptr++;
 	}
 	/* Start transfer now */
-	/* Enable RX/TX/Error interupts */
+	/* Enable RX/TX/Error interrupts */
 	out_8(&i2c_reg->i2cmr, I2CER_TXE | I2CER_TXB | I2CER_RXB);
 	out_8(&i2c_reg->i2cer, 0xff);	/* Clear interrupt status */
 	/* Chip bug, set enable here */
diff --git a/drivers/i2c/busses/i2c-st.c b/drivers/i2c/busses/i2c-st.c
index 0a2b43b5577b..873ce2f5a406 100644
--- a/drivers/i2c/busses/i2c-st.c
+++ b/drivers/i2c/busses/i2c-st.c
@@ -256,7 +256,7 @@ static void st_i2c_flush_rx_fifo(struct st_i2c_dev *i2c_dev)
 static void st_i2c_soft_reset(struct st_i2c_dev *i2c_dev)
 {
 	/*
-	 * FIFO needs to be emptied before reseting the IP,
+	 * FIFO needs to be emptied before resetting the IP,
 	 * else the controller raises a BUSY error.
 	 */
 	st_i2c_flush_rx_fifo(i2c_dev);
-- 
2.48.1

