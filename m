Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793794281;
	b=xM4RacenJm2NrcE2XTCZbeR43MH/E66pOK62MMIST7YbX0Tyc5sl3TN6A6yvxF0BR5w5
	 0ghmX44L+q5dsxAjrfdR8iI6A7bLBLnEGMBkUoSTbYTrp5cp4RD3/tvHW2OJWsH2lbCXc
	 WALhwHGj6wCypQV/PFKKkvBExljAVvZgW/ZcHWVcMbuKXAKqQUWaoGfL/zfS5Ry7wsZVa
	 ucmDg7s54Zr50WYFDamuRrucFL/aWfLG2ZEb4sx2+3W5BrNq5w7vpCEJpXdyqHMrgAZIX
	 AzVOOQK22ShFsmhTzo0p8RU+8i8oenaNxj0u2O0P3oZ9wv5OhEXOlSruWWiPnhdem/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793794281;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6EsKNx+i/27AOT45Y7CU7NIo3IUkBxCrUdSGAbsZRm4=;
	b=x6P8UDFsT+MQ8RwoUiiIxAi19JnP2HvmYWYc2Or9X/WRR8ZNHw1C9U+hF/AvSwv+SXH4
	 3r9YpeEO+uPO79uxfyJsxsnIFuS3W/plHY5YoOBiPmN2ySHoXUvI3WFCmCxPm+3BuTFTI
	 yO/oKY7WNTQyuUo1h9zGY6JRXLAPKETZCWAlqlZaUtgJaSjpYOWzmbUk6jm+1cxAWdOAL
	 d1sPJmTSths8qk0zttiVHSi4ktFSznkoZhorU0iemqBfZ6Fsk78zEHxpgLdKFYtreG4GB
	 FeUkf3Oxe/DAUnxa3UD7vPP4N6I9Whtir2pJaq7ZvIX9bY8WFGzbSojzC2F6AeQmsmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CVb22o5M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31AD606A32C;
	Wed,  4 Nov 2026 12:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CVb22o5M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827D01F00919;
	Wed,  4 Nov 2026 12:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793794280;
	bh=6EsKNx+i/27AOT45Y7CU7NIo3IUkBxCrUdSGAbsZRm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CVb22o5MeuxPtkYl6fYYqI1g8BE2dtuG9E8jQBTPP/QAhN4X+PPEcvCpb0LQ6DJMo
	 e6lcTM1/DwwfxmQYhQKfNDFIjyWI3or9dBC/ryYC1eLMNRlCd+wbU81XUU3DrP+8QU
	 w7KsSPFe9HeoL/jcHWdUsDZORR0eDM5kvF/bjnXn6dBc4fhRiIgZhbvdYMTPsO4861
	 +f63SHH12IbRoe8viAV9/pfG05ejYzlLRHsVwUHNIxAU0K1fYW3RSLUHDLT7EIWOwg
	 5BQSngEIVLDhHo/Vm5KiV4Wf7gBEpUDzHBFyN9V+hNVLZ+XDdYXSqqIrQfevsceM6Q
	 oJ+83gHwuVeWQ==
From: Michael Walle <mwalle@kernel.org>
To: Dong Aisheng <aisheng.dong@nxp.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Carlos Song <carlos.song@nxp.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH 2/2] i2c: imx-lpi2c: don't treat a NACK in SMBus block read as an error
Date: Wed,  4 Nov 2026 13:10:36 +0100
Message-ID: <20261104121108.659820-2-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104121108.659820-1-mwalle@kernel.org>
References: <20261104121108.659820-1-mwalle@kernel.org>
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

An SMBus device might indicate that a value isn't ready yet by asserting
a NACK.
This will lead to the following error message which will flood the
kernel log for some device like an IPMI SSIF BMC:

   [    4.277005] i2c i2c-5: SMBus read count failed -110

Stop the polling if NDF is set and return -EIO, just like everywhere
else. While at it, drop the MSR_RDF_ASSERTED() macro, it's just one bit,
no need for FIELD_GET.

Fixes: efdc383d1cc2 ("i2c: imx-lpi2c: fix SMBus block read NACK after byte count")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/i2c/busses/i2c-imx-lpi2c.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index f57e800ac3b5..583155802e8a 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -92,7 +92,6 @@
 #define MRDR_RXEMPTY	BIT(14)
 #define MDER_TDDE	BIT(0)
 #define MDER_RDDE	BIT(1)
-#define MSR_RDF_ASSERTED(x) FIELD_GET(MSR_RDF, (x))
 
 #define SCR_SEN		BIT(0)
 #define SCR_RST		BIT(1)
@@ -594,7 +593,10 @@ static int lpi2c_imx_read_init(struct lpi2c_imx_struct *lpi2c_imx,
 		writel((RECV_DATA << 8) | 0x01, lpi2c_imx->base + LPI2C_MTDR);
 
 		ret = readl_poll_timeout(lpi2c_imx->base + LPI2C_MSR, val,
-					 MSR_RDF_ASSERTED(val), 1, 1000);
+					 (val & (MSR_RDF | MSR_NDF)), 1, 1000);
+		if (val & MSR_NDF)
+			return -EIO;
+
 		if (ret) {
 			dev_err(&lpi2c_imx->adapter.dev, "SMBus read count failed %d\n", ret);
 			return ret;
-- 
2.47.3

