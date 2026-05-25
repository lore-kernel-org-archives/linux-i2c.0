Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DCF2B9A4;
	Mon, 25 May 2026 11:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779708290; cv=none; b=PNRHNndWxU6zMYJicObCWui/zLhJJ1Vd9xiGHB27QDP0fS1YF4WxX1hqhLWFb//F6ZzDxzA3tndnGoUXQ8FAcj2VWdRKifDDv/qGzdTUfShLGtHeykJiWPujJGSRKheuoTipDiVJgFbknpbHoNHIninY918lPRDsTtObaR36tTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779708290; c=relaxed/simple;
	bh=47xlOO5JbId46R5ZNpfziDDo8V+XnFuCW1yJNrzdW3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TI6TMxxkD9Yu8pTD9hDVPn47Y18EYYm7kGXfLdW4HDk6I09dTeN85OQmUFEiwxaSWDTnIbIEAe7+L6AsDhFWK+DEgDvJoDo/ZzetAeZLnZNVH6jQ8c4ateRWH1xyiP8UTVBFexq7DLo2qIK0/EabPFUQ5Zb8zmCdhAMW0vnC9I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=GC5+QXQy; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="GC5+QXQy"
Received: from [127.0.1.1] (unknown [91.160.0.144])
	(Authenticated sender: vjardin@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 49895B0059C;
	Mon, 25 May 2026 13:24:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1779708287;
	bh=47xlOO5JbId46R5ZNpfziDDo8V+XnFuCW1yJNrzdW3U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GC5+QXQyrM/L8pDABN5U+N6oqFJw1qGBvBh+sJt0SXW5J5YrETyGLTwx85gQMFt6T
	 iy1OB9KAi2KRROBi+oK/e/B3BvgLkZtW/hFfu2C5tgmuTAgYPdnrXCnD9Fe8iXl1v9
	 ANTofiUA/NPvDoCIqm2pkmF/HiCgDKwNkjqsJWzVr4aWWqACdPmX2BmhS9nhTpkqBt
	 LCLz60n/v1SBqL0RHAqu3SCaPZ4cHKcL330woF7cM/vPj/AUIUSg64q8+0RpIK9rKf
	 kgV1lf113lcdHlHG32ylLkr4h+CznbAh5LOBWzxMusVghpAOoxJ+nuPefdNIDBxLig
	 qlS+9dk9gYQJQ==
From: Vincent Jardin <vjardin@free.fr>
Date: Mon, 25 May 2026 13:24:02 +0200
Subject: [PATCH 1/2] i2c: imx: fix locked bus on SMBus block-read of 0
 (atomic)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-for-upstream-i2c-lx2160-fix-v1-v1-1-f30ab53dd97c@free.fr>
References: <20260525-for-upstream-i2c-lx2160-fix-v1-v1-0-f30ab53dd97c@free.fr>
In-Reply-To: <20260525-for-upstream-i2c-lx2160-fix-v1-v1-0-f30ab53dd97c@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779708249; l=1759;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=47xlOO5JbId46R5ZNpfziDDo8V+XnFuCW1yJNrzdW3U=;
 b=2eo7uMa1GLjy9XOUrlVsSrBMoV+sMK2Dc9T5c68PVvADPOD6V2VISAuCyCV/8lho3kg5+hk1L
 Iaf5oB8SqXjAK8k9smeYquWY1LfjradUGe0gBniikkvzvBBskr96KOu
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=

SMBus 3.1 6.5.7 allows a Block Read byte count of 0, but the atomic
(polling) path rejects it as -EPROTO. Worse, it returns without a
NACK+STOP: the next receive cycle has already started, so the target
keeps holding SDA and the bus stays stuck until a power cycle for
this i2c controller.

Accept count=0: NACK the in-flight dummy byte (TXAK) and extend msgs->len
so the existing last-byte handling emits STOP. The dummy byte is
discarded; block-read callers only consume buf[0..count-1].

The interrupt-driven path has the same flaw from a later commit and is
fixed separately, as it carries a different Fixes:

Fixes: 8e8782c71595 ("i2c: imx: add SMBus block read support")
Cc: <stable@vger.kernel.org> # v3.16+
Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 drivers/i2c/busses/i2c-imx.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index a208fefd3c3b..0cd4f5892591 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1436,8 +1436,19 @@ static int i2c_imx_atomic_read(struct imx_i2c_struct *i2c_imx,
 		 */
 		if ((!i) && block_data) {
 			len = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
-			if ((len == 0) || (len > I2C_SMBUS_BLOCK_MAX))
+			if (len > I2C_SMBUS_BLOCK_MAX)
 				return -EPROTO;
+			if (len == 0) {
+				/*
+				 * SMBus 3.1 6.5.7: support count byte of 0.
+				 */
+				temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
+				temp |= I2CR_TXAK;
+				imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
+				msgs->buf[0] = 0;
+				msgs->len = 2;
+				continue;
+			}
 			dev_dbg(&i2c_imx->adapter.dev,
 				"<%s> read length: 0x%X\n",
 				__func__, len);

-- 
2.43.0

