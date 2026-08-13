Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4460443E39
	for <linux-i2c@vger.kernel.org>; Thu, 13 Aug 2026 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611150; cv=none; b=HnDoczKysGx6Zx+Wo7mmIJGeptfkYsIyGawJw2wlMyhyPrItqYCYA7c0TpksQ2gfhR0IrX53c9+/+Gc/nPCOK/zW//FFi4rKnXmzyynfjYFu1k4feIqFPX4Wvlk+1a9AYVCYh+2eXY88MTVAvhfLvBFvENbKisqMfPLyAK0vA3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611150; c=relaxed/simple;
	bh=FXylZDRS0vL5lJ0dK37QjjyweatES9/jT4f+DeVAPAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A+Oltg7aQGC2pSdt4Xp4QDGWNw29EQlIYsDGx9ERcr/mMU5cZerj/rTFSFHEtxvF1UCUMHLXvlFNZGWzLDkpqBQA7mwWs1YkIqPFe1Yd3RZZNR4D+cDEFXfk/YmcdyXK5UKuhxqhueo3mkGtiT0AfqCrOYiW/faYUKM0A3D0mRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYa6UZiv; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYa6UZiv"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d032846c95so22688355ad.1
        for <linux-i2c@vger.kernel.org>; Thu, 13 Aug 2026 01:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786611149; x=1787215949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C7Nwke+aFQIchgqktAdduXcSR9uk1TvuFvMJwR1VYsY=;
        b=gYa6UZivZhNKiR8TYHSdcxaLCztAza92FffvZEzjzNJpp7bGZ5KMe+0XgniJc8t5Ow
         dxa/Mt7DmyhGAQGYLQ2Xd0ESkVfKL7ua21R1/sqbhSO5ItXBoZWSnPV19ZzS0wbVnefu
         iJS4CrUZf2LNdz8brjr6kC5RUfsHrUZIAZgVnbWzF2Q+j2rzmWu2XQqROpLf4RYuIIki
         gLvcZL3uN024n7dJnrpeS0MD+PAIwi8OWVe0p0Mq8RUepCTbV0hKLreQyB67nU9tsyDY
         InfUpoXBMderENIDixhPe87JbVDHDyn2P7INVouTPnzjGeRgEMJWszOO+2yTV9aznBo9
         JAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786611149; x=1787215949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C7Nwke+aFQIchgqktAdduXcSR9uk1TvuFvMJwR1VYsY=;
        b=XOygx5KIQ5kZKIYxPnNPUdOgxRSYwRmmHOx7IUizTovmXRYS0CYCmkRxYbmNt+a6gJ
         iga/hJMKW7rJg4tdkarISoUeaOUa1Cj9wXX/2amLJ4KfvnZl8U83aNUjenYaXAx0X8zX
         LEyRpHanAW95DDd75HISIKu6Shoyx2OJuHlcT8g3SFO0qdRwuenNKwY7unEUdYLbYssw
         L4vSyHxMtl9zMK6R63OdgDBh4MBfi2T9SrZTfUmIMtn3Mv2UGUFGt++/7pAM81BiRgnO
         ewy9tbZGLSSJU9nJepBiziTZk6dB4dj8gJLv+KyfNOExClo4g9L02CSYMtGLqircUF2Q
         S9XA==
X-Forwarded-Encrypted: i=1; AHgh+RqGfK/mU2S/FqoP/2/73GRLzsjq+kt+uXWt6gocnajYH2xDHL/zaIEcF/IFaPF3PTbNuWIhvMi3rvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzboDTspCSaG9+l2opZQUh8Zz/i5l2X9AZ3yx3i4EWG6ew9mWQ0
	Bvk92cUQ8TqqKaXIstlheaZUHK1mOx+my0pxwqxwrFHv1LHp9DnVRxMo
X-Gm-Gg: AR+sD11iBCmaoimHUM480wVuEDzuSRfS3Mc9af+Ga2ox7TtnUcNr2tMfy2dyG+CxL3S
	Tb8TzycXLeNUxSiraAsxq4/2K0W3TOCzdkAkuJKrpsdMAfcqDLEo11tdaiUPMdrr2PVMo1phu8+
	QoPyqxTJm70v23Am7NRuSz8yb6+n6FcUzkAzd40Bo+2HbXH99SeaGKwYD3OGDhxXqPn255v66By
	04D129tjq/NwsRCMvXZkxW/1uWDcGPBus6NCJpUPdel0ujb5w3UYJGftw7Mf2UMMKbZ5rzuRVzP
	Ugn3PxuhTfQyhgtL+bBG1gZD62JQbhwwFTzAUkl/uLPsBKFaF1ey8/NthMaX66Q08O7MTW42U+i
	vTSplzzK1Sfprs74UwawV+v46Y1lsPDbeiyv7ytSZR5i1/pEkbvZ1Ff56vsfNDCDC8wipQAZHHJ
	0DsLAPZjVE17vBskpPbhXKTBNBgp6HD+4ATqo63oW/2/ZFb7RUT/3dzH7c3N4TOeSp2H5MIyW8k
	zcnu5NlDlUfB8g/cDWZDewcNxZVP60EbUCeYV+rEBBPMQwciLyeZC1sAK/wT8DggXAh97pPHleK
	Li6q
X-Received: by 2002:a17:902:ce8e:b0:2ba:6518:a6d4 with SMTP id d9443c01a7336-2d37ebb3240mr41449645ad.20.1786611148883;
        Thu, 13 Aug 2026 01:52:28 -0700 (PDT)
Received: from phuc-desktop.. ([14.160.25.72])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ec0223e31sm5465372eec.25.2026.08.13.01.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 01:52:28 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Kamal Dasu <kamal.dasu@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-i2c@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@kernel.org>,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 0/3] Handle optional IRQs correctly
Date: Thu, 13 Aug 2026 15:52:10 +0700
Message-ID: <20260813085213.44001-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Hi all,

The changes were found through code inspection while reviewing optional
IRQ handling in I2C drivers.

I noticed that some drivers already handle the return value of
platform_get_irq_optional() explicitly, including i2c-designware-platdrv,
i2c-ocores, and i2c-sh_mobile.

This series updates the affected drivers to properly handle errors from
platform_get_irq_optional() and distinguish a missing optional IRQ from
other errors.

The series also fixes the handling of IRQ 0 in the brcmstb driver, since
0 is not a valid IRQ number returned by platform_get_irq_optional().

The series was only compile-tested.

Best regards,
Phuc

bui duc phuc (3):
  i2c: pca-platform: Handle errors from optional IRQ lookup
  i2c: brcmstb: Handle errors from optional IRQ lookup
  i2c: brcmstb: Correct optional IRQ handling

 drivers/i2c/busses/i2c-brcmstb.c      | 6 ++++--
 drivers/i2c/busses/i2c-pca-platform.c | 5 ++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

-- 
2.43.0

