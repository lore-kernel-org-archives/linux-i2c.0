Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794257445;
	b=A2ZTmVVY5vYrHpI/65ha8XO/XiIiDaDJajxH1WBKChPmYweUqJG22xMmcZlIysyV8Fik
	 4w7dHzA73elc/0k5YfTVYgC+sPClohS7Mbrv+4KyLI8++SyaNocdlhluPl3IMoYIsFFR7
	 eLRlMljgo4Cc00+Jn0ZviFvMLQcFsKGmhnD7olpCA6/A/pw2ajtxdWsylYs6WUbct5FjH
	 S4yER958eBtaFbY5KUfVhP84ciOQoxOK7/At8geLevzFXFphcETblWxIkCu+I7ArCTQMe
	 /c2G1BZgw1yAzR7P6y70JtSM+uOjVV/r34cL2GHoZHgYpjDL/FxIVtVyhz/AZ3ZeqrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257445;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=sSztLIfTL7rP91viwwmG1Mg/R15whdkK+sNzl7hpt+I=;
	b=fgqT7S8GP52euYC/gGU2brmJsG6TXohpGhBBk9tdna7Jzlw/8uie3oX5PbtO7UQwGT1i
	 VWWcKq8D02AIc+AwLQB/hG5LUC2Ywof4rpDpaKUem9qyMkaS9Yz+JhBbk6XKrQFm/aXob
	 PmuQO8Xgy240oFFnbQzSdACwtlKw0VPbo+BXampK3f2tLU90C2Ibr5ITjvveV9Y0PozRc
	 ipP5ImYGM3BNbAXg20XBWBrghdiKIPSt1qt8dRPV+WP2dj7+J/YdXiwW1sPKlD7+HYh4F
	 fMpkDVPOLV5lcHrEp9xGsMMakoGjfHi+z0cf80nqm9RPXi2Fpbuwq0xTvg0k6u6jZqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iPKYFLqz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC32606A321;
	Mon,  9 Nov 2026 20:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iPKYFLqz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B251F008A1;
	Mon,  9 Nov 2026 20:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794257444;
	bh=sSztLIfTL7rP91viwwmG1Mg/R15whdkK+sNzl7hpt+I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=iPKYFLqz+EX/z3/ZFdGtWsQmCPWBeUHQ0WI8Os9aYBpocCiQ902L2eBjfSWSM//JT
	 azQeruoU98mrIXFU8MXVb3JlvUaz3MjMEPDRG0z3IZ0RWo+XU2RdhpJKXT8gUJrQPl
	 Z7v4g8YXDLVaO4int9AWQMp7oSmuLWYOgTQuEKgKa0o9KmIVLo0m33LDLWLGCz+7xm
	 usHFrjzXJ21q4PWLm/ZUbZmFbbps4LNfqw2zHZ0YwFmvUeR8zRgHUnv7bSTkZOBDDF
	 A+5Gfue+sWm/I+7+nMQIfWuq633v2bYQw5o5f25WsjCWghhMzk2vabviyfTeG6h5l8
	 +yXKCF2gC8jHg==
From: Joshua Crofts <crofts@kernel.org>
Date: Mon, 09 Nov 2026 21:50:07 +0100
Subject: [PATCH 6/6] i2c: xiic: remove redundant
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
Message-Id: <20261109-i2c-remove-dont-use-autosuspend-v1-6-49a08b8daf36@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794257409; l=1070;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=dk1BkhlWjkfHfvbN45iKopstDS6LZ1zhMuFGwU+ohvM=;
 b=gHAAkd+gnKdoDSGOhxX08WF7yeK7i/NYttu//4RK0Na+fNs/flmaeV7VOdKxUp2LFm9eAo7Zl
 T16cg8odT40CfnbWzoVlwiyfw0lyGeQFL0pJqdNDHA57bO4xpkMzqSa
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
driver core is now responsible for undoing any
pm_runtime_use_autosuspend() calls on driver exit.

Remove the redundant function calls.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/i2c/busses/i2c-xiic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index ab7916745ad3..4e06fa4f73d7 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -1580,7 +1580,6 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 err_pm_disable:
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
-	pm_runtime_dont_use_autosuspend(dev);
 
 	return ret;
 }
@@ -1606,7 +1605,6 @@ static void xiic_i2c_remove(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 	pm_runtime_put_noidle(dev);
 	pm_runtime_set_suspended(dev);
-	pm_runtime_dont_use_autosuspend(dev);
 }
 
 static const struct dev_pm_ops xiic_dev_pm_ops = {

-- 
2.56.0

