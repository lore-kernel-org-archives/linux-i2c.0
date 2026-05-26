Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570433DD516
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 10:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779790973; cv=none; b=WFE0u/AIP3mGJPGBcwz9KN3edQF5l5V4ZjJKeVeM/TCA6IxFI1NLdQ2ywBK+qitNFGdq+3ZGLCk0LEHjmyyGD72MLzL+xeGe/WxJ42aW3w2Poq8bya3ljvZSodJ+fMU1SgPQyPXVd0zvC70EMlhNCvunxeD8kDkRgHAgNUHunVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779790973; c=relaxed/simple;
	bh=OKtF6eK9AIl/tFnl+6zGmvBcaf2/4kp/RLLsV1dGIS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PCmmPJuAsqVU6tjuAsGVCzDS28mdn9PUflI9swa9qU5v/m/wfb4SpemYjX/xtSY/J1nZCrDg0TI4psKyOgZGK6cmrovRr6hQ0aYmUVgjcXyOxbXsadMB3N4oMYU8ZzvYtrQ6wh/8y4UGFbe8cmF+mB9UG1rZd2mr3LrYUC2SlBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpGu7Szh; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpGu7Szh"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3680540a6efso5815689a91.2
        for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 03:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779790972; x=1780395772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GsMFlu4zMM9QAuZhA61CFIpsfkuzQD+bunJ5hQnI6aw=;
        b=EpGu7Szh8NoEQkcL2TQkkU4E1kbPGxsFk4bw6zCJL5LNoGiwHSoBEi8CRDj0m6mcSK
         YpWo50DDsTB6wZ9MCBQAVSD9X8Wu5uJ+jVw0WxcPlTB3N3MPzE7dDg6rzSRq7I8dXC4e
         6i+ZsUiD3tCpD8mVUbDAa0qoowQ+SmJBMwaBqdwXnCRGLfaT37GHsYLtXl6FgBCI51IF
         YB13Vh+z2BeZONHp9jko5zCW1N9xVak7AWi686uWS4NVGF30qUk3K0oqCQAZ+VrMtW0z
         v1tQ3TVKNm2znIBk9tPSYcSKHnAanauoZGypmGvp4kiiVBzgDEZ5pN05i2ciomwm/RdQ
         vwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779790972; x=1780395772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsMFlu4zMM9QAuZhA61CFIpsfkuzQD+bunJ5hQnI6aw=;
        b=J2drt2k/I/5tIR6IYUAs3QL2P73c7Aq5zWZ/vQcaUhMqCrYKD9T/2pYEeMg7uO2VOd
         /t065oLxXtPlDXq5p560kUM4vXpAmDHFRgBQsZi9N0EQgXIlivpjuCTImd0DWCE2J0oH
         j8gnotVE5qqs30AUdMVfh5CrJcCCWprLNCR/mzj+MGb9SjdATB73x+pJ12Cps+EFSaTG
         GbaH7jsbc615aVsoL/+lKtvZ2NZVCYv7iOGkP5GKmMdmAtnBonuETDxI5BxsQaBJc/R/
         3gALG13n5k1o24xloWjg4XAmJVXq+V9tG3mWKbA3obW/fTioie2QSNGFX9D5JwFJYuwm
         Y6Kg==
X-Forwarded-Encrypted: i=1; AFNElJ8sja2cUl1pnBHgEzf2D6HHL8mLMrP7/Oc/y/dnmF3/gcoiIhs6musImrP5qDO4sZHn3SEeGof1+/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY0CbcjqvToUCb++EXDYNmYKi3SLwlIyJSjFN8hBPGDzcWO6uL
	HmORra8xnF7G1q5MJ4szimfP6MlkotH2CEf6KvgDz6bZfOdXZy+WYbtD
X-Gm-Gg: Acq92OGZ1G1r8tZrXbFxsqRaLPFl8ynRtaWiW6SBgUIzgCi+PADlLCUyzRyf5jRhXMx
	u26vjmUvzav0hDFuCkS0AgKPDaaM9yEQAEr+HJftbTB989PXpv2RJ69MeeU/qkkxO3OeZsJUa3k
	sTP09ESt6zZ336Ym2jREyKSXMc1J/HaWm4650KonoZlw8s7TOIuHFF9oAMrZVpZepFtsELZhtAU
	UDV2hjdgYRqbGIzOBQdPB+zQHcM9cYeQ+b/14D+jCsC6sP+1W/MXBrm+EhwhigLMiv69XzDQ6uk
	d5PdEs4DgTh2LOLv3RKjLhjrj2KfcpTLh58Hf5G2TIo9QuK9V12mMAsZQX9x5QcYfCVusiCEU5q
	gEPRD9SADPJCYYarRvOASnbAFN8tT2GPkM6mqNVmnWVXZo2dTHC4E2hlGtEFGZ3U1ReuHEihmWi
	umg9fK1E/FMYzJlauRZOtBhu4Q56uXj7yoguuNjvA7H9Tt2gcfwg5d1AV8Isgrt2Pj1BJMKQWc
X-Received: by 2002:a17:90b:42:b0:36a:f382:9f72 with SMTP id 98e67ed59e1d1-36af382a1efmr4718899a91.13.1779790971630;
        Tue, 26 May 2026 03:22:51 -0700 (PDT)
Received: from chaitanya-virtualbox.. ([103.249.241.55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a71d9416csm16435713a91.3.2026.05.26.03.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 03:22:51 -0700 (PDT)
From: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
To: brgl@kernel.org,
	andi.shyti@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chaitanya Sabnis <chaitanya.msabnis@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v4] i2c: davinci: fix division by zero on missing clock-frequency
Date: Tue, 26 May 2026 15:52:40 +0530
Message-ID: <20260526102240.4949-1-chaitanya.msabnis@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the 'clock-frequency' property is missing from the device tree,
the driver falls back to DAVINCI_I2C_DEFAULT_BUS_FREQ. However, this
macro was defined in kHz (100), whereas the device tree property is
expected in Hz.

The probe function divided the fallback value by 1000, causing
integer truncation that resulted in dev->bus_freq = 0. This triggered
a deterministic division-by-zero kernel panic when calculating clock
dividers later in the probe sequence.

Fix this by redefining DAVINCI_I2C_DEFAULT_BUS_FREQ in Hz (100000)
to match the expected device tree property unit, allowing the existing
division logic to work correctly for both cases.

Fixes: b04ce6385979 ("i2c: davinci: kill platform data")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260514044726.57297C2BCB7@smtp.kernel.org/
Signed-off-by: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---

Changes in v4:
- Restored accidentally removed blank lines (removed ninja changes).
- Collected Reviewed-by tag.

Changes in v3:
- Reverted probe function changes and correctly applied the fix to the macro.

Changes in v2:
- Changed approach: updated macro to Hz instead of dividing in probe.
- Added Fixes tag.

 drivers/i2c/busses/i2c-davinci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index a773ba082321..66c23535656b 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -117,7 +117,7 @@
 /* timeout for pm runtime autosuspend */
 #define DAVINCI_I2C_PM_TIMEOUT	1000	/* ms */
 
-#define DAVINCI_I2C_DEFAULT_BUS_FREQ	100
+#define DAVINCI_I2C_DEFAULT_BUS_FREQ	100000
 
 struct davinci_i2c_dev {
 	struct device           *dev;
-- 
2.43.0

