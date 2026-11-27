Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795802295;
	b=PFYkwqTl4uWqzHujsXAdTTRVQM5OUOkMOXrjqtgtHQ63haga34L9Gbl6J0r/oP5nFF6l
	 Mf5lz/ve52Jms9iHo8baVBsSECB12GHGtwEkzgMMvEIc6re5un8Fbj32uQGyBtTMOxHRy
	 pVEr66sRW6cNLbi46/d0gc7fnteOeP1IkbVPb8bPf9GuvEPpgx7SvM35fFnUEXI3ghz9s
	 CdLDalyIR3mfbb4fK6f35gSJJCkVwcG4rUHv9/1G6Shdd3DItSRGQdNKcSwLOv/bjr0um
	 t3nmCbTH0+XOeMvy/X1k7iI38bUgeGNWvDIIH8k60oswya2gm3ngdH4Kdektq4a6oow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795802295;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Subject:
	 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=saxtVLzvrKVEDx+4nSgqFXA99F4jvRuEf4n2U7n1B+M=;
	b=RZNvYXgH1A3I40VsZrLq0maw0lSFvRGUdKRRb4EHIus+T/n/GuKVLZMgTE8+9F16D8u9
	 mZviY31XN/0rETRWVjYOGpXirmDWw17R+njCs03MYqP/XPbd82ht9PwzOz5t/8DNaE9SF
	 QjQbDsPzCHwoatQ6zjDGDK/3uADsfmYrXcQCkJlGNIHXb2gfpnTjGKxjciqUyeuA+kMb5
	 xs9We+uoi5RHovOpGoxI/VE739+BzHEdYHItOyN2MkY10kK2UoDqQmZ/S5qk9Wycm5tp6
	 JbDwKfj8GajpH/84e7S5Y2HdswMvy7VC70cm4YlQYv0VdG/pGbIv3u5kgArlGcVOENA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=VvIBmqNl;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C0C606A31F
	for <linux-i2c@vger.kernel.org>; Fri, 27 Nov 2026 17:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2C0C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=VvIBmqNl
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 51573C2AC4C;
	Fri, 27 Nov 2026 17:58:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5C56C6049C;
	Fri, 27 Nov 2026 17:58:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A3F4C104395A4;
	Fri, 27 Nov 2026 18:58:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795802287; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=saxtVLzvrKVEDx+4nSgqFXA99F4jvRuEf4n2U7n1B+M=;
	b=VvIBmqNlzWTRahjudKumiK4bKv5VIlCwgXZXpsVkleU313euGr6gzfeOBjssGvTy8PjVVB
	q0R2MFH8PqkbGlgz18Hr5QhFI+vIoZEEy0C+WcQuS419Z8jN5U8nprGsEb0e0jVLMqhXTW
	iDiYbbgRbQOqSh8h3Q2a7ivea05Xm+pkoqCjL2pOeRdSQghq1mV0aLHrXzPLZORby2OoDs
	FiH7p0zvWrEfTlZhYafS6gdVOgnk2Ix3RVNnBTR6TPDjPC+kvgmXuhwetobP2gqjvJ1+Bj
	kCt1Nbv81a2MaFeUHTB5tK23yzj0Hc633PBdziijz9mN+iZufKIwBHaB7TBFeA==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Subject: [PATCH v7 00/11] Congatec Board Controller: Add storage devices
 support
Date: Fri, 27 Nov 2026 18:57:44 +0100
Message-Id: <20261127-cgbc-i2c-storage-devices-support-v7-0-d0e70fc57879@bootlin.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43SQW7DIBAF0KtErEs1A8bYWfUeVReAhwSpNS44V
 qvIdy9OpDqqF/XyD+J9RuLKMqVAmR0PV5ZoCjnEvgT9dGDubPoT8dCVzASIGjRq7k7W8SAcz2N
 Mppx35ZajzPNlGGIauZVE2pGRUgArzJDIh69bxevbPSf6vJSmcR2ew8J9354x4TK9NzZQ/d84I
 QfuqZONQqg1uhcb4/ge+mcXP9jCT+KBRNxBikJK8qZtGwLyakvKlWx3kbKQqq2skt46RWZLVr8
 kAogdZFVIspUg8Nh51W5JtZIIcgepCmkcohfSG1K4JesHcs+HmOpCWgsaTCepNX8Wn+f5B9uAv
 vCGAgAA
X-Change-ID: 20260717-cgbc-i2c-storage-devices-support-b3ee7cea3320
To: Lee Jones <lee@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>, 
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 Markus Haberlander <markus.haberlander@rosenberger.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

This is the 7th (and hopefully the last) iteration. I did few changes in
I2C patches as requested by Andi, and collected his RB/AB tags. As
discussed in [1] I picked Markus' patch (PATCH 11). And I rebased on top of
for-mfd-next.

[1] https://lore.kernel.org/all/20261123-cgbc-i2c-write-status-v1-1-5b0fa0322b57@rosenberger.com/

Best Regards,
Thomas

Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
---
Changes in v7:
- Rebased on top of for-mfd-next.
- PATCH 2: add Andi's RB tag.
- PATCH 3: add Andi's AB tag, also remove Cc and Fixes tags.
- PATCH 7: initialize data to '0' and prevent potential division by '0'.
- PATCH 10: make the I2C bus probe fail if device instantiation fails.
- PATCH 11: add Markus' patch.
- Link to v6: https://patch.msgid.link/20261117-cgbc-i2c-storage-devices-support-v6-0-bb070ad3e9aa@bootlin.com

Changes in v6:
- rebased on top of next-20261116.
- add Lee's I2C patch (PATCH 2).
- Link to v5: https://patch.msgid.link/20261103-cgbc-i2c-storage-devices-support-v5-0-ac11f23fae51@bootlin.com

Changes in v5:
- mfd: fix error message in case we fail to get session handle.
- fix I2C bus names earlier in the series.
- Link to v4: https://patch.msgid.link/20261002-cgbc-i2c-storage-devices-support-v4-0-eb42e0f1df59@bootlin.com

Changes in v4:
- Fix struct cgbc_i2c_platform_data comment (kernel-doc warning)
- Move struct cgbc_i2c_platform_data from linux/platform_data/i2c-cgbc.h to
  linux/mfd/cgbc.h
- Use MFD_CELL_NAME macros.
- Link to v3: https://patch.msgid.link/20260911-cgbc-i2c-storage-devices-support-v3-0-594b53fbc5ea@bootlin.com

Changes in v3:
- rebased on v7.3-rc2
- use PLATFORM_DEVID_AUTO for child devices
- move I2C bus and I2C device definition in the MFD driver
- Link to v2: https://patch.msgid.link/20260811-cgbc-i2c-storage-devices-support-v2-0-3efa998e0ef5@bootlin.com

Changes in v2:
- i2c: fix typo in CGBC BIOS EEPROM label.
- mfd: make cgbc_devs const
- Link to v1: https://patch.msgid.link/20260804-cgbc-i2c-storage-devices-support-v1-0-fed38510671c@bootlin.com

To: Thomas Richard <thomas.richard@bootlin.com>
To: Lee Jones <lee@kernel.org>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Werner Gartner <Werner.Gartner@congatec.com>
Cc: mfd@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Cc: linux-i2c@vger.kernel.org

---
Lee Jones (1):
      i2c: cgbc: Propagate hardware errors when polling read status

Markus Haberlander (1):
      i2c: cgbc: Fetch the status of a write transfer

Thomas Richard (congatec GmbH) (9):
      mfd: cgbc: Fix use of negative error code as valid session handle
      i2c: cgbc: Use real I2C bus names
      mfd: cgbc: Add I2C platform data
      i2c: cgbc: Use plateform data to get bus ID and adapter name
      mfd: cgbc: Use PLATFORM_DEVID_AUTO for child device registration
      i2c: cgbc: Add support for fixed frequency buses
      mfd: cgbc: Add virtual I2C bus support
      mfd: cgbc: Add virtual storage devices on the virtual I2C bus
      i2c: cgbc: Register known I2C devices on the bus

 drivers/i2c/busses/i2c-cgbc.c | 165 +++++++++++++++++++++++--------------
 drivers/mfd/cgbc-core.c       | 187 +++++++++++++++++++++++++++++++++++++++---
 include/linux/mfd/cgbc.h      |  16 ++++
 3 files changed, 295 insertions(+), 73 deletions(-)
---
base-commit: 5a8fc2b762fdd22698dc10449a960a892e43192e
change-id: 20260717-cgbc-i2c-storage-devices-support-b3ee7cea3320

Best regards,
--  
Best Regards,
Thomas Richard

