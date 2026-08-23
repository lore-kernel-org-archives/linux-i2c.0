Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08FB38E8C6
	for <linux-i2c@vger.kernel.org>; Sun, 23 Aug 2026 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787486189; cv=none; b=V2+uy/0e5w2fkQI4j0xDuQtdeIbet8IbdVIZXlHkTdD4DrDQjZ63IEXvh6sQxvfHUP8I7uUXw+4Or5GcDPB1/dEHNr+4Ir3GfH/EwVyOXcE0yJLra4xPu2uLE1MtV12G7P3cPCkkfiRYgTciuFLKyB1qPyH2wBYfk+33mdSSTok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787486189; c=relaxed/simple;
	bh=9i4CmNtGZj76Ske03T0miA59Y+t25yQlxECHaxFUx+I=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Jr/oYCh80W+gNxrtzu5taqvYoeTLTT3Iw9gABNbW/vMNbaaErP7aC67APQmZdhvOxm/V//XAZ922sizunSk1eEsec4m0DT8ZewrFLtrB9FcV6b5//iT7JLss+GzFjIUFI2Se5xO3+h++eK+YjDfmaar5ikZ0Uk9c+6FG+TKsNmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arG7UsA1; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arG7UsA1"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso19039635ad.3
        for <linux-i2c@vger.kernel.org>; Sun, 23 Aug 2026 04:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787486187; x=1788090987; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hMXLNsCEJBPVUF9Rtef7lSjv0r0TZUbgwcu2Y8b1UgU=;
        b=arG7UsA1cyfjgIozJntiYtaRKgHAyTJo3S29H44n5IK8aX+wAF4GPZtHbJ73KcnhmE
         6L4i/kgGnSjWxMhcj5p7DgfLmjEL9EkMumHI3nGr37rdQbM0I7TpZykT57NW1NgcwoDy
         QM4qambx1ysZ5CLIxU+WifHTRxLeh5RCHW6Rjmaf+aE9bPABnQ73nd16ue1efVzCspFT
         IZTmqzr6BghEckVHqcMw9Ie09hlHLZxSk7RplciA6EsMigHuuXsa6+ralFN7p4EDPVfc
         ALTZiTWnww3iuwcNNvyiyvSeGijbqVNhuiQUss38Tw7SPjR35QDzfo/H9inwCYQFaX5p
         7lcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787486187; x=1788090987;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hMXLNsCEJBPVUF9Rtef7lSjv0r0TZUbgwcu2Y8b1UgU=;
        b=pA5lg/P/hXKAeWhQ6e0q+xlRHXCGdhRJa+/pY2up2UuEfNpcVn0x4rIBTL2NflG90+
         kd4pd7zR0kyjaWFAlPgFa3+GAsuZqwKDgSFD28u0P6D+e3Vgr+8ODRqjgli3kE6lLPEC
         JUT+VtNR79FqpFVNqfWJvlinaGQOsp4fR99JbQ7u2tm0dVndz4rRmkQENllJxcbeAZHZ
         k6mWLzmyDl4PsMcRH8FzR8/kf5ZQEj8lj23cCCi1umrvTt9vmVL0T3poQJFKhXrLcLl/
         WrG6avthcVrVkc0od6Np+aL96nRF1Gb7GALTKQtEJ76C805vYEWhjcx6C+zWPSkSOicu
         eKtA==
X-Gm-Message-State: AFuF++lpPNllUtjX6i2oLdXNXyCUb53282PzwCyfMZtBFk75d+awAprW
	Nm3KAzqiWbrNFnL//zuBOtswjQfYL82LjRLIZOS7YCtVJlPD5Q/VFPo9
X-Gm-Gg: AR+sD10naCCPEbLcGEYN1t6/nDzXL0vVjv5544eedn5EnD88RkDcFhI/D+Rrg30aIzv
	TYOzVMFABUXA30AnDnG8Rx43l3q4g1YgnN1QxH6l/ofOfx63A8/30TZugLEZjd52UilDFyzrXsM
	ISpst50s6dzoh0z/lN9cxJ/KdWZm4OgJkwG4XsW95mky9mTH2q0akzk1+a4Fm9CGwgnWDsYpS+E
	vKPpttoQ+nIQjn4oLb8xFy59PT9C4Z/FntWxigTSGjBpBZaT3occzhyPmBZPc5x2RGc9Y9dS3r4
	SequZkT2D+l2Mk74N+RAamgEsWCjzD4g20BVSb7JrDdQP4G/SKbTs9Vbu7IjwF/mSWGXaSAouGk
	+F3IU6WRb6F2pKhpGTtbl/lqOq9aojQz9wee7VCwEu2XleVisSjQLhMdrrLp4K5kY3h7IklrvNT
	IEypp9VwrunwlAf1jz2G4ch/CxD5K2hxYy7uXINjCtlpVkhkfvwrs6cloEbfUNsK+j0RE=
X-Received: by 2002:a17:903:1a30:b0:2d3:160b:c01f with SMTP id d9443c01a7336-2d64adce8e3mr358562255ad.6.1787486187179;
        Sun, 23 Aug 2026 04:56:27 -0700 (PDT)
Received: from [198.18.0.1] ([117.182.103.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6768957bcsm9258405ad.43.2026.08.23.04.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2026 04:56:26 -0700 (PDT)
Message-ID: <63cb7f6e-27ab-43d8-adb5-d2f4acd57674@gmail.com>
Date: Sun, 23 Aug 2026 19:56:22 +0800
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: andi.shyti@kernel.org, westeri@kernel.org
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: xiaoyueyoqwq <xiaoyueyoqwq@gmail.com>
Subject: [PATCH] i2c: acpi: Add DELL0A86 to i2c_acpi_force_100khz_device_ids
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Assisted-by: Codex:GPT-5.6-Sol
Assisted-by: ChatGPT:GPT-5.6-Sol
Assisted-by: OpenCode:Ox Alpha (x-preview-f-free)
Signed-off-by: xiaoyueyoqwq <xiaoyueyoqwq@gmail.com>
---
  drivers/i2c/i2c-core-acpi.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 8f3bdd5..3af0e05 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -371,6 +371,7 @@ static const struct acpi_device_id 
i2c_acpi_force_100khz_device_ids[] = {
       * the device works without issues on Windows at what is expected 
to be
       * a 400KHz frequency. The root cause of the issue is not known.
       */
+    { "DELL0A86", 0 },
      { "DLL0945", 0 },
      { "ELAN0678", 0 },
      { "ELAN06FA", 0 },
-- 
2.53.0

