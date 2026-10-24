Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792877125;
	b=UDO2HzQGgau3u9wFD6K2uf6yHbDLawLuvtrmUISrpDbAGc1nSb8IS9QKuKuXeYZaEJSj
	 QY2HJRV/jpYnzdLPqNrACiLrwJVODgkvL2Q5QK+5jX4pUBrPHu4Oopf7+EtQvI/RxtBkU
	 iEl9jcUNUkhe36SRfBHSbArT8k7SRG4l6v40pJ8GDTKPB4CpA2OQ8qiE+Ch2XtVReIgsL
	 5h+lo+LRqIOaedy2cXWNKRZsZyoYoSfsIjgcfPZ5HMQsGNSO31H94nfSIt/r7A1oS1hX+
	 zX3W7BIhIBMpkBrNE0H/2QfX3kuC7OxUqYbW5yPbDSj7+rHJhi8kBcOzR3Jw9knKeHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792877125;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RB/QFiAwZFPgogQWGkL0l25DXALwqoy/QmskzaMu3fY=;
	b=U2OO8VXbj68GALkSpGu4k31r0/1NYfpnn6FIkX6EZoVxrTj192HwLpZ+wHAHec4Ugc2z
	 AwWdreug7dafnHaXv10d5wO28c+kM710bCtJOUZzO/jXanqBuGiUsgBwJmqAFIxbpQ42e
	 uQlJGzS70lYE5fN05psS+kDu2fnD7U//dOwhBsAyfuup7XUFRf2wb6AP2ehYE0rT8tWJp
	 sN5YdCMqpKq5k1zjeNo6v8HGcXyaKCAl6NqsyqkIe7v/QzhJjO70VmupQT4hiZoqfW+9Q
	 8zHJspol8wDrYcQIm4xCRtRcJX0y0Fp4qm9GqMuWmwXuGyluNY/O9e1ntUTPswnJuRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Zvgo6i15;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329DA606A31B
	for <linux-i2c@vger.kernel.org>; Sat, 24 Oct 2026 21:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 329DA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Zvgo6i15
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso14545895e9.1
        for <linux-i2c@vger.kernel.org>; Sat, 24 Oct 2026 14:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792877122; x=1793481922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RB/QFiAwZFPgogQWGkL0l25DXALwqoy/QmskzaMu3fY=;
        b=Zvgo6i1589cIQqIk1mSPjEk9cn89c4NbZ3U8EmUe7UMtPnDkn/IB4x3IlE//XsR47q
         A4Hp6Q9geaXji2lWuUS9eTVjtUaIk3AhPl3Glx0wam7vcVdRlXHKtxXN0XBbN9n626ei
         4BMSKivumEOIVuu6PP/FPuIiRnIdNkTICg/UUDy/VfBbO3PcBoU9EYnl0SstdOvb7G+a
         2HXT/DHEIdOXMBS2IGxrXwDEQSUFnyu01doDpIiKZprnEr/DlR38bfGr7s/ymjXs8oo0
         L4ofMdhONoeyLzNJps+vsNDHggxQp7T1TGQdgB3TdfHgMNe8g0okSwHbjlehL4KmGEpz
         RhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792877122; x=1793481922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RB/QFiAwZFPgogQWGkL0l25DXALwqoy/QmskzaMu3fY=;
        b=HHJK3nNihPfktjZLGJBnCx74LLeN9ReTgbgCb2eyxKZC1EBgLzDl4Kxk6hcI5x6yLm
         B6bGqWftp7AnekNNzFgeZ3N7SvjHzDUYk+qaFQ0NuMNW9jCoPvFVdVt6OciNjgPWqRjJ
         YEcuNJ8XvlYHHfs6vf+mhUwARrmSVpurEMXo+kF00tp5TtrI1Vyv4gzNw7iTnfC69xcx
         S0cYgg1luY3QyeQFpcwARuFxoygyYViOzTCursjvCPidwKAJRDe3N8KZ7RhEEacZ33nW
         EbDgXn+yk6ivfo1wMoEsapeA/JUBFaYuw5YsqKdv+N9GoGmRv27IIFYjYFjrVv5PlYBY
         WKaQ==
X-Forwarded-Encrypted: i=1; AKwUvByRJM8NTerJNgpUPpVXH8z/8VwrVyl44rGmq9pGeE/EuTho8m2nV2RrbbRxzza7sbvd7XtaRr0H8jk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLhKML9VIqozb7QNzdF6nth6ZMQI25xXp9wC+C6n3KELFCK1jhu
	2AI4fSXWaDmqfor3jVzXTm3LYqPqA8XGVW2IPHMO1NARjDQ2P1c/JbCOs2RMJsnjOJ0=
X-Gm-Gg: AYBFou0DFhIgfKaeTJQ4mIHWcyp8a00Q+B6hBkMU0Ike3qoK2avm0Qma74x0m0E3R0s
	JELq7pib9oJ3C58e7oIYNs/GbP6D8idvgk/SjlAWFme8T/sgFgSwscd6LumNMxFJl2pQJ/DqX9e
	f31uxf1jqn8jfMgmkxFZwifAefUJIX+h/ce7Kx6l5aCgPbpmQ2ts3OQruDnxN30ljMv+Q98KyiD
	0cL3uizXHh/dPd2TBQnTE2L28789vcxG8ERog5ejBhkY20XmUorD5fHYzsIaOzXDW3tiirJ2s84
	53ZTCARMfnYlQvtClTLqLjQug9WnGwGnYcTFofi7K3EU4BKkeW6ylFw7oDqqJB7iTrhsFSR6Ejf
	sEIF65hnEfS/P+EgW61xS2wGOtvUDte2+5TfLEn+569EQZAjKsk8t6kBuUyVZtSQtqySuVvcsao
	g+HZs5Ty06J6cL0yVffjKdP4yZjAeaTEE/RfK/hBVSt1Y08AeVDHnDRSkt6Gc1+F4Sw0QMkPBU1
	M86+gzgDcSEOKaRfsfKyJCkTbbUVVztwMAIBYTHWIGjSD0hVlIHGXECOyw9DgYpnKCVEiUab091
	p39Y1HfXJR0db1Aq83anKDyYdFfsNJcDIWBq6wtR7gIZ9tAlkl2uE5xz2r7yNvvIAo9R/uWSrw=
	=
X-Received: by 2002:a05:600c:6289:b0:49e:7c8c:361d with SMTP id 5b1f17b1804b1-4a35ac9f52cmr43172355e9.22.1792877122133;
        Sat, 24 Oct 2026 14:25:22 -0700 (PDT)
Received: from localhost.localdomain (2a01cb060184ad00bcfbae5efa3e0f0b.ipv6.abo.wanadoo.fr. [2a01:cb06:184:ad00:bcfb:ae5e:fa3e:f0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a2ed5a2sm79597135e9.15.2026.10.24.14.25.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 24 Oct 2026 14:25:21 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Paul Cercueil <paul@crapouillou.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Olivier Louvignes <olivier@mgcrea.io>
Subject: [PATCH v2 0/2] i2c: jz4780: Program the spike filter, add the X1600
Date: Sat, 24 Oct 2026 23:25:18 +0200
Message-ID: <20261024212520.91401-1-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
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

v1 said the X1600 moved the SDA set-up register from 0x94 to 0xa0. It
didn't: as Nikolaus pointed out from the programming manuals, SDASU is
at 0x94 on the X1000, X1830 and X1600 alike, and 0xa0 is the spike
suppression length. v1 worked by accident, by writing the set-up value
into the spike filter.

What was wrong on the HiBy R1: started from the vendor kernel, the
filter held 116 APB cycles, longer than SCL's high period at 400 kHz
(102 cycles at 140 MHz), and every transfer lost arbitration. Setting
the filter by hand before single reads, transfers work from 1 to 100
cycles and fail from 110 up, whatever SDASU holds (1 to 100 tried). A
cold boot leaves it at its reset value of 1 and works.

So patch 1 programs the filter for every X1000-class SoC, to the 50 ns
of the I2C specification, and the X1600 needs no driver change: patch 2
adds its compatible with a fallback to ingenic,x1000-i2c.

Changes since v1:
- Replace "Add support for the X1600" (wrong register) with a fix to
  the spike filter for all X1000-class SoCs.
- The binding now falls back to ingenic,x1000-i2c.
- Rebased on i2c/i2c-next.

v1: https://lore.kernel.org/all/20261023081452.44118-1-olivier@mgcrea.io/

Olivier Louvignes (2):
  i2c: jz4780: Program the spike suppression length
  dt-bindings: i2c: ingenic,i2c: Add the X1600

 .../devicetree/bindings/i2c/ingenic,i2c.yaml         |  3 +++
 drivers/i2c/busses/i2c-jz4780.c                      | 12 ++++++++++++
 2 files changed, 15 insertions(+)


base-commit: 03a5cffc818695157414456dec695f7c30b9ffff
--
2.39.5

