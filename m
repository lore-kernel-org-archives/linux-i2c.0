Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5316131E824;
	Thu,  7 May 2026 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778177845; cv=none; b=JN58Pa3HJT69xG0L5ZwfLsRpW6Hm1dh1AyU6kYwCn25FREJvaWGFyRaW2u4+FdVJk3D218kv6L6/mb9xFYb4SOAeJKdTV8gBc2hhUyKHX64Hi7OMy6GO90vf57LzuUmtEX/TH0cXxxfUCeirIk5cchIFPm3j4UnAIpzPbzSlnRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778177845; c=relaxed/simple;
	bh=gweMeq+lgl6N4XZv+GZ5ck7Z5Y064khmcKl5EAnTbUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TENthNuswxoBWmkfZwHTVzX4A33p+0ZQilB9XJAIc0OEqPqHyEs1clDN/CRv5vGC8A2NXQA+SfFSGiQyP6+g6qcdAzqf9weXOwPQpLCCigEKNGYzG5a2DeHccwqN8X7O8yJG5ygbNda4K/zLBVeC19+U/zoiqdFLTn+0QiHod3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=H81vzncI; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="H81vzncI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1778177841; x=1778782641;
	i=markus.stockhausen@gmx.de;
	bh=gweMeq+lgl6N4XZv+GZ5ck7Z5Y064khmcKl5EAnTbUg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=H81vzncIOyCnwrCJrCeRCTfAf3TC6Lp75bt/wbnvhJhjA6ETfS91xXW7ndNS1oEd
	 MrwYQtSXbGmegNLpDmw9JojwzQou9FBDEqFxMAmnllMxeQaYYLCBWEdagq3Xy1OVi
	 ule5P11IUdyp7eNoOF6wecTfg0NtSy4Ti5jipC8cZ+Izx98ZvMGpcFwznBUw4Yv5Q
	 2Xan8NzD6gQRGdbH3JXjamjWKYCYuf3tpvv/C+zFIVlCSE+NaS+XOWf8NabSBE1B9
	 Kr98+uk8ja/zCzcb/Io6K0jyZ3uQhp2U5hAihmAkFC8mg7QxAL3hYWBF+LAuwoMVi
	 3BR9WVUj73qFypEIdw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLzFr-1w3etM1Teb-00QtXg; Thu, 07
 May 2026 20:17:21 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH 0/2] i2c: Add i2c-shared-gpio driver
Date: Thu,  7 May 2026 20:17:09 +0200
Message-ID: <20260507181711.2696783-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Kw2NLEuI9voJFx0iX9GY1lgRtGExCAalaSVJR4vEx4IF3WFboLM
 MN/qeR8/VmdCepsJt3/jdq6LUst8xQy50pIXVFdnbcSyw1lhC5SyKR3L6MBvgIxuN0st6Mf
 OE7wcRLrGewMLxE0V5hQwOLRS01YjjREWfqyZ7I7vHo7TJXohcjjcAxPT/MtkXA3vSHkwVq
 Zb/L2SKEqZa/na5MfdxNQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GuL4qRnL50Y=;npLXkuIlAK/w6MNPYqgh0rlPdCV
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

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>

=20
