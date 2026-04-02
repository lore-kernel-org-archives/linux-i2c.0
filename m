Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A1836DA03
	for <linux-i2c@vger.kernel.org>; Thu,  2 Apr 2026 05:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775106936; cv=none; b=EZHvMwxG5gO9xMkP31YAiJwFjENr+7645hk9vs+63e6fPQJR2o3JjPQLPfj/bxfued0yW4T4EDk3lChF9gn7G+LRjx9z1H7UqPu/GxIE/tl6pmV6u9G4pXJSegt9vht/SNNkSFEjYEZnKT8Jx9oZf3nZCY/HizGKlUhI6W4/+/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775106936; c=relaxed/simple;
	bh=HVoeiC7t5M0u01gC8ZWrF1ZSdndrYAnSTfQH8ssTUVw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bW8vJ6196Mew8IjhClvnmx8R1PRHOSdkAh2HnV62hbCCHpkvIECefFVvgD/nLl1p/LgGM0DvdNi+o8xEhkpgpOfPQmxLDR7W+PvcaOv6cOWhoIS2uSBLrVcp9fZQoZUQ5vux59ARvMMyKQbZ4SKfHRtO0+McyRzRKVYu3sbnabY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aexidzYF; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aexidzYF"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35d90833cacso227996a91.2
        for <linux-i2c@vger.kernel.org>; Wed, 01 Apr 2026 22:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775106934; x=1775711734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9VRhm1iFIbmMSuYjrKLq45KZf5lir66/ZO2vyNWUJDo=;
        b=aexidzYFvmt3YUxjauyrhjoe8SwDNNMksF916eZytT+OIQSDwv+fk8dut+4JpZJdf1
         FJ6tzmwntIrY5zt/ua4BlUIpJ2yr7BUK5vLmntaa6lM17aaSw1N65UnXEtmU4wQDChPa
         Hrp6o2VIXdXnE9X1zAmRB587COYxbWO3Rc6t3wbJcw9ZFYbhRbcLlz/1gfvPVHNJ9jLv
         jM2tr/bO/UPDAKTx81hkgJrfHdJlbUuBPh0WyDRibWzEJ7MRFDe4JIYLR0neXEaPYw7E
         VeLIu8Zo/y8OYP0GsN3gtGe2cj7cRi2CVT2rxGPmtrh0yvE2JDztD7sOsKR2AuvM/yjq
         ENRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775106934; x=1775711734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VRhm1iFIbmMSuYjrKLq45KZf5lir66/ZO2vyNWUJDo=;
        b=eUi68Z/qKKXHD726ChmOtzSzMABITkOY2TB4qKp//Zu0jXhj+hXw61Bc5NFpVDwSB0
         97xuk5Zw8q6I3xyUg/E6g4bTHtqBe+MAsSP2QwbqrNFLaOhGw6hJfZWcEb5wJJkXHJVN
         QCoG9iGYOZLxbiCH6LoCLmT5bUGT0xAb3D+rw/RbBNOZJpL2KzZCGgxH+toC/xpbOggg
         aIWv+7Q24/mi3GhtnBDw9U/7qtpWkrh/3kDPo24umnjFsYVgw0DjmwC83bJkoZzl/wq3
         +Eg/ttVsnuA262moBxb/E+rIEA6K+00SPVz4uUert14GekheHkDwlT051aKQh8sHhRYf
         zifQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAEfLwhYvJkQ/ogz4+dbd2mGUWbBypjCVyn923zMHV3EZTqa5zvMLx+fhp7TmN/16QuwOUbhhQc1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHHv4jrrygrNQqW3S7T1AZP8IXjo85imlQ0FISit9hFU2JY99r
	1FpEvnZTgzNjUmEpSjCT4YXD2TWoagn/AZ3f6rFUCzi7pytJMsxG+y1M
X-Gm-Gg: AeBDietozUWnbD2XMfWRb4r05EA5Plq/kNlZoWH0Ksc8mV1E8DyFYvgtosDtpao/cDt
	Xz5xnRP9lRdbzFy+c5ASsDXNkNJ4WExFdR8l8/hBw4RlWxMmNK15Gmj3zeJnK6CCFtEgHpVEqjq
	qjV6ue9WogpX8w1AobDv2fccEOrGkf+gRRLzJDkEXB/ccn5flm4SRhFccA9QFN3S4NZc4Gr0oXL
	Mifg/wNmYhHwxIcFZzj7U3W519dMQAaUXe5RbvddB41/yTn7cmmuqSvHfEgW0iXJzQ4w8w2d5Jy
	QlbcrQyzEFRSV6A8/gzAONGaCWxQZGul2aCYzuuVaKWWCMCeDCJFVrGzVbREDY1Uyjdsz3NDI1r
	xeo6xcHVuO6IS3sPHUjSLnIWNbwg08cvHT1lua1B6/PuW3oH/TbuuDrJAyGdsiebG9gN/MxUU8a
	/BUQCGtjpRewiOg8w/J9grfzXozvT9oDLzaG/XmoFGGKIA3+9Vnped4OGErR7li/nfkg==
X-Received: by 2002:a17:90a:c110:b0:35b:9c97:3d18 with SMTP id 98e67ed59e1d1-35dc6eae327mr5651672a91.12.1775106933827;
        Wed, 01 Apr 2026 22:15:33 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe93661fsm6902107a91.11.2026.04.01.22.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 22:15:33 -0700 (PDT)
From: a0282524688@gmail.com
To: tmyu0@nuvoton.com,
	linusw@kernel.org,
	brgl@kernel.org,
	linux@roeck-us.net,
	andi.shyti@kernel.org,
	lee@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org,
	alexandre.belloni@bootlin.com,
	wim@linux-watchdog.org
Cc: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Ming Yu <a0282524688@gmail.com>
Subject: [PATCH v1 0/2] mfd: nct6694: Refactor transport layer and add HIF (eSPI) support
Date: Thu,  2 Apr 2026 13:14:40 +0800
Message-Id: <20260402051442.1426672-1-a0282524688@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Yu <a0282524688@gmail.com>

The Nuvoton NCT6694 is a peripheral expander that provides GPIO, I2C,
CAN-FD, Watchdog, HWMON, PWM, and RTC sub-devices. Currently, the
driver only supports USB as the host transport interface.

This series refactors the NCT6694 MFD core to support multiple transport
backends and adds a new Host Interface (HIF) transport driver that
communicates over eSPI using Super-I/O shared memory.

Ming Yu (2):
  mfd: nct6694: Switch to devm_mfd_add_devices() and drop IDA
  mfd: Add Host Interface (HIF) support for Nuvoton NCT6694

 MAINTAINERS                         |   1 +
 drivers/gpio/gpio-nct6694.c         |  26 +-
 drivers/hwmon/nct6694-hwmon.c       |  21 -
 drivers/i2c/busses/i2c-nct6694.c    |  26 +-
 drivers/mfd/Kconfig                 |  47 +-
 drivers/mfd/Makefile                |   3 +-
 drivers/mfd/nct6694-hif.c           | 649 ++++++++++++++++++++++++++++
 drivers/mfd/nct6694.c               | 180 ++++----
 drivers/net/can/usb/nct6694_canfd.c |  18 +-
 drivers/rtc/rtc-nct6694.c           |   7 -
 drivers/watchdog/nct6694_wdt.c      |  27 +-
 include/linux/mfd/nct6694.h         |  57 ++-
 12 files changed, 829 insertions(+), 233 deletions(-)
 create mode 100644 drivers/mfd/nct6694-hif.c

-- 
2.34.1

