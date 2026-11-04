Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793789371;
	b=rFquUizhWxEunvvSdUNodb79elXorUaUtgdWgqGPZUDUpvaAIpqFUEjIjDGzwSVP8iH4
	 Kq1bjPlN29vcWFjt6JFxEsJGu8K8vIrFG73a1yex0ENR4qDGxBA6K29WIDBcwg2ULmIm/
	 qAgyUI3zzZPONhD5+9NtukUOtJiLPtC6Gmm2ZBT4qwz1op10W4UlIbjVChXuzV4GIf7Wp
	 GhyjvZ5UGglZDyt5hU29kYBa8hWRKGOv8ISAbb0577YiLrCWDID/oyxMTBVg6zvKpF2xK
	 PgS9J/I0P4sHQyp3Wln3KAg8tiq4bhbfxC6DqmKmUvqxACF/aZYlTdwN7Ru8MBSSNqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793789371;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=PeiTE4L7cDiBX3okf4cJ5RjaFHsp1BNxTKSquB0awMA=;
	b=YfEzeUiUnGq4JtF3KaC2R8qnxyO5PB5huB604yfNEjL0lQ97n0N5CBimuRhA2vj+CRo8
	 tg6bzaTjGhxfZDFDwDeLxKSHShRsy7oI31fEA39jQz+DLxJWmN5Y13X/zxjl2Q+H0dGqG
	 /UNV7AsXMItg3/EsXTKPL5R0lzWPFzPCjvegzVrLA6suCb8V77ui0Ptk9ihXi2JvhJldB
	 oKr0IqeYtg/8dL0CTwLDNEKA6kqtioLRbteExH8fsmhQNX+QjqqaQMwMb4rfcdLQL06N/
	 a2HianuqZJGik7lkpyzTzPf8htdy7az5qj5dkph/BMgiIIeOaaBqgp1qNqAwhAhtHAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=x8mLVKv2;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6731606A32F
	for <linux-i2c@vger.kernel.org>; Wed,  4 Nov 2026 10:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6731606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=x8mLVKv2
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id ED5ED4E413F7;
	Wed,  4 Nov 2026 10:49:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C1FF760770;
	Wed,  4 Nov 2026 10:49:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 71047103291F6;
	Wed,  4 Nov 2026 11:49:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793789366; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=PeiTE4L7cDiBX3okf4cJ5RjaFHsp1BNxTKSquB0awMA=;
	b=x8mLVKv2sDXPU0x8hMssSMe27NlCxzyArdGIYh63Rlv8YSvaAirqVpPCOKgJVrhHdvIhVU
	vWKsYx/NQ+Vv+bGQOMbONBFzWnPkr9xvtQjrhgaDvhcwtq2DpdkRBJFS8c9zngaObe9FUl
	IAvMekqKXmK3RUBOGr5OXVw3t5N4YWHZnpSYOIfzuG+p4ZgXYS48EoRKKqhQ8EDbSA4TWB
	P+rZPAeSJ9K0SxtolQfgB8enrQ7dhJQnA0846z4fiKfKcNhtU0T2mVyWBPCx58zoV7k+0Z
	2cPydq3w+78qbXt42kLJvvy5Qg2GPFNBXvJbhwxr2yKBQnR2m2M2v+8JMIL8VQ==
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
Subject: [PATCH 0/3] i2c: octeon/thunderx: Fix DMA mask + improvements
Date: Wed,  4 Nov 2026 11:49:09 +0100
Message-ID: <20261104104912.166301-1-paul.cercueil@bootlin.com>
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

The first patch improves error handling on the bus, and the third patch
improves the latency in HS mode.

Cheers,
-Paul

Tanmay Jagdale (3):
  i2c: octeon: Add error state recovery
  i2c: thunderx: Set DMA mask
  i2c: thunderx: Use polling with delay in HS mode

 drivers/i2c/busses/i2c-octeon-core.c     | 31 ++++++++++++++----------
 drivers/i2c/busses/i2c-thunderx-pcidrv.c |  4 +++
 2 files changed, 22 insertions(+), 13 deletions(-)

-- 
2.47.3

