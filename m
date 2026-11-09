Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794257440;
	b=fNn0Z/97mEphjyFIk0StfncbV6LUwEYHFubegbT1b5KMYmJ3arv3ToUNeRdAFcJ6IU3R
	 msB+SZjkHUuUbqpDdYUQp5LvdsMwW3Z5Li9Ff3AsEyvnkwysA16z5qzh94HN89wmb1JvY
	 pMlfxZawhHYCDLaQ8klerFjj3PuO+f/E309w/XKwtQ1DvjEfgLFrdaudxZCmOGWzKBc/r
	 cRAS+4b/Ru4FwdTIPexgZWU93+fB2+MChj2YWdm5txsw/W4v+sMfUszelyVnAU6/GfRT5
	 4EtZHNf2CGZTMEpS0H0UpRZxDPGpVS2REZGiAC+iwYC/FetnPelxOuRxvcIEhJ78qsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257440;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Fb45Ep5C1SrmFsY0xupXAmvUNierZf0Cwr6xIMYa+jY=;
	b=YQJzAqo8y6sl5LCSeg8glOw3laA3JeHwTQuaYoW+p69XCBgfCocZ+TE7i0I2/LTyjc2n
	 MMmx+GblBs+ej3qpSjVQBT1x31M1vrFrcTuuwvIE3GaaJ2u04DSnF+lOroSjcZIMKpMW3
	 osDFCj82cgdhSZ9jrHRhQOo+rBkcqRZDznQ/4tcdf0v6Xyj4ykOANHkGjCRWO4AjSfm8/
	 apP+hAs2LprogD20LUfEk4Y28fDSp+3D1tV/iN3BZaNf8k6Yc3D2FhKnPzXg4mq2LnA9c
	 ZyoabzRvpewf3wgxgOjsj+JFiGzTsf+Cd0dtM179qbfdizIBY8VVjuwazyJnvUIpVCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SPV7iv1q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0347606A336;
	Mon,  9 Nov 2026 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SPV7iv1q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D471F008A2;
	Mon,  9 Nov 2026 20:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794257439;
	bh=Fb45Ep5C1SrmFsY0xupXAmvUNierZf0Cwr6xIMYa+jY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SPV7iv1qxQdc4E1pQHBdu6Udpwrw2fJcH+ZMvZdMCUitaHaz6KCSlX3p6uqSuqmXq
	 Vq5T5aHSudwAY+CZ0LlgtGo3O4iDrxQNmVJ4Z/gApiLyYlz3NIaWBcoItPzntDjXCN
	 hzTc9LO8V4GmnfNnTQ5KiMbp2vJZq7toDreGBzN+t7mQ/86KuKYjB4XaLZz9lbSGBs
	 ds3fNwzdtWRI48JnWZvYJUAm/FZ5A0skEAzNR6mnMYmXciNSF2MVm1Mp6ivJTX4uKQ
	 2zTsubQpDHDH/KktoTeu705Ar/7DT7ZuKKEfw5Rtv2tTkUcGBckR0Vno7TgoARflRR
	 +h0Zw+RTdu4Qg==
From: Joshua Crofts <crofts@kernel.org>
Date: Mon, 09 Nov 2026 21:50:06 +0100
Subject: [PATCH 5/6] i2c: stm32f7: remove redundant
 pm_runtime_dont_use_autosuspend() calls
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
Message-Id: <20261109-i2c-remove-dont-use-autosuspend-v1-5-49a08b8daf36@kernel.org>
References: <20261109-i2c-remove-dont-use-autosuspend-v1-0-49a08b8daf36@kernel.org>
In-Reply-To: <20261109-i2c-remove-dont-use-autosuspend-v1-0-49a08b8daf36@kernel.org>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Chris Brandt <chris.brandt@renesas.com>, 
 Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-renesas-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 Joshua Crofts <crofts@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794257409; l=1230;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=mR3PUAwrVyNnmrif5Ipr/TukEQxQRGcBhfdjxy/Wrrk=;
 b=5L/yIKW2JMwL9uV2e5wlknf75dDMX9mKJgcm/y1LkUGpHdAIJst1pMXqMbGnmGMe66x8n7Njp
 vl2J9SLaDnUBc7pxQoarYbtd1ACtDic+JBwSNUALQ2xtew756vDfqpv
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
driver core is now responsible for undoing any
pm_runtime_use_autosuspend() calls on driver exit.

Remove the redundant function calls.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/i2c/busses/i2c-stm32f7.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 2e1cc6a92b81..7904d888550c 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -2325,7 +2325,6 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
 	pm_runtime_put_noidle(i2c_dev->dev);
 	pm_runtime_disable(i2c_dev->dev);
 	pm_runtime_set_suspended(i2c_dev->dev);
-	pm_runtime_dont_use_autosuspend(i2c_dev->dev);
 
 	if (i2c_dev->wakeup_src)
 		dev_pm_clear_wake_irq(i2c_dev->dev);
@@ -2367,7 +2366,6 @@ static void stm32f7_i2c_remove(struct platform_device *pdev)
 	pm_runtime_put_noidle(i2c_dev->dev);
 	pm_runtime_disable(i2c_dev->dev);
 	pm_runtime_set_suspended(i2c_dev->dev);
-	pm_runtime_dont_use_autosuspend(i2c_dev->dev);
 
 	if (i2c_dev->dma) {
 		stm32_i2c_dma_free(i2c_dev->dma);

-- 
2.56.0

