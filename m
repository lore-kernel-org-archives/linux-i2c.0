Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BC32737E0
	for <linux-i2c@vger.kernel.org>; Tue, 23 Jun 2026 05:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782193656; cv=none; b=eSCiy0vXxPFsPrPy1QM3/0bm0eZWgeOlHEXmukCknNy0kHdgDS+oKzhQx7M5Xk52jX6FB5X5KdpURjJ6vlmlu9EiRcSyYlpFf2k+8RBzzeTEKt2n7tq8GHU2S7RzVvFRjPe9zYdulncLMZvibsPY5TgVsjyEGJaEdoYyb6I4JUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782193656; c=relaxed/simple;
	bh=xJPNnNjrts5BMBYUMDd7SJN812yW1TjE2bDrl1c/eFk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DjkxbExrIpkJ5e6dDcs7UKu57yRwu43uWowCzkBcE95Ty1jLOWZoXE9JnAIw6NdWVe+Z6cFxm6Waatu15ipRTMKZjBOPdK5fPtwpI8ioys2U8WMoNdoNhA4WPLt6rVeBs8RwTaGFL8+w7p1Z6NsSMz+H1/DbWb71u+jgOamShpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+yYfU/q; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+yYfU/q"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-37d7c265ca5so1982914a91.2
        for <linux-i2c@vger.kernel.org>; Mon, 22 Jun 2026 22:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782193653; x=1782798453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qHZPqZ3RqRQO0OE16/UixYRdvhqayKPw9JQ+fgUzrdQ=;
        b=N+yYfU/qELCUG8UmUzRMGsXnSm4RpuHQBihLpJxPk218Rx2fH83WTws+D+XW72yfyK
         OGpRELlBQ4uawWYRkey7Zt3lPAOe1ISmmHBMbRKKHsJl8pcp7yusKF+fw17WspKxo4hN
         jsIBHfwIirPNghTcKUXONm5iFvJDjRytoXHOZOfEzAQ8zoRcGGoEugsuq6gGA43VacYr
         E2IFkHm2PpEG4TXk0kgFECKe6T+C/Q+TcGiX5uU53LeQnCCPfyEUaEIEIVAaGAJtMbWJ
         I6/S/nRmRSD6JsGSbV3FvfxtiwKp/iNqfzp3bdicoLwZp31Oq4YxvZpvO1XWKJ07hwnU
         C10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782193653; x=1782798453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHZPqZ3RqRQO0OE16/UixYRdvhqayKPw9JQ+fgUzrdQ=;
        b=OxQHIz22L3P80lTfb2NJ9s6o6f7rGB3FEGUdN6Ha//U3QW9+jpxIjJCyFyK5Rj4/fQ
         ofU9CfAShfuOL17Px8lFebY+/2Nes6JtEzFw/U24t9aMnxsyKLU6dLwt/BPCekELmBvJ
         2gsNrzMpgz5s6KqQQ7tPcKqprCN1S/pyIz2UG+PHort7Akjm5MqKVFkev6IXUr0zbo0d
         XuEmw5fFTN1NbNnpDPgWpc/8Am8MNiaMfXOHHQtz8+A65JSMZtoM1aLdXGf698voD/Xq
         I+fwUVoXBR/y3IvLTzk47FP7/74hz6v3dQ7aN4ngI9QZCOGjwsEUIil/HgBbCugAHPxP
         KpKA==
X-Forwarded-Encrypted: i=1; AHgh+Rr6jDFtrnL399DC1lHNjiBE/YSgOU+9/Ye5TjYTEGnUsbWbQxEs/TVyt4+cP5XmeeytJeNI7+fkCiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfyyO03f7jMDt8DeaE0yo4AukIYuUQt13Xp3iUcCwQKWiOwGJY
	u3oBYzzvztziAkImlU0Dgp0dE2gk4n7wWtyJF7SJENFEvJRVzTpf1m0P
X-Gm-Gg: AfdE7cnU8UfidqFi0h7+6r+9ytFWZaMT9voJEWCyusI0B3MAzPOQwsCI5wIyOjabCr4
	oqCfIRj8zmoFATdsqvzuP41WSIZM7VXDXS3rw7y926nfIayVnzlzL/1sjuTayPxpo1jGUDBITOE
	ZC+FSiiv8/OO8aSXrJOGK9200v03K6V2ZMKmt2UoCJaq32g+oVvXCHmNjASDaYRH7Z7l1XJkNcy
	V/DMZV4A2xg0LdgnaI8k7xT47JkQqgRAK/jCtuQSmEqzfXKdh26MD17PhxRa4V2QV9D9pmTBorr
	hwMLGtC8S/GE+o/BsCIXRrCKQQVoekNNz7m+GZO7kyjNeb5keaCLnaEj0IO+okaK4U4F0nLdUoo
	CJ1QN7jwQf1nlwVaPap1v87eDqVI/XFPGdY3UG/kwpSPF6PeUTnWQ/cKsfFNwjV3AeqSpZFCeSv
	PLV5OoVxyRxt9vDK9B9/yO2547l7MvxZ4RiagrblT4UGfvOy0PHRrC
X-Received: by 2002:a17:90a:d610:b0:36b:9c4a:e05d with SMTP id 98e67ed59e1d1-37d160b500dmr18300016a91.17.1782193653403;
        Mon, 22 Jun 2026 22:47:33 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d15df8b8esm11506913a91.16.2026.06.22.22.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 22:47:32 -0700 (PDT)
From: baneric926@gmail.com
X-Google-Original-From: kcfeng0@nuvoton.com
To: avifishman70@gmail.com,
	tmaimon77@gmail.com,
	tali.perry1@gmail.com,
	venture@google.com,
	yuenn@google.com,
	benjaminfair@google.com,
	andi.shyti@kernel.org
Cc: openbmc@lists.ozlabs.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kwliu@nuvoton.com,
	kfting@nuvoton.com,
	kcfeng0@nuvoton.com
Subject: [PATCH v1 0/1] i2c: npcm: unexpected SLVRSTR IRQ in master mode
Date: Tue, 23 Jun 2026 13:46:34 +0800
Message-Id: <20260623054635.1214525-1-kcfeng0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ban Feng <kcfeng0@nuvoton.com>

SLVRSTR IRQ occurs even when BMC acts as master role only.
This case was not handled in the master IRQ handler,
resulting in IRQ storming.
Handle this condition to prevent the spurious interrupt.

Ban Feng (1):
  i2c: npcm: unexpected SLVRSTR IRQ in master mode

 drivers/i2c/busses/i2c-npcm7xx.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

-- 
2.34.1

