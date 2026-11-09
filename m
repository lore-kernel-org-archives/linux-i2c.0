Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794257429;
	b=p2VsEuQpAoDDML4MtNIvvsv0819Ov5G8wGd+034IQmROckP0ym1IxWBmY4vw4qzWbEr/
	 DFBPc/fI/sTuJOSm8a3nrX8gbFYWSiI6NndcwVoB0M0CJ5DQ1pZOmBexla7qMedVFZ2nC
	 xwtTKYx3npYW4wgSdMBG8QXSKwsA15H6i1uxfADcW4W6NMyhvaNN9cveIMd4chIBUI7v8
	 SAaxpnfgxMJI6A1GvSraogmhIBj5udo0J1cHS8sY4cjoxhz1va7sAu57WQyesJ3uboGvY
	 R+DNiZ69DUwtWg1eWeoQwgDdGMKSb5KYCK4wm5lRYt//tVG6yuib+/EKL48fl/fX9Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257429;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=XtZw9RiZ9ZP/coTCe+5jx9QB2zpmHdqGFtZ4US7R/6Q=;
	b=eDjg/X4QeVgO5CfmN+O7MWUTkWYTm2kOlJch+IdvjkUHIZ+HBUoel7VtIc6niMjDkMkd
	 wRSofnKo5v5QBtXfjFVGpVvPjglbSq0SfQiB/mEaLU8DMY2senOPAdPcKqdpGLXkNbj+a
	 GVB//+2IxNPN7cNGmOFu7UoM201hXfi409vU0brWU4hUEwWjI+HJo8qs+q8HBcIl0Y+h0
	 +I8Y2drAAJnGRJvdsMcGd9RvM6HH4vLwdpMydf4zadpc26fRjfQvpUeBZ+F+85sewkxXo
	 Pv85I/n8rjK/A+B1aWFIDzHhdcYkEZ7vEF+tJD+QWHTTDk1CSr7AxlkcEymfZegWg1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EplhOPHT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66913606A325;
	Mon,  9 Nov 2026 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EplhOPHT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6D91F0089F;
	Mon,  9 Nov 2026 20:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794257429;
	bh=XtZw9RiZ9ZP/coTCe+5jx9QB2zpmHdqGFtZ4US7R/6Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EplhOPHTPfyf6pU+s2WLgVAGOzyCjAna86YBf/9xKnVVz8iE/GCKKi3h+ec/H4JDy
	 NpzQztqRWuyb/mvG513Q5HuELmPtL4fhkcWFP66bgKsKSWyfCLrcaMlFHI9aNikun/
	 CVaDf/SIbrdaArrC52hbcdTzrIdqc+vkRi5s0jFujmW6oMpqcxmrV4GG6FJsLxu2zV
	 5sgCOhnBUUuDWNJgSHTqRQ+Y5sKh9Aa6Z9wYOqe6SQ05AWd7LHseuwBFtZEMmQZ9DF
	 42orcjm7aCh/nCHvTRzjuxwt2BqwKzlrUWtbQBedTD0vdBmsvPrNZHavVhXj1thepv
	 HDqWuHEP2Bx1g==
From: Joshua Crofts <crofts@kernel.org>
Date: Mon, 09 Nov 2026 21:50:04 +0100
Subject: [PATCH 3/6] i2c: imx: remove redundant
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
Message-Id: <20261109-i2c-remove-dont-use-autosuspend-v1-3-49a08b8daf36@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794257409; l=1098;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=dFiUdJiKgbqssTJINy3nJUb9IlGxYj++ayLzL29F92s=;
 b=tAWNJPuvEVeEADlATh8dc1kcMG2aU+Hci2YxATHsp1CxFbSi5iEfbo6ebkUZOAUS1F8+8Wjz7
 TzWaFDnmWFQDu4tKdvvkEdFx50Cy9fncwaTUrBCu6ntf1zOClX7RE/J
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
driver core is now responsible for undoing any
pm_runtime_use_autosuspend() calls on driver exit.

Remove the redundant function calls.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/i2c/busses/i2c-imx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 89f2b764bbc4..05906ddafbfa 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1964,7 +1964,6 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	return ret;
 }
 
@@ -1999,7 +1998,6 @@ static void i2c_imx_remove(struct platform_device *pdev)
 
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
 }
 
 static int i2c_imx_runtime_suspend(struct device *dev)

-- 
2.56.0

