Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794833080;
	b=FkFnsKs3ZHSobIpJ6BLVv1Bq8htVOiATIfAcMEYjIvwd9rasQvINxQiNkOESBTMAtQvr
	 p8kQnUmQ7gd4HgdoguTlUeFYKbQdSR9OtskpbOhMnDL1Ml4uVvmS5I9+0SXGfTMTi/Wo1
	 mBQ+iVLl3NcWdQY+izkQi89SRGbEW6y5dSbVwr8RK/MLyzx80d1PVaviXS3oJnI/E/4b/
	 kMW7dKtF0jYkcYseeJkG7Orp8N5vcVIC9Er3pjwPmmQVvO6UcwthnAhhHxMOqBafGDhy7
	 MjyZ4TwnqJKN1UU2Hj4oegN9xmHdoywPcvmK8OdqqEN0GLxtN2i/BO3hP4nTiUiXpRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794833080;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3CMJxVv9/aaz1Nd1h5S+aoZPa6Wsq51r76/7Qk+jCcU=;
	b=knCYZ6/9nfnEOGtYEtRioyfWpIKDVmGRGX0vJpz+pV8ODH35pK3x+MGy/chU6zNgCDjO
	 khe0uaGD6DULr1d+5y06I4JbMJFdqVVRIkPCAjH/zHxZS6/SFdKq2T6MzkZExOF0/wCaa
	 W7v+qdbRSvOaxZMGZqKajh8s1rN2RIoXAmC9G0YoeY1CAzxlvZfe/tlJOMTIdR4BhVYqI
	 V51tZ3XBkg8ahOzCVKRSu0WolfTK2bQ3HfbIdUvuL9Kcek9YGXdyc9hba8Q3EdnxW7ZQ7
	 1Ovq6Kxa1Pr02goVhUVEpPH7tNu7F/jF8lEiSD72I37Nhgg03axBF4fZvnZYy17wX0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="XFKY5V/o";
	arc=none smtp.remote-ip=209.85.167.46
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D289606A32C
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 12:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D289606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XFKY5V/o
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5c151178f0cso3252868e87.0
        for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 04:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794833078; x=1795437878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3CMJxVv9/aaz1Nd1h5S+aoZPa6Wsq51r76/7Qk+jCcU=;
        b=XFKY5V/o0fvV9QZehP/l7g9fPYmKxqllsHjCT4DOfQMJYCPmzEbnz4qijBwT1XfN++
         gkWRWUv8CIxs6o/FJG7TaSM7iSeaFEunze0I2ugQX9/GDWxNl9i43YgB8aLp9qRpCGjL
         40x9jm3XWiS0JY3g/th95mcIQvgU6/tr5Li/PgwrBHqu4cIBBJtuN3jzMYwJI5W3ufOO
         cH8MiltsSDXpKpE8JtEBKuCpKhAsAa37nCvAJ8NjE+GKWMOcDJrIjaON6HuzozE4BqjK
         VeDTJF7NqblpFZmYkI7Lpxdp1fegmQV1nWPJ+OvjSOK4zKPhZGNoKWSpOpPE7+IXana0
         aAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794833078; x=1795437878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3CMJxVv9/aaz1Nd1h5S+aoZPa6Wsq51r76/7Qk+jCcU=;
        b=J5TLPuCufrI2q/yfISFD2GdU3upNEpM26PlkF5SqaLLzTOXnnkbrmTOuzAs3ivwDSo
         zJBbYWzTWXlgSEmuUHDtMfb9/3Cjih9sNi/DuCP/WtSQyWOyVdCGgiy3m1G3hDlGq4ff
         po0Peb+a9al+ivwd+3MYgO12g1/BZHTAnRccsA49F5REcrEr1v8sUVOpnTzdahnIjsLn
         /ArZjE4cm91PIJbz9A5t0iOiv51sodRnkRIWyIGnTTK9j8cDWgXYI3pQ6GhpK1nprpYW
         ePh7QOHq7v8E22V6Ed3hqk3GWqrx1TiK5jvixxXN0gz1C/0pfWxM73tGdy8OA4w2jvoJ
         DfXg==
X-Forwarded-Encrypted: i=1; AL+hErHjew1M1KVLC7dz3C3asxXB2qe2SYnqqsMvyNe3wSkMff7j56VU0xe/y+SpgVx/FD7rvF3k8igevnM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xf7QnM61n+OAy5UVONDQC9iGn7FR5eXpZBXMX+POEQoqEl9Mz
	egIPUHq8foo1UTnXbp14t44vf9Aqd8YkpuV1wFOr9W5Hl8XIgdD7L9x9
X-Gm-Gg: AYBFou3dTUKS2QI03/IdLGtVfQtIcUaB6wnkr4wjUJz+mXp58TLVEngm3PEB/ZTc2Ml
	YKKivLHmHT498mHVIvlT48oplSAJZjbuVjTG6r83usmR2bCoqqRaPc9ZFhL04FtSkcmDmHDmJQT
	abwpUEHHF10Zsf4vZOdTXPrxkwC85wtIABT/5TTvyQGXtKCPglxVeldPQcyUVHn9uFinqLPPEPA
	gPh5XndNWzHLgFhTfSsxwcMLCy/RLF4b4b7AymtKWo5SwQYEdT7wEOx3SHQ2lrQBy0lMffN4+fB
	RJSvrzgl6jhadIoVl+PDuCtYYfeG4xx6MVqhT0ieN5jKbVUism/li0FfKHmngCJASXDOGAE2mi0
	meqMnNw0ygOcp/pg/xMHsvN2cqBBcJcAwia36gdDSWNFB03/rm9ZcSXHKqmedrWHLVbk9+S5s7K
	MnSYaKDOK18bs2ycbAar5pozwCIGnwcL8trn6Ej2BeA684gk5XzN2Zzg0ve7qy6WOWRBI4nFci+
	svLmMY3xsQcIddknhOqTZSrbxy+troNkaujjHkZj4eNmuw47iaIamq7LWQjQf9xaReOrFj9KsJ5
	ywWjiS26KL82W4urVzhLh4aq73AbdOxsvVw=
X-Received: by 2002:a05:6512:3a8a:b0:5c1:5715:bd00 with SMTP id 2adb3069b0e04-5c170b1c313mr3742145e87.18.1794833078067;
        Mon, 16 Nov 2026 04:44:38 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c171348078sm3201870e87.57.2026.11.16.04.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 04:44:37 -0800 (PST)
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
	stable@vger.kernel.org,
	mehmet.fide@screeningeagle.com
Subject: [PATCH] i2c: imx: do not acknowledge the last byte of a block read of one byte
Date: Mon, 16 Nov 2026 13:44:30 +0100
Message-ID: <20261116124430.1358948-1-mehmet.fide@gmail.com>
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

In the interrupt driven read, the read of I2DR that takes the count byte
of an SMBus block read starts the reception of the next byte. With a
count of 1 that byte is the last one, but I2CR_TXAK is only set in
i2c_imx_isr_read_continue() for the byte after it, so the last byte is
acknowledged and the target goes on sending. The read fails with
-ETIMEDOUT, the bus stays busy and the following transfers on it fail
too.

Set I2CR_TXAK after taking a count of 1, as the read before the
interrupt driven state machine did and the atomic read still does.

Fixes: 5f5c2d4579ca ("i2c: imx: prevent rescheduling in non dma mode")
Cc: stable@vger.kernel.org # v6.13+
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---

Notes:
    Tested on a Colibri VF50 on the Iris carrier, kernel at this base plus
    "i2c: imx: acknowledge the count byte of an atomic block read", with the
    M41T0 RTC at 0x68. A test-only hook passed the messages that
    i2c_smbus_xfer_emulated() builds for a block read to the adapter, alone
    and followed by a one byte read. Register 0x05 (0x01) as count byte:
    without the patch 40 of 40 failed (35 -ETIMEDOUT, 2 -EAGAIN, 3 -EINVAL),
    after which the RTC driver could not read the time any more; with it
    01 01 and, in the second case, the byte after it, 200 of 200. A count
    of 0x13 (register 0x04) reads the same bytes as before.

 drivers/i2c/busses/i2c-imx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index ccf08cd63151..0a59ebe70eb0 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1095,6 +1095,12 @@ static inline void i2c_imx_isr_read_block_data_len(struct imx_i2c_struct *i2c_im
 	}
 	i2c_imx->msg->len += len;
 	i2c_imx->msg->buf[i2c_imx->msg_buf_idx++] = len;
+
+	if (len == 1) {
+		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
+		temp |= I2CR_TXAK;
+		imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
+	}
 }
 
 static irqreturn_t i2c_imx_master_isr(struct imx_i2c_struct *i2c_imx, unsigned int status)

base-commit: 25e7ab89f4774b0f842cee0e8a20c11f755924d5
-- 
2.56.0

