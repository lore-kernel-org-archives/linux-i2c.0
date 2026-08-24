Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C022403AED
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 11:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570306; cv=none; b=lftDopifdyfZo1OfNM/qm4YVZTWmb4g4yQ7oX5q4QiLpwYuvenC/Gn1Kg9ZbmjkGgrI7w3M3TLmnPZziP/hx2bdWPWoKd8vh37HxFaEueu1KicxYIxwZp0oeprsXcZ4T7Js1Xb+pwzdEGFF4/lrkdx68AxyuJjzZ99hnSU5VwLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570306; c=relaxed/simple;
	bh=AlZ4vuMUyi2tB5H0lqXUdQkINvZUab9+u/VDyDzWTZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCllulQUtc50Nog0LY3R72yD54zAQlNlnKTAsK+v5+0pMFejSmpz2F/iFofJD7qL359Ax1H4gkKEfIuutJ4hQMSZPIwnOWXlfWtB5DE8lzW2VSS4Yu+kLeGTjWpLApF3urukZKr93mFyV0v7FbOS/iqYI3Fh/mFNwYER/YtmR7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ojbNSdok; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ojbNSdok"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-848743155bcso1044347b3a.0
        for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 04:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787570305; x=1788175105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PLWAvy8i3HHUYpxrhO29SLzKq3jWCbJeGE8x7BTijLs=;
        b=ojbNSdokyha4Dez9P/t1DJCXZWUy77FFd1q/Ep0mBKz7iqYd21VV40g4m7GykmQ6WD
         sFIYr0IqCcv7NbQZFjugpYYsJO2zN08ZJTjJ2ex2t9aP8sL1oAKkroGxwbKczlltXzX2
         4C7XmDa/DrpYnps732k4jZTeSxtAdLO30u+v8E7odmZYmprBW+pIBDuCCSLiy2ksiF8o
         Cv37+VBYSAdLOZ6pKt09+oeYgHS/uahUdEjMi2ACoMw+e/CtHIqiWJXRbPykt9pNcHL2
         lQdLwEGjlqbI1851avwmmspeBJ73ihgk90wWc6rJJv6LYsAe2dFrI+GeEDiYBM5n1Ti2
         rR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787570305; x=1788175105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PLWAvy8i3HHUYpxrhO29SLzKq3jWCbJeGE8x7BTijLs=;
        b=O4JU3kUEKvKOBX91spq4zSNzgiJ8bnTVXxi3+q+C21HLTmD3SL90G4wrL7jlnI5Uaj
         PFKa69QY1/ScqnDMKrXwXi2fJnzxHdGxxlsg5+/FS0NZJxc22sE8lFXcrG/3G2/yLfky
         Es3gl3M8lZ/avUa+2Ds0UGB/eY5vSdHNLmHTAlb4JuJrOhNjxHGfchEsGmfPcesZGE23
         Zv6AMYc3rWyCQYOUc5LE5mMLmhPMRf0PliF7PM9mgam0AB2MTB/0d7iX8MX08kQzdyYp
         xVmqV26kjVbqWNy8yXNISFdovl9YSjC/gJP/OOAgSql0IPrzsaCPVHi83/J/EwDgiENK
         zk8A==
X-Gm-Message-State: AFuF++nRLP8/8n/nQ1vNXuTUOj7z1fkMOkqn1uyvQGHWARk2SY3Om7Bs
	KCZFrv63JfzU2yOURnZ3P69BEWifHzZ0RpCQTlyewPAi0W/q8Zv2Xd9hsh0md80GQV/Eph9F
X-Gm-Gg: AR+sD11xmME5dcGzWJSdBkcneaKVPz6+DZtPw8xP7/N1SbBSShTy36fgkqS6nBUybpK
	R2SGkmk6JihZy4KHJeoB3nVZ81Zhp9zNEpymz4PoHLvWJBDriwkVTEvNIApPbeJLSr/kTv0347q
	7PHS1pTBrBqP8sR+x7eJKn1oBtD1fRaIM3Y0nBvGxmoLLuX+l2BZ+PAVCpLzz3zB3F93ewuc46A
	GNAClN2mC1gP24HYPNwxBuoC48OOI6CcPPKVUCGQVFy8pu1cJP4f+sES6v3GTuPifcUMC8Gdnas
	pyAFtsjxa4qi8uhMyQFeUI7w8JmKG036ViW3C24tRF7z8njXwP0iGlNkryXJpgUzfTDuZam/n1a
	fxiLy2F9iCXa5iTaTpCnnlyf3LdIU/1ldLGLJo4X8zVwuykqmiu93yEa8lnHRgSyzXuyFbNVNMA
	dVgx2xJBaA7vesT5MWoZ6y7u1bJ0RFVrBSnCO6mycVR7ecAYlPO+anhGABx5znWQ==
X-Received: by 2002:a05:6a00:3a1f:b0:84e:909:ac03 with SMTP id d2e1a72fcca58-851f9a4e57dmr40314129b3a.10.1787570304589;
        Mon, 24 Aug 2026 04:18:24 -0700 (PDT)
Received: from InspironBook ([23.26.139.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199e4b2e3sm868201a12.16.2026.08.24.04.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 04:18:24 -0700 (PDT)
From: YuXin Xiao <xiaoyueyoqwq@gmail.com>
To: andi.shyti@kernel.org,
	westeri@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] i2c: acpi: Add DELL0A86 to i2c_acpi_force_100khz_device_ids
Date: Mon, 24 Aug 2026 19:18:14 +0800
Message-ID: <20260824111814.75242-1-xiaoyueyoqwq@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260823123310.188189-1-xiaoyueyoqwq@gmail.com>
References: <20260823123310.188189-1-xiaoyueyoqwq@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ELAN 04F3:3185 touchpad exposed as DELL0A86 on the Dell Inspiron
13 5310 intermittently exhibits excessive smoothing when the I2C bus
runs at 400 kHz. During an affected period pointer movement becomes
severely sluggish and sticky for tens of seconds.

The ACPI firmware configures the touchpad bus for 400 kHz. Add DELL0A86
to i2c_acpi_force_100khz_device_ids so that the bus runs at 100 kHz, as
is already done for other touchpads exhibiting the same excessive
smoothing problem.

With the quirk applied, the kernel reports that the firmware requested
400 kHz and that the bus is forced to 100 kHz. The problem did not recur
during extended heavy use, including an S4 hibernate/resume cycle.

Assisted-by: Codex:ChatGPT-5.6-Sol
Assisted-by: OpenCode:Ox Alpha (x-preview-f-free)

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: YuXin Xiao <xiaoyueyoqwq@gmail.com>
---
Changes in v3:
- Use the contributor's full name as requested by the maintainer.
- Preserve Mika Westerberg's Acked-by; no code changes.

 drivers/i2c/i2c-core-acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 8f3bdd5..3af0e05 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -371,6 +371,7 @@ static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
 	 * the device works without issues on Windows at what is expected to be
 	 * a 400KHz frequency. The root cause of the issue is not known.
 	 */
+	{ "DELL0A86", 0 },
 	{ "DLL0945", 0 },
 	{ "ELAN0678", 0 },
 	{ "ELAN06FA", 0 },
-- 
2.53.0
