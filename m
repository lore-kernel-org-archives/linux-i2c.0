Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577313;
	b=1dUJdbASMytOSIr8agl8o7QBE+bezweHnx/5khqJMdJLX7DQ8SEVJ21BnEiY/s8LiUEt
	 lqZdfwAhacAZze7QKdrPAYhh3eOm3QFjb2n/re0Bg/F/RaW7TYXLti2IECByjTV1o6s1C
	 49g70EaJyFXAgBhYCtham/Aog9oMGnKOGTMSXfbrTWYcwbQLvCe0CwKee+uWbDtSBCq/3
	 92SLfWTQ63JLId8X8n5D0IEmqwEFP3h0baci2NsP/CDC4Nb8J9F/lNOBXEovqLCWq2ln2
	 SgBuQ6YRjMPJYJrxFmvPLEJyQjRmecQM6al/dIfOJAh0TFE4QLYSjMmpy3YB7mZiIaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577313;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=lXWADzxXGxHpcFv7Ee701Kzn+Er/ey5xktA1/baHiuI=;
	b=eCOxLZinxPnpam6P7gOhN6CWqbhjal3mgmluJa6/No3f5t5ALrGa2zK8GY7PTDiAk4WH
	 +yAb+CIW83mdKykFUVJA2sihsfH1V4JZXpbojDjnTHvVVolUdOAqKJ8l+RMd5Zu8WUlhI
	 htLUtlk6ED0Va7N/EqjAfBDimqyNTcMLcJGXYUCAbyqsZ/rJB7/V1s+eTMk0qPHYPetz6
	 7xRt2+PbLFR8WqwjFgWng9xk5WKK/aAUTjkGk4SH7WVzbDJT/6tFE6Onxa2KWT4VngNm2
	 OPbaYGTRDtBi3YPXS+k9CFskPPmYeJhXgcgvcBccAgCgxJCO5VOPcRS4kfYOfaD1PIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=tGDy3QH9;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC4A606A8B6
	for <linux-i2c@vger.kernel.org>; Fri, 13 Nov 2026 13:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BC4A606A8B6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=tGDy3QH9
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B00764E415A8;
	Fri, 13 Nov 2026 13:41:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6754C60015;
	Fri, 13 Nov 2026 13:41:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 51AA111BC0565;
	Fri, 13 Nov 2026 14:41:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794577303; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=lXWADzxXGxHpcFv7Ee701Kzn+Er/ey5xktA1/baHiuI=;
	b=tGDy3QH970C9Sqf19bxSrzJeay9jZ2KWaPC4+yMx5LCeW4HAf1jyRzHVYmChUrWobCi9Sh
	Q9yyhIBpnN1rlGkvMnQNlRlVL6iXp+KWs66WQ5k98LolBcTQd8Pd40lrcTvUEhA4x6TJTd
	0+7thjXE/8gA/rLXqwU0iI2ID2MpGvmxjQJmOJBPK+0GApD3g7lHMD27SiXv4IhfrRYdiX
	hRLcq97tEBKWbcYO8DnduHX8dsKuploHIsb//TceHPuW6QeDA2GRxFKqLHXVVJUKBlCJIw
	sbNkmH6sXEX7Hr1yAKmvBHlgU7fYGCWJ7JGZjuhTZzjQ9I9Vdm9YyACYdr/f6g==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Robert Richter <rric@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Umesh Kumar <ukumar@marvell.com>,
	Shashank Gupta <shashankg@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH v2 0/4] i2c: octeon/thunderx: Fix DMA mask + improvements
Date: Fri, 13 Nov 2026 14:41:24 +0100
Message-ID: <20261113134128.58826-1-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
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
X-Last-TLS-Session-Version: TLSv1.3

Hi Robert, Andi,

This patchset adds a fix to the ThunderX driver where the DMA mask was
not set, sometimes preventing MSI-X from being initialized properly.

The v2 brings an extra patch that fixes an infinite loop in the clock
divisor calculation.

The other two patches improve error handling on the bus, and the latency
in HS mode.

Cheers,
-Paul

Changelog:

v2:
 - [1/4]: New patch
 - Every other patch untouched.

Tanmay Jagdale (4):
  i2c: octeon: Fix infinite loop in clock divisor calculation
  i2c: octeon: Add error state recovery
  i2c: thunderx: Set DMA mask
  i2c: thunderx: Use polling with delay in HS mode

 drivers/i2c/busses/i2c-octeon-core.c     | 35 ++++++++++++++----------
 drivers/i2c/busses/i2c-thunderx-pcidrv.c |  4 +++
 2 files changed, 24 insertions(+), 15 deletions(-)

-- 
2.47.3

