Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794555176;
	b=wnnJ6HNiNLt9RNxVmoLH6oj62pB4ufMGYvIbwp8v38T+uwiVlf7g601L2cqiYYr3QCyE
	 D6qntDjCy85rVucRjk01Tfvhy09gpk3O4yaBPukZGoL/JQ/u5RaDdiLjKrxP2bfVBXLmk
	 8x8aFDnGz4xQcs1Gz2tCOSWZ3hk4Bc1YY8Uhkww4yZa10it2E0pJhkvtM+2+rZQM3nUT2
	 ktwS96MY21DGZz25WMF3NHRCLHZLFfRqgDuwnynjzXn72E4WpTVxIkcBoll8/vxXxq2CV
	 capddccSf9OX39bHqjMJYCHk9mUzQEEjpiqiFt/U2rsIgV43q+tH3RtM0vXnEiwYLEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794555176;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4ra5/SK4PyEv0el96ww+o2fa14mgOl6L/hKOXN+sF2E=;
	b=1AcfLlGCCJsxAZib9v1b0IlLfzk55sCOd0fsij43cgQKh0/pyGPUqVq45Lxpqxb/wpw9
	 Eq1QAQSNDUmBvcHyEzZoW3C1zMIWQuG7uAr7WSlY7Bl3Gs34B++3cwfzewuPsmqeQ69sY
	 MkTe9lDgrfPlFpSK6m8zWL/zx6HfVW66xpAChleOFEdbXNX5VrxWjo30O+94QycqKUMuv
	 ff51Y7s3WrAGB1aLCOXGHAne5vilB9bAlrKr/xiyk079g6pi5gTPG61PS327UwSDKxK/Q
	 TIAdfLdGodZehLZ14bH3UCKvxelDuqwT4OYLbFYUbg9tA7sFt1xSCONh6ArvFevO+7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a6OKct70;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE3D606A888
	for <linux-i2c@vger.kernel.org>; Fri, 13 Nov 2026 07:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDE3D606A888
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a6OKct70
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-492690dd5daso796035f8f.1
        for <linux-i2c@vger.kernel.org>; Thu, 12 Nov 2026 23:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794555174; x=1795159974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4ra5/SK4PyEv0el96ww+o2fa14mgOl6L/hKOXN+sF2E=;
        b=a6OKct70ZG6eI6DeH5mM5WUBeroQ1w0LP+arZrrCd6Io7STDuWpJP+2n2UwoDDcBnj
         gvjj+Dq2k2hlIoK2bnv0ws2Ia7164VCtjy/qh9ZEKT6KBtL4iVEtMGpE93J1jpxtzGk9
         M+8vafOtIVBHx3DVOtzQCMmJgKuz4knbz+NQlteHSFCkvgxY+Z0oVocE5PDChpiSZkgf
         4YwE/ul1QJ+8iE4u0v2g2gyowGWrZKUqrvpZoWJ1FTIA00BoEUcjnYPXAstvFtX77lw5
         KGOLcwQOcXjj2RZ2yNcD2pc494O/eMebz8dI3vebsZDUr5K3D8zu2WUcrcEcPssftSpP
         1miQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794555174; x=1795159974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4ra5/SK4PyEv0el96ww+o2fa14mgOl6L/hKOXN+sF2E=;
        b=2h4Bv08YWyNMj8YI0gKgFt3XzlYizD4gv7Rb/njaoTwDUjlQ4WumbP2LQtrnsbkz3v
         RyXEX9NtMFwGb4NjP/Z/LqKzwauHtxgkq+tG208pi6ow4Z2gcuGZhaa5EWojLokFWp+i
         MW9rqoe8NhbG50SJE+x0PzDK926W5xY9k7ny53Pv6gZPO05eIKbwseGYqTv9inx3s95g
         LMrQj3qmXwhNyWg3wKeb1rhnDEhxfSqXut+DCW0MIYCWjFnbC3CZdgMLibiwJQlORpwK
         UlhM6J7kUOhSYb6ptAwIZ6HQRSrtunRnRzB4k7IXTxsMx8G/OTtb3ZmTH83aezvE7X6+
         bCMg==
X-Forwarded-Encrypted: i=1; AL+hErGLul6HGtA2QK3fifhm679x9WK4JOodtoipClrkng2SSrvkkMRtzTCRhzgKlviT/56Rj7/w6fHrzm0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9JZGNUQD1tUPK7AghLLfywoYYeLXFknh4ABq5oswvkn8YAdPHN
	b1AXydy3XbhwG0DHzDKWGR4b9p0/fnHSfnokGz2GWXQVMwvnQ9dYVSXrKf+zolCj
X-Gm-Gg: AYBFou03qEGJbi+QETtoxBe1Mxi4Iywdr9jOk2YTY/gHJSWYQL0/yyOYESe4IqJViyW
	/T/tUSBx8uvSifnzeE9ZVFmJvjgI1W6spIteL7ITaWdUTjgI6UT/31bD6HWQU1sdg1bF6lDFMKf
	koxAjvlfmxUjWCxF3JwBQD4te1TxN64UjD2NgGjExGo9VdIBVJv8GXX/E9TV4bLMKFPXK0T97sH
	eonjZn26WQGDz9ciADk4eEQ3zQA6dVzCwnpD77mey5EqOfSOwiD7+37BurmUgo4NvwGaV8U/8P6
	0qw7U3uTAw+SHxsNp6yjs1ZZwtP9Jzxi73RKfHeJAYGFFlgEvRVX1ibyPiP9dcHTtok/zPEVPuU
	dSIflfSCBrHaiwplS+Ykt5R5FYAPN5I1iDX1qQBRsV7xbsXJ9ODXXI1FCNPFwsvOQMzzRbBwbQt
	Ess707FLMMvsIaHmIJSIB//pxDjMy7TBZSPQL2PqdsHgqascqkpUZl8lvJ5LyC2FcXw5OcWulMw
	hz61//siGNzZqmgLaajezW6ybuwSKticvExXE2uP61n4q+bDEcSKcAF2qtJ/NQ2UvSBAFsyWUHb
	YmjDQ95NKroyeyG0MdGq7TkX8t1ltxZl8fU=
X-Received: by 2002:a05:6000:98c:b0:491:49c2:3b3 with SMTP id ffacd0b85a97d-49c71d48644mr3357985f8f.51.1794555174171;
        Thu, 12 Nov 2026 23:32:54 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5d223a29sm3799903f8f.8.2026.11.12.23.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 23:32:53 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Yao Yuan <yao.yuan@freescale.com>,
	Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] i2c: imx: return -ENXIO at once when a DMA write is not acknowledged
Date: Fri, 13 Nov 2026 08:32:50 +0100
Message-ID: <20261113073250.1037215-3-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113073250.1037215-1-mehmet.fide@gmail.com>
References: <20261113073250.1037215-1-mehmet.fide@gmail.com>
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

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

When the address of a DMA write is not acknowledged the controller
raises its interrupt and no DMA request, so i2c_imx_dma_write() blocks
for DMA_TIMEOUT (1 s) and returns -ETIMEDOUT, where the interrupt driven
write returns -ENXIO.

Let the interrupt handler end the wait when it sees a missing
acknowledge during a DMA write, and return -ENXIO. No interrupt arrives
while the bytes of a DMA write are acknowledged, so that path does not
change.

Fixes: ce1a78840ff7 ("i2c: imx: add DMA support for freescale i2c driver")
Cc: stable@vger.kernel.org
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 drivers/i2c/busses/i2c-imx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 1987a0fd8132..09934f3b13ef 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1108,6 +1108,9 @@ static irqreturn_t i2c_imx_master_isr(struct imx_i2c_struct *i2c_imx, unsigned i
 	switch (i2c_imx->state) {
 	case IMX_I2C_STATE_DMA:
 		i2c_imx->i2csr = status;
+		if ((status & I2SR_RXAK) &&
+		    i2c_imx->dma->dma_transfer_dir == DMA_MEM_TO_DEV)
+			complete(&i2c_imx->dma->cmd_complete);
 		wake_up(&i2c_imx->queue);
 		break;
 
@@ -1225,6 +1228,11 @@ static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
 		return -ETIMEDOUT;
 	}
 
+	if (i2c_imx->i2csr & I2SR_RXAK) {
+		dmaengine_terminate_sync(dma->chan_using);
+		return -ENXIO;
+	}
+
 	/* Waiting for transfer complete. */
 	while (1) {
 		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
-- 
2.56.0

