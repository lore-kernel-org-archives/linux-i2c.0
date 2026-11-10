Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.10.215.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325428;
	b=srGyMh1w+dcx32zVVkdbOpxNZhn7y7rIuqQzHY2UBccJ2oRd3RoZQroJX+Nih/msBP3l
	 cPLK0TQvKQnw1vNK8P3aoQfoa4S3xQhOjiEQn7FKUbtcZEkCtABPpvrnRIRc+JpX5xAvg
	 lC4T13XR5iC1eEsn+uL9Imj9vuUt61x5CA1sCyt1owliTg7MsErdLP8CuEP6/GAKkbd9d
	 RRSPt17+IYhn4Ei3LYH2mmOKjClJ2RoyuvIwIiwO550wQKiqC7M0AYKdUYCAl6jk3/h/z
	 jt6ZuxsOUFpMiA/gztH8i8sRa8yFEqdetrJ+mafblCn1qsuKdBmEs4bRGJ+tfFDNYUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325428;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Virus-Scanned;
	bh=uHR4aQt4WAcnvlSCRjVJhRx9c7f7trK7sfwWQfwqILI=;
	b=qQN9xeNaVBnqtA8ewnRUzmthZD305yx/Qf8hvNgLySv2Gs8FbdT3XNn+R/1kxDMyhThk
	 W2om1zCn6XmcBhn75wPmBN+g+W4IwGZe19ztG678igwk+3vp3hpS41gTY9Xk8J+bBptSp
	 vcGRS5hi88o4N9H9+WqQ95t2VlcDIJBtBd0R2qEnxOcCz/lThYCC6ku2JXQYK68Wu4irb
	 1hA8kJO22BMeGT/tv6d1lPal8iwnKiYxJLYP4oLaiEFAdRiBGaNm8Ptn6aZmhs5tZIxKr
	 hiDneN8U//BuWiXaxvCTccTGuyAopps3sh/WIkGhlxdIYn8HoCCOSJXSn/1cTydtGQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hetzner-cloud.de;
	spf=pass smtp.mailfrom=hetzner-cloud.de;
	arc=none smtp.remote-ip=85.10.215.232
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF661606A33B;
	Tue, 10 Nov 2026 15:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF661606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <sarah.maedel@hetzner-cloud.de>)
	id 1xQo0W-000IEH-2t;
	Tue, 10 Nov 2026 16:43:36 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sarah.maedel@hetzner-cloud.de>)
	id 1xQo0W-000CQE-2G;
	Tue, 10 Nov 2026 16:43:36 +0100
From: Sarah Maedel <sarah.maedel@hetzner-cloud.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Beno=C3=AEt=20Monin?= <benoit.monin@bootlin.com>,
	David LaPorte <dalaport@amazon.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] i2c: designware: Fix stuck master on multi-master buses
Date: Tue, 10 Nov 2026 16:43:28 +0100
Message-ID: <20261110154330.78515-1-sarah.maedel@hetzner-cloud.de>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28179/Tue Nov 10 07:26:51 2026)

Since v7.0, the DesignWare controller used for IPMI SSIF on Ampere
Altra (DW_apb_i2c 1.20a) can get stuck after "spurious STOP detected"
errors, and stays unusable until a power cycle.

Patch 1 limits the spurious STOP check to controllers without
IC_EMPTYFIFO_HOLD_MASTER, as suggested by David LaPorte [1].

Patch 2 lets __i2c_dw_disable() abort a stuck master on configurations
without IC_STAT_FOR_CLK_STRETCH, where it otherwise never recovers.

Patch 2 was tested on Altra by forcing the stuck state through
/dev/mem. With both patches applied, IPMI commands in a loop no
longer hang the controller on a Gigabyte and an ASRock Rack Altra
server.

Both patches were prepared with the help of an AI coding assistant
(Claude Opus 5.5). I reviewed them and tested them as described above.

[1] https://lore.kernel.org/all/20260505232244.71807-1-dalaport@amazon.com/

Sarah Maedel (2):
  i2c: designware: Only check for spurious STOP without
    EMPTYFIFO_HOLD_MASTER
  i2c: designware: Abort stuck master when disabling times out

 drivers/i2c/busses/i2c-designware-common.c | 19 +++++++++++++++++++
 drivers/i2c/busses/i2c-designware-master.c |  7 +++++--
 2 files changed, 24 insertions(+), 2 deletions(-)


base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
-- 
2.47.3

