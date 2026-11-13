Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577315;
	b=WRKEeDMaJo0RAXLw//vGjarvlAQIzxgLBuSO0gCZOzIf6ont3DI5xcmgtjAAE73g/FAb
	 JGeLJ3bpFJZudzi/VQ/mlFzEEqE57sCKcbC/FP+dc7e9aNEiQssrDeyxDd1RDQq2KzxW4
	 WqxG/Hsy5yYRZlkXrvCs82IEowx7w8FH3Ho3FA6GWyh4OBvv1vayMvIzitzKOgiosDBQe
	 gZr/7YyjE/SLg/r3UiaNl2c7gthvsKl23sJATo1p36h8vh4an9pE3lQcjuwCt+f0ktix2
	 F6bLDyQcqDEe4SCo52PLZwocSdjlduIskyZjxv0Kzqsfhy5rJPyWfhjnJjAePmnm1Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577315;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=o2Wwkh3wbH9koQ4lEbZGwuz+0Kv3y1lt+bVCbuKUpIQ=;
	b=oRl0XsmCw459YIDYoBxq3402gSRY/QSi19CRBbnkFC4Hgp5NxS1xj5YlhzISqolMO+hA
	 5BLVgLZfGdrkU3LJy/DVo3BQGDg1M6e6lVA7twiV8HElEis83CxUiN+CeYlSBCJ2sYRd4
	 DF1zHt4hDXDp5mHPC1oS/3gkBS7MZrB6j2D4oCOCv9CiYuCXLVLmj6DAMi7Cl6S+gSrv2
	 CgsbpddrqULkzZlE7iQPev9rgSnKuc4wW40b+f2bHS2XDacGre+q4XKd4Fk1BaM3sfapC
	 v63XXNulfrSSp39QbYDB2J2q+rB7s5CAHnMmN1+G6MgxWHsuO7lhF81lA0pm3jMzIsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=1LsTFaJo;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A075960A2607;
	Fri, 13 Nov 2026 13:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A075960A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=1LsTFaJo
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 68BBF1A1655;
	Fri, 13 Nov 2026 13:41:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3710D60015;
	Fri, 13 Nov 2026 13:41:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9528911BC1D61;
	Fri, 13 Nov 2026 14:41:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794577312; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=o2Wwkh3wbH9koQ4lEbZGwuz+0Kv3y1lt+bVCbuKUpIQ=;
	b=1LsTFaJoX5zjmUk7xnIsGOirum/Hv4Ukl5fqHXVmGZLVuII2zvwY7/Pm7slJ69F4hOStnl
	KYKS36M2NSVuBVg+VBOWbtGbOYnPruD/WsW5p0tbJ87j7omgY8FL1/c8sbMWnyS++NkLjG
	clumlAEdp68lLUm/bqKfFOEihkfmqulB2/QXnpEXlMjLs/d38eBksn1HkrDzW/XihYqBUh
	mS7OkX2BjIB07jPsOBYYefcDKUB9BZbwQe8WYMw/Ies2gibf875RQwGQVHO0sBehrTQ3zW
	94zUDUeW9jFTbOpitQxsjWKphlJAOj0eHO6LO9f22lN6i9m/rdv0h0yWdWS/Wg==
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
Subject: [PATCH v2 4/4] i2c: thunderx: Use polling with delay in HS mode
Date: Fri, 13 Nov 2026 14:41:28 +0100
Message-ID: <20261113134128.58826-5-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261113134128.58826-1-paul.cercueil@bootlin.com>
References: <20261113134128.58826-1-paul.cercueil@bootlin.com>
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

v2: No change
---
 drivers/i2c/busses/i2c-octeon-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
index c4f80d178c2a..9ef3306e57a0 100644
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

