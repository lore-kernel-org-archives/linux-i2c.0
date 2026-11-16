Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794833985;
	b=y/y8DOYM14GFtZ3GvEfwkyqSjO1dZslEPQrBzj0C7StJcfRHR/kaDcFuRviYKvSk/KQN
	 vbRGyBmjqid+Hsvvb+y0vuafqSdRnWv/iH4vv5nnqpdc4WnvVo3aFs8ghaLKa9U4b/ZNx
	 qODFH+9J4Fz5q5eUfJyv+xOzT31uhRTF0Qz7FDGEPhZJ/fHyz6mMqIirmidHmIJ/XEkdY
	 3vYTK2b/XofWKT3rMiE6bloksfz271aBoFtaprUchGZD5ENujiToohEx5KudUaOJQjTMe
	 BeKU8WhHlUBk3UQigzrE7gYc5gWkU8AIVmHPixQel8VQcqY7g32pfmzNjmEH60fX9oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794833985;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xcfNxQDKaTxKC3WY7d0/shn84qbuxfAl2J/mE8lsllI=;
	b=YKSL0Qf+MWsLc0AOXXazqs/vdcmN8GBnTxzaONUwxudBo2groz91ZXkt2JxiLqo9YhCY
	 kV9DQHM1+ETc4AouU0e7LxeJDXmqmHfa54xN5uwi2Ursszfo7dWmEo4C86e/DBroeP/gt
	 lDijbjfF2b1WrDmj9J61XKghp0fvsBjl9MBd9ymROwyQSWvgePlg/YuglMVYeJMEMFZGB
	 ESPDF7QtBIL4z208Ml1taOvKIBgfJes87B/YXwfjGQ31TQaZEQK2lnAVvywL3wIAGDuhl
	 JGZYzqGCe41KUvwd+/VgKRRITcn9Sy+YQV+Ex9AqGoTn3LrTxn5MvoRda99Hcvpk2CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D9gPU+Cy;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B7260A2623
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 12:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6B7260A2623
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D9gPU+Cy
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so10481805e9.3
        for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 04:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794833983; x=1795438783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xcfNxQDKaTxKC3WY7d0/shn84qbuxfAl2J/mE8lsllI=;
        b=D9gPU+CyjJQ6g+iJIUplUYc2NJyLCwP/xrnG9ifrsvPZM8auQZpcDpMeMePZsImhPx
         uch0qXkdu9GGb3N7/uULQRL+Q8eSB1ZxgT95QxupeXT4QTetsnuv7zarGytHzVgEsrRj
         7wdmq7MZ++aZ/9O+sqsfDbTZQmBHTM+Sgm5tNCXUAE5B+bv6eZjRHNfOlI7C7B5Nzfsu
         uLrzBPObBZcwyy6cjzJFuXhVDYxGhEp8V/GTKstbJSMNBbdhcwLUv/Kq2v5aw/9ehM/g
         Nu68huMWr/T3MwiIAkRsdd01eJWAOyXozTy2dxrTyQUyVnIKpMqH4XzKtmJbTvkc0O/q
         2tTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794833983; x=1795438783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xcfNxQDKaTxKC3WY7d0/shn84qbuxfAl2J/mE8lsllI=;
        b=dmYeoh1k9eRreuqF6DvOR7xqLROWUckw0+VodBPK9lB2qAgDmW8JlZPTuKLqpcCAbt
         xTdLVvhJOmu9eHMuqU91K2EIzDoCxdyEjrsg9pwrjuRh5GRkCqs1iR5Rso0XvQFar/+e
         xegZmnHg95Fq9mhbd+mVOEBYIoL4MydLpC4yjALAxwyWsWefGz2yBpFEqAUX/25P6bxi
         o725dRWnbl4wLnN74ovoqb5F05MDwrdBD+kI9PAqhHXAdf749Qp/zWXsrKXi3X0/8F/+
         OTJ8G3HCrvKVke5OzkrNtWF+Y4pkPnC+JUiyEa2t9NnMPfIdrI8qALUhJ8OgrtNnRmHK
         PmxQ==
X-Forwarded-Encrypted: i=1; AL+hErFZW7Bq3cPkvI7xoGPDw7xSKP7XRWoc3PNMIumPa1Sukq2yRjCDEvGxoR02GlDpnvBDxvLl0fLk65s=@vger.kernel.org
X-Gm-Message-State: APuU4Z9EEG+2NFzBGpg1DubwmaoY0Zc8hXPknsol3YZgo+kj4khdpL0+
	kXcWn4C+Ftw9yyn0UsN3RwNnBz/+GJb2oWXOlbmjgkdg1gKlBnz+Q2GE
X-Gm-Gg: AYBFou3xY+KO0vN5keDmuJyFDU9xAvIlnQYPaljfLGdnDxVNd03u1Q70zXMHFe7tmw0
	EtRZPCVdZNsieUTUCehiPPFbPB92OaJYHAE7jeorW2P3K4K2uzQpwB3xmuwcLbHXjGq8rzZyVpf
	8qdgnbwtosIlN1/DpZTwGPcl36H03xiL67EMePKddhSPRzu1NWJYhgAMq1c8DTGpoKVVpWhk58D
	xE3ZxYjMzdlzO3CoiKFpclIOuG02JIKyR94N0AsjA0GkiJsPsP1MbXhHl1hF6igMi+nS/xBkMFO
	KnCDyZjC8OeHZWE1OJitknGAYTYzNRQhruiRkDzBxEj5s9hePV+o2c2xJr+487Zj4kh/RYY3Lmz
	V3ef9g2hw5I8chwM/Vuj08vxnMW2rjQSEfqNk4PEmGd2kk3nROleBANRW2KvVLF/rQjwM5FA0qn
	e4fRlQ5k0DZrsJ/fxojLUQfLnZiL4tgR6v2JOjLndAkSBZp0rzEz7ZuQ8p11B4IasbU3GeVu52x
	fqpCygiNHNmYsGbeELnS0gUwbeunmgugGbbuHjxMQjPb+DejFIsiis4PndvgH+SldUKb15jMcsr
	78XV/6qr4CioHL857ojcfjxc8373sICFfY4=
X-Received: by 2002:a05:600c:8708:b0:4a6:30c3:1114 with SMTP id 5b1f17b1804b1-4bb55a7ece6mr231511055e9.12.1794833982968;
        Mon, 16 Nov 2026 04:59:42 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb65ce005bsm205471805e9.14.2026.11.16.04.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 04:59:42 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mehmet.fide@screeningeagle.com
Subject: [PATCH] i2c: imx: keep the error of a failed read
Date: Mon, 16 Nov 2026 13:59:40 +0100
Message-ID: <20261116125940.1368194-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
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

When the count byte of an SMBus block read is larger than
I2C_SMBUS_BLOCK_MAX, i2c_imx_isr_read_block_data_len() sets -EPROTO and
fails the read. The read of I2DR that took the count byte has started
the reception of one more byte, and its interrupt comes in while the
state is IMX_I2C_STATE_FAILED. i2c_imx_master_isr() has no case for
that state, so the default case replaces -EPROTO with -EINVAL.

Ignore interrupts in IMX_I2C_STATE_FAILED so that the first error is
returned.

Fixes: 5f5c2d4579ca ("i2c: imx: prevent rescheduling in non dma mode")
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---

Notes:
    Tested on a Colibri VF50 on the Iris carrier, kernel at this base plus
    "i2c: imx: acknowledge the count byte of an atomic block read" and
    "i2c: imx: do not acknowledge the last byte of a block read of one
    byte", with the M41T0 RTC at 0x68. A test-only hook passed the messages
    that i2c_smbus_xfer_emulated() builds for a block read to the adapter,
    alone and followed by a one byte read. Register 0x03 (0xae) as count
    byte: without the patch -EINVAL 40 of 40, and a print in the default
    case showed state IMX_I2C_STATE_FAILED with -EPROTO each time; with it
    -EPROTO 100 of 100, as the atomic read returns. Count bytes of 0, 1 and
    0x13 read the same bytes as before, and the bus works after each
    failed read.

 drivers/i2c/busses/i2c-imx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index ccf08cd63151..c7fef98934d4 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1142,6 +1142,9 @@ static irqreturn_t i2c_imx_master_isr(struct imx_i2c_struct *i2c_imx, unsigned i
 		wake_up(&i2c_imx->queue);
 		break;
 
+	case IMX_I2C_STATE_FAILED:
+		break;
+
 	default:
 		i2c_imx->i2csr = status;
 		i2c_imx->state = IMX_I2C_STATE_FAILED;

base-commit: 25e7ab89f4774b0f842cee0e8a20c11f755924d5
-- 
2.56.0

