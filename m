Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009591;
	b=rV2JZhn1GcPe5V1kgctqiAkHEfHri9tsPKV6xNpL3FRg2Lga9BOlr08KER70+a5uVCxu
	 yAwKo5tO00OuY3VlIgt9VDGWcVccb6ppFD4KCRrmk9r2PO4gT6+j67D4nMKb3vTmAMXVj
	 gUx3zkT9NGMBPNOHFqyXa2zQbkJggKkalw6UF9WE1Qic9lM+6YPwhWbJE05NTXcnnfsOY
	 q5+xaT0hQ80mgbaz+s6GgMefyFWn5IzNo6DffQc6c9lJmnwZc+KQyU19N87pNEKYhw43F
	 eJl4qfcf2nPOU0vZ1j2tZ1AFlbhoC+OHs0Xx4aV2cc9cU0rOR/dE8iT4hMN2oxWebCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009591;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=r5rkylK0kmxNPJjElKiNQWgQc8hm3aYSqsTEmAj7cWY=;
	b=gO7sh9IH/CfoJ4NSOlL/wk9GBj29SZF5kABh9/ulxcvEs4qoWhPenCGqD4+xTMcE7Nkq
	 kanprxncjngrbeC2AxD+KFPpHEk2SMN0+RwHrvBjRLVDZbDW0L5bIBCc3/Sndl17xjfPs
	 ZK9kXNGrB+3RAi8TdJy0x7aosINB0lbcbZR9SzoQTpsWSs/n0Rykp7TUZaf2mBU0DS7vY
	 SIjjEKkpOy2JSIYuCfQl7VbEZ9SayXv5lV586cz7cqVWdTOUEhM4WWhv0Lh0FlOIRhVAg
	 4FdRyvULG1R2tucDZlYc6yqnFdKhmK8NgA2/EaA/4ZGG6zrDRksfeVOs/CH5Xp+M2Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0MXZF5KO;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11357606A32A
	for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 13:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11357606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0MXZF5KO
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c40e30c26a4so433258166b.0
        for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 05:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795009589; x=1795614389; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r5rkylK0kmxNPJjElKiNQWgQc8hm3aYSqsTEmAj7cWY=;
        b=0MXZF5KOwiqwOAzMhO7D4kY65eEcZmRgLYINH0+Lr2BNsVJSqQWl2rMOvgIJ8QC1vR
         sIDh2/aNdFWd43gznbGMcDtBaqKgndsJyYBp+bGq/RRh4yQlvO5+tE7CC4P/bHaxNJya
         VgPBv2HrHksg1mxF02hSenGYzVqRQHOqiqkuaOuI332dGM7Fk5qz/LKcVexiKyH/cXQ3
         5OinlWnek5KA0+87MSZ7+YSPJ++Oz623wWPen2LpLSInUtQEmW9IUU/uLRZyqZThNA4o
         b9EGShylrHVpMe8TZ9gZWEVCUzR8CLeybdFDIIEGfzQY8G2sXtbd5Wp0+aw9Ez+GTYwk
         1OoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795009589; x=1795614389;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r5rkylK0kmxNPJjElKiNQWgQc8hm3aYSqsTEmAj7cWY=;
        b=of3LDN1Y4aYM2dqgddz9YP57tv0GnxFvaX854EJfHhuv+X45kfDPemTSTtcKcCRkq/
         aHIMQVv+ogNgVIit7w2xuAqKZv2RE2Ar1NldYATPooJDDTKVlvy88ElUi71vbXiIhPkK
         7ST3lQJioghiPgwXuPAX4VMeEZUHYthHzObwwh3D4gVf5DNgU63z4QrnoV4iKZ5R2Hq8
         VW735CrnqhngJyHNVxsYvYG0zUZeZRJgm+qjxOJK8D21XgiFXVA4r+kXpUvR6catrT8K
         0eiHcickFA0HQ5RV9KWTzxMttXeObL1QXsKqSt8KLY0+SvrPN2co6TCVWuUngw/JBYS6
         x3Jg==
X-Gm-Message-State: APuU4Z/29n8T3XdHzSKK20vGWBJ+nJYl1xfZ9R1VQ6f6g2pbJKxw0zAL
	gE/7NfGO4T+V740C6RcDvJ2aE9hhPXpe4Gblt8wrpArNJPsdMwvjbOWu
X-Gm-Gg: AYBFou1Z6DkQvCwpLqf20SFM9+PjOzfezyKE5vPCykzv9UZBYwCjKaHNp4+dzaOZnu2
	KPOrzTZjxJ+eAFJHKRkdJhifO4DmWOkdQvXyVeBGVky3mehIxmvE4fSrjvg7D7USstRPE/KjsI0
	86Ig3LYwimxsq1rlxb3+9mge5E+jRdPEw/uKVKM4JuhdnzGCeFEHVumCOiKDiupxeMdWTDy99Bk
	Z/DR8Q4RaWfO1wlAUx3otcYR+7IHoSHTBvgO1IOioFR1JcZPiDqUfTsgBvVbthKUP1BYh+xL4+X
	VA6RgB0ONZ/kPCtEVq6SiZ0K6/ZgYOaeXA6GEDFrXIVt/ne/VX6FoecIB4eWOUhZ54rA8JYdPuy
	vqv7+TiGORB/1Tc6DLi7mPFdIj9JUtXG6WkQyUvHoXhz6zpdf14hXFttQU+zyw0XuKJ82Uiy6Pk
	VkLOAltEIbcrMmeInZp2TALKOdEQc3tBnbOQloWsUOMXCElc4dtP0HTgm5kCXiTuFEwTK9850rk
	iwDIzQ48bzCxhivoy9tyoEh2R6pwZTcaYD0clZ+2tYTYmQ+nx8XXHyPK6M5QKWMlwRce+jB1VxH
	mh0W3qXJv1z8B+sbBavVJJFBMDMpNNIVIzvpPsw2NQBlx7krsq1QfHp4XJM2nprPRwy+MZJSeTd
	YHSkaLGpcqg==
X-Received: by 2002:a17:907:72cb:b0:c50:8612:d441 with SMTP id a640c23a62f3a-c510e39c4ecmr254203666b.21.1795009589188;
        Wed, 18 Nov 2026 05:46:29 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510cab33aasm95461766b.52.2026.11.18.05.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 05:46:27 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Hans de Goede <hansg@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] platform/asus: Add driver for ASUS Transformer's Dock
Date: Wed, 18 Nov 2026 15:45:45 +0200
Message-ID: <20261118134555.195479-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The ASUS Transformer dock used by Tegra-based devices has an extended I2C
bus where certain devices are hot-pluggable and their presence
is indicated by a GPIO line. The set of hot-pluggable devices must be
predetermined and static.

Tegra20 and Tegra30 Transformers have EC and dockram clients on this line,
while TF600T and Tegra114 Transformers have hid-over-i2c keyboard,
touchpad and EC here.

I have tried to submit this patch in more generic way, but I was rejected.
More details: https://lore.kernel.org/lkml/20251013060018.43851-1-clamor95@gmail.com/

Michał Mirosław (1):
  platform/asus: Add driver for ASUS Transformer's Dock of Tegra based
    devices

Svyatoslav Ryhel (1):
  dt-bindings: i2c: Document ASUS Transformer's Dock

 .../bindings/i2c/asus,transformer-dock.yaml   |  56 ++++
 drivers/platform/asus/Kconfig                 |  11 +
 drivers/platform/asus/Makefile                |   1 +
 drivers/platform/asus/asus-transformer-dock.c | 260 ++++++++++++++++++
 4 files changed, 328 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/asus,transformer-dock.yaml
 create mode 100644 drivers/platform/asus/asus-transformer-dock.c

-- 
2.53.0

