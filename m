Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.135.140.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795106462;
	b=PAl4EkV/cpUoFdGer/6kPgo0tFkpofMf/fEaZrHZTRoeX36xFe2sExT+fnjYWl9Nv9GS
	 oFtYf0CFwAI5G8lQxDXGAiA5sJ7WDokUO+eleTguOhsa0qLY971r2y92wb1x+Gt7RVaGs
	 MPqC8tTQRmKkxBnJnIBkKZPXqaEuknrvBKAkJxvNXcPax2TEK8cBBmpy9HdIH3xClFNHC
	 N30/tHCpkOaIVzXU1oDPXpn2FQ6RTTJR7Y71U376roBfyhCsq+P1V78ithN5M52R06mnb
	 IDDvzntVn7Fjj3AED9UU3AwIN0K3/2X7nSZsPwY6Q6/1nc7p0NyX1SOKgU5r4o4LfVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106462;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=nxP0zUDfPSiyGCVRDOR3qEnGVvd7XxArnZcAUdY01IM=;
	b=AABM7tAiaoBvNbZ1dNZCsrfNyNqQb5zQhx/nzKI3gEyC1XsLIzAqMtldE/mG9nnOvpan
	 T+ReL02yPpvZFAKrzsxjZDnWkqD5atWyYQpuaCDWGtro/xPYHp6YWaSlzrY2RHX9KaFZV
	 2PbOBoUnnjkrrrA4/PKbH6ae4IwQzywd2qMj5ZbpRoQM9TqAn2GfN2xKbnBSOa0hPIG+/
	 SxHhcKfBKOCOiugR0AFSP7hkLJXpeKqeuPFW5sP1RqzqVAgtPRgiIZXoxFMoeYrS27vQ6
	 CqfHJd+wPj7LtONH2wVtBt5dL7lQKNF1OdhsVOb43e3cW9QiFNGvrVCakn49/2Ha48A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cjdns.fr;
	spf=none smtp.mailfrom=cjdns.fr;
	dkim=pass header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=XCeITSHN;
	arc=none smtp.remote-ip=5.135.140.105
Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA7060A2612;
	Thu, 19 Nov 2026 16:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BA7060A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=XCeITSHN
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 06D62571036;
	Thu, 19 Nov 2026 17:40:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1795106454; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=nxP0zUDfPSiyGCVRDOR3qEnGVvd7XxArnZcAUdY01IM=;
	b=XCeITSHNHtCzo3Q0U1DwBnoh4FXO9cTky0gnJK90pOAXTG5gOpYDwWcZQgzfx/aFHOfttz
	/fllntvUb4n0tO3u8PQXkkO/taNJEfIznYfdbSnVH1zJ58cGpJ71acXngXDsyFfw9WD8Vz
	HdtsaadSBYKCC98mIKLGEP5YPGkNcENHwcKMw5mBtPS0rYM4yVwL4uhuy6KcSjkyegT5/g
	tF2kkJ0I3ud2sPEL/huDVUCXBd2FexV/YFQk/YZNzCYfHZPr4QtFhtGof45lFeLeUOoQtY
	kDmCN9oHE/7lH9Jrzq82pi+HBLPz4Q26Sz7eJ0BwISPVBdSY7Vu6f10mpliOtw==
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
Subject: [PATCH 2/2] i2c: mt7621: enable for EcoNet devices
Date: Thu, 19 Nov 2026 16:40:40 +0000
Message-Id: <20261119164040.2400580-3-cjd@cjdns.fr>
In-Reply-To: <20261119164040.2400580-1-cjd@cjdns.fr>
References: <20261119164040.2400580-1-cjd@cjdns.fr>
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

EcoNet EN751221 uses the same I2C subsystem as the MT7621, allow
selection of this driver when building for EcoNet devices.

Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 275aaa7f35833..9295a35f4a181 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -918,7 +918,7 @@ config I2C_MT65XX
 
 config I2C_MT7621
 	tristate "MT7621/MT7628 I2C Controller"
-	depends on (RALINK && (SOC_MT7620 || SOC_MT7621)) || ARCH_AIROHA || COMPILE_TEST
+	depends on (RALINK && (SOC_MT7620 || SOC_MT7621)) || ARCH_AIROHA || ECONET || COMPILE_TEST
 	help
 	  Say Y here to include support for I2C controller in the
 	  MediaTek MT7621/MT7628 SoCs.
-- 
2.39.5

