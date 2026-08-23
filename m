Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274DA3D3488
	for <linux-i2c@vger.kernel.org>; Sun, 23 Aug 2026 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787488403; cv=none; b=n6L6eRZUTFe83aB+8GG3iG3o4zVvpRIzEXQI4jJGC/Jv61cVRYV8sTwn1g9LwXZHuk0z6tySn/u+s6ETg0B1QFIFCmQnAtZfxUsBQZ593zQ0ZrFmBmd89vUX9mlbW7H+243puSDXP8KJqc4OEj45K2sYzVJOuFJq+VDrAcNw7OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787488403; c=relaxed/simple;
	bh=eFAek2fTRzS73NfCoH4RA0rIRDbPRNXEUtq0xg+7oQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nq6NuD1VdY/XXwYA4S6X2At8l43FN2pWB8JlZ47qJZ6X/k3ZQ2t97Cq5ltSmDcSftfe8bGZNRax+8/JUJ+5twoDssuvrQ4Cs8TNs/5KpOzLJe3vlQR13bHrMaPNlUJcEni3OPCj9JuJ7sroR8rTKi+exLC09/7nkGxFqrcDtHdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeTMD2ta; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeTMD2ta"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so2656548a12.3
        for <linux-i2c@vger.kernel.org>; Sun, 23 Aug 2026 05:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787488401; x=1788093201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3c/+w0gY/yiLxrAX3Ag3KOv3d/87sKGQ7Sm7A1q70M0=;
        b=TeTMD2taCpTw2tSrAZBuy90DHEA3NxLI/BHi4kVj5sEs0Q62CdMYCuIZ3Wo3PW+HiI
         MJPaTXhgV3SZIJ6sy5Re4g8vnZReXP/RBA73Ycx6b8GHy+hmkuYblowFDdMKuI6eFELc
         hLam8TpB04+31oWPavHJzr033KeJuG0YyoSgoncEmLFLisuNOwThfQQ4FgwSIcTCpOP1
         PqFlg9iVGuaXJ6lZr3/kxGq/Kql/1pBm/fGI+rZV6olfVHzUSsE9GnITKMB54EIbFiwL
         hXqMyefjj3omaLPBGIcDn8CD/+KQ24nmE3hUsPkKurIoE3JmJCo0VPcMXlfT979fNaZ7
         XI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787488401; x=1788093201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3c/+w0gY/yiLxrAX3Ag3KOv3d/87sKGQ7Sm7A1q70M0=;
        b=qWtUDWza6sO6Zg6TefI8RZihZCqhUNsX/KwVc9L5aX8Nn5LW1bVdQaNUz0/4oS7ZtF
         2Crkf/a8Ntgn0iRal3kPv2J51eyUzJZu/JLA9cTYStRP7Ex9NaudG9b+vJ+QiyOh5k8p
         JmZzKIglqNP/OOEitX8vewOzceEoqs8Gd+n3U2w5/d2drlQl7q005Cfj9FulK4VCRR7F
         N8BrtmWesjbGNFdtPaScjqoWbtSunf1/tsDviyK1pPp/vM+MzjD0L+MrAvJd6azV5+NY
         ix0QiyL1e4d85WXIwwFN5A6e5OcyTU+m8odpf7bIjmqYIDvWE9TJsMiqYZorlyYvATFg
         6nIg==
X-Gm-Message-State: AFuF++mu41P5PuZBRSmFlQX8/EQbxr555Ybz4L+3hOBVyEYPMQ0MLlAk
	uIF96+st+chHlBvF5K9wW121iNzViD2xOIhzARQvuXrc49nGoWaqyiSa
X-Gm-Gg: AR+sD10pXcE1vvSlHbF0NQ5yEBA0EKmg4Xefdhu+Mct7NN1qyi/3OTnFor6Gw7Gj33f
	B1GZxfXhQYXlpqmEifdL+EOHvUcl1BXHHgtTT0YjQOnztbF0BhXOFhBw7zacxw7OYofbMpm3Dvr
	Z+fApvNNgdRTs3bHNcA0j8F3yRvbl2KnA03mdL/PHxL0iAULfgB3FWetUuDgZU/9wA+6BvvfgZ3
	ixOjgt2dpRIuVu0dXTqWSqy8HEpYlsnv9S51yYxavzpCX/2Vhf9xI6mkIGYASl47UEx7Z/XLpHk
	DAGqlJprbR02XmCaL9y0AiBdUwtTxidb/SGgUQ7EZZWgmV3QnbyPMCodavvKnGTOyBHq9KQo6c4
	+CP5vb062Reratk79PB2PGKDh/iWCKPCTE2NAwVihDL+Lcn2z3Qrm0NrV3X7NOP9BtR+lex7YoX
	55+6I1NS2MbolQVGSoUdcrWNL6+7mkx8LE+CZ2GV2/WgSXmj71QN+TdB/AyWU98/X1694=
X-Received: by 2002:a05:6300:220c:b0:3b2:8685:1473 with SMTP id adf61e73a8af0-3cd2fdd9b4cmr38342943637.7.1787488401490;
        Sun, 23 Aug 2026 05:33:21 -0700 (PDT)
Received: from InspironBook ([117.182.103.123])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199e4b1e1sm261058a12.21.2026.08.23.05.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 05:33:21 -0700 (PDT)
From: xiaoyueyoqwq <xiaoyueyoqwq@gmail.com>
To: andi.shyti@kernel.org,
	westeri@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] i2c: acpi: Add DELL0A86 to i2c_acpi_force_100khz_device_ids
Date: Sun, 23 Aug 2026 20:33:10 +0800
Message-ID: <20260823123310.188189-1-xiaoyueyoqwq@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <63cb7f6e-27ab-43d8-adb5-d2f4acd57674@gmail.com>
References: <63cb7f6e-27ab-43d8-adb5-d2f4acd57674@gmail.com>
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
Signed-off-by: xiaoyueyoqwq <xiaoyueyoqwq@gmail.com>
---
Changes in v2:
- Resend as non-flowed plain text; Thunderbird mangled whitespace in v1.
- No code changes.

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
