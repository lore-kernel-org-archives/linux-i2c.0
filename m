Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED4143E48B;
	Mon, 19 Oct 2026 11:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792410491; cv=none; b=h/IMbqYepJXaQrnuXSHpmgbQYrfGVruGxIWjIan55eCXacMJkq/D2y7bMFtsekXckexQ6iRqfliXJ1BEtEt40KXPM9RPWktNIkEmNmwBRnLdlFEB52sO3xHNizYkk7L5wTh0YzkybazmaYGIfbHJsIunWQ+EmWpRLKgLdfgjZ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792410491; c=relaxed/simple;
	bh=p2RC2pRCO+1oiOyqh6qwIORQiDJGoZ7BkU65dixdI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJorRFEBlNfdffe3jLtQvXcBK5UEpoYlNOFNWVoA15oiH4hOXe4z89Xx0s+axEOj6JjbbJxBKNcpVw2W6VR+udCB5t2MW4ejus8T3keiQDUcsOedg5kHx58KYbS8lahiXooFaOEwMMcVSkBIEnvW7HQ/hO85mKK3s/kbMsI9Mk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMWlJvWv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMWlJvWv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3D21F000C8;
	Mon, 19 Oct 2026 11:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792410490;
	bh=RtoIVqaodiCg+dNzww+iraTc1OL+OOJjUO/4Brgj6sE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nMWlJvWvDZSLr536rhVgq5a0ctHr9LnDSHs3GBBEBBEN20pMnzEOEz3SPTrpz4rey
	 ENUmDHUPGOCoqKHiN07iWa3nd2l0Tt2TiSgKDLL0Z4O3sc4Ec0i62oI5hL10vXDpS8
	 WrxVKZplWVvyaAQySzgnMxOsDAVSq78Kq/kPphLWJhT8wZy/tX8xrQEzJRySjGHOmk
	 JuOXhVUvVM7J/q+o1XYiI4l9Bp/1UPu8GjaNBsW6o1u0UF1Se6wkhXispFso3EfdTn
	 KcuhAVGqDy6/0N7TX7EF0g16KBzAFoSfXJT4DXcXZRFz3w1sVDKBbD+DRTtwOd2bKD
	 QZXr3rvO9/h/w==
From: Sasha Levin <sashal@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Igor Korotin <igor.korotin@linux.dev>,
	Andi Shyti <andi.shyti@kernel.org>,
	Carlos Song <carlos.song@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Pei Xiao <xiaopei01@kylinos.cn>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org
Subject: Re: linux-next: manual merge of the i2c-rust tree with the origin tree
Date: Mon, 19 Oct 2026 07:48:06 -0400
Message-ID: <20261019114806.1298980-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aqK86A1SuLKQP5Gi@sirena.org.uk>
References: <aqK86A1SuLKQP5Gi@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Sep 10, 2026 at 03:21:28PM +0100, Mark Brown wrote:
> Today's linux-next merge of the i2c-rust tree got a conflict in:
>
>   drivers/i2c/busses/i2c-imx-lpi2c.c

Hi Mark,

The probe hunk of this resolution takes the i2c-rust side, which
reverts

27c9445be86b ("i2c: imx-lpi2c: avoid accessing target registers on master-only controllers")

SCR is written unconditionally again, so master-only controllers such
as i.MX8QM are back to the asynchronous SError at probe. target_supported
is also never set, so lpi2c_imx_register_target() always returns
-EOPNOTSUPP. It builds without warnings, and next-20261016 still has it.

That block should match mainline. The delta against next-20261016 is
below.

The conflict comes back on every merge because rust-i2c-next carries
older copies of mainline's lpi2c commits, for example

90311787f483 ("i2c: imx-lpi2c: reset controller in probe stage")

This is what llminus generated:

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index dd5b8bcd05d04..7302464c371ae 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -1553,13 +1553,23 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 
 	/*
-	 * Reset all internal controller registers of both Master and Target
-	 * to avoid effects of previous status.
+	 * Reset all internal controller registers to avoid effects of any
+	 * state left over from a previous stage (e.g. the bootloader).
+	 *
+	 * The Master block (MCR) is present on every controller, so reset it
+	 * unconditionally. VERID shows whether the target feature is supported.
+	 * Do not touch the Target block (SCR) on a master-only controller to
+	 * avoid an asynchronous SError.
 	 */
 	writel(MCR_RST, lpi2c_imx->base + LPI2C_MCR);
-	writel(SCR_RST, lpi2c_imx->base + LPI2C_SCR);
 	writel(0, lpi2c_imx->base + LPI2C_MCR);
-	writel(0, lpi2c_imx->base + LPI2C_SCR);
+
+	lpi2c_imx->target_supported = !!(readl(lpi2c_imx->base + LPI2C_VERID) &
+					 VERID_FEATURE_TARGET_PRESENT);
+	if (lpi2c_imx->target_supported) {
+		writel(SCR_RST, lpi2c_imx->base + LPI2C_SCR);
+		writel(0, lpi2c_imx->base + LPI2C_SCR);
+	}
 
 	ret = devm_request_irq(&pdev->dev, lpi2c_imx->irq, lpi2c_imx_isr, IRQF_NO_SUSPEND,
 			       pdev->name, lpi2c_imx);
-- 
Thanks,
Sasha
