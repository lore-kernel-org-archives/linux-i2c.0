Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793789375;
	b=XSbuCPMHYrm0231ikp76C7SLtiL9itwpej2CFl5CjQgjWC+FQd0hhcq/zcD6LhZTCMNv
	 VnF4lOFXrPKFCJbCBlFHaG4cmp3r6F+4U5gBf5MNBG3uj5HpHi01XTc+OdsN6w+0mgUfa
	 P0+tozJWhnpgMJH4fLfVT5Q9mEHwRJW4oSO9cH/T20etAUTq3rnkIF+DdmHzoTYVNbLP6
	 BcEo9XDQ01vV2YJvcKI6u1trT60xe9YjV2YnTZGTQPuzDQYf65WXPXiLJUDZMRO4I2tvy
	 9JUz95fJDp30gvLy31JQuUEYlvsz1Mf4oiA7rinxxht+0rUN+aBuiPPY4iWEWugbluw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793789375;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=t/5zO77jqUFjV/r+jtVCxKhvFk7JEFL6M5A3wXfcn/w=;
	b=rg3ALQBRMhUPzHzWBPtpmJjrwkA+ymd0sxL3rZfREsuuC/K7sHoEK+uEaVjLodOA1qGl
	 oIZBpcmgK6/ZSVvgcwT5RAoWdVZf1afnfy0WpQFChPw3ZrEFgHeOfQcuX8FKBpMsRVixJ
	 W7rzDIUk9Ge9XMZok6eiPDnh0V8PgNTo3r1IAAQiFMCDmijB0UDQ9Wipl6C39luUTfLz4
	 2lkvIVTPWGPdPLyQTTh+3aoYmQmFB5Fv2tJXBNlOcreXzYt6Op4yk8X1bsWiprNV5f9US
	 zSbQQNNGW39JrbFMgZMGFexA1bTUOKjkYYo7c99lDl8l62rGJFgjFjPpqkSMzwGJELg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=IxDtHQrL;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E921606D80E
	for <linux-i2c@vger.kernel.org>; Wed,  4 Nov 2026 10:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E921606D80E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=IxDtHQrL
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B26861A1457;
	Wed,  4 Nov 2026 10:49:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8704660770;
	Wed,  4 Nov 2026 10:49:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6C4E0103291F6;
	Wed,  4 Nov 2026 11:49:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793789372; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=t/5zO77jqUFjV/r+jtVCxKhvFk7JEFL6M5A3wXfcn/w=;
	b=IxDtHQrLi7jhsQGtV03M7wWcaIaHpLnSZb3DAmqz32K9UEMWPZ1LI/q2Z4Hxv11ZyNCA4N
	7TqN8QP9so2tKBOWge5UeO3PNoewueMKogTkdGdHx6xzn55Xa+AKUgYJCrDh7ZCWws3kgC
	psVd5W/ZpUt82qOw0iBn1GaQ7cPu2RI0aoZC0OnOZAXSlcw1zOQ4rUoK1uP9sdjXEmoR+/
	ld792bNCy8tQqDcUws5gT8HRKnLhRslCYNxpXZB84vYlMntSDPVTS/uO64yjvLfXdYdZZL
	bJlwuVpr8dRJwSQDT+JDvsobUxaTQsqf1U2inODFLpW/rFc/XL216YH6zIDcQw==
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
Subject: [PATCH 3/3] i2c: thunderx: Use polling with delay in HS mode
Date: Wed,  4 Nov 2026 11:49:12 +0100
Message-ID: <20261104104912.166301-4-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104104912.166301-1-paul.cercueil@bootlin.com>
References: <20261104104912.166301-1-paul.cercueil@bootlin.com>
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

From: Tanmay Jagdale <tanmay@marvell.com>

High I2C transaction latencies exceeding 1 second were intermittently
observed while operating in HS mode. These delays caused DTLS handshakes
between the main processor and firmware processors to time out,
resulting in increased startup time.

Replace the existing wait mechanism with delayed polling in HS mode to
improve transfer responsiveness and avoid prolonged latency spikes.

Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
Co-developed-by: Paul Cercueil <paul.cercueil@bootlin.com>
Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>
---
 drivers/i2c/busses/i2c-octeon-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
index 9f72ec1feaa0..4c05d2d00cbe 100644
--- a/drivers/i2c/busses/i2c-octeon-core.c
+++ b/drivers/i2c/busses/i2c-octeon-core.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -65,6 +66,9 @@ static int octeon_i2c_wait(struct octeon_i2c *i2c)
 		return octeon_i2c_test_iflg(i2c) ? 0 : -ETIMEDOUT;
 	}
 
+	if (!IS_LS_FREQ(i2c->twsi_freq))
+		return poll_timeout_us_atomic(, octeon_i2c_test_iflg(i2c), 1, 1000, false);
+
 	i2c->int_enable(i2c);
 	time_left = wait_event_timeout(i2c->queue, octeon_i2c_test_iflg(i2c),
 				       i2c->adap.timeout);
-- 
2.47.3

