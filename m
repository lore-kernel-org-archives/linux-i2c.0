Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790E839DBEF
	for <linux-i2c@vger.kernel.org>; Fri, 26 Jun 2026 02:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782442740; cv=none; b=qCV2p77o0sz1gjkWcSWe3GJ7UYeNTMtgde1IJYg9uGIT8N8wQ+nvqZJGZB4ks/746hFioGvHrHKCpmoZMrbY+MljZqguUzgBCdq/SuzSGGtTdDnbAC+5+S/RPfyQ/LOqeVAb3imzkX2KCvFSioWi4EwsoUwMzJPzRR31nXY0YSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782442740; c=relaxed/simple;
	bh=aG0d86+VStYCLhrRw4TkiqCfZ90Xd/Y/zoM5y23rOFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EGyw6C5aDx8/mspVPO3dn+PzsQ2YLNfUvexRt7oaIdhooL6qQKJaUDCNZWZbKWk2kAlTS+PqWAm5dDzrJ9HHKz+c+HZW2bojpnGlU2jzYF/5Hr9EY0h3I0O4AAIiO2+SY2V+QJCnu1fjhfVDChpMdEbFylN1SO5sDOUaDr57Rwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwLo9oBx; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwLo9oBx"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c6ab886da6so3461695ad.0
        for <linux-i2c@vger.kernel.org>; Thu, 25 Jun 2026 19:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782442738; x=1783047538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVsjU9yKl2cJB/WfxCzz06jvF+n5PC9ZLu0AFLXamVs=;
        b=XwLo9oBxqluE6pY0EON2hm6P7RuqqkUhGaRoqB+qQT5sCROnn/EKsDa0JezXNCdsIO
         XBZsR5PrTVIvqw36QBbjIDYv80YGL/OAVa1t/PB7i7LLjtMkeEY+Osb2wmAwfULyYYej
         lazycJAdzx399o7Av+7nBvX/EYAgp07eEqPAPVAjYlXPXkVmW7Gwbr7Io4ilQoae401p
         sAs46jPo/Xsf7dvq39oDzJeepzFRHlfki7jtbyOaPkaxT/Uo0ChGoaRTDdQkJqjT4/vR
         L6Fc/O+JlBKluZHSrI/9Levry6nCa3UjRe31VPjj9ZSq2koRAgmXJAB/lZs2f9TV63E9
         fksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782442738; x=1783047538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vVsjU9yKl2cJB/WfxCzz06jvF+n5PC9ZLu0AFLXamVs=;
        b=HG1v1HE1evYGtt+BbhmmffKZpVUrQQGMSOyitwTq1GETkmXPs+FSKzM1WH6aV6lB/W
         ej4PBXyQtHLBHUgZj2bftepinopeSjKK8zDrOc0yPbyJkZDRDgi62k40Q434CP/cDlTc
         JCexEFYp+esT5DyfQFfVS61JCDiarFIy/FaSIu7Yl86aW1zEeh9/JgTlsLGs425YzpUU
         mpwYHvzda04WpCdKDtEdyymhPvhN5XR7tAMUMbaVd3T0Om5tLkNkWQ+opBrqmt7lNRZ4
         BllqdngxmM9sZ99skcswiAogPrcTM3LtkvyhRZGD4xbndHpgYmiKWn+2tNltrOJ+OgY1
         /acQ==
X-Forwarded-Encrypted: i=1; AHgh+RoCkChryWWxUYCMDF6aGqq/GNJKfj8ejOtTBPd6wtBblpI1SpLuZZpgVpLxsXEpHXs/4hLw3hDNO2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwypPV9f0gTTp0vcwbgaGfHP5ECZOrzv1mQnRlU6yHHmIE7pWBR
	+Knc1FCf+d5F52sr9QsV+M73XJlBB8F4Q3Ne2ypdqO8S1mMSdVKq8xxJ
X-Gm-Gg: AfdE7ckskWi9g7gzilmsee3iyvuurpVwRz/E/dKsaZIM6lxa/O7xs5rm9I3CU1c6975
	t/ZjYO8mohqfHRnmyR80MsyMxCY825oFVL8uNXjM+v67+/v57iFc5hBAn4Li2FlX9yNDzD4TTpJ
	GDqg3Mj85o3nlDZO9f6logBDFSJ8mutAeDDiP2DuKRiSHUSTQdQF9yN/uAWIU7VG9pFNbPtEBck
	QdpjKIxOPrdqOsjIVZ+ZmcHEjw3maKMF5MlOZd5lTtJmaLcXgHob0jXWu69GQaNzkRqyNHK4WcJ
	EokHfApspFjs8DEFiTSgH3OgOwD/bMPVSKkYxDyG7FRSgRndGhNzQeUnDFQPSwWZZGyBAb0wXMh
	Qr5fmNaVUh+64YvH9DDX9x1H3wPwzn9uH1ERShkQESOnQJLYHmtJzxkd8Iq7xb0NNwljVQyT8Xb
	Lfzitwr6K2Bdw=
X-Received: by 2002:a17:903:46c8:b0:2c7:d071:3ef1 with SMTP id d9443c01a7336-2c7fca19129mr53387105ad.19.1782442737717;
        Thu, 25 Jun 2026 19:58:57 -0700 (PDT)
Received: from archermind.. ([182.150.55.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5afb1e0sm31252535ad.29.2026.06.25.19.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 19:58:57 -0700 (PDT)
From: Liem <liem16213@gmail.com>
To: frank.li@oss.nxp.com
Cc: Frank.Li@nxp.com,
	andi.shyti@kernel.org,
	biwen.li@nxp.com,
	festevam@gmail.com,
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
Subject: [PATCH v3 0/2] Fix slave mode corner issues
Date: Fri, 26 Jun 2026 10:58:44 +0800
Message-Id: <20260626025846.106157-1-liem16213@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aj1UR5ddawsdMbZC@SMW015318>
References: <aj1UR5ddawsdMbZC@SMW015318>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes two issues in the i2c-imx slave mode.

Patch 1 clears the slave pointer on registration failure to allow
subsequent re-registration.

Patch 2 cancels the hrtimer before clearing the slave pointer during
unregistration, preventing a potential use-after-free / NULL pointer
dereference.

Changes in v3:
- Split the original patch into two separate patches as suggested by
  Frank Li.
- v2: https://lore.kernel.org/imx/
  20260625160219.55116-1-liem16213@gmail.com/

Liem (2):
  i2c: imx: Clear slave pointer on registration error
  i2c: imx: Cancel hrtimer before clearing slave pointer

 drivers/i2c/busses/i2c-imx.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.34.1

