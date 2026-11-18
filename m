Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795035171;
	b=Q2CGDapDN5fJfTh14q6ZCDOFjs6HrcBPpiRAvVjnszOGzU39BO9hb9Hcf6nSUAxJw+vP
	 EZuLfbjCGtxE9V8J3VJgixCLEUpfMH2qm3jjOZ0hSclB+oOPvYXELy5W3o81UADLVe+rd
	 SZ4W6fGWkKgPeSWaFqRSbKxzEtQ9KKsUOHpOqd1d0hPkZ1/QQDGhl+eTBJqTRMIC9ODMZ
	 Kr1Jn+JSyHuZZLZtq2NsXLMGHlCNwrjOIdz2TsVb9Socjb3sm4A1lBXyjwv5kOUhqqJZT
	 Jv7eLnNo3WOQMve8cEOahzU9j9Ru6EzUTh8DyLcoF6rSRTbwZQKQQnXSUqc/VYuTFHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795035171;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=a5MhG98OmxdXqTOc5Xluyx99XKwhYZJ2KKliQ9c2OkM=;
	b=Xl0YMvrJBlLRCfnVBe7uyvJYZPdMKbxFe5JHfT7923paDi96B/HemX4utrfC/F0I281G
	 6tiJDXr+L3lGPsIOCZ5/rjBhvouaqqe5Oy2EGyo/NsDDztxEL4UsAshkyMyEgy9NpxCnw
	 dlY3qNJevdLJSemC20fu7OYpFN9NdldLpLKn24bOrQy8y8KIPZ0wwSMX5xmiXqiycZhFg
	 I0P1bwZS2gXb3gUO2Aa/59RTuj93k+rtV2EugSBzj5oFZ758jpts5cpb//hjuuDkRaGHq
	 86EEUTU2Q/LMa4IZE8i8ycpHVv27CgoPi4ZTJ3ofs0xGIqfcDz6zRGPW6d4y1SCmVYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jlxGHW+k;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7442606A331
	for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 20:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7442606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jlxGHW+k
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so216459366b.3
        for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 12:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795035169; x=1795639969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a5MhG98OmxdXqTOc5Xluyx99XKwhYZJ2KKliQ9c2OkM=;
        b=jlxGHW+kRyHFaEMpeXR4BNALXPsNplbIhzII6rNliHUbcX6NmABOnQ8XTqgppKQz/0
         jnpx4OD9SPT6Kr4gK+6e7zltezYlXyxXT2NfU5Odo31hxeQDHI1/oRoHWTSOtpxIboeQ
         FH3N84C6KLj2Igb3KbWBC2z49+iRGJvp0vB6BJ0/VWt5XCdgR97RAz5PXJN+PoywAORY
         xte54o9ByrMsQ2uilazjjngyPJdALuFEoOaJiHVqDv/lnXYuJF66BDqjNusCCR1GMXJe
         eOgd9Vlih01Qr/4o+siFo0v2a4oF4APKzmmYHrhLbqFeAgDBI043ZSqUkY6x4nruS+yR
         J75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795035169; x=1795639969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a5MhG98OmxdXqTOc5Xluyx99XKwhYZJ2KKliQ9c2OkM=;
        b=lzFq2qhqXjIBe+42mRL8cxdUkgJnj/49VhQe7q+dlUpjEd4Dc7jeG5H9Udcc9SMmFP
         HKcn5okt+R0i75Wdl/CnYRXLNtoYN42H4SQDV4A6/h8s7v5oc5cE/XAn7HJ3BEaHF5NW
         XWbcv+ahW/AgMV0/kdsz9zJczdn+QJdQB/+A3FT3kc53sQoi9ydBO3vsAXqapb6v9WpN
         sT3z63MsWp9pI4w3fKSRPq2VRTo0h4BiSV7fY2mwlGTYeDaDmKhRjdrIjhBX1bwXo8hA
         RHGjqfZdvpUyuJHRlbB/D2h6OQM2PLZHmfmC18jzf2sFytSGwgjT4EH08kHhoHpv9o9A
         CsMw==
X-Forwarded-Encrypted: i=1; AL+hErED6Xo3mHmWPe01pncnw9RebTCN3bGzWVF0IU/aa6nn/HXT/PWN3D2rBhRpKRvN0ZfmRyQq0RAsRwA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Dur++OSqDFDvapBWJ8EklZA/HJF/5h0JZNEcj4hytIG8tkAQf
	3QIPnE2mWlcKtUfQMjr4o4ed4tnkmmeQGQsvJxkO+jkr5LbMuTK6m4Nu
X-Gm-Gg: AYBFou3Ew3tjZfwF9hLz+AmUc8ZgXGw2mhS2S2Itk+on/rDFjsCVIrr7tTEQ1nDerwa
	TLQvstzHEkwxBVZJrSrFcP0Wd5YRZXqToJllrFq2osjIghpF5mr0kgxSYanrpyI9vjqOSjD1e/8
	rtTAez6hbFAj1KVrnxpRL/5brG+It2sUxDq7mMnH+09mP891MC+/hjtjLcMSSIIOq3NRbfX+kI1
	MAvDXBtpYeY4udiVqo5ll4a+gdz94wF/mxP/jJxTd0PP0MJjuowukuYN+qE0+QPXRPA5Cu5Iuc7
	FZUhmrTAR+lcm8KItd5Ds4hyoXp0Ac+9K82zJsyaWZMYcN+OPXwTYwMQ59JOOUfIJS1R5cl32ri
	QZubewcLgU4BFw+o6AVY8VNhYrCNyysyCQyoI792BKXL8VbGxd1wl2od410ELkaEvrpD2oCzULp
	ZjI2Y0jxMFdZuSlfETJLQqoNBv4uiAllyD8Cix1RzzwF129Lyh4p5+kxoOo0zmsbeDGrudy1TMT
	Hngj5TGH7Djs5WkcbSoRWKBx0cj8vHxvj6yLt0IUHo1Kt33QCus73Wyvxm1zdmxZedsJXLr3CPH
	u9GhAyllDUncx9QqzAvZ4PH+iZDcS6G6Gqt5EhSvIUAfy+GuDooOutUAerjYb54HQm++tzDIrzW
	5Xaz+LNA=
X-Received: by 2002:a17:907:1ca6:b0:c50:ac4e:3770 with SMTP id a640c23a62f3a-c510e516a2dmr391250066b.34.1795035168876;
        Wed, 18 Nov 2026 12:52:48 -0800 (PST)
Received: from antoniarch (84-40-238-230.cgnat.inetia.pl. [84.40.238.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5123421612sm35303166b.41.2026.11.18.12.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 12:52:48 -0800 (PST)
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
Subject: [PATCH v2 0/4] i2c: omap: add support for DMA
Date: Wed, 18 Nov 2026 21:52:03 +0100
Message-ID: <20261118205213.88778-1-apokusinski01@gmail.com>
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
Also, I noticed some unused arguments in the receive/transmit_data()
functions, so I added a small cleanup patch.

Kind regards,
Antoni Pokusinski
---
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

Antoni Pokusinski (4):
  dt-bindings: i2c: ti,omap4-i2c: Add DMA properties
  ARM: dts: am33xx-l4: Add missing DMAs for I2C controllers
  i2c: omap: remove unused is_rdr and is_xdr function arguments
  i2c: omap: add DMA support

 .../devicetree/bindings/i2c/ti,omap4-i2c.yaml |  12 +
 arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi      |   4 +
 drivers/i2c/busses/i2c-omap.c                 | 363 ++++++++++++++++--
 3 files changed, 350 insertions(+), 29 deletions(-)

-- 
2.56.1

