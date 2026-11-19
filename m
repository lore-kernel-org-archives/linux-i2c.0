Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095754;
	b=1Jh+KWd6oBJYq0B/OqKNk6ZyurKtRBlQtTAQaO+Vxo+IctQ2pyNdYurH7ovkLNM77Z6Z
	 gtb1wpdKgDN5tLMyD0iAl04X3OD7Nx3/FvAVrzjyoON1cHCDQ88Auebk6gvZSW8DlO+ZM
	 ZDK4oBHSbmz4iYfnk4Sg8+cvHkujB9Uh3V1b9GdBQeb+ngHaT/ZrdVGcMop1iflKxvWxV
	 TFCROaZeGJpz34IWX258JuXqFNnRMUAl5RRvuT6FpZ1LPf0RNNjZpKD87dKKJPAgilWBj
	 nGc4V6gHjjW/YfDdKKLwMjNO8kCgFk4K22VoqoGKnMWpHW9hQtZsVqb83IEFbqmt74w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095754;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9qeJQ2WcAvPP7/Q2COJ9+M/C2lXq9FsH5eUhG/hiMvQ=;
	b=UQzGk0Qx49RdpMljQh9jchC8izBsiwHMSNlb26j4W7gsQCp+MO8Ow4k73vADqr220GqQ
	 lAg1VbOTQGxRnJf8fv9s9dAXfLrLIlJU2SwQt1YLrEeY7zl0tpT8TuFN5BcdUHjv2+90b
	 QPS5tlpJ6tmB8UOtT9oDvRWcxzR0aP0wH3qFbvHYaDiUDKQtX761LqMTGh7XRDHTnX8L2
	 BlXlhEtwJ0OtszrbJ8RkVq+l3PLyUGLf+AN1IkMoF1HF4Nw92JhDAkLs2UvEtK/b7qQdF
	 lm2Nq+f3bxlmXNu0abADoZvXvUWHGe+V4APDjDzTumhdz67xrO39mCbwF4H0CJTEM2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O7MKf09n;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D16760A382E
	for <linux-i2c@vger.kernel.org>; Thu, 19 Nov 2026 13:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D16760A382E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O7MKf09n
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4a33359c1b3so1602892f8f.3
        for <linux-i2c@vger.kernel.org>; Thu, 19 Nov 2026 05:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795095752; x=1795700552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9qeJQ2WcAvPP7/Q2COJ9+M/C2lXq9FsH5eUhG/hiMvQ=;
        b=O7MKf09nfKVBP1T4oceqltTqNtUEQMesLfGURBojEzm+GY2PG4pGTRLM358fYPh3Bb
         J7gEm70bgkgR+aAKOziihcRGiyQZ/5m1A4bDhkpWXWGOvot/7vlfc6twpDoA/knjlyBR
         v9LdUIG1NjuUuyejLuiKGarM1yLCqKXx1emsnc/n8iS/V5ZQ0x4Gc/x2wEkYkAaq4Tx4
         oLYuQRNkzG+C472Qn4CWCBXndOU7ucavfo8oISYimlIjbR8g4gaPvgZSjkz1NnP1BnZ1
         ireq8zSTYDWK8sCK18d2c+u3Go2TXNKzJ+ZUPeqB8xM1O2AxxOkIEXf9tbKIB/a7/Lrr
         vI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795095752; x=1795700552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9qeJQ2WcAvPP7/Q2COJ9+M/C2lXq9FsH5eUhG/hiMvQ=;
        b=tv7reISbLru57GjATgdoOwN0noWKelnrAVdfmNT2z2idi0wAeH8z4wCPXP6Ozp2mdb
         kAYymsXgcIJZR6GO7vbQOdo0PE/tPWGj2DPBlCXO4n/gooCe3L9QjylvyeGagapwmjT6
         o2Tn4tn/h63QTkA5RHs6ytWcnFqOvkY22cgq4Zect8qV+7JfvI3AW7JFSWda3JnBUOpY
         hRGcHQerZHDGw61B1X5ZmDcqMGaFcH87UtDbP0/rS3qFcJslvk28Mo4tSCT3xTLMeRCf
         NPlE/23p4zfLtIZw0D2tCZs+SirfjU9jLJSo3hY9rguv7QOxNhvXPbCWu8RXtKbRRhwS
         EVHA==
X-Forwarded-Encrypted: i=1; AL+hErGZPeUmn2kowC9oOyAmOcrwUs3MetzLSfovhSigcB5MIBHP3BToB2SNZKTfkk746tLyq66GmVovpD4=@vger.kernel.org
X-Gm-Message-State: APuU4Z906ZCFDHYqYe4jBKmx9hy1DGcvB8uBC24azksX3kWT/5CiAyU9
	vpTUMwCkC1PxH586bdgw1v7K5UlmyoqMf6CGxhOtENzLnwiqwQPyh9xa
X-Gm-Gg: AZFdTZfscWxU87q2ZcMERN7glp2QUXNryxtrnrFmn9pLH6jUVE65rE3ZOi3OO8RsYDG
	LliE0nUPZk5idVK4MgUWmjdyoWj6ca/XsjCiQudH458eVPHIi33+l2lpPagqGQ79pIsMIUA598i
	xqO+KEJK/EvipRC8xYOqeqoTxYYThB0R5VmsyDC2Rf9LrN5enu1RTAShXkYRW3ZZsCpXwJksXga
	+XL6J2Dm4nkq1CeTpFUb2dqnahmbEIe9lqBy2Sv6U6xe4zlQGTr5DahafSOCBcLuVZHezefn+JY
	F2gP4cajEd8jXQO7N7llwZ+TTXvHoYRZlpwU75HbR3yCNHTlfVS0zDTvyqVym/aIiq5RlbrcxgD
	WqOEApWnpMSgDzgJBxNBaChvWWH6wOt0mB29RSOC2MzB9POunnOCoFPG4PnEw5XUSN1lTSGkv2Q
	sEjwBel7JMHrM7+vL9IY1NOx5GbbcnE79EC1CYwF5Qq7v1SPnzGYFVIwtRZHFUin8s2h/XaLAD3
	L2vRetYaRY2k4kzC56U29uwOS2COXLnveD03kZvXESAoiJSReagVRDbu9q4daFRA4MY6OnA8FU5
	oS/6v8NrQQ5yYBWYu4VO2C9rSunXTUz/xf9qlW5Jnb0ekdhip7UiaDRs
X-Received: by 2002:a05:6000:2c0a:b0:4a7:1fca:e52b with SMTP id ffacd0b85a97d-4a71fcae766mr11850285f8f.19.1795095751841;
        Thu, 19 Nov 2026 05:42:31 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656095e98sm9437971f8f.42.2026.11.19.05.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:42:31 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	Yao Yuan <yao.yuan@freescale.com>,
	Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	mehmet.fide@screeningeagle.com
Subject: [PATCH v2 3/3] i2c: imx: return -ENXIO at once when a DMA write is not acknowledged
Date: Thu, 19 Nov 2026 14:42:25 +0100
Message-ID: <20261119134225.265242-4-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119134225.265242-1-mehmet.fide@gmail.com>
References: <20261119134225.265242-1-mehmet.fide@gmail.com>
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

When a byte of a DMA write is not acknowledged the controller raises its
interrupt and no DMA request, so i2c_imx_dma_write() blocks for
DMA_TIMEOUT (1 s) and returns -ETIMEDOUT, where the interrupt driven
write returns -ENXIO.

Let the interrupt handler end the wait when it sees a missing
acknowledge during a DMA write, and return -ENXIO. The last byte the DMA
writes is still on the bus when its completion arrives: look at its
acknowledge once the byte is out, before the final byte is sent.

Fixes: ce1a78840ff7 ("i2c: imx: add DMA support for freescale i2c driver")
Cc: stable@vger.kernel.org
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 drivers/i2c/busses/i2c-imx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index fbfabceb29ac..06b082c677a3 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -480,6 +480,9 @@ static int i2c_imx_dma_wait(struct imx_i2c_struct *i2c_imx)
 	if (!wait_for_completion_timeout(&dma->cmd_complete,
 					 msecs_to_jiffies(DMA_TIMEOUT)))
 		result = -ETIMEDOUT;
+	else if (dma->dma_transfer_dir == DMA_MEM_TO_DEV &&
+		 (i2c_imx->i2csr & I2SR_RXAK))
+		result = -ENXIO;
 
 	if (result)
 		dmaengine_terminate_sync(dma->chan_using);
@@ -1123,6 +1126,9 @@ static irqreturn_t i2c_imx_master_isr(struct imx_i2c_struct *i2c_imx, unsigned i
 	switch (i2c_imx->state) {
 	case IMX_I2C_STATE_DMA:
 		i2c_imx->i2csr = status;
+		if ((status & I2SR_RXAK) &&
+		    i2c_imx->dma->dma_transfer_dir == DMA_MEM_TO_DEV)
+			complete(&i2c_imx->dma->cmd_complete);
 		wake_up(&i2c_imx->queue);
 		break;
 
@@ -1248,6 +1254,9 @@ static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
 		schedule();
 	}
 
+	if (temp & I2SR_RXAK)
+		return -ENXIO;
+
 	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
 	temp &= ~I2CR_DMAEN;
 	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
-- 
2.56.0

