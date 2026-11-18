Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794998999;
	b=nJFC3eD8Z5QhFOp0GB1MnWGPBbQ0C1I7M0tQCS3uEIbQuMfOKbdRZqawJXFi/smEIveD
	 sPjE2d2HoaxVtyHoDjirfbBxv6R002iaOCq1aGSsz8P2pZID+SbPawTRA70zVAIclPLRq
	 wefWr7VPt8k2uopKt0uxVcJ+FzC0VmdNN+rboTAOGBO7EU1IHcqI1tFtH6H+boaK3gDcE
	 0Y7F77neTTzwfmE7LHnaegz/lDEYhLxeRSHZKIabTnV0L7kcmANCPyyJgbTu35VGc+FA+
	 tcOqrqgM6CoSpPFXPysDT6nIoObDeGxptoU9X8EX9cbG2c8Qgaxg4D4a70ZwEnjwKMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794998999;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fimuKL704+w6i+p1mK714enmZrR4sYS+1W8BVN4RDvI=;
	b=V9UmpDHGsPIM0wp84nrtshh3GUvMb2FXpKiV5TxN9GpCvEU3sH9ymUgo7Hhicej/+PAw
	 p0O2XcdwLtZsN9l6+Lc2fH4KA9xBUJEXeeoH1tNBd0fai8GJ5Zbd2w67GFDLuEoDzYNAo
	 EP92sE3BATqCWCEmSsVEM2rvSCqbG/Tax8EClvQE6wJoaL8l/m/hdKhtWxf2tIPmsJyTJ
	 Yl7vljV0AdE6NLWE1+9Xjs+2a+z4OHXvO70X6mKjTbhQ6Tsin44NDVfXXfwWrRV/YpqR2
	 igpzfk7QrWQEw1hc6o0OfHpOLkg5YZhwX4PSCdmW+r29BTomfuIOZKUyoagQLnFQhzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IKL+IduS;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB38606A31C
	for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 10:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FB38606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IKL+IduS
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-38318d69173so199376eec.0
        for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 02:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794998998; x=1795603798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fimuKL704+w6i+p1mK714enmZrR4sYS+1W8BVN4RDvI=;
        b=IKL+IduSHt8icXf7vsf/3N8oH0GRw551xT2y5OyDyRsDrs56U7awFNd8EZkpDthz1/
         eDRrSJnXP1k7vbjb8UsZrZpA+ffvyNwT+Tt3CCw8pZtgH0ygFYe0+48TSBouwgmTNp2Z
         slFGSTYqo5XuYigR9GvizeAJ6KuuDlAygGxEZvkq78xFTI4Pmbh7JpwQbC/twyJwRwvq
         e55U8Bq9S4ElelkYANd4q1J9Bez+nTvgItPm77Fe/vfv8fk419ChNyq8uM1wKc0N7K02
         ToHEJmbh5Zn+9h7HJV6DoNur+YgtCkU7boryD5EZuJLQvyH/Ul6frjivPmWr9EOgzKnH
         +PFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794998998; x=1795603798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fimuKL704+w6i+p1mK714enmZrR4sYS+1W8BVN4RDvI=;
        b=FOfxwNLCUjqqdVaDSJlsQ3Gh81e4/Mo/X9zfQAcYHL1sH4Fyzwb+mB1wpWtfaZF61+
         N+4bJZ0aKJF+yQDXoqw5i064rNa3lcUZL1KMh41hPU1lP2B7jysBsieuZLqG3/L+f9gr
         MFsBXu2iooLDuOH60ZBuSbGl8mkY7LaAueopWUfjoWfnAC/cKRf+G9R/ff7ksJJyPPGn
         PvMmTyJIJ2BtEBGqyT7mApKEEWkOn8t/WLorUl3rLi349G4FvJ3eZm2Pha4TPSYljDan
         +S+ynOkORfAzijIHP0Fi99Rd70ncOIzwaEtTHp8g4MwVIjs1gxm0geD8SDcmvH4788Sk
         PSdQ==
X-Forwarded-Encrypted: i=1; AL+hErEFiEFEDqs+fV274tUTGOsXmm4E144Ef3nK5BzIvO6/jfzFOqx9C4+XS5eMwejNvrfuO3GdrVBOlUU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+v//FaJn6+ozFMo64rY+FhK/cmPkTBJykY9zk3yykVx41rwHwc
	HhrnNvTSuT0Uy55C93Td9JXnz/mOFLLNcKIkq90bDwq0u0gvRoKXoMmv
X-Gm-Gg: AZFdTZeCthTz3AcUKnVHCWmV6Ji6z39qUEbnQdcv7PKsg4/NDIwXWm2XePvK4+g9z+q
	/7b8BoWUpMU0OKrPidDAryTR26A48Wh4UiwAA/G46ZOrcHHAPrbbKp1jUTO9wYbtGvxfJpTR6PF
	YWzWGCVQC4Qd7q5mkObWQqDqI2JV9y/Np8heiaHYLICWqmoukCIxFJr5AR7+k7p6fCDiVez3X49
	ysarEPjd7488tOU+OyDzp9dWUjICL+rDp6qegDMQ8W2PS+jyrawdCVQbnUsNltZ+c0kWUv2S9An
	R3sinc34oAK86CIK7eaHa0zjhYUeZXCIpC9FwVp3+HUtfGoZXXbLwKmLhT6lSxl4LDeft5fmu7p
	7Lnj0ZTdUG+HoW4lENKaNMB+73mYsRQSxbOQmwv5RxNsj5VuX5QzpABCRBJ+nymSrxvurOOorG0
	K5cJ8Io6JabcTYq8HohDkLjzfBvZ2hg1RePon7mOz6mLwul8qlCwYlW6Q9HbG9HlIyWYwmHDIxf
	X3EEodNUv9WyTv9+Xhn1uhdBxnMfsU7Gjr2cqGWv9/M752Bx9Hq4Shv/o9VeW3xOxZ07gYC5IGI
	+lL6RZu1G1Vfs6t+jRazCugR7D/30CuM
X-Received: by 2002:a05:7300:d088:b0:381:a911:1772 with SMTP id 5a478bee46e88-38281215ba2mr2333979eec.22.1794998998227;
        Wed, 18 Nov 2026 02:49:58 -0800 (PST)
Received: from archl-rock5b ([45.112.0.182])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a45260a8sm11729913eec.3.2026.11.18.02.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 02:49:56 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>,
	Aurelien Jarno <aurelien@aurel32.net>,
	linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	linux-i2c@vger.kernel.org (open list:I2C SUBSYSTEM HOST DRIVERS),
	linux-pm@vger.kernel.org (open list:SYSTEM RESET/SHUTDOWN DRIVERS),
	spacemit@lists.linux.dev (open list:RISC-V SPACEMIT SoC Support)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v2 2/3] riscv: sbi: Register SRST handlers with firmware priority
Date: Wed, 18 Nov 2026 16:19:14 +0530
Message-ID: <20261118104935.1716-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118104935.1716-1-linux.amoon@gmail.com>
References: <20261118104935.1716-1-linux.amoon@gmail.com>
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

The SBI System Reset (SRST) extension currently registers its poweroff
handler using register_platform_power_off(), which assigns it a lower
priority than the default PMIC poweroff handlers.

On platforms where OpenSBI handles system poweroff, a PMIC handler may
run first and perform I2C-backed regmap operations in atomic context,
triggering invalid wait context and scheduling-while-atomic warnings.

Register both SBI SRST restart and poweroff handlers using
register_sys_off_handler() with SYS_OFF_PRIO_FIRMWARE. This gives firmware
handlers precedence over default-priority PMIC handlers and avoids
board-specific workarounds in individual PMIC drivers.

Defer handler registration to a device initcall because sbi_init() runs
during early architecture initialization, before dynamic memory
allocation required by register_sys_off_handler() is available.

Preserve warm and cold reboot selection, retain the existing legacy
poweroff fallback, and report handler registration failures.

Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Suggested-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
New patch:
   Link: https://lore.kernel.org/all/20261110061429.2036-2-linux.amoon@gmail.com/
---
 arch/riscv/kernel/sbi.c | 43 +++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index af1ccea222f1..ab6e5bf25411 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -512,23 +512,50 @@ static void sbi_srst_reset(unsigned long type, unsigned long reason)
 		__func__, type, reason);
 }
 
-static int sbi_srst_reboot(struct notifier_block *this,
-			   unsigned long mode, void *cmd)
+static int sbi_srst_reboot(struct sys_off_data *data)
 {
-	sbi_srst_reset((mode == REBOOT_WARM || mode == REBOOT_SOFT) ?
+	sbi_srst_reset((reboot_mode == REBOOT_WARM ||
+			reboot_mode == REBOOT_SOFT) ?
 		       SBI_SRST_RESET_TYPE_WARM_REBOOT :
 		       SBI_SRST_RESET_TYPE_COLD_REBOOT,
 		       SBI_SRST_RESET_REASON_NONE);
+
 	return NOTIFY_DONE;
 }
 
-static struct notifier_block sbi_srst_reboot_nb;
-
-static void sbi_srst_power_off(void)
+static int sbi_srst_power_off(struct sys_off_data *data)
 {
 	sbi_srst_reset(SBI_SRST_RESET_TYPE_SHUTDOWN,
 		       SBI_SRST_RESET_REASON_NONE);
+
+	return NOTIFY_DONE;
+}
+
+static int __init sbi_srst_sys_off_init(void)
+{
+	struct sys_off_handler *handler;
+
+	if (sbi_spec_version < sbi_mk_version(0, 3) ||
+	    !sbi_probe_extension(SBI_EXT_SRST))
+		return 0;
+
+	handler = register_sys_off_handler(SYS_OFF_MODE_RESTART,
+					   SYS_OFF_PRIO_FIRMWARE,
+					   sbi_srst_reboot, NULL);
+	if (IS_ERR(handler))
+		pr_warn("Failed to register SBI SRST restart handler: %ld\n",
+			PTR_ERR(handler));
+
+	handler = register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
+					   SYS_OFF_PRIO_FIRMWARE,
+					   sbi_srst_power_off, NULL);
+	if (IS_ERR(handler))
+		pr_warn("Failed to register SBI SRST poweroff handler: %ld\n",
+			PTR_ERR(handler));
+
+	return 0;
 }
+device_initcall(sbi_srst_sys_off_init);
 
 /**
  * sbi_probe_extension() - Check if an SBI extension ID is supported or not.
@@ -677,11 +704,7 @@ void __init sbi_init(void)
 		if (sbi_spec_version >= sbi_mk_version(0, 3) &&
 		    sbi_probe_extension(SBI_EXT_SRST)) {
 			pr_info("SBI SRST extension detected\n");
-			register_platform_power_off(sbi_srst_power_off);
 			srst_power_off = true;
-			sbi_srst_reboot_nb.notifier_call = sbi_srst_reboot;
-			sbi_srst_reboot_nb.priority = 192;
-			register_restart_handler(&sbi_srst_reboot_nb);
 		}
 		if (sbi_spec_version >= sbi_mk_version(2, 0) &&
 		    sbi_probe_extension(SBI_EXT_DBCN) > 0) {
-- 
2.56.0

