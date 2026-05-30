Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4670C2C11E6
	for <linux-i2c@vger.kernel.org>; Sat, 30 May 2026 20:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780171574; cv=none; b=nvaz/KQv1wCTlUig+bEFILGkaH2xJAKvc2fPzaOtETUOEmcXve1pZv7gt00U2/cMElTTQgDJ4I5nWul5lReL4PAdV4b2/oaAqawEJQMM379uHt53hEoKMqY1INz+2oRAR5lLHdvkvvHkjDmYW7lctnwqviFxKLsb3NuqduMRGxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780171574; c=relaxed/simple;
	bh=cm+7oPUGXwscThq8v9br3e4nNphRaCFZBysh2owGR/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RegEiRfCHGO1xUB1U9zS0pB+ai/tugLePGAvw7FL7Gf/c8E2WAteLHxRZZiYbRJkO7GovfITqX1iplhhyFiYPHl9tl1DXqiHS3t40GcNjWxhnDwtROMth7pDlok9MrellckK/gEbtqDoM1xtc2EEcUEjJSq/pxO/YMpqshwTHuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enLLBTZY; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enLLBTZY"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c0c3546924so725005ad.3
        for <linux-i2c@vger.kernel.org>; Sat, 30 May 2026 13:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780171572; x=1780776372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7fBSNfLq7QUu4AmPks5xSIdwkB0r3aZw9X+kxcAAws0=;
        b=enLLBTZYdeo3rUMKLnF4yVoCDeX4WRWq0K3wJv6AlS16qfcxOYOMKIYpBPXiktcA4X
         n3trXg9gwb9cTdiu0djVoe7HDdqvab5d+OuzKWQeiuPJiGTCTQToRaOvsqL8DKIY7FBM
         uVzx9VozhyD4ZfmuyWIe0t59xk8kxYR//NmhYeMo7QUilYOHkPNsMsTw634l501fgV1e
         n1fs1Z5XMRdpUbzUJfbjuaQ9u0htd2PjChZbxh2oaeCjSMVwoA1R1BcABOvbPma8CiCm
         0SyE1PBEA1yTIglbDp3ZJ59njIfzigYcOK00SCCcu6vqKDQ0NFZhvqBZQhCF8wL6IZBM
         Mx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780171572; x=1780776372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fBSNfLq7QUu4AmPks5xSIdwkB0r3aZw9X+kxcAAws0=;
        b=jOQRYLT7yZkxyX2LGQ8V/qWBNZDu+ll+NfKTzHWnhJiU17faYPdkLMtWkXrbAW1k2q
         b20IA4RGnuFHgYJkbaopa3bC7diHjWNu5GlqsUczWWW7cMZh89OMWMUPQBiNxOqeT5MS
         XxZ6HhQ3LqzXdFzQZxomgWpqPSfvjwvOyh4pW8yW9UhjSuhc4Gtg95zF/uHwNxIflBgy
         YoSAVuwUARpSqACz4oRHTG3/p82xuG3srRa/aenjGTRJkzAaZMZ/UncN9VbrFzY5hRcW
         324+b+481D7aFXiMISbKHKvlUCA0yxqAdGqG1BMSzOpHP10ySE/ral3p3O0+glyFT+Pl
         ldBw==
X-Gm-Message-State: AOJu0YzNoXvFcj4+9OvD2VunAaqB5EEI2EbVtE9Zm3fP4NLJBLgptKfi
	zc4SSnTgDFHCFf69E3YLbCKDA33m3wBHCOYbenHY2kuLXhv0yvbnPcuPLCe/qNJH
X-Gm-Gg: Acq92OGK56uMII6KNa8y+NKxxirZs1SFxjSqnwbXEla4J+Ujd/GuFCJ51QLvKue+gyE
	VlzjHvp9zx6358UNc1UUJ3DxezXHRP0KshHVl7mEySR9PVHcr34mh/aD7xN8wYluNwixYPk/RF+
	19bT+d07yfQWqmDVxkuIKVAI6oTCbLPKeP5JCR46QSDooi1I2z9XIIXnEvT0gSmr/yymFxi77UW
	ZcEJJ0jVXjTtWum7vzdEl4dZpVEDH4HQ3MnWFUIsmKLW7F6iWyZRvAD0Zhj6v+hq1F5XNBRdvAV
	OGzpV3Y9TzkSmCJ/0fIOM/Kgkzipv28cYfWiIEjlImC0kgea/zzndiPI8cKHf0BRNylLEDOTr1C
	FE0I70RKwDea5eH+I+QUUeGh6fVeg/xEandKuDeZQzchejzAo5s8NfZK7ZOMP/AdMgYLSjRzBnN
	XrUZwVz/NpBwRUqFCE3JEsABEUZdbN81X/l9k3H0Aa48PuIgly+NNdoIFwJMxIn3wBRfz+ATXYN
	R+QvV0sIWENEhabtOvIrEbqEvBzhB+wA/fNYsFKQRiJcQ==
X-Received: by 2002:a17:903:37ce:b0:2c0:b5c1:8e32 with SMTP id d9443c01a7336-2c0b5c192fbmr19092815ad.41.1780171572211;
        Sat, 30 May 2026 13:06:12 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c4dd4csm58546105ad.78.2026.05.30.13.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 13:06:11 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] i2c: mxs: add missing kernel-doc for struct mxs_i2c_dev members
Date: Sat, 30 May 2026 13:05:54 -0700
Message-ID: <20260530200554.8415-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kernel-doc documentation for the struct members that were previously
undocumented. This fixes warnings when building with W=1 and ensures
the struct is fully documented per kernel-doc conventions.

Assisted-by: Opencode:Big-pickle
Signed-off-by: Rosen Penev &lt;rosenp@gmail.com&gt;
---
 drivers/i2c/busses/i2c-mxs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 08c9091a1e35..4e07babea9c3 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -108,6 +108,14 @@ enum mxs_i2c_devtype {
  * @cmd_complete: completion object for transaction wait
  * @cmd_err: error code for last transaction
  * @adapter: i2c subsystem adapter node
+ * @timing0: I2C TIMING0 register value
+ * @timing1: I2C TIMING1 register value
+ * @timing2: I2C TIMING2 register value
+ * @dmach: DMA channel
+ * @pio_data: PIO data for DMA
+ * @addr_data: address data for DMA
+ * @sg_io: scatterlist for I/O
+ * @dma_read: flag indicating DMA read
  */
 struct mxs_i2c_dev {
 	struct device *dev;
--
2.54.0

