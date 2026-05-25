Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F49A3F7887;
	Mon, 25 May 2026 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779727428; cv=none; b=mkfXI2VNHFZgn7NRbrSdkNZMwm9shaKSIU4xFHxwkbzEv7RDUO+Xkl82mHMMloNd1pRiZG3aM5VEiiXINj3PBdOfvNbGLi51HSdoRV6ynbh6OcVDscivoILt2/PY8hvEXQLmYbi0mS1eMpffqEHG203EO9SiFQlDMdxKUeCwLxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779727428; c=relaxed/simple;
	bh=qp1BSjiUi/5p94Cir8hjZnud1/YLhmdgzYl21op+gvc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=fR2JbF6G6f9/Do6K6Su9a6OsFb6k2O2H+gfJbq1o+VChw8fbEAJzVQdtmrkY9tw7E0QaYl916/pN6nuA5BRlTpGRjeU/Wv0EjifwIU7IfzB4LryT/DDQ7aGAEJYQte/qmSxO0rZPwMJIIbbypZAuT/Y7XeIFPbRDVKWvakQ6n0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=XPuei6rd; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="XPuei6rd"
Received: from [127.0.1.1] (unknown [91.160.0.144])
	(Authenticated sender: vjardin@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 492C8B00573;
	Mon, 25 May 2026 18:43:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1779727424;
	bh=qp1BSjiUi/5p94Cir8hjZnud1/YLhmdgzYl21op+gvc=;
	h=From:Subject:Date:In-Reply-To:References:To:Cc:From;
	b=XPuei6rdkZskA0RwtiqaThjnXqS16ATRvRhHDM6yBENsFK5U48qrhytAMF3Y5xVwm
	 Xhi6+LQH0RofaRGbKs8diCsTqyNxQOUlZReL8HIUBHc/JpC6/1Sp/AbPbMwmZjWGlv
	 MJCJNOwNJuVJU0JhX7nXJN9MK3KLxDrV3e9arOY1hgRG65dbWA9BqLdG45FLDKCr/m
	 PXW42nuV9bKgkjw+l+EgQsrsi7WWR3XW/Q4ToTN5eqnR8cPj4LzJKktoKMBpTzGpbh
	 hfvknXDufjXM8yddWNpxeL+r9An27M/tgW1c7FQ+QokbMhpiWQb+j0GW6H8+EF0N/R
	 3tE2cQaI7E9dw==
From: Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v2 0/2] i2c: imx: fix SMBus block-read of 0 locking the bus
Date: Mon, 25 May 2026 18:43:14 +0200
Message-Id: <20260525-for-upstream-i2c-lx2160-fix-v1-v2-0-26a3cc8cd055@free.fr>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACJ8FGoC/42NQQqDMBBFryKz7pQxEotd9R7iIsZJHWhVJlYs4
 t0bPUGX7394b4PIKhzhnm2gvEiUcUhgLhn43g1PRukSgyFTkjUWw6j4meKs7N4oxuNrNXlJGGT
 FJUfyrSNHVBVsIUkm5fScgbpJ3EucR/2evSU/1r/Vhx1DQa61RddVN/8IynwNCs2+7z/FPPq9y
 gAAAA==
In-Reply-To: <20260525-for-upstream-i2c-lx2160-fix-v1-v1-0-f30ab53dd97c@free.fr>
References: <20260525-for-upstream-i2c-lx2160-fix-v1-v1-0-f30ab53dd97c@free.fr>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Andi Shyti <andi.shyti@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Wolfram Sang <wsa@kernel.org>, 
 Kaushal Butala <kaushalkernelmailinglist@gmail.com>, 
 Shawn Guo <shawn.guo@freescale.com>, 
 Stefan Eichenberger <stefan.eichenberger@toradex.com>
Cc: linux-i2c@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Vincent Jardin <vjardin@free.fr>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779727406; l=1125;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=qp1BSjiUi/5p94Cir8hjZnud1/YLhmdgzYl21op+gvc=;
 b=/ro5eVxZjr1OWIerjlcGOqzj2R+rX0uTtmI8My9AmNtsOn4T8Sc0gaQam0AfE0a8rfwikUoZ5
 vWZINmgOxGjAakNpEz9usWrVpOcMUv3VKjcF7tglCiCol2IrBWVCKW9
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=

i2c-imx rejects a SMBus Block Read byte count of 0 (valid per SMBus 3.1
6.5.7) and it returns without a NACK+STOP, leaving the target
holding SDA so the bus is stuck until a power cycle occur.

The same bug is occuring with two independently introduced spots, so the
fix is two patches with their respective Fixes: tags and backport ranges:

  1/2  atomic/polling path       Fixes: 8e8782c71595   v3.16+
  2/2  IRQ-driven state machine  Fixes: 5f5c2d4579ca   v6.13+

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
Changes in v2:
- Handle when count > I2C_SMBUS_BLOCK_MAX the same way as count == 0
  Reported by the Sashiko AI review on v1.

---
Vincent Jardin (2):
      i2c: imx: fix locked bus on SMBus block-read of 0 (atomic)
      i2c: imx: fix locked bus on SMBus block-read of 0 (IRQ)

 drivers/i2c/busses/i2c-imx.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)
---
base-commit: 6916d5703ddf9a38f1f6c2cc793381a24ee914c6
change-id: 20260525-for-upstream-i2c-lx2160-fix-v1-0cba0a0093e5

Best regards,
-- 
Vincent Jardin <vjardin@free.fr>

