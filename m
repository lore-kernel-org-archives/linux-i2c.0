Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072921FA272
	for <linux-i2c@vger.kernel.org>; Mon,  2 Mar 2026 02:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772417327; cv=none; b=pR/DDjUbfK0w0QRcYhiKImqhfKSP4IBRYSOwZvI4wW+/pj/6hKPfVwJZDfkUahCT4U0ML0JCeyZTMW8+IOzY9NbX0ho0Y0DAZQkBiuBubbdhNiDTyd4nq6szw8vw+9kDsokjOINDnzhKIaE7qcx6/xEsdRUso0cpUcKWF95jHV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772417327; c=relaxed/simple;
	bh=Vq51sRK3RdC1jtxFUqgKzYqZCzaWApRRwMH2Phu6ty4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uVCw0rtjeKxmGbSHzjGrji4l5FeMO0Lz+djosTtV15UtmaKTNXo6957TSYx7KztXvjUckztkHdzefppQwARCCioAkULwxn71cYq8x0KmYBX+WytFG9OMkV9+YlM9B3YsMBlQk9Am56prOCQbHgSuVYz0dCsALwgXITK0nmFzDlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCcWST/q; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCcWST/q"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c70f191313cso1511738a12.3
        for <linux-i2c@vger.kernel.org>; Sun, 01 Mar 2026 18:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772417324; x=1773022124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRLmaJWutmjBaVf2ZkxnCmHqpfR7O4995L9wh5FFM+E=;
        b=mCcWST/qlujZv18bYkQC8nbr8dmz5I615ret5xdzCLHXFFaeLxQ2JaTaGPPCq+PN9p
         4Eue+vattYiLtr8TUPt2sVEAgkEYSRhPd+J1dIbnu4OSfKHNzQZgra/oIFNPBczba8sL
         iAApxOGmomSUnftAEGUsn0vlyaXcM7Nxycv4PF45AyTY/uWm1/7CrQTZU9/1Uli575ba
         qR8TcpDJ3MDkhA8VD1CkMpwl3TtMAILWjqK4EteiUhYvaG0J5mFXR2V8lw8yj1O2FHel
         tG1XCr7DlwpFIxFYwcj8gWnjCOLEDMLpf4KsjbQQvb7WPfs8XEB4/LLbzlzfqpyhn6XW
         L4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772417324; x=1773022124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRLmaJWutmjBaVf2ZkxnCmHqpfR7O4995L9wh5FFM+E=;
        b=NICj2FBi0HFcu6hW/pVovmp3Tq25jokCzqliQGJjxSwWNCDQy9QF9vNgNlZeYJc/7c
         ATGoyMUjZg6MhPyXzO2UUPlDdbtf/zuaPG9cDObObzG75QUp/Kmtw3/erKzFnKtQCys7
         9IQzpPaENuPc9KAXbPgToizqzGFMNtLKl454Cow2ex+8DIGxMq8tv88e2i4HuxL8paNM
         qktOt1Bn2bfwaIpWAsA2u8C/0xGXsl63UyjiPdW8qCr0OO75P1mgjDujygZlcHDnQaM9
         GcGTKVvwW5Ixq71CicKk0UA5+uzxBn4vHkwS5iRSTipTSklU6PBUxBaS6pq2v9Jlf5fg
         leyw==
X-Forwarded-Encrypted: i=1; AJvYcCXMro2OIBdiWYyPU8F6oxwFjfywV2LDnbcIKOXu37Sn78oK4NzS+dfxR6CrtuD/xnbPNBsIO3oxQzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW9secPQAPe1OvSyVKIxI0VEpB25Ua0oJJ/7YeIIyyPTXXoKQ3
	uo45QEu5S9RxCHbz7wJSZ7wt6OVjCbnnWDHOtjYPV5k3xhaojpwt7KN7
X-Gm-Gg: ATEYQzwNp80YQVWJ6MdfpWMuEW+upEw2Eteymc8tKgYeXQYT/6PQZ+LRHcjydzOmNlC
	5EbKV4ziXhyUrhx/AQmMhWklo+LqY5xdfIS9zcvNPPODuf/S/EWFK13Nd6PUMO10EYfPd03la+f
	ak8G+FnP6RrKqRxxih5QGCZuEu11sF5506G2yxxE6ZAjbnFabdbO0fLwtzcWFJeD8eXxfcWcryv
	MgCRxAlFaCOf5NEp6HEEH73k9xnsRTl73cpf0GmBopdv5hO/ZUrx3Q8OolSpsM9x7+h8OKq1x6Y
	BtLNB4VP9btzbOnqb0wIw+wkOxnGnIECnjrRHNb4G6uMIg/r9j0+GZ8FSt9CdiqE4QGkEYw0EuC
	Sgp0ZkjuuRfLVBTz8QUenkBFU6Z69mO5anHBLWodP1wp+1h5inDxX51vdi2fd5bXKm3ej9l69MW
	UCQmgMcc4yfraVH+PRf2PFlJ1P1UTMp3fiQzmEXnC0UuIsoR9QQTSoZEkC6QleHPoA/DKoUNZP9
	10gbJQFUw==
X-Received: by 2002:a17:90b:54c6:b0:32e:a8b7:e9c with SMTP id 98e67ed59e1d1-35965ccac3emr9541808a91.29.1772417324267;
        Sun, 01 Mar 2026 18:08:44 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35987523629sm2764697a91.7.2026.03.01.18.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 18:08:43 -0800 (PST)
From: Zi-Yu Chen <zychennvt@gmail.com>
To: andi.shyti@kernel.org,
	ychuang3@nuvoton.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	zychennvt@gmail.com
Subject: [PATCH 0/3] Add support for MA35D1 I2C controller
Date: Mon,  2 Mar 2026 02:08:19 +0000
Message-Id: <20260302020822.13936-1-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the I2C controller found in the Nuvoton MA35D1 SoC.
The driver supports master/slave modes, bus recovery, and runtime power
management.

The implementation has been tested on the Nuvoton MA35D1 SOM board.

Zi-Yu Chen (3):
  dt-bindings: i2c: nuvoton,ma35d1-i2c: Add MA35D1 I2C controller
  i2c: ma35d1: Add Nuvoton MA35D1 I2C driver support
  arm64: dts: nuvoton: Add I2C nodes for MA35D1 SoC

 .../bindings/i2c/nuvoton,ma35d1-i2c.yaml      |  65 ++
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      |  14 +
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       |  65 ++
 drivers/i2c/busses/Kconfig                    |  13 +
 drivers/i2c/busses/Makefile                   |   1 +
 drivers/i2c/busses/i2c-ma35d1.c               | 819 ++++++++++++++++++
 6 files changed, 977 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/nuvoton,ma35d1-i2c.yaml
 create mode 100644 drivers/i2c/busses/i2c-ma35d1.c

-- 
2.34.1

