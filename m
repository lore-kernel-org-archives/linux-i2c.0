Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060EA3CC31F
	for <linux-i2c@vger.kernel.org>; Tue, 30 Jun 2026 11:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782817707; cv=none; b=dcE346uEN5veuh+/3zXtJjclbS0nklu7yKlWGYXWWFhIEjnApIa1xlWd+OixZkSfr4QeWOOd71NSde8QXVfRRmqFrP2c+33Q/TI3VWRYXiWu+mH7YJvhWcYpVKqThN9cf8sezftdch1kwDp8JAPbajxa4p8tpIf1mkvWvnFqwJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782817707; c=relaxed/simple;
	bh=UhLHL3u+f8vmIRPpQfw0sweKyA+oiVJlf1tWLCUZqSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lfqB6nR+KH3aMrRScNOFUt/aEftFWyJj+P1pmvON6X7TOyxhv9NwEeNGihBjDAO1iWZTXguIAL1YW4eBMXpVSuHW3jnOVweON0BaRy6vPGulPrCP+YaGgj+lBjN2HFXLE2jKF/Gm5JbCm4zbx3wAitVckqfxQmT1422O8kf6lwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsTnNZyH; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsTnNZyH"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-37ff798fe89so1227373a91.1
        for <linux-i2c@vger.kernel.org>; Tue, 30 Jun 2026 04:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782817705; x=1783422505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6bh4jBEphMG7ihkZ16kaaoOAnDIWxUT6Wo00wnq5q+E=;
        b=ZsTnNZyHpikj7hzYAVpdFtISYte0zsw2WzOs0o0spHTiJamDcMnRQH1Tfr9440SQEG
         W1U105LjhmKaaKCMu6JEBgMeNtq5OcaYgSD7cUqzuxC8m2RI6QSX9ey3kWz4Ms3xd76+
         ifqmaRcYNdEqp/PpKXhK1YGgUSogsh0at56TbtTZibZGkJY5sAxrKJghbKKFOMXXMcMn
         dj973p+T0RveLwCEPLaaKk5Tfn9QiQ0RLvmXQJJlUUXlcWw6ieUqAcOE736j4787tOm6
         Dig3+/EnmWFem4uETwF5E+i16262WmJDM/1NzF3WgHsESPufIF5hJnHJ2mzDmdlFhsGZ
         12eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782817705; x=1783422505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bh4jBEphMG7ihkZ16kaaoOAnDIWxUT6Wo00wnq5q+E=;
        b=ZxRTyIjVmDbTfcYR88e2Pzmqzp7gI79qgGyle4v6j60Algbnn/aY+4Tcvh2f1p55zP
         95A4MhF00pT518gB5ThPBp0nYju3GPapyEWzwqzK44NnhDOl175fu4Ktv0khVzkBkqNs
         wLK5JQOPvJVsuTzXNJa7P87j/vz5UublcUvTU4PBzy4MoFM2NJZDesW1kYzMxGHjNZtN
         daipVz2SKuO00OPO/2CcEwp9CjoS2uPxm3SXYnEjgO4JxYOZqK2jynaOIhXsdC3S0g7i
         FleqbM62lq+Rre2tkrqCNSdvfZRf1npPW7NFhpY83dbks4Uip87DL7Ak0qvyPAM2WSGZ
         ppDA==
X-Gm-Message-State: AOJu0YyS8/LBeLWUSSezC6bS+nSHfQRuNYZNS/qKJb0L01xZM2PlwsF4
	N+piJQpQlnGf//9fPSdvKO4br4lJOkxrP6zFVPMA2DAq0lQjXg3u0x/k
X-Gm-Gg: AfdE7cmoZbbQCk2Yt6V5oM53+Zus5NaR3WbKykbkfdTeexOfehMfTRBLhvM1fwyUigb
	Vx9jILjjzyy4SWOB7up5o27aA+cqXOFJtbWog8zngEzzo3CsyFx+PzsSElZFYVMTaEW/777dXb1
	e1sP7hPv4ybTkrmAAMORG0wH9LjVJf7hle7MhkHb0JwJWCaBqAn9ZPb4SLsztfn5hFoKjB/4qSh
	EO4cqW+gXMn5s9Tly3TKC/Pnn+i5xfSZNGQwjh7F256VD5T4ecIQuyMof/m53HCMlL7WiD98bNA
	lmPCioJo1+6E7hZZIauCcnw5g93vnRODd9uIxQEPbiLcHliRAjX39xOavfnY7uc3Qx2vbLPy75h
	ZqEWP+nXCQNdYHABxNVazCklC5CliyVsl4dCVVFYV7POTfGnYniyj0GzqaP+Tpy1wV9JDOgx+Du
	1wwUxgIP0V0rnj4YwDfoP0qsCt332fr6FAdyLUMaFCru1jzA9dD7ZY7bUZoQ==
X-Received: by 2002:a17:90b:3bc7:b0:37c:6505:e7c3 with SMTP id 98e67ed59e1d1-3805273970amr2295663a91.22.1782817705202;
        Tue, 30 Jun 2026 04:08:25 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-380532b020fsm1501738a91.1.2026.06.30.04.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:08:24 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Stefan Roese <sr@denx.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH] i2c: mt7621: Use dev_err_probe() for clock acquisition failures
Date: Tue, 30 Jun 2026 18:08:09 +0700
Message-ID: <20260630110809.559134-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Use dev_err_probe() when devm_clk_get_enabled() fails. This correctly
handles -EPROBE_DEFER while simplifying the error handling.

No functional change intended.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/i2c/busses/i2c-mt7621.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt7621.c b/drivers/i2c/busses/i2c-mt7621.c
index 0a288c998419..8b0407d70c4c 100644
--- a/drivers/i2c/busses/i2c-mt7621.c
+++ b/drivers/i2c/busses/i2c-mt7621.c
@@ -280,10 +280,8 @@ static int mtk_i2c_probe(struct platform_device *pdev)
 		return PTR_ERR(i2c->base);
 
 	i2c->clk = devm_clk_get_enabled(&pdev->dev, NULL);
-	if (IS_ERR(i2c->clk)) {
-		dev_err(&pdev->dev, "Failed to enable clock\n");
-		return PTR_ERR(i2c->clk);
-	}
+	if (IS_ERR(i2c->clk))
+		dev_err_probe(&pdev->dev, PTR_ERR(i2c->clk), "Failed to enable clock\n");
 
 	i2c->dev = &pdev->dev;
 
-- 
2.43.0

