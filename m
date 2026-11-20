Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795201197;
	b=4srMvZKJEERVOEC9ktXGSiuglvMyvqgf9I2Z+UvxLsQaH1PRFocmGmLj5+LwzfqOrWYt
	 gFJDhnTiwu3wdlNmpjAIvW+zRLooMtkkRci+wTeaavFFXgpX0JrwFkSgOQr1vVSyIWvZ4
	 ekq9YpONg9p/3CrC/vGtkd416iUBh5xPshxecsHgHIOCt+tJ41yKiuzPVsmUMnurVbinn
	 rJve7gnB3RC/8qS+n+Zbt+gq2wDfjH+4UHf3D6TpZMDF+tchZkjoYJpqzsDCg/OStg3Dm
	 UKyBskaFIQLKo1nRAsgD9sx8lFePj7cDax8JlR3DiFP3ItsZLcBDwHH6+X3GBk4zX5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201197;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=y+xG+koXTgpyKRztQQCKLUQgqoHofBaalUCYpzlKwFk=;
	b=G2MpL6oWXjXS3CUwgo+GFSDsz9WZ4vWtQTPlPtCn56ZJdglluSkKniIV9BD/8FNTJKOP
	 YKBP1C4tMMqf77YquwwOjiBHRWiT8mk07wHp5nlHpF/NYFc++1mLX31jPfa3DbtQ2jWWI
	 Is/dGaclxhGtxnsQulouqipkXQblyEU51AlJSXGnPsU/BEN5kY46cWiajPdTBmjWE1aiS
	 TNvSGNEJVlMG03pK4AkFC+TkIUaTax567vfZgVvv1Ko909T2D6ajA9HjGvCMX9Ue1MFuN
	 Bkl6Hbj5tVtfXIDJ3I49oBvSBACbQNtFSEkFO9kIBiaTueH/sw8YXq2xPS52nxeu+cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ZwJ3I/gf";
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B9160A2633
	for <linux-i2c@vger.kernel.org>; Fri, 20 Nov 2026 18:59:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14B9160A2633
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZwJ3I/gf
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c40e30c26a4so506207566b.0
        for <linux-i2c@vger.kernel.org>; Fri, 20 Nov 2026 10:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795201186; x=1795805986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=y+xG+koXTgpyKRztQQCKLUQgqoHofBaalUCYpzlKwFk=;
        b=ZwJ3I/gfafwZiWA5aZDcO+609t3J7/x+kBEjaZHwXFdrLDUlZmBT8ZKqFYEwEX7Ob8
         ykNW7FobzosPR+C6Sz0Fdw5qJiQq/GIeyyFcKZxvMxXR+Mka6M74WbVWT45oTZIUatIV
         8qtng2vGdvk7OiLUYXL9BKQD8WEfaxScKpXsHREyR1kMEYzXCPF0d4vlUq426eD23JQO
         UtO4CDbwI/qfXZaOZoj9CxO3BVYjizp3+kddEc0R8JHtenCT8+yKt+elCXEWaNirbrEE
         03HYg0t7D/tzdeAPq1IF2ALgqzNFdFwBod+xSdSg0rTQRrJPksXrmsInAitjjot9hPYn
         cC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795201186; x=1795805986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y+xG+koXTgpyKRztQQCKLUQgqoHofBaalUCYpzlKwFk=;
        b=svlXAotzz9SGRsmtNTaOtjQ9h5zEMGew0EZV7ToKbzwL39csyZJAJ69TFYX6nH7PA8
         wOMvf11OzUZwtvAEFtusOmm7v54TPgfY4jzTFK1PxqdMq2+lgAeGdqn3qrzIhfS2csNo
         6JxEYiwtyZVgFRsE7aL41joURZBj4TYb/tWZouLYY9EfuNrPtGynwpX1nig1Udsh9fPI
         ZWgwJ5m+e8LMSWEYp+DjhTsO3zKSnXVd01YkWf/WIU/0l7DBWJliijGR8M+l86HNDaCt
         D6Pu6ykSUn1l+VVZ5lTywVpe4AUSiM2EtfjXsTq/C/h1NbHzaM3UGNOOo7sl9XlUaZxJ
         GDLA==
X-Forwarded-Encrypted: i=1; AL+hErHbPxODe30kNfYZ9W0ajYlshIUIiI7UcdGxM+elY61b1KOKDuLVOSunXna1b7a5XGr30nh/yn4nAtU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8GrTAGJEX4OYRvAkgPv4f2w1BFJ8Z8LfqQeWQj1wE0jtW57DMm
	nf6QEQ8Qpznw9P5E8N2Auh0M6yP3UhpD96PgMccZhkK9GN2IlbD7tBDV
X-Gm-Gg: AYBFou1ODmA/QS381JcJOXVlWkLUg/LmNwlJxmrWXe2asRSxFkcLQsHwlXO1aKZCU6d
	pNpo2APl777I30KsBFKBn04NjFxu4xpHNn+NY8f+QtmuvseZuU6k5J/CIc0dLbKl3dAZxxFypCn
	DvjEMZOiy1p5WDn+0DsTh68lDjQ2pB6Z0QC9pHYRGy3IrNpEfalDPNkFZK7M6TLs2u+PfzKgH3d
	WZUHeQTYlKN+hZFkmVZDVNdDjHzpjXjgqmRBmur1LjkLX97qg5gL6K99fmb/CnlmipLqwEUgbjr
	6E7doHS9hV3Cd6OpOxbl3yU/wLVwOubwY9JBOcuu9LX/KFy3iTKxrSP0qGPGdveDFTbnXMC1BlC
	1XvAIB+NBqNqs0ZPAakVYQhmx4A0Y9BM8ixHvUgftWfnnyb4ZAYYs/RszjeX1mhwkZ1ba09ZY7g
	PVU+r/Bq/BcVXZPqoB9Gz2SQgHWErug8NDWqlyLEZgA1sUSvKlutA9kayBd9jXcJYC5RBlSWRw9
	vxDbBFjsL+VY3x7Mdr6fX+Nvk9SZVcZtaA972vcXA/svZ7wigPJb9kktTGvSHYlz077UR+hvAHa
	HXt/KIarUuIKOSU2e/Sa4FwKp8QT6F5J+rxFv8GjlIl94EyKOPpZ+/kN5TSWmtM=
X-Received: by 2002:a17:907:2d23:b0:c40:2439:4d9a with SMTP id a640c23a62f3a-c51319c24fcmr565365066b.28.1795201186217;
        Fri, 20 Nov 2026 10:59:46 -0800 (PST)
Received: from antoniarch (84-40-238-230.cgnat.inetia.pl. [84.40.238.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513b02de1dsm125205266b.85.2026.11.20.10.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 10:59:45 -0800 (PST)
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
Subject: [PATCH v3 0/3] i2c: omap: add support for DMA
Date: Fri, 20 Nov 2026 19:59:10 +0100
Message-ID: <20261120185915.150228-1-apokusinski01@gmail.com>
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
 drivers/i2c/busses/i2c-omap.c                 | 373 +++++++++++++++++-
 3 files changed, 368 insertions(+), 21 deletions(-)

-- 
2.56.1

