Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.135.140.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795106461;
	b=WA3NwepHASL0CkfSRhMrB8IHq5PQokUVZVZyf5gg8Lf58v0URRnsB7AecSdLj3uEJnXt
	 9r73mbTESGoLxtWY0ksIf0fVTXK63ySmq6+mdx8fCGIuU2b6nxiyDg/fIrdPWrakLt0pG
	 b18lzNoR0u8JtJf64hnFqxdOxtUNBep2zhTxzSXngij82lzJaf68n8bz1SjBA4FfIe5Jf
	 GWYbg599hBUGMF+2vF1LWfdpDi5vohP9w7vVThN5SMAklWFdQ4FG5CNRqa+E85qjtRI/d
	 GYL54jtNmu5oI3NRwfNnsrAScniav5G5PTJ82QBFqXq3ToGmuNnmMx2eluHY1T6KAaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106461;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-Id:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=KV6ADa/11UllCU84spZSd59cv4gMkwsky/9v11X78Qg=;
	b=EMc/TcQVcFPFx6rsW1vLnJAOVUscxq8Y1H1MPnKDv/gqXmJ0ZI57Gw6sk3cpYQTD0OtL
	 CAQ5e+dG/S4KfDhatviEqUUG4loOS9AaQCNCzf7i2jioWAYiFFXokaRMCCN7o+hec5HJh
	 LBJ7eJHJ2jO172PSTPlYKr6HKh2pqVaIxpyiiWchAGoqeN6rMAups4smAuV/GPCRj/rFY
	 u9v1Bmz4nXtgHBGSGOF0pMvL7m1/cLe5an/+Ca/LsTIQgpKgXu6whqUtsVHLraoc2fguO
	 2OiVp3nJlUz4V5+vxs9HJMz033mfLpmSbboZzcUTMLd6OlUrh6tyVOOqj88GrXh4/Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cjdns.fr;
	spf=none smtp.mailfrom=cjdns.fr;
	dkim=pass header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=WpWseaga;
	arc=none smtp.remote-ip=5.135.140.105
Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9336C60A2609;
	Thu, 19 Nov 2026 16:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9336C60A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=WpWseaga
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CB788576656;
	Thu, 19 Nov 2026 17:40:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1795106452; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=KV6ADa/11UllCU84spZSd59cv4gMkwsky/9v11X78Qg=;
	b=WpWseagaYETOJ4V8cnXs8YD8T9xEC7a1LWlYcScOyJkvkbt/0GtvkOib8bwL4t9yszLfoM
	Ai/UBO4AdoOTYGXoq+oHPyeyXJSn9BBKqqzhq2/aEAnNfPZIc/vXHs3QPmMqjR26PUoNST
	vN2Zaacr1r5B1z1j6G8ZLN7WGyV6/LRb1QyfByfWd6FPI4YmeRFROlhxFb49nd2W0HtETY
	ecmVIVchyCm2n/+xb1RdKgTxb24xggJX+aNv0j8TaJK5f9+DV88bd9c5Kh95ulbdxBR5/3
	6E5P0n6amHTPA8X/NRWoqsVikKHcZfEYwX/ZMCeNnqZ+Z7k5DLycR7NbM8OLRw==
From: Caleb James DeLisle <cjd@cjdns.fr>
To: linux-i2c@vger.kernel.org
Cc: sr@denx.de,
	andi.shyti@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Caleb James DeLisle <cjd@cjdns.fr>
Subject: [PATCH 0/2] i2c: mt7621: enable for EcoNet devices
Date: Thu, 19 Nov 2026 16:40:38 +0000
Message-Id: <20261119164040.2400580-1-cjd@cjdns.fr>
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
X-Last-TLS-Session-Version: TLSv1.3

Small patchset to fix an endianness bug in i2c-mt7621 and then enable
building it when building EcoNet devices.

Caleb James DeLisle (2):
  i2c: mt7621: support big endian processors
  i2c: mt7621: enable for EcoNet devices

 drivers/i2c/busses/Kconfig      |  2 +-
 drivers/i2c/busses/i2c-mt7621.c | 21 ++++++++++++++-------
 2 files changed, 15 insertions(+), 8 deletions(-)


base-commit: e8017d29067fd1310a65c3494ce1a1b492adbac6
-- 
2.39.5

