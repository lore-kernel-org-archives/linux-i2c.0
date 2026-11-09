Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794257434;
	b=DNB7lR0qAwkxTXMTuRXU4Z3dIQNQlrp6Hg7XaZF3KH6e5IWib0tltN9YOzGoOfTToCms
	 BIE2wFQFrpvxp1Y3GIm/5AVQNZkG3RlAnhh3xlKqz2ok8WlNVpefGK4ECX7LvRKAHne4o
	 KmJ0P9mnJjxqDPCvPjt25jfigmz8blthpol9PTjhqABvHdtapU+8s1dfipm5pM+jbB/lJ
	 CKwL+mBoFIApdq2YerUplhgZYmyWNaK1ASVVxRt+VMu2oo1XycHPQcv5ZSBGgH4HBmjvH
	 Q3xeJrQ919r4Z5EuXSFrtEeuO78OH0ydJGjUohFvJ/SCiuOPqg7fL/Awqkmu7tD3/Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257434;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=U3dBz/jVADkkXLvlpKnunp0HEFmKspxrcSPqzBVm73U=;
	b=4M5ZDrcpHnDY6fY4YvQMLgC1pynNEjVXGdys7OwbsxxFFq0lrHxEMYF/8IPAO1KZxjED
	 WFwhgxJT+fdiPDCEiqmZIuooBrtBvnJoZlTsTD9NqOwvOiEOwmmhj/pSGSwA9Dc0b1vZA
	 WOeQFJzPTuWxcBfBew2MFlB5e5LnZTPEpzuK8H/LkJL4VXatLECbguNIqqxvyA/x/GMwg
	 M1rawyJqdODzuRhII/0hAg5ZpOREWioVQDhMyL/Elbj0LhZipDzCFIMT8T5uWBSA5FUu2
	 /c2xUWKUmcZC3wPve320DA5PNVkc8t9iXxEN9Tnrm1wp2t0gOCab5QzcFmYWJ3DXMkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IuFRFLLB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75546606A326;
	Mon,  9 Nov 2026 20:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IuFRFLLB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E361F008A1;
	Mon,  9 Nov 2026 20:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794257434;
	bh=U3dBz/jVADkkXLvlpKnunp0HEFmKspxrcSPqzBVm73U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=IuFRFLLBcJhl4fO8HFoYvnm+hiFuvQF5+RG82n/zznu/lt36a7tnep0pYzweJ4W3t
	 SF1qiQknWAWW2p5J5Z53YArpcCHZzLx3uUQMhTDHY1L79MSVGYmqAoO+T/0Sd34xfM
	 q/BoIqT7jrnUr5wVXPlqzU9PsdXP/hU1deHWLoRfJTFTx+7yJ3Gt+JoAX+MfTSUeTI
	 6LNSFE/i6IHMVNxD2wcnbyYUS1RWBMLWPe53/0nB/5/a/zj32iy/kEG9lX8YOMle7/
	 P2MAKF8lqeAJdmQHYP2xE+Jz/npOx8I4yKbf0ZMQrvaOEVBVOpG+bymI0brlF5Fxwt
	 FwGhCwUR6svCA==
From: Joshua Crofts <crofts@kernel.org>
Date: Mon, 09 Nov 2026 21:50:05 +0100
Subject: [PATCH 4/6] i2c: riic: remove redundant
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
Message-Id: <20261109-i2c-remove-dont-use-autosuspend-v1-4-49a08b8daf36@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794257409; l=998;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=IVSers25eoM4DZzx6qxJHQbEMpXnYtK71Jw2toaHrq8=;
 b=t9pE3zY/+7WdfcULSx+Gk9C4x2Vls9kHzCAWOqg1ofU7Ri94Hoa8R1JslHm57Ld4gq4gfV+Ne
 IZ9yOf4qusGBun4WPDb1MluRTItABlkU+1xM5TS6H4Wh6yoC5w6rwrg
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
driver core is now responsible for undoing any
pm_runtime_use_autosuspend() calls on driver exit.

Remove the redundant function calls.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/i2c/busses/i2c-riic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 26b9d608fa28..57532dd2e3ea 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -591,7 +591,6 @@ static int riic_i2c_probe(struct platform_device *pdev)
 
 out:
 	pm_runtime_disable(dev);
-	pm_runtime_dont_use_autosuspend(dev);
 	return ret;
 }
 
@@ -608,7 +607,6 @@ static void riic_i2c_remove(struct platform_device *pdev)
 	}
 	i2c_del_adapter(&riic->adapter);
 	pm_runtime_disable(dev);
-	pm_runtime_dont_use_autosuspend(dev);
 }
 
 static const u8 riic_rz_a_regs[RIIC_REG_END] = {

-- 
2.56.0

