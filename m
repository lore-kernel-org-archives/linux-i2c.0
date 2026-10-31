Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793409060;
	b=wEit1kL6Or0no+EPPGBZUILphVFMaMSNw0LjEmm+wupbafF1mcEWPfQu5MFOvQceueWY
	 XtVHs9H/WnOMGI7mH6N+/9FWiZbGhvX2ST7ezkBE60SCbWG5FpKaSCC7J86m2riI0S2EA
	 2zGuwVCuQP6eCjbrwJ77vMJl4ivTNkky0llLcC+FNI3SR7ZTf8CS5KaVtP2Wo8yq+rP26
	 7UjA6P7tuuXCu9pYD+Puu4mNYRRAvzvj5UMl2o+3qqHQyLfS2cpFaecsvQy1Tfm57cwpv
	 8N+peJ9x5xdAxlLwzR3sHaVxPF24+Ey4Ye0yYm++Aq24fLhcGjVZMc33oI0l46S/etQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793409060;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=u6n9A3ZneE8NABlrOWtzgZuqAMh0oDJ8q3EQsuGSkn0=;
	b=rp/QpBCJOyTuYD7JNQssTzSVHsFqH9sX7Hx2X1BQNEkS+JOp/2woNok9irN3cAAIYpRr
	 UqoPAmsQyoKFdQykt4JHlJgfKA1U1MvKwdXWFDUJwiGurzDWja2yNFUlD7lyIqkp9y4Kl
	 BMipFPEj2StghENhVzfQlxFtpoCmFKRARRxkBOyZTsNp2ajBV7Xo+lvXyXzunnuXJXy3+
	 3MQgtWIuQGshQfYH3uK6qt1x7hVxUyLamBGb7NRa5nTXe21+XbqfzP8uyjSnuFB8eIacf
	 rgnVVmQ+nSgWCUFRgfIgGE+VouslhnrLS1u+GXQ/sCTELENAIh9J8MCLnK3tTkPFBHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MdnSbLoo;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0229B606A31C
	for <linux-i2c@vger.kernel.org>; Sat, 31 Oct 2026 01:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0229B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MdnSbLoo
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1a2af4c8d00so421134c88.0
        for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 18:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793409059; x=1794013859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u6n9A3ZneE8NABlrOWtzgZuqAMh0oDJ8q3EQsuGSkn0=;
        b=MdnSbLoow4XHYSAMpeanDAsO5fXk3GRDZWFXUXt2lOyOcNiSWwKXxiwqLr33NjNJVc
         Me+mhuJIMhV7aJvUcYHKmaldWldcjtIhQ0QJvBWdYtDtr1hsxuptU8Lzuxd7JHO/w4B2
         XW6G24c+okFeaO3vQJBIUmuu3Qr1mfBJZAk5oS68S4/vQisgk8+0/9EbJzJwZR33V1aL
         qt6+2+FF5Be8m6HvWStBvbZW6kwFebJr8HIeuqStAlOIDTzp4Dq6qbXFg8FtrfsteWPC
         mK06rsdNDyHQOUoSOM8wL8zN/+9geuknric2ZMGhmx1gXJW/hHiSElhjoOzHyWOHxS/t
         NagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793409059; x=1794013859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u6n9A3ZneE8NABlrOWtzgZuqAMh0oDJ8q3EQsuGSkn0=;
        b=MNs7zijpWf4MGOuP33W1D2Hhhzux+px+nXrZQ29fo2jwyxQu0Qlbe1Xu4lCeRvw2+9
         OsotwyEwG1fERK8xh2hRlUxqmDg3aCoG8iFN02gufYr4993x7s+UMAF/qx2lW58UZtlQ
         Bqlp1H/8U2kb3lvm4fqVSe7OQ+ljJnQWPoPwldZ0txSnMsCFEa3+knH+Ilr7eC1y4lZx
         PrJgQms1fSadi1Jtn9PR+bEG+2W0rIz5ZXSZ/YnqQ/9s+x0J493GGAggBYLNiRUFpYN9
         kC9aTVcC9NSyYtyi9c2EAdMdTeZjUSdneOXeTvnwpo1kEVYUF9A0i6bDnQeMVvAQRlTu
         mQdQ==
X-Forwarded-Encrypted: i=1; AKwUvBxZQupQkCPsrm5WSBUCJ3IY/IsYD1ZSzICjcQ19be7a3aGvQDeggDvpexpzrwvCh+BAQl1E78/8C/E=@vger.kernel.org
X-Gm-Message-State: AFq9FYIe1ea1CSEquaC/7exvffavE6i8jQxYyM6KmDI5d6LjrxtOPGsX
	nIyt6EOpn7kuiN+0mHwn3cxNXIwHeaObpzmNViQu/R+CNM4OxZFtr0Ba
X-Gm-Gg: AYBFou37KUv82kkJDImI+/rHZLuxmU7lHcl5EhaTJr+2LcOhu49ZZ9QfvygRrYukKKh
	HKWT/jq4f/3kwWRO3S0dlu8Tbhel3WCpkh3f2mK8Y1Vo/k+6365dyHbzQM2LHoNgkuff7u7ULvY
	iaBZCdzpLAHXXaGVDJU6FCbYD+HtVmtSBnJ6Sk02Ud2VrfJ2nKnbzkVhlDdG9/kudHt6uCDQMBG
	nRFyGn9DY5d8Ly5yWa8+msntTGymDyWRp0dK7RKcDM4MreVbVsa4HAyD55JYpbCq5qu2PqZT8gU
	y+kEtr4TpiiUXY+wC+N5PhXeOcddNqi0vP/YVbLa2SLx2F/soUAaao+djZR0BBz0/T3SJQfoA1X
	ABWIv+ofLxsIR647GncFcZ4Wy1HqxEZZRUWNpWbtOXArB0BdtdnVLpa0F/qZz/dNlg739lHeTNg
	+S7b2C+jeEbUeVjhRnCfEHAVGC5EHt2iR9tpqb7Sd1txiEtYad78bthRQF0Fv2f1mq3duJ+ld7y
	c6qiskU3DjLnYuWU8VKAx5hDOQwOFN+M+G43GyzZ3pt7Xe717Qo65y6O9r2b7jTyo8vHIoyxdtm
	cseOkAtr1zQrOnfCcL7kAI1/Yazn89onkOJS7/rKHNcTEqywn10Z6uLug1iKVuttiGlgSG43bdz
	HYVBivMHirGLBloh+JOmB/k2ECmNZtRjXWRlJbWIoF2N5SgC1F9jv20iBUb3dOYe77dfIQKBAEm
	oEPsWCkqmWE2tlWT0=
X-Received: by 2002:a05:701b:424e:10b0:1a1:47b2:5512 with SMTP id a92af1059eb24-1ac5b7dfd1cmr5677779c88.26.1793409058894;
        Fri, 30 Oct 2026 18:10:58 -0700 (PDT)
Received: from brev-9gdpyq8lp.ap-south-1.compute.internal (ec2-3-110-210-194.ap-south-1.compute.amazonaws.com. [3.110.210.194])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm9900636c88.8.2026.10.30.18.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 18:10:58 -0700 (PDT)
From: Samarth Narang <samarth.colleges@gmail.com>
To: Qii Wang <qii.wang@mediatek.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-i2c@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Samarth Narang <samarth.colleges@gmail.com>
Subject: [RFC PATCH] i2c: mediatek: stop APDMA before releasing DMA buffers on timeout
Date: Sat, 31 Oct 2026 01:10:53 +0000
Message-Id: <20261031011053.3370685-1-samarth.colleges@gmail.com>
X-Mailer: git-send-email 2.34.1
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

mtk_i2c_do_transfer() unmaps the DMA buffers and releases the DMA-safe
message buffers through i2c_put_dma_safe_msg_buf() immediately after the
completion wait, before checking whether the transfer completed
successfully.

If the wait times out, APDMA reset occurs only later, through
mtk_i2c_init_hw(), with i2c_dump_register() running between buffer
release and the reset.

A completion timeout does not establish that APDMA has stopped accessing
memory. For example, a target may hold SCL low until the adapter times
out and then release it. If APDMA resumes the remaining RX transfer
before it has been stopped, it could write into memory whose DMA mapping
has already been released and whose bounce buffer may have been freed or
reused. With SWIOTLB, a released bounce slot could also be reassigned to
another mapping.

Commit aafced673c06 ("i2c: mediatek: move dma reset before i2c reset")
previously addressed APDMA accesses to DRAM after the transfer buffer
was freed by changing the reset order in mtk_i2c_init_hw(). However, the
reset still occurs after mtk_i2c_do_transfer() has released the DMA
buffers.

Move APDMA shutdown ahead of buffer teardown on timeout and ACK-error
paths. Request an APDMA warm reset and wait for the enable bit to clear
before unmapping and releasing the buffers.

If APDMA cannot be confirmed to have stopped, retain the mappings and
buffers rather than potentially returning memory that the controller can
still access. This intentionally sacrifices memory reclamation on the
failed-stop path to avoid unsafe reuse.

The change is conditional on the APDMA reset and status operations
providing the necessary hardware-retirement guarantee.

Fixes: ce38815d39ea ("I2C: mediatek: Add driver for MediaTek I2C controller")
Assisted-by: LLM
Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
---
This issue was identified through static analysis and model checking and
the patch has been compile-tested with arm64 defconfig and the driver
enabled, using W=1, without new warnings. It has not been tested on
hardware.

I am submitting this as an RFC because the hardware-retirement guarantee
remains uncertain. I would appreciate clarification on the following
points:

1. APDMA warm-reset semantics. Does writing I2C_DMA_WARM_RST to
   OFFSET_RST abort an outstanding transfer, and does observing
   I2C_DMA_START_EN clear in OFFSET_EN guarantee that APDMA will issue
   no further memory writes, including writes already accepted by the
   interconnect?

2. SoC-specific synchronization. The multi-message apdma_sync path polls
   OFFSET_RST until I2C_DMA_WARM_RST clears and additionally sets
   I2C_DMA_HANDSHAKE_RST. Should the timeout path use the same sequence
   on SoCs requiring APDMA synchronization, rather than relying solely
   on the enable-bit status?

3. Reset ordering. Must the I2C controller be reset before or together
   with APDMA to ensure that no further peripheral requests can reach
   it? Commit 05f6f7271a38 ("i2c: mediatek: Fix apdma and i2c hand-shake
   timeout") appears relevant to this ordering.

4. ACK-error handling. An ACK error may occur before the RX data phase,
   in which case no outstanding RX writes are expected. The proposed
   patch also stops APDMA on this path as a precaution. Is that
   appropriate for the supported controllers?

The DMA-safe message buffers were introduced later by fc66b39fe36a
("i2c: mediatek: Use DMA safe buffers for i2c transactions"). Before
that change, the timeout path could unmap the caller's buffer before the
APDMA reset.

The intent of this RFC is to establish the required ordering between
APDMA retirement and DMA-buffer release. I would appreciate guidance on
the correct hardware shutdown sequence before treating the proposed fix
as complete.

 drivers/i2c/busses/i2c-mt65xx.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 307925fb7..2a8b8bd1d 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -993,6 +993,19 @@ static void i2c_dump_register(struct mtk_i2c *i2c)
 		readl(i2c->pdmabase + OFFSET_RX_4G_MODE));
 }
 
+static int mtk_i2c_stop_dma(struct mtk_i2c *i2c)
+{
+	u32 reg_dma_en;
+	int ret;
+
+	writel(I2C_DMA_WARM_RST, i2c->pdmabase + OFFSET_RST);
+	ret = readl_poll_timeout(i2c->pdmabase + OFFSET_EN, reg_dma_en,
+				 !(reg_dma_en & I2C_DMA_START_EN), 1, 1000);
+	writel(I2C_DMA_CLR_FLAG, i2c->pdmabase + OFFSET_RST);
+
+	return ret;
+}
+
 static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 			       int num, int left_num)
 {
@@ -1201,6 +1214,15 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 	mtk_i2c_writew(i2c, ~(restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
 			    I2C_ARB_LOST | I2C_TRANSAC_COMP), OFFSET_INTR_MASK);
 
+	/* Stop the APDMA before unmap; leak the buffers if it won't stop. */
+	if (ret == 0 || (i2c->irq_stat & (I2C_HS_NACKERR | I2C_ACKERR))) {
+		if (mtk_i2c_stop_dma(i2c)) {
+			dev_err(i2c->dev, "APDMA stop timeout, leaking buffers\n");
+			mtk_i2c_init_hw(i2c);
+			return -ETIMEDOUT;
+		}
+	}
+
 	if (i2c->op == I2C_MASTER_WR) {
 		dma_unmap_single(i2c->dev, wpaddr,
 				 msgs->len, DMA_TO_DEVICE);

base-commit: 83f32c773255720a661aa45d83e36278135f23f5
-- 
2.34.1

