Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794555174;
	b=VZL9ovsZN+kksH3BfNToc+da6XjbENF45hBRbHFJvxzoNgqO8f+ujC54lienJbNcBL/u
	 CSMMsbknXEnwPbS781qCKzaGrPcFiy0o3qbUUrKjOBTl8QLyNzAvLGn/jd1iglAlvqLma
	 udNYKt+891/DQzSrx4Nbb2YsgGTPCyckYr7wERo+ltVsENRuH2l/QHgK+bNkBU1yOCazB
	 +I6CEFRekNVGFR5KlQPEGGIynC87hyXTdfNMega9d8kjBL3zwAkGFrHzVQONLu9PKWuIb
	 tPF6F7ksjPArIGT0NixJDWJNZobe4eKw/O+7CCdMSPhbBuqMIOOllAI1ID9tzOFnq8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794555174;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Jqp8TYr/BxJeYtd0GqFzJoVixzfcdiw2tIdD5ztXl7A=;
	b=W8i0CwvOwZv387iYV2966/vMTWDQId0MunvRxzo1JfdnHmBKl1JZgCZjvu26e+YapE9N
	 MidUQ9YNAHTdmoFfkwTOu7Mr26fuMVFwPO8TWNEbaQaT+/WTGHun2A3ZZ/T9N9u9nPGky
	 ze5AfhvLunF7WjIxxZnpATx52f41FKeR3fsoCwCvSHk0VKsqzwXdrt9VHV7FH7FrsWkMa
	 lz6kdnjESrL3jlI7omTNnMR5QSa7hDPnlfM5YfDpNi6CNghSeb32V48e0JiR7AS2I+200
	 0AZ3kUpTrjYHmQhGCBuRdndsx/3CXWRXGANbMBQvHgiXru24eyV8N+gPMgbCnFRFF+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jW6XVipS;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FB9606A321
	for <linux-i2c@vger.kernel.org>; Fri, 13 Nov 2026 07:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40FB9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jW6XVipS
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-49318428d98so189593f8f.1
        for <linux-i2c@vger.kernel.org>; Thu, 12 Nov 2026 23:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794555172; x=1795159972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jqp8TYr/BxJeYtd0GqFzJoVixzfcdiw2tIdD5ztXl7A=;
        b=jW6XVipSXdMdRTxsiijSiJOltYY8enXMvCw0kLuEMKivD0O8Eam/rZsLu0qkRJmhMg
         0gm77RI+ElgZgUSELzgGh6YYiZ3ekKa2Iuz3V9mzgQLTdzQ1er3kL+6npgfNMjUA3EOg
         q7joZ8ii/JliPk8lGo3/CjkyjggwOpCH4MX048SSOnyj86C1TSRdGoOrVD4Tlp4TnR0C
         nk7RjKDlnoCNZ8RN6LQKArv/horCrm2ZUhYVx8bFJKBCXmPCN1Ww1MgVtmpE+P7Q1q4Q
         Rl+9xxVIEV5+xtc/WqOERzJsW1vxDTEHKmBw8t9dSspbCvVQHudFSzvWptu2E6uzTvLN
         gxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794555172; x=1795159972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jqp8TYr/BxJeYtd0GqFzJoVixzfcdiw2tIdD5ztXl7A=;
        b=xFyP/zGIXv2DUH47uyOlWvBN+MYabSJY0MulJ8L8d9JDoyDx1ByPWzbQyvXMiSuZPy
         Yy0TdWHBiFAOnOFJ150hKunp2M4INzI6A0R15b40w0VG7+nPjT/wgzI8EclP5JrZusw+
         qSplThFKg7eZLmNuXdjuZc6MkNg+GVLYu0D+SQrFhdAENxH1Fb6d7Jp2xFfNHUiQuUpZ
         rt5rosb4UkNWfQ5THa+g4K0ibuoKfl6x3CWag3HdiKKi2/8sOuvdPNaULw+trIEobpJg
         H1U9bQntT5ln3C8z7dBc3dXsW8ZocY4BoqPN0+ZrKFyWFXouXQuj6A/mbTeBiWwdRu9R
         QoLQ==
X-Forwarded-Encrypted: i=1; AL+hErHcrZ6H+nWokndm18dBTOYCp1fsF426ZPuhYpfGqqU/RqS4r/f5pg/Sd7/TjpOK4dyOL6fpCaq3UlQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/VeGEOST86mTq2ANHS0D0CDf2SdfaNoMkMKRxiKz+euzz3wERE
	rFeCLUUveHiY17Z4yLghPZ81OMjr+connpAfEq/megF8IcjbNEXgesPM
X-Gm-Gg: AYBFou2XFyEBe87YSsaijsm/eggF+Y/mMK928Hpaqf08XJQoh450HKHE7vqSw/4XrA3
	tOdQbJo23Fb9bzWsybKqEBRWNwQ+INtrQo/mbo6aVtSxZj6aoJoVDqTbOjUzsl19jVN7TLE/Qt4
	IBF5IFKiJPb4bKy6fbt9m4nh+AdlyzVz1zNajG57/I1AZxs6FrOF6r+uNyQlVRbn/WFX+WvPqEj
	VQWhqD326BFAX5u71L/LnGrVkFpn5KocnrVpRVmX0xkjnLIbrUW3KHbDJBTaze3FF0/ZoQuFLmP
	CNFu07+/XJQgQHvEmT0IJHL2monBhnx8BB953JkPMl77F7VWx6xdFiNzWVKArBTpzBK/j3KFmFY
	SpjPqH+fPEs0Pjk1Dk2uHi/YO8mww07Gc+pyii9fLRDq9wXCe7bd+oeEVUJHcolG2x+H8lYIUOs
	SKjESH5gEMYFocJ+8goHKcqFCQiVD36khgazgd7N3MEefht8lpGuZ9rO+kLVaW86SW/ZkfuDRzc
	lPlzFutj1VjIZLSh1m4n8kzSKzQLGFNTfZiPgJc3bT0EMhKsvdlxOOyfEfMioFuyIlIkyMevupK
	m52ebEMaNgoA3lCiNlo508UzgleDktKKDQw=
X-Received: by 2002:a05:6000:240b:b0:490:39ba:4359 with SMTP id ffacd0b85a97d-49c714a2db3mr3596058f8f.23.1794555172357;
        Thu, 12 Nov 2026 23:32:52 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5d223a29sm3799903f8f.8.2026.11.12.23.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 23:32:51 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Yao Yuan <yao.yuan@freescale.com>,
	Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] i2c: imx: two fixes for a DMA write that is not acknowledged
Date: Fri, 13 Nov 2026 08:32:48 +0100
Message-ID: <20261113073250.1037215-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

A write of DMA_THRESHOLD bytes or more to an address that does not
answer leaves the interrupt status behind, so that the next DMA read
returns 0xff for every byte without an error (patch 1), and it blocks
for DMA_TIMEOUT before it fails with -ETIMEDOUT instead of -ENXIO
(patch 2). Patch 2 needs patch 1.

Tested on a Colibri VF50 (i2c0 at 100 kHz, DMA) with v6.12.117, where
the touched code is the same; on this base compile tested only (W=1,
sparse). 200 rounds of failed write, 32 byte read and acknowledged
18 byte write: 200 times ENXIO at once, no wrong read, every write
acknowledged.

Mehmet Fide (2):
  i2c: imx: do not carry the interrupt status over to the next transfer
  i2c: imx: return -ENXIO at once when a DMA write is not acknowledged

 drivers/i2c/busses/i2c-imx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)


base-commit: 25e7ab89f4774b0f842cee0e8a20c11f755924d5
-- 
2.56.0

