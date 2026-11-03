Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694601;
	b=N/OXr0bSAs/qlqywdnHYWDhxeUGbmKi8i5nh1WIcstn97tfXybjgw0fzAg4AJ/AIyrqE
	 i6WL+lWmj9XP3JCjCcwBW8xfg5fMbrH0hpqS58/sKavP5aKngeGCOgngG9UPwGxZEM/6M
	 cUD4qCMWOEJ2o9I+/CngS9UPcOnur9PiXYCnAf7spA+fNoveANzUmgrg6VVgPLfWh9iG5
	 KyEzwkMWk/A78EO5DP8VCijvzqjhVtIrVhnlaJUhp5k6zMw6EJrHvVwW2PzI6jP5RW7iV
	 9flInK0jEYtzE7RrW498ZvBD9ZnXoIO08tLv6+aIeGH6xzc5xy6tpQ5uUR9EcZg+r6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694601;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=kwaHvVSLNnlL8EJAB8gLTdFPA3NQtaUsH/86Rw3xZxE=;
	b=aC3hFBumzy3fvBRoLqhnv+RPUriEDBmKCLCqibThUtTALRTvNM3qtnA/htiu5FCDaI/9
	 pSmEk5vPAKEyctdlGMvOMyBktaoIpNKFSaJuJkYAIxx1dDijhjw1rDkiuLo1tO2aM8Q5J
	 Cfy0sKpncgR/uqbCurf8IfMX51IDvya/s81ivpRXQFaYHInbDoRRvnnAtQKMdGk/AxXOX
	 RgUao19sitdP7IEeZQZ1L8H6NQi3Olw8UaNFxVOC5KqzrmchS5pT31CMIkC14PGdDEyDf
	 vecaLl4A1W5Wb1jQRVpp2fcHPTj7CD8CLMOQdYcgdd8Jnnbm+nBatoivwdkcvndGYJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.144
Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3704D606D80B;
	Tue,  3 Nov 2026 08:29:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3704D606D80B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1793694607; x=1825230607;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=gNZL42AuWbEzzLyd7sP8TMmreDXdLL3QoO4en0rD8y0=;
  b=jGjGl/BYnlY8+hK+RJVu+eHgmwZ2WVO6yffzDJkgSz48jjlWFfWP+hZe
   av0v58XhLBxRBvlf4lpTHwKmi4q0HBaNHHb7Tf1cBU3aHTbJTd6gmZN2Q
   PS2vp8NU7g+6zQB2hLT0mc5jvI25YlRRTtikDBKvWi0gKMs8L9Qqs3Q4S
   KMh0o3klAC5tDtgBPTv4kI4whQcBBQNJIFPWW18GwD4DSXrNOYZc8Xera
   M4keMF/U9OzdP2eyTiGfxJe0DOuU4m0w+77dflji90tRQ3aiCv6NOA09g
   mBaZbaBZjZfwh1eFdRiEaV4wI35fQPq95Vo9kv4yqAbjRxEx4spFqQ9m7
   Q==;
X-CSE-ConnectionGUID: mkHVKEemQYKyShKrAcDMuQ==
X-CSE-MsgGUID: mTMutnd0S9murOIoMRHXEw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 10:30:04 +0200
X-CSE-ConnectionGUID: HIzJ9sgHSOaJYO2yzYAxZw==
X-CSE-MsgGUID: o9r1Km6qRjaGCMSP1ub6Sw==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.3])
  by ces03_data.me-corp.lan with SMTP; 03 Nov 2026 10:37:43 +0200
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Tue, 03 Nov 2026 10:29:57 +0200
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Tue, 03 Nov 2026 10:29:43 +0200
Subject: [PATCH 7/8] i2c: nomadik: fix race condition with interrupt
 handler
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
Message-Id: <20261103-i2c-nomadik-fixes-v1-7-655c6af2cb70@mobileye.com>
References: <20261103-i2c-nomadik-fixes-v1-0-655c6af2cb70@mobileye.com>
In-Reply-To: <20261103-i2c-nomadik-fixes-v1-0-655c6af2cb70@mobileye.com>
To: Linus Walleij <linusw@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 srinidhi kasagar <srinidhi.kasagar@stericsson.com>, 
 Ben Dooks <ben-linux@fluff.org>, Andrea Gallo <andrea.gallo@stericsson.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Dmitry Guzman <Dmitry.Guzman@mobileye.com>
X-Mailer: b4 0.16.0

If nmk_i2c_wait_xfer_done() gets timeout on waiting for wakeup from
interrupt handler, there is no synchronization with interrupt handler
that may run in parallel. This can potentially lead to various race
conditions between thread and interrupt handler.

Disable and clear all pending interrupt requests and wait until running
interrupt handler finishes after the timeout.

Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 drivers/i2c/busses/i2c-nomadik.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 361a5fc6a587..cc8b5a357f06 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -505,6 +505,11 @@ static bool nmk_i2c_wait_xfer_done(struct nmk_i2c_dev *priv)
 		wait_event_timeout(priv->xfer_wq, priv->xfer_done, timeout);
 	}
 
+	/* Disable interrupts and wait for pending interrupts */
+	disable_all_interrupts(priv);
+	clear_all_interrupts(priv);
+	synchronize_irq(priv->irq);
+
 	return priv->xfer_done;
 }
 

-- 
2.43.0

