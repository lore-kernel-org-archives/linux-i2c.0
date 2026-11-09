Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794257419;
	b=DdvZwyYECxGkgnpxaF+2BhGQyaHnRrRH7olRdhOCQhmQ9BIJZmavPxHyKHy7x+ehBGod
	 T3PMuPlixi/sFsv3dAm0VoFM8wlYXpq/6NzGLW7Q10jeH/7GSWufscbPOMOsSQd1BSClf
	 /H8yc+0IpM/8JLh8ZWexWKKBoBSuyl03+x59RVi6gRPZx5z5PVTXZdZwEeHzs6aRCIvO3
	 3kHEqisEXED8XhqrUNO9vcVbQ/Frd6rbJkbXbHns60ocg9R1u9g7F5f7iEpYDN4F2GbHj
	 27KPhFc3emQ/9LKnAKcYtq0l5PB2RkLnizoMAF8CLLUWJY/ZQwoN8eBC2wk65l5eKNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257419;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=7miTEOiplQxcmJ88x1q2T7iLbj4kl+6UoeaymDMDFLo=;
	b=GLYaQ5Iw5GcPpKr8pZocmH00Q3qH89TMorsRiDLWZeX04MinNU1yQUlW21InrC0LcJHg
	 zUhnIBWTpYnAbw4DrhMYVBDHKbLoRsWECH6eBmE2Dzm+gz3OiYc5ozoTCFLAfmeOjo2oI
	 5nmBZ46I1VlzXwVTu0Ihz18BbSg9g+vhwyA+I5hyXPQooql9khJWv27N5VjyidKKa1HFR
	 ggYhfbyQPYXqRUmk/ZyTS7GfXODOVOnLcpadg/d0b/JKcYgh1C1uvfLqDOYgSf2qwU4wr
	 VjRlEOBHq2locZYueQVnpvEri7CPaG4BIxi1lgfSKTApZ/vjOR8Ouo4feotqnrFFz4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WCR+mA6F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F886606A325;
	Mon,  9 Nov 2026 20:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WCR+mA6F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4471F0089F;
	Mon,  9 Nov 2026 20:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794257419;
	bh=7miTEOiplQxcmJ88x1q2T7iLbj4kl+6UoeaymDMDFLo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WCR+mA6FhrXWzBVl/1COK51IUdy8LfFnqMehYmnxGdjBSB/luoY3wOvfhxJP4KH8U
	 NSgoj3liX65nPulNP3UdtUf3XxOo+HF4tl2Ql7+n0MRTPRKQZBMAFKQ79vfrwSQO++
	 syunUMGE0glhowcAbxypI1wZfx3ipJrdjio4YOAuYKWcPjquYhjFIfX4CTT/qYzbkY
	 CeYGGyOgoDHKCLJZBxE+xy2D0PgTZNGFOyviTQqNdqzEabC9t1oMFpUzcisaMG2Esn
	 fvDEpw9XKNS5wQAgeygD6VfU2WODjW4iMwu/i0J/n+zjLtMuwDhwOklzkCnT5NWqn3
	 QCeLu42Fmrocw==
From: Joshua Crofts <crofts@kernel.org>
Date: Mon, 09 Nov 2026 21:50:02 +0100
Subject: [PATCH 1/6] i2c: cadence: remove redundant
 pm_runtime_dont_use_autosuspend() call
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
Message-Id: <20261109-i2c-remove-dont-use-autosuspend-v1-1-49a08b8daf36@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794257409; l=889;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=x0cVAUy8IYjp+jUMgpdBKfb2DOQoqoodKMXtnZKYq4A=;
 b=Jnfhon4DZRhrhz8foy+27RAp2SH+92NVbHheQRsorpw5srsM50CwbNsPxenkwav2DT07DMMxI
 Bv1lWNDJp4aDrvZXLh5zIU6+LnAkp8IffMOZPXZc5eEkOVKIIL1KGc0
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
driver core is now responsible for undoing any
pm_runtime_use_autosuspend() calls on driver exit.

Remove the redundant function call.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/i2c/busses/i2c-cadence.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index 0c6887da47d1..8e65ea474a84 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -1628,7 +1628,6 @@ static void cdns_i2c_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
 
 	i2c_del_adapter(&id->adap);
 	clk_notifier_unregister(id->clk, &id->clk_rate_change_nb);

-- 
2.56.0

