Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696269;
	b=RLwyqCHfVGAvYJIrr16DrFUszzD9zvP1yDrazaiWkYUYsTahSBXbAXaI3dgBHGUM8YGr
	 X4Rogfj+Xxfzu9kWs4ifUdEcfciIZXWgbip4RKLWo/r71SeKd+syfKEO96K6kqoqx7q6V
	 Y3u1FJPR1KCOf1vutihuMYdQ9s5kAA+8mL0Tp90hi1F8AAkNCVUhVK3kRP3b6UmkIzUud
	 SaDCy55lsGGeKQ9Z3WBwLE6v/ywKmZm2yYRQAi7E+Gl9mPc8mWJuE4BKce+ZN2LCJtuHe
	 7nBK8TIyvW1Nk8TUKrCtNQlkeIc3YpLFuY6+Xa7gIXg0ffOJ+s21sMQVGpe5GJPbrjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696269;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=CHQITMu5mxsqFBnDwjJJDU7QOx2dfM0PluJPpJKe8sI=;
	b=waPzyqC/sybTYaMHErU9gsX6u+mgw+2Cikmxpq9fKcFFqEdEnWQ2Ev+N0z1AJYQoRTYd
	 gHEbJs/WeAoM0KTnfuMP3byVVL2ouTmdO5+IuAcVJhCZVx/BzoLI5jR8OjeWpIJeuwhvs
	 80yPIiX2wCakdrxOa56EKElr4VQGPhBwRrGQG9eH0SLMrwcIFnH0C/nmBwWUU9+9hEIrv
	 Rw1p1E+rjdLo2EQHsTAngDNPXX0/XOKwBQ/JQriU3GIWEetOjYFO/uZM3snF0xysUsmYu
	 FUUqDzbKZ8pzIcBVeMltxy0QWkvCAIcMIv2ZXF7BuUWPhmkHxsvhl5a1+pwv12DDx4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=samuel.tirwa@web.de header.a=rsa-sha256 header.s=s29768273 header.b=AcyQAo2s;
	arc=none smtp.remote-ip=212.227.17.12
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50DB606A326;
	Tue,  3 Nov 2026 08:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D50DB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=samuel.tirwa@web.de header.a=rsa-sha256 header.s=s29768273 header.b=AcyQAo2s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1793696250; x=1794301050; i=samuel.tirwa@web.de;
	bh=CHQITMu5mxsqFBnDwjJJDU7QOx2dfM0PluJPpJKe8sI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AcyQAo2svrCcTFIRqfbrkIh757XDq26Ph5SZdj466YglmVbVI3wT0OZ97gRWIp42
	 61TpgNsxn1UHDqwzfyRT0Aa89TBmmyUXiDtnIFJ+qyM2byx3Cn7eTBRffWYVWRrvl
	 Tibs+JJyJU22QN3Ll3dNxXXVwZGjWM/UrgRCO6whCFlZ+GbDmtekdUVVUKTKAv5rx
	 k6/rpsikRsd/cRbRVv3mtpk/p+YMjQ44XY7Wu4Qe/B9brPnH/ZrhM2p32v+bpF4Qs
	 e1xpoHXMYz2vsk7eV5bYW45EDcVhaHCoW2bDk4W3tLpHbDBzDX56CefHEMFWmXd0Q
	 c0nbDS10vPef9XVChw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MoeY7-1whwg72pWz-00oqav; Tue, 03
 Nov 2026 09:57:30 +0100
From: Samuel Tirwa <samuel.tirwa@web.de>
To: Lee Jones <lee@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fix Agent <fix@kernel.org>
Subject: [PATCH 1/2] mfd: intel-lpss: fall back to polling when no usable IRQ
Date: Tue,  3 Nov 2026 09:57:18 +0100
Message-ID: <20261103085719.440-1-samuel.tirwa@web.de>
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
X-Provags-ID: V03:K1:jLMBHQD33WEQDwfMtW4U7eKCdNEQyF4/2HzX+XhsQBv92X63DGi
 HzY18pLAFecpsDJiaTWerYMPftOX6tP6ltYADKLU0kLooS0rWqF88/T7OFmUBE26lESOJEz
 2aUID+Ri5ztdwMQo1jCQGPSyVJvC0a8+OUpOdZb/lcJLxUmn6PXeZg0qkalxcLLfltDNFvL
 Y3OduIc6bYy5DqnzSi0YA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H29mBPWP074=;mFVroZu1zeDlOwG4sXoZUKLIf2N
 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
 pEhTUj

From: Fix Agent <fix@kernel.org>

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

Signed-off-by: Fix Agent <fix@kernel.org>
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

