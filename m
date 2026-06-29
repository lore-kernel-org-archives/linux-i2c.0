Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9133535E1BC
	for <linux-i2c@vger.kernel.org>; Mon, 29 Jun 2026 02:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782700720; cv=none; b=BPPmLkS7ERcZUqLt1tM/7wbQWZgd8ZQlhwGu4Nsp1n81pErd7VZo0c6p6OCwMoXvgS6WFlkgtOoSgfwRSOxNI2oPwjebVW9LVPOKJXT7KmRU1gUfcLGqFgrW+0EEUQOwzkEyYS81KqgNbwBmtW+bUsX+oFB5bfD4vfeDYHzKjL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782700720; c=relaxed/simple;
	bh=DkX9vTSiFgNjVTUlOQE2kuUmogz0cH5iWuiWCqbkZpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZRa1hjRNSf70Io8ow0NQ5tGWyMte5j+x8YPdR4f2cJ1pwcGCIp1nGyiqd11Wdpm5gVBnK/f6HVXb8qhQRBX/x/QRA5n4p+L4TVcwcqdYSeYz2LklrfNFEy7POaWqIpLr1OYSK0Usz3CQADiTdiw0Dj78kdXjFA5TP/tdNG3HflY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ps3ewnXG; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ps3ewnXG"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-37fa53bc22dso1723212a91.3
        for <linux-i2c@vger.kernel.org>; Sun, 28 Jun 2026 19:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782700719; x=1783305519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rm7QBZ2TRjajMaYCqvf/rtcGfIdt/uUAyLjjoINRG/E=;
        b=Ps3ewnXGR162EbY23xKuzQMiOPq+jezG8r7t0+XOLUhk0IsuixBwwMc+UP0fywV14s
         IXADc9VNd5jK2FnzX4mbwZB1fVW7B+t3gmpa+lOkaZDQEiT8jiB2gXpjiJbJ9I1MTTSf
         v/V4s1O8VBkbmniZ3/mVW7Ip4aFuqBRtpGyxUiP+EoI5r25Q1d4zZdBZA5caXgkg0N29
         WYpuzmL9OeKDKh2cgjiv5qp5Vyiv9YR7Tuy0ccIGvhPdQN5JdpnsGcrjc/9m2ufF14Db
         NqYGOailPF94jNzJMfybun9wJ+LqNw6x+2PoMDXJu5doiq5aJWSWi+XeMm5sIHsuIH7Q
         ZLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782700719; x=1783305519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rm7QBZ2TRjajMaYCqvf/rtcGfIdt/uUAyLjjoINRG/E=;
        b=Uxb8YJ6k3Osh82LUo14rVPKOax+K8eGZ9a2n+ABewtwD9qNh/bFkKFkT+KY7YAqk7Y
         VvOv7ARO4HBmcKnNELGhQ2HWEmPbC0HvmHUirCpl+yEJHxZ+YOTG4f4n52YoXNTBN7nD
         OnFZSxkszL+h/gpP39rtBdUFaT5r8EcCEJj5R6YBV1BQ53PjY65ZWhRZZglr9fYiQpDF
         l/DDV5SRK34lY2w2kZXXj1WoUPAcE1nMzfMEF5oNy3aJjmktW1jasdOoYM/EFAdK19ti
         fHGbkZsgC+kSrcfzj5E1WwjxUN38PKLgxBo+3N0piIU3vY05uUNo/xfYLR3LVcl7Cko+
         4uOQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Ae7JrQ3nIR6tHG1YOxX59E0ZyVU+/TwxSbtloWAowSdjuFteKSXAweTqwzGtA3qanNIFaColwPkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPONYipt1+wYwrHvUjKpi3MlcMJdCyggPum+kPO5i/xXRbDJNM
	gZ+WJIWd4bZP+tcULw1RE1i28sw2K9eJVCiyWZzE0xUtOxPLzv9UyDgc
X-Gm-Gg: AfdE7cn7u63yphohc1WlAehxfC1yr81EVOuMPl5Glsbi3OzNd0bGgMo1SdTNCWPFKdA
	I/kSfPp33JcsqefLX6a/aKm2BkAjOk94pg5uVSd+tobf6GZXlhoAMfeKgZMElXXIPqfUFwwm2IT
	mvsraG8LNbARzxLTBy9pk79HSLRzoCiQhgsyi8cujacbiCT68OguLkoqBBCLcf3gL5F/c3sDmHu
	kDRcle0SC2re26FuReuITa4jjwDvfm7vCaMcRRpISuOaVGsYCwYMisuBn9ou/jjrs1lLB3LcVr6
	oglZgKZ16gXo1j2bRsAIyMyROnpAMrxe7Mg05jMlHim03YrGOEbtd677M8EyKGvxuAuzlOdk1Ov
	2/ntIemY3JGD4zyFjfKsK6jAhgmJ1+aiP0cj5ABzLzwwqisnRlHo2EpIy5rAshiTC2dtebFKra7
	JGGbyfj3g+rdc=
X-Received: by 2002:a05:6a20:a107:b0:3bf:6c08:fb9f with SMTP id adf61e73a8af0-3bf6c091423mr8265130637.51.1782700718910;
        Sun, 28 Jun 2026 19:38:38 -0700 (PDT)
Received: from archermind.. ([182.150.55.91])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92b9dc216csm6914869a12.9.2026.06.28.19.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 19:38:38 -0700 (PDT)
From: Liem <liem16213@gmail.com>
To: carlos.song@oss.nxp.com
Cc: andi.shyti@kernel.org,
	biwen.li@nxp.com,
	festevam@gmail.com,
	frank.li@nxp.com,
	frank.li@oss.nxp.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	liem16213@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	s.hauer@pengutronix.de,
	stable@vger.kernel.org,
	wsa@kernel.org
Subject: [PATCH v4 0/2] i2c: imx: Fix slave mode corner issues
Date: Mon, 29 Jun 2026 10:38:27 +0800
Message-Id: <20260629023829.152651-1-liem16213@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <AM0PR04MB6802B863CD9B9AE1609C1785E8EB2@AM0PR04MB6802.eurprd04.prod.outlook.com>
References: <AM0PR04MB6802B863CD9B9AE1609C1785E8EB2@AM0PR04MB6802.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes two issues in the i2c-imx target mode.

Patch 1 defers slave pointer assignment to after a successful resume
and protects it with the slave_lock to prevent races with the shared
IRQ handler.

Patch 2 cancels the hrtimer before clearing the slave pointer during
unregistration, preventing a potential use-after-free.

Changes in v4:
- Patch 1: reworked to avoid race with shared IRQ handler, as
  suggested by Sashiko.
- Patch 2: unchanged.

Changes in v3:
- Split the original patch into two separate patches as suggested by
  Frank Li.
- v2: https://lore.kernel.org/imx/
  20260625160219.55116-1-liem16213@gmail.com/

Liem (2):
  i2c: imx: Fix slave registration race and error handling
  i2c: imx: Cancel hrtimer before clearing slave pointer

 drivers/i2c/busses/i2c-imx.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
2.34.1

