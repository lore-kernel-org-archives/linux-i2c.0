Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAB74266B2
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515299; cv=none; b=YbL4ew7gQ+AEc7TGoinztbzBPhGJo9usd+4NjCj584OcnoWeE2Otx3oJx4gvp1kXTP6ei9dB4hUqio4kuPDercErU8kE+aexh8yxrs0kOsgXjJ4xPYLKMjd1+dQQ2CYszadQRkv8pviphC4LqxQSzv6gHV2aEtnqAn8URKZBgRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515299; c=relaxed/simple;
	bh=R9I/f75qY7Rz47zyfVcNUenIwxmv+W4uRzZz1ioK1WM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFItRufGYODvD2MDZknwv3Ro9armChv406HXCBcjlMQUBYk+A+mH+VP6OwTF9Hpgxip5d2T9QRO3DYKzHnDvoZIabWDYhHTxSqcqw36GC3HIyUZHQ5t70uvaGW5Mn6iyy7UEkCjcXtBtzQMbtmAlPF3TvqgEGg0mpnIWB/2jb84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=v8a3TSE0; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="v8a3TSE0"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4B43D1A1DD5;
	Mon, 11 May 2026 16:01:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1F7AA60646;
	Mon, 11 May 2026 16:01:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 03DA511AF9ED5;
	Mon, 11 May 2026 18:01:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778515296; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=6oiAfU8MEqd8yhhPfwMPKZd93U5KjSCmMlrrYUL7Xn8=;
	b=v8a3TSE0epjS4P0rXkRdL8gBSJhtaAKjN+QTLGPiLL9dtfkmu6ijFzNXuh1KcPdfp9Andm
	8mAFZSMWL4NuQFa40/DYW3IRK5yUfkbPwI0pYGxYV5C0R+zlvnOUzP3hkrmKpZuKMGhTJh
	EPkIchZUyUKEaHWrG5btb3tQXIQayI7cciq/EpWjxu8gqLOPfpNweGAN0rRRinigNWt/xx
	oTIMNdOXzqEBp/uw0PCoKl0BUx6HoX5DvLNLwSliZiTMx2B631ioldKSWWgXBPOvJTaPVA
	KuteCceQYV4YnzqpslCLMA3DU++6dZqCJYSNMJ9/72EQTwV0dsAHDg2OCLIjVA==
From: Herve Codina <herve.codina@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v7 1/1] clk: lan966x: Add MCHP_LAN966X_PCI dependency
Date: Mon, 11 May 2026 18:01:27 +0200
Message-ID: <20260511160128.34786-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511160128.34786-1-herve.codina@bootlin.com>
References: <20260511160128.34786-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The lan966x clock controller depends on the LAN969x architecture or the
LAN966x SoC.

This clock controller can be used by the LAN966x PCI device and so it
needs to be available when the LAN966x PCI device is enabled.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index b2efbe9f6acb..b52e2762b25c 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -278,7 +278,7 @@ config COMMON_CLK_LAN966X
 	tristate "Generic Clock Controller driver for LAN966X SoC"
 	depends on HAS_IOMEM
 	depends on OF
-	depends on SOC_LAN966 || ARCH_LAN969X || COMPILE_TEST
+	depends on SOC_LAN966 || ARCH_LAN969X || MCHP_LAN966X_PCI || COMPILE_TEST
 	help
 	  This driver provides support for Generic Clock Controller(GCK) on
 	  LAN966X SoC. GCK generates and supplies clock to various peripherals
-- 
2.54.0

