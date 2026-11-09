Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794257424;
	b=Jmb4Qwy5jzVUscHjh3Lzs+1PvLcwNuH3g1unP0VynIs38Viyk8cs1hANwo/ML2hEEiAg
	 cG4zLMXGNlGtT2wJVySoFRF637qAE2YHGS1kqVbEj8dj5YcBKHqAAdUcHOEQd5sKcvoqT
	 Wne47iVJptSUACik71V84zA3pDyPNK5+DURixuVd2IMIRGfwZF0GJqqoBd6VDs0xccmJw
	 89GNm6MqfdfSQajglK+o4MVJz2S+yoeCx/+j56/k+KnQxK2jqrK7M3fr8qMwVi1cQA9lO
	 cQU1JxM06lUZThRbKtdYy9neDyKB+J6z66uWTZRtDE2N0AU3bwZl8KMj5AbkMce6CLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257424;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ega1vQ2CDY/HzdEsbyX1IiM/sEcRjuH77QeUKn5VUh0=;
	b=LA5SGioa7zaSTOFo03UUn876Z6DPUQzcejnt00mTNM5AgMRfOGYSjS6618uH/oyjnybv
	 77MSB2dB3pRgh2Wh1u9VRAsj6gL4jpM7bMpR+ul3UgNz+IJXsLYDfAtR7Ms5HKCKaeZCJ
	 jPYML+KMIuevRHYmDbRQYB8/bO1i3cVOok9tAENvfUTv86c5UyIf/NWNOhM69aIst+PoG
	 3NynIRp0GbLGz2I4GAW/fSny+mx1rl/2blEBG5Cv2QFVXrX2eJmTQoCSXlm9l1nzZqTPg
	 YlxmR+MjuY/v3a0O7YzMCC2eXhhAJUQUFHdzLHb3CcvuxDAEG0QzkRDYOGmVCOQHMAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZVfZc6uh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F3E606A326;
	Mon,  9 Nov 2026 20:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZVfZc6uh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E5E1F008A1;
	Mon,  9 Nov 2026 20:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794257424;
	bh=ega1vQ2CDY/HzdEsbyX1IiM/sEcRjuH77QeUKn5VUh0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZVfZc6uhCnWKWT7yjeZaaFliUPH67rtfP9YvS+RAzc9EYIRj5KsdxSljTh+HzP6wN
	 8oT7BwTCgfwxyUtJvMoWBchM1IQeo/3F1Ji7HihLhGlluo2cmJw9wv4iXiZcQYRDxs
	 4KEt8+gClZDhjzai9o8bNZ93LD+COKQyj/cBj6fwqiEt2/936uUf6DjxsEpcK9zrRs
	 BuVPRehYgu5dAwqWvlPg3JZtp6pIXLvfAqHMCS2QmBZX6suzqk9ZAaKs7xiFs1cmjz
	 ZsyYa9n6o2neoiBspLFrUY/+BdOfnljqDS3l/I2XbAel3kg913mXuMGPpuqJspZRiI
	 yf5taFtq85QJA==
From: Joshua Crofts <crofts@kernel.org>
Date: Mon, 09 Nov 2026 21:50:03 +0100
Subject: [PATCH 2/6] i2c: img-scb: remove redundant
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
Message-Id: <20261109-i2c-remove-dont-use-autosuspend-v1-2-49a08b8daf36@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794257409; l=849;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=NodHhw1ykeg2hVN9scG0KViJ0ETpgpTWRaROalsumsk=;
 b=MgGri77pJ3gRjcUCX0+nBVvyiHYhN+Y4cV6mXpDSwFGS8nu0ny/pA3mgQKzpT5/fXEC79dYYI
 zkkfFeOPVTZDiSkoQL6V98YCp1SkK/ASR3511i9DsoEHzhjwhCh2azM
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
driver core is now responsible for undoing any
pm_runtime_use_autosuspend() calls on driver exit.

Remove the redundant function call.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/i2c/busses/i2c-img-scb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index 9d2ee449a40b..9b7142bf0059 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -1403,7 +1403,6 @@ static int img_i2c_probe(struct platform_device *pdev)
 	if (!pm_runtime_enabled(&pdev->dev))
 		img_i2c_runtime_suspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	return ret;
 }
 

-- 
2.56.0

