Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.72.192.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696408;
	b=2IPUH4vqMvA4hcLK4eVA2dnpgn5ZWHvNqC9/FvGcA1Fo5zYaKmHk/mkxnpMGC7B/qoXP
	 lVKpGpBpJql337hcxtc+zUVv9haafeE4UT1BsQ0SnDFHW20sZo0qVAOTpvziMroszitMa
	 N1c7Mayj/xZ6MBQoU61ShCK0ArACDah2xZNLQLtdLEx9Gd+lyhq2rBrW8vPzTyG7SbhGa
	 MaUpp61dJtQKoJfxYpV9uNATDnb+KSp5fKUdJd7Y6Ma3ge2MwIYXjkshxJfPV9h6Aoyzk
	 zZaetAS+H508iFVrPvZ7IlQwf+axrEQeLhO7cFBB8jnr7v96Xv8Itwi71YG1YbF8Hjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696408;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=462UpejJ5qYOboAogYgB1iN5Z3nb92GciWnjw6zYOpc=;
	b=XiDtnj7BXGdEI+f3R0c9+teMwjLdjhiDB1f59+2NQoWl7WIHlOxRdS8WVtWXnEinbntC
	 Sy6YgRBOG4B98pnHFGtL05GHatR8b8Bgje/sO4e1ExMlYp1AkAus+GyU16AylLpYTci9t
	 MNHAMZ3GPCwXeLx90KJLNmJiTPxc85nNBQ2T2OsCNQ33BbkTQzLtAsG7t2B1ahdwyEq3T
	 KZ+RoKCFxuMnq+3f1JhrMYhnIUq01yjQuGGa2Q/eLuhfgHl7ENbAjvdGz3E2xtCDkyZad
	 xI4It03xVbRpWqf6tzjC3eBeODJaPbbbsXqWblMVSXh1vzZlPxsnbUaXdvRM/uax84A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=samuel.tirwa@web.de header.a=rsa-sha256 header.s=s29768273 header.b=j760RfJf;
	arc=none smtp.remote-ip=217.72.192.78
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F09606A324;
	Tue,  3 Nov 2026 09:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7F09606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=samuel.tirwa@web.de header.a=rsa-sha256 header.s=s29768273 header.b=j760RfJf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1793696399; x=1794301199; i=samuel.tirwa@web.de;
	bh=462UpejJ5qYOboAogYgB1iN5Z3nb92GciWnjw6zYOpc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=j760RfJfn/GRnooVzNfMYTaAMPgWBeQmVhMEFn5V8yNOPAsJgBOwn9AefXC8gW1B
	 BSZ+MfL2g5V0OW/NPRN0yHOtWmHtEeFL88B1AT95fHkXhYRmY9+RAtXbz8r1ZEFG8
	 o5Rbne+dW104X+mjCbSm4NUUb2RjTmhO5khEhY57FL1IFRRz0A7Y//vcVqXOqtgjn
	 3i+1YhLKfADRzrygxpZ9UaxCVc3x7rjCqnKSyyB7zwZzqdbrfn6qFmb7vbfDA0Fkn
	 7O44pR1YYb5kt5y5ygKsNeW3vBnhcMVrEX4MX1qQ0Uc6J1WZwZkf7uVp39ijWGems
	 PGnNwITWheDhXn0TPQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MrftG-1wlWB92wBo-00o0n6; Tue, 03
 Nov 2026 09:59:59 +0100
From: Samuel Tirwa <samuel.tirwa@web.de>
To: Lee Jones <lee@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Samuel Tirwa <samuel.tirwa@web.de>
Subject: [PATCH 1/2] mfd: intel-lpss: fall back to polling when no usable IRQ
Date: Tue,  3 Nov 2026 09:59:53 +0100
Message-ID: <20261103085954.1497-1-samuel.tirwa@web.de>
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
X-Provags-ID: V03:K1:kqQv027QBARuZlBNHAhV63K09dSQNBXUtgbHt9VlmL5B9/l90+7
 ErPH0uZlJGYj2eitQ8l+5aglc4KQHTZnkxC8Y3z1gU5HhhTXOF2QeKGZ/laY8hPmtqnBJ+3
 x4OaXmkFwvEI16TzEbRxTWssM9Vr07nmmKK+YOlkxzuewsjMtAT5IaHx15OVmOpL58/K/4Y
 aenbPAzOrJadVPZI+CpRg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:reMgvXkf9qc=;ADPRcgCRxM/vj3NElLbDKORtAr4
 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

On platforms such as the HONOR MagicBook Pro 14 (2025) (Intel Core Ultra 9=
 285H)
the firmware ACPI tables report the Intel LPSS I2C controllers' PCI INTx l=
ine as
not connected (Interrupt Line =3D 0xff, GSI 255) and do not grant MSI cont=
rol
through _OSC.  As a result acpi_pci_irq_enable() sets dev->irq to
IRQ_NOTCONNECTED and intel_lpss_probe() rejects it, so all three I2C
controllers (8086:7778/7779/777a) fail to probe with -ENOTCONN and the
touchpad/touchscreen are never exposed.

Treat IRQ_NOTCONNECTED as 'no interrupt available' and pass 0 as the IRQ b=
ase
to the child devices instead of failing.  The DesignWare I2C driver alread=
y
supports a polling mode when no IRQ resource is present, which keeps the
controllers functional on these firmwares.

Signed-off-by: Samuel Tirwa <samuel.tirwa@web.de>
=2D--
 drivers/mfd/intel-lpss.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index f71e076..f785d5d 100644
=2D-- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -1,5 +1,6 @@
 #include <linux/mfd/core.h>
 #include <linux/module.h>
+#include <linux/interrupt.h>
=20
 int intel_lpss_probe(struct device *dev,
                      const struct intel_lpss_platform_info *info)
@@ -7,10 +8,17 @@ int intel_lpss_probe(struct device *dev,
 	struct intel_lpss *lpss;
 	int ret;
=20
-	if (!info || !info->mem || info->irq <=3D 0)
+	if (!info || !info->mem)
 		return -EINVAL;
=20
-	if (info->irq < 0)
+	/*
+	 * Firmware on some platforms (e.g. HONOR MagicBook Pro 14 2025)
+	 * reports the LPSS PCI INTx line as not connected (IRQ_NOTCONNECTED).
+	 * Fall back to polling mode in that case instead of failing probe.
+	 */
+	if (info->irq =3D=3D IRQ_NOTCONNECTED)
+		info->irq =3D 0;
+	else if (info->irq < 0)
 		return info->irq;
=20
 	lpss =3D devm_kzalloc(dev, sizeof(*lpss), GFP_KERNEL);
=2D-=20
2.56.0.windows.4

