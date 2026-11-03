Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696473;
	b=ZiOLXt5B0krb8rURz9rEt5KsRzIkeCWkABkTFLBhabvBp8/tXsBuHBBDe7Ww4uGfljzd
	 5YAoH5nLsBiWxccR3sKyFu8I/0qBnigFzAQDwgqWu9g8CWhQm8NPxS0NRyCVHBQnpNwkD
	 /hCTnE5YejLjNHRl6G7Q4khq0CSO5x5svLWPR+Ofx2XepQ5Z1A6D4hYqtFMr6I3rJ3kJI
	 hJ5qOZcEhjgWk18mFYtqOdDxztqFZAXE3aHLmXJhvwXdH4j3NbI6oOx0bYWR5zjlMzvTF
	 jBLu6nxbqfvIekwXuHnWEOAaNNibmnR4ocehICx3JcoMZ0gkYEfXHmFLtCwWcv7Dwdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696473;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=lCoVzsWFe5YOKcK6Rk5r6Ai2zm3LFae65AljAuEPR5k=;
	b=1QooD1AKrMu5HSxTfhRxVgzY8IMHe2l0U3vo0ArLKX453uT/Ra70F5PYOXkG9oNFbgEY
	 zFZ5e9SIImUtcM8/8EHsQrGlLC5H++NU62r60gW1PdLJteFe9ZLaPhDmuFqTzj5ZYEByQ
	 ljPI2VACuqGczQzHAeJNZyJXF+oVcOogh0fPHa9cY/qQLqdK0ZhQjtmvpL5sKN3RqfsmG
	 oa1uFA9ranxKUoaWbmBytJQdkj/6Tzk56yb1dvAW+RqEcMFWwr4M+p1FNJxewQwtSw+cC
	 1ms8HG2RfA7V1fasyIrXYQBujORE83OIJsrZrYWRyArELsZSzUsZ5nGyCtw6wL4r6mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=samuel.tirwa@web.de header.a=rsa-sha256 header.s=s29768273 header.b=m2EgzlAf;
	arc=none smtp.remote-ip=212.227.17.11
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B1F606A324
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 09:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0B1F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=samuel.tirwa@web.de header.a=rsa-sha256 header.s=s29768273 header.b=m2EgzlAf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1793696467; x=1794301267; i=samuel.tirwa@web.de;
	bh=lCoVzsWFe5YOKcK6Rk5r6Ai2zm3LFae65AljAuEPR5k=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=m2EgzlAfpf3AUZQtryLe44oHhaLsGTH/7cVFMNXhen0U7k/Qy2lEVABlDDprnRa7
	 OMVMYs/KPvm8b4LPkNUJ//o014XluFG2XDtl1kKtJvdtAwFuuBaVSFSokoLVeJRoA
	 TswZueLpmRo27Y3+CaSSXi+q0reueFVjwwnBu1qVlyiAskjRk5XFSXHNOiGmvvIVv
	 o5DfXdx+PZKlUAl8KyqnWK+79D7zkXhlcMqcq3y0wVwMU7PjlzLafog0prG/dnJf7
	 am6LAMcpuDKMXxxPG0B8Buv5fU81dAYgT/qZJ4WkH9n+KynnJimTQ9K669ZUc6kVz
	 ri8BcxE0EfPQx3JsIQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKMA1-1x5p5q0MCF-00V9b5; Tue, 03
 Nov 2026 10:01:05 +0100
From: Samuel Tirwa <samuel.tirwa@web.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>,
	linux-i2c@vger.kernel.org,
	Samuel Tirwa <samuel.tirwa@web.de>
Subject: [PATCH 2/2] i2c: designware: use polling when IRQ resource is 0
Date: Tue,  3 Nov 2026 10:00:59 +0100
Message-ID: <20261103090059.1759-1-samuel.tirwa@web.de>
X-Mailer: git-send-email 2.56.0.windows.4
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
X-Provags-ID: V03:K1:RGSHxRcP7K9juMLKcCHRy0Gsp8C5G8hdrNmpj2qiD0DtWZAvO4Z
 57BXKxq+X61zBCxlQaXzAO1hOVZ6DTCV+7CsEnDo651erV55ElQA5Qg2aoG+X3NQjg8iEI7
 Vg3VXXZH4LTUfFveKis/M9PSISPv6jg+n9XpaF6AsfmnoIKZqXo8o3wZ5E7r/Vu+fLCsczy
 WeZ1nKMwgp+SEbWH/O6jg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1LF5NxGOCkA=;x9UpqBT5iZ3TrjWDPZP7ry2diu1
 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

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

