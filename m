Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696411;
	b=bDVqRfzuqCCG6tU60gGe8BjCdOFZs3MtaEOKkflKiAz8z30FXciMgl55dw1zSzbx0z83
	 PpblrVJJd1ls0+RmR1a13Ka82tm7R5vD4Vk7fo9C8o8WK6wZ03gfJT33FjUhTAGvwC1Hi
	 mqySXibVm31J5bxDRfs+gTlUaFMg4VCYyzgOQuBNM9b49wraSqfbmWpsTk70GoC1MwJxU
	 aT0sNSUsAWRMvk3FEtvXPM89t2oEBm2o7KNKD2yfb0xdV2ANSTYMh+4FRVYBJ32B1D4Nj
	 SjYSrKqw8IcdC01Xj60kQJDLPQbyMyWBd0z/LiG4y9fIgEL1o8Es5phlb4Wl5aiWLCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696411;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=lCoVzsWFe5YOKcK6Rk5r6Ai2zm3LFae65AljAuEPR5k=;
	b=e3YKPR9q9Et5IJQA5A/6Dnzf+azXngbm1yAKt+OBwe4vhp6MsxDKFYSXIV0ye6XnFmhD
	 adVmXVJQ8Pf4IM57lako3p6dNUu7FYZGtAsrltpbUh3zxhgTQs+LN4HRYAlV47S87q6t3
	 Hm8LnjLX3YqsR8T9o+z08zUkG4lsCWQ7HS4ZjHKPuYYePCcTgS/bTg4kPgLX61PEL7Wzo
	 hlf4THm5TAKeI0U9SGe8XWTTV9fWu5agkSUaWmKPi+ysuwhXMLRPZc96c7zQQkI3sKg2I
	 6IKZGR0oaWnJR0H9Etg0aVLWe/cDQymP+GqcUzEdSs9DtLkH3UfqtTkn1kGaKKjLJEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=samuel.tirwa@web.de header.a=rsa-sha256 header.s=s29768273 header.b=szMkZ+Ga;
	arc=none smtp.remote-ip=212.227.17.12
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738EE606A32D;
	Tue,  3 Nov 2026 09:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 738EE606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=samuel.tirwa@web.de header.a=rsa-sha256 header.s=s29768273 header.b=szMkZ+Ga
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1793696400; x=1794301200; i=samuel.tirwa@web.de;
	bh=lCoVzsWFe5YOKcK6Rk5r6Ai2zm3LFae65AljAuEPR5k=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=szMkZ+GaPNSBR9f418yY50jS8/XKP7wOJBf4ubtaR++IPgREvKT6AQp4YapCEGg2
	 thfiKHx6Qm+Ia9xe8ni9rnpNh/lVZzhuiJCjMW2cOe1125bUzKDlYKEu929KPe23b
	 weLnL9uXJGwlnYESKy/UMv6LCSxoKqC1CjEJD7N5MvkPTmgpuR0R77xcQB8gwSWuF
	 /LwNdt7eG0GebOhmnIJOpfMh9nYUetJDdqd0XMOF4Q5el5xWdxGKXfjBnS2d/AICd
	 YKg9EpXiWVQtu4A6a7iPzDy3AtykmQZ8zc+hwz+FAt2J4Sw66Plar/0QOFkKWJfBf
	 ZrbRKo0jfkEQVCA0gQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N1d7i-1wMH9s1jTs-012Guu; Tue, 03
 Nov 2026 10:00:00 +0100
From: Samuel Tirwa <samuel.tirwa@web.de>
To: Lee Jones <lee@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Samuel Tirwa <samuel.tirwa@web.de>
Subject: [PATCH 2/2] i2c: designware: use polling when IRQ resource is 0
Date: Tue,  3 Nov 2026 09:59:54 +0100
Message-ID: <20261103085954.1497-2-samuel.tirwa@web.de>
X-Mailer: git-send-email 2.56.0.windows.4
In-Reply-To: <20261103085954.1497-1-samuel.tirwa@web.de>
References: <20261103085954.1497-1-samuel.tirwa@web.de>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:08srE41Yao9Bn99YEvc1cD4Fw4VG6vSv/Sn1J6cEJwDWjKayqFG
 QV7Eggecnk9LTUcm7IUUUMuUB1adjE9TMXxuILwxxSJbWipGkbKsQUkb0mI8meO7VLZvqPX
 0yk6zoyU5lHRE41R5AMcE2QlMLptao3kG6YXWwMAc/90Qu7qJ2wV4f933OMfV3GFs6YBNin
 LQ/5Mlvo1hGBZysTwiqwQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XBspJST+YUs=;2yvKVWjZllkuU1J5F/ezZsbsSND
 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
 EqHhr7PIIfF/rb/M7QCKZrCm

When an Intel LPSS I2C controller has no usable interrupt (firmware
reports PCI INTx as not connected), intel-lpss passes 0 as the IRQ base,
which leaves the child device with an IRQ resource whose start is 0.
platform_get_irq_optional() then returns 0 instead of -ENXIO, so the
DesignWare driver never enabled ACCESS_POLLING and request_irq(0, ...)
failed.

Treat an IRQ number of 0 the same as 'no IRQ resource' and enable
polling mode.

Signed-off-by: Samuel Tirwa <samuel.tirwa@web.de>
=2D--
 drivers/i2c/busses/i2c-designware-platdrv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/bus=
ses/i2c-designware-platdrv.c
index ca63b74..035ec92 100644
=2D-- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -4,7 +4,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	int irq, ret;
=20
 	irq =3D platform_get_irq_optional(pdev, 0);
-	if (irq =3D=3D -ENXIO)
+	if (irq =3D=3D -ENXIO || irq =3D=3D 0)
 		flags |=3D ACCESS_POLLING;
 	else if (irq < 0)
 		return irq;
=2D-=20
2.56.0.windows.4

