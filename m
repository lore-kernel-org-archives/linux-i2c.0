Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795632499;
	b=2Z6XZ93NfT0rykdRJF8P5qfiuuwOLFdTidYJppzIUDRZFdZbbdungg8WBxqVPXZrHGum
	 hf989jVBfG0SBtDj/niju+VpHs5S31mvFvjNu9ItGQv7Y/HsZTVY8RTjS/Svt7lys8mdK
	 93sPsi2T6nKvh2+W0gDMZzQt3Sb7idYg7FIzAUl5fwIjCp3M4+y7ivVTON0S2oeCM/X3k
	 1FYQMFwShShwZ5CzjtMEGyvygRRuXx4x1dpFMp7z1XiljaID1G6Rb27ltQ7LgOGNg23UT
	 Xnt1l1Vki6mfbzVbDdUK2W2d77HXc1+aJDzYmjLuMm9aEb172wkZbilIHpVC/0oLFSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795632499;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VQW/Ymb8D+uLvIjWbZ057G5GtIuukitNqjLkdiNCMvE=;
	b=flA9b94ukoNUInNPhRtuS8EyEOYw2g93VC/4OvYNnMywtp3/j8ay/AZ/Qtdg4Khkpilh
	 ry5jAoDYpn0h3RiilotND/tL84jusxKBUbsmwthOh29VVGLIPLvh8zQ2GqRL7G4J8L+uk
	 9E2/ay9WxF0+FTtLyE0nVnOrP+j1WV0CAdFUvIS0VY5uZ/iXHBLnygdkSbsgWVHv94nTc
	 fia9zy1JeKsed/xIIFpymV4QA/C5hFeq5hMAi8qN/9BRvMFfaW5l7tuQ94+NCK+/EyJ15
	 wKZo9hQpheu4kilJKdRbBdbLc4ahyJ4Pwd7RQF1oW3SN4zZ/RU1q9RKJvkXzdxcsI3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oNnBk9yY;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0419606A321
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 18:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0419606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oNnBk9yY
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c516a194350so100153866b.3
        for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 10:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795632497; x=1796237297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VQW/Ymb8D+uLvIjWbZ057G5GtIuukitNqjLkdiNCMvE=;
        b=oNnBk9yYeUkh5s9pJTjawpl5to9WwX7SUukW3RYanpUXdKryi5g59gdyC013GPo5KJ
         44RoaPNMbHUir0M+Zhp87TWdQHbZM4kLUCrIT/znmwvN/7W+plDblEnJSJhJVNx59B1B
         chd0czeEamhlDzqBzlSNWAgl9RqCeMqEu6tglGhHKOhF6wrzB6GX//4va9yD4oR5ChIx
         6K6UWxCkBgpDnKlJT8uwYLnlEsvzSB8A3x8XJ6Yf8H9wGHX4cfSvnWq7kPdJ2YCYmOg7
         RA0MMU1tmW9T8fguHCAFFhimvY97TLhouhiNYSJ0/UyZSjdG48daDEwMt3AoiQ+nHBGe
         C1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795632497; x=1796237297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VQW/Ymb8D+uLvIjWbZ057G5GtIuukitNqjLkdiNCMvE=;
        b=mfk/4HgjrDMajgpsCnKP6/Uc7/7ovPltP8xayRQMDqwvgSEvxqpvD2JULM5l7nPca0
         SUA9DsYPkzuv4A42zm2gnHZE5vbzSS0c2lEL5xQvbBTWANNL+CSsQT+SW4P3FewzIyvb
         Lco99dbSORh1j9yfPHxXMTe+ANAaZtuKP196e6ErhP8eXJ1jNuTYzJ77e8livRR4eJ0o
         0Wb/Nty5H3czdlDE3ekEAACTJ2w0UFQtXHv4/TDg13SSElxYxnVyp2PW6JUP3brIZF0Q
         QzcLBpRah4bv5NDlB+INUzQavsVDs5kazpb3895BEN6KbnMMETfJXTCNjxE5e1JV3v8T
         u0og==
X-Forwarded-Encrypted: i=1; AL+hErFbi0gZVA+P7V0jq5fMnH6kNQDWdRukpg9ngvK/tzc487/OW5pF5Jf6dZm1ZwMv96B9gH+tHsKQSO4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9sLTLOXPCZHSDxWikkY+B+3+KHGB68VdKjdSjrsPHvlqy/ieMg
	7QSjvtLR2PSvBgOSX+LtkQxbxYAlvfORB2iTVWUwLmRRDOwVPFb+PfVw
X-Gm-Gg: AZFdTZcZ3Ro9PMH+QcVtK+CPNIUHZ5kTRCqQcKkqm4eKSY8T0TM7M+DN+xJwgienzyl
	s9Av3xSWi8ge36/K0bcM6Gm9YQkssdRb1EkvvNE3u+LrSo626D8dShrBTceRo/gZ0qErkOYUqOw
	7b9RkFglg8N6fwtD2wgcHEFhj/b3AhiUO0X/89jcJcW4EOtj29r+YTCQoaEMF0+E0/OJ/IauilO
	zVrAkDmVsimjYwIsWKz6PB4qNWBvFFUSyKWaD4c5pbPomN/9JIqFErzV5O4mbZqH/NhivYGUGNc
	3A30S00GUHW/lFV+8WGRJPWj5WV2km/Nj3mZ2FSTprsVZm/y52RTV9KrNbzixkOEv5PjCvxeDTz
	UyhsCTa3meTYVDmBE1Hz7EzLv9djb7KSSMcD13xoFX0gyUutKJXjOy924wmgPOngwZggkotiFrC
	BaOkr+lQ4mK8zxBJJzEH0Ra5zZgaqYWu6bBkqVH6z3WhZJY5lRtE4DrTnyCeYliUADRqZkBTPrl
	o2OREVcr+W8jM2Adf7TWVVCNSakk3I9Gfo94rNHhbbj8Z+nsnNhiZ/GY+J8FfinCzCRSSxwsOms
	6X3WjOKfpSZA9TI4lRdPW54/eYNTrjFZd3WIjg9XMcCbz53qDmghcnab+5k=
X-Received: by 2002:a17:907:20e4:b0:c40:9b75:84af with SMTP id a640c23a62f3a-c513a5ec7cbmr1173636366b.8.1795632496938;
        Wed, 25 Nov 2026 10:48:16 -0800 (PST)
Received: from antoniarch (84-40-239-22.cgnat.inetia.pl. [84.40.239.22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afc73d3sm677226666b.64.2026.11.25.10.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 10:48:16 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: vigneshr@ti.com,
	andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	aaro.koskinen@iki.fi,
	andreas@kemnade.info,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com,
	jmkrzyszt@gmail.com,
	sumit.semwal@linaro.org,
	christian.koenig@amd.com,
	phasta@kernel.org
Cc: linux-omap@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v4 0/3] i2c: omap: add support for DMA
Date: Wed, 25 Nov 2026 19:47:45 +0100
Message-ID: <20261125184750.57866-1-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.56.1
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

Hello,
This patchset introduces support for the TX & RX DMA transfers in the
am335x/omap I2C controller. I tested this implementation on AM335x 
(Beaglebone Black) and things seem to work fine.

Kind regards,
Antoni Pokusinski
---
Changes since v3:
Some minor changes to fix the issues reported by sashiko:
* resize_fifo: changed type of the `size` argument from u8 to u16
* xfer_msg: fixed style of the REVISIT comment
* xfer_msg: implemented fallback to PIO if DMA transfer setup fails
* xfer_msg: disable the DMA request as the first step of the cleanup
            (instead of the last step)
* probe: introduced intermediate `dma` variable
* probe: all DMA init errors except EPROBE_DEFER are now treated the
         same way: dev_warn() + fallback to PIO

Changes since v2:
* dropped patch "i2c: omap: remove unused is_rdr and is_xdr function arguments"
* added `omap_i2c_disable/enable_pio_irqs()` helper functions
* probe: added `if (omap->dma)` before the DMA free
* xfer_data: signal DMA completion in the case of NACK interrupt
* complete_cmd: signal DMA completion in the case of bus error (e.g. AL)
* xfer_msg: removed incorrect checks `if (!omap->cmd_err)`
* xfer_msg: added handling of DMA/IRQ cleanup in the `b_hw && stop` path

Changes since v1:
* new patch "i2c: omap: remove unused is_rdr and is_xdr ..."
* probe: added `goto err_dma_free` instead of `return`
         in the case of failed `i2c_add_numbered_adapter()`
* changes in XRDY/RRDY, XDR/RDR interrupts management:
  - init: do not enable the above-mentioned intrerupts
  - xfer_msg: enable the interrupts before any non-DMA transfer
  - xfer_msg: disable the interrupts after any non-DMA transfer
* xfer_msg: added checks on `omap->cmd_err` to catch
            NACK or AL error occured during DMA transfers
* general: moved scheme-related macros to the top of the file


Antoni Pokusinski (3):
  dt-bindings: i2c: ti,omap4-i2c: Add DMA properties
  ARM: dts: am33xx-l4: Add missing DMAs for I2C controllers
  i2c: omap: add DMA support

 .../devicetree/bindings/i2c/ti,omap4-i2c.yaml |  12 +
 arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi      |   4 +
 drivers/i2c/busses/i2c-omap.c                 | 377 ++++++++++++++++--
 3 files changed, 370 insertions(+), 23 deletions(-)

-- 
2.56.1

