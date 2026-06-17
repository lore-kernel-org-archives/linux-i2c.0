Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED4E3783A1
	for <linux-i2c@vger.kernel.org>; Wed, 17 Jun 2026 19:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781724385; cv=none; b=JzvXFoQcBIdAozTogyWqsGyVO401SrW7WCXobDAGGrXIPm2MWbyp5znVPD5hHBFOZfajKWRN/g+5aAMKqgHKMFVXhRPdXaucmS9jp8V62q6kDQ7n03w8m6rmJuHbYlSS2ryfMAT3974TDhex3elgDjz5DOtY4zMJRlSJNiDtjDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781724385; c=relaxed/simple;
	bh=BnJsZ3WPeYkFpre/Cn9M9pKYLILCB8cVCrvC3ptA2xU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mQ8SJxhxeUQBhbR44BddCrmOwrUjFDEAxnGE1GAumwou9P3blqXLjY5MyhCV/1gz0mhpl780XFaK+nG8JIX0BuV56XnZORzviuRowEJWnytCR67NmZxWRLG9dmTqH5+s8cyOfrBnZroqxp3ePM1dY1nQ7YoIOys32lf8AroCE3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keXioTKe; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keXioTKe"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36b9d265355so52359a91.2
        for <linux-i2c@vger.kernel.org>; Wed, 17 Jun 2026 12:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781724384; x=1782329184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yk/1s0jRwJ/lH49h6qFUiwiCHB6wHO1/Mh9K9iHW+No=;
        b=keXioTKeSXwyvHSRiqEZGALNk5GNi95ahC7GilG4zzXgJ8AlkFuGQhzymcKsDTgCb8
         n2fvXoJfdEaoza0plhENgcgmA+GbAi8ObU9PDVyga+Le5+nBm3t4woygCsR7Tvrgzhms
         6bAuBYdBEUJP/wcSVwuJCv4yOIi1WwnPBT6E69y4gDC6A9mFx7WeXFbboP5XbSFzog5V
         Z6hTthK2J1NDn/FLte7Bfl+dQbyfxZifzi5O9MxDoxGxTT/FttlQw0Xva8li2hZfBgBS
         Ce9eZ1Bx+3hfUnZBguiDiEw/LcyU9ajooMnZU6TIHPB60++wG3lGGtScNrb3RZwwOg1f
         vsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781724384; x=1782329184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yk/1s0jRwJ/lH49h6qFUiwiCHB6wHO1/Mh9K9iHW+No=;
        b=qtOxqS4C7V4GEozIomaS9ZiiSFSRg/mqyZimGM335z3zB0JXRQ2MR0b//fRCRovwx9
         LvCXXpDNC3ybf7bEguaVL3F+pZ09ViHj0WJdnnEzeVnAeKEQDOxNv5E6dB1y25ELal0A
         mH7CV93+kBNYR4llsVLgt7bbEw6BuFRQh33kM9HeilrFfcDFCLd0r0K5wRFtAgkvp4nn
         12MVBTetLVq2CxD4+axkK+1sdkJncVr+XVU5O2Qi5heG9Et5neDFyH7wSOOsupvSpz9l
         T7SGc3yYuByYSDewR1E/fL1tnr+TZtEkBvVqtPM9MG1i2+xE2Kl39KwOZ6f36kGjmnVW
         fqCA==
X-Gm-Message-State: AOJu0YyONSdeHp1J2HFhFEbjl0ucGcQwE8+QEzUADaUT9Ve2VHm/RXud
	ZNktcx7LDat6UwAatQB+ls/kMc8Nh9jlEJUgBZkyUVV8bqvBwrS24FpO
X-Gm-Gg: AfdE7clWAhtjJQhbK6atN41YewtjPl09fGD4qJD4Iq5YFERJ77EC1/YLASg88Tz8hXW
	4gpkoPqQVPOGqSPFd4XtK5VHnnaTsl/+DUvr5CvIzkVF86/kp/zyUBaOuq4dXm3/BRaQ78DIbzO
	yQcM0FhM7gMZw9KkyzuuhMcuPiXM83mXyZ0NAtt7wLuEBLVgrvkIxTmJFJM0TBbdNhdExcb3QVu
	eB69FfIi5L4GoRJbaU4aZOmE43qotZLoMD9hdKj4olTlNhY+LIGRBhOx30u4xVxpV+oToGqVQBe
	lTdyXpVN9p2bE3HpUfUwrLAqdnxlGWmZh/I/+dXdDSLPqbVFrin30umaSNFuVVNthiSK0PD6CPi
	TC/Jxvjmomvra1plHqmPPBtZk0kFIq/o5DMOef+3N2XvDhHvpNA8woXVrE/1yR74oq+PmNLHljm
	iAyQSssY2i6aE=
X-Received: by 2002:a17:90b:2ec5:b0:36b:b9c7:35fb with SMTP id 98e67ed59e1d1-37c9366f513mr5378031a91.14.1781724383884;
        Wed, 17 Jun 2026 12:26:23 -0700 (PDT)
Received: from TarotClub ([117.242.109.68])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c522c3a41sm7000994a91.17.2026.06.17.12.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 12:26:23 -0700 (PDT)
From: Abhijeeth Babu <babu.jeeth@gmail.com>
To: Mika Westerberg <westeri@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: acpi: Force ELAN1300 touchpads to 100 kHz
Date: Thu, 18 Jun 2026 00:56:11 +0530
Message-ID: <20260617192611.125513-1-babu.jeeth@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ELAN1300 touchpad with HID ID 04F3:3104 on the ASUS VivoBook
X513UA_KM513UA exhibits severe pointer jumps and erratic movement when
the I2C bus operates at 400 kHz.

The system DSDT describes the touchpad using an I2cSerialBusV2 resource
with a speed of 0x00061A80, corresponding to 400 kHz, on the
AMDI0010:03 controller.

At this speed, libinput repeatedly reports:

kernel bug: Touch jump detected and discarded

Add ELAN1300 to i2c_acpi_force_100khz_device_ids so that it operates at
100 kHz.

Before the change, nine touch-jump events were recorded, with additional
messages suppressed by libinput's rate limiter. With the bus forced to
100 kHz, no touch-jump events have been observed and the touchpad operates
normally.

The affected system uses BIOS X513UA.319 dated 2023-05-09.

Signed-off-by: Abhijeeth Babu <babu.jeeth@gmail.com>
---
 drivers/i2c/i2c-core-acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index e5fddacae..763743d5d 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -376,6 +376,7 @@ static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
 	{ "DLL0945", 0 },
 	{ "ELAN0678", 0 },
 	{ "ELAN06FA", 0 },
+	{ "ELAN1300", 0 },
 	{}
 };
 
-- 
2.54.0

