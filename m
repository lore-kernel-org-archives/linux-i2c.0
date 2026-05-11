Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861C03D410D;
	Mon, 11 May 2026 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516746; cv=none; b=cvAPiQykE2PWAM89INlpYwPvEMWECE4t4t1RlpVSw2MMFwWzeUA2MfYn5xitNuUFg/xeAHMnWjBQT3ykiS8yHE8Nga88A4OKBT6GxiQQwLELNB0RDHydI4rXJvNj/N7z+WarMwcnOO6CF0Dp7WFB3w+uIopHhHIjOr+k3pMrVIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516746; c=relaxed/simple;
	bh=a1BYN4pHtAlEXiCkg2+kWP78KUPHsGhUWUBtyyRfcRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ihxGfIv/1m5KTUVIjzkBn/07jnr30GmyM6V64JqJzPlWMY4QueQ1K2O7lDISGYImibuc/9qjl+BIFhwllxxd1UuWyv/i3F6sTJ0/o7GNRXsTsA3KnzDku7LuB/eZD8PWD/AI6exWzlYVlYrDR4mpX42rx3LuvIU+PfPQcOtvx90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=HV4VzsTe; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="HV4VzsTe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1778516738; x=1779121538;
	i=markus.stockhausen@gmx.de;
	bh=XoczE/pNNJWE3nHYLnZ4Ck1QTSBWY6V0YgQ9A/s0OL0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HV4VzsTebRLLW3JTStqHildf+WCcVnd9VYo1MK6myh8DkFIVEMpC2/lVw9ILev+b
	 hYlUd8pKqGL57S1OzBAkO0acirSsnseMxeNoMga8aP8lC0TZWubCGgggrrX16q8j/
	 BjHNBWQguv/iibm3fKiV5c6uoCe6vPL1nrczdnmX5lr+WXwORuf3qQCg/FZUB7kRX
	 TpZfBihCDBckKxN9i9fgE+KMNiy9xNF27koDtwdr4AS3GWx4mTVpcaWDmMUSnJRmM
	 //WWGwK224UF2bGpDQP0O4/kxpHmr+n4D7B4IpTzqFfIJPXQroB2ZS06FTzF3zbPI
	 wCa4MQxF05JQpWDNsg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqs0R-1x9Knz2MUb-00ekdX; Mon, 11
 May 2026 18:25:38 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: brgl@kernel.org,
	wsa+renesas@sang-engineering.com,
	andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH v2 0/2] i2c: Add i2c-shared-gpio driver
Date: Mon, 11 May 2026 18:25:26 +0200
Message-ID: <20260511162528.84508-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AO3OVtPsQHRTpRnCqBv/ZZIZE4ytVeDP8bw7JUXWznyJbjwsy0D
 yKdKhLL250McFY9soreYS99NPCRXvc46hgTlXWfF84P3fZWivKvR6KZRUiyZotvSGPLz14w
 4Jo7GolCbrHv2Ns7/wVw7bdLT3U7XA1hwUFxOFjd34t3/c9/hpEQN7oFQ9KV63McsXUg5E3
 6euIMQlqjQz6hkW2JhfKQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lz00IaO1hDA=;jLtVS0QNQOjtjoP+9cWPh/klDtP
 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

This series adds support for hardware designs where multiple I2C
gpio based busses are realized with dedicated SDA lines and a
shared SCL line. This way N busses can be realized with N+1 gpios.

Currently there are several Realtek switches that make use of=20
this design. Samples are:

HPE 1920-48G
Linksys LGS310C
Zyxel GS1920-24
Engenius EWS2910
D-Link DGS-1250

While at first glance this might be a usecase for the new shared=20
gpio architecture, discussion and testing shows that this is not=20
trivial at all. A shared gpio is handled by a voting system. If=20
there at least one user that votes for the GPIO to be "high",=20
it stays high.

So the implementation manages several classic bitbang buses with
locking/unlocking in the pre_xfer/post_xfer handlers.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>

=2D--

v1 -> v2:
 - Adapted the dts so that all SDA/SCL gpios are defined in the=20
   parent node. This way the i2c child nodes are kept clean.=20
   Their <reg> property is used as an index into the parent SDA=20
   list.
 - Adapted the driver to make use of the new dts structure.
 - Hardened the driver by adding multiple consistency checks
   during probing (number of busses, duplicate dts nodes, ...).
 - Added recovery handlers that are synchronized via the central
   mutex like normal bus transfers.
v1: https://lore.kernel.org/linux-i2c/20260507181711.2696783-1-markus.stoc=
khausen@gmx.de/


