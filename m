Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A9B38F944
	for <linux-i2c@vger.kernel.org>; Thu,  5 Feb 2026 10:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770287394; cv=none; b=JpGinmmtUvduFxpi0gpq5+b8Azh7NNC5OwcGRhyA9LmM/kE019G7d7Y9P+gDqZgWOOIe1OZ59gXUTP8gB6gH5WAKthFGti480+8QyRnxjsL1qXU/a0HBiPqhSWkG0/rdTuYn8z8MNAwLiyF7JDMNQdRsclN/FZh2DWatP1KoOWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770287394; c=relaxed/simple;
	bh=iCMMOuNbhHu1PgVAZgbxHKPmKrqrfHxjiWy2rfsDFH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tFn5TPm2fPEOWQZxiRu4V9MxeYnYgMi1SUehiNtUuGqwdz8NiqbyUmE5JgQkZBSqH2GkFaYQsO31awVQqUwQOt/zUbZ3dio+rGmyHEONFZxvcrWlpe9R8nivWa/1IPq09Xl36me4sIaEjDC3bUZjHN2kPUR8jkfVEcqBSBZAP3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPxytzaX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPxytzaX"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4806d23e9f1so8258755e9.2
        for <linux-i2c@vger.kernel.org>; Thu, 05 Feb 2026 02:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770287392; x=1770892192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wtfgkFNYt3Wxt+KtLhLBhE2nyxyzaqciQiwFpAEbbKo=;
        b=JPxytzaXH3yDabJKJKETpwU3Ze6Sjv5tVD82bRGvWLqJdwiWbodmyK00Q1xpexf7Iz
         ETr98/Xwun4urK+glb85i6bRJIGmRck/Fzbyd+UiTXmLcuz6B/8wnR7UdigyKxQi5Ekq
         FJwg1XxgHl0D+dE8+mpFHhDvtsQDixCN1hoiJ2IIzoz4ON3cRjMdllRSsDBjCyMn6jNd
         Ef/A0vfXWQn7h4JVGNe6rv4aOGfzNDdVdjyiVCFHU4iURCL4T3j2ALWiztNX4kg0Dxyb
         klmYg4bW5fvPI0sjcb5LOkP/NgTliV6lGyuZvE53wB2qn0KB//rfv4LV7LdKCpXzJbPs
         irRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770287392; x=1770892192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtfgkFNYt3Wxt+KtLhLBhE2nyxyzaqciQiwFpAEbbKo=;
        b=tvW4NmEVUxknsWORUm/rFjqVFatJpVRhOaGYIC9Qeq2xioqGMzGh7QH//DYLYnliGZ
         fwzxf87Tjv9gcYAhxEkshNdQMkK1hTrqUtjiuLIzathJyMFoig46h/uJHxkmW+g4O7dv
         j7NPgRnR0/PuzGpt2OFKaFA2uyM4/5Gk/ntQVS7n2Ss1AM4xnEKwf0Gm1ikj/JTYBcI/
         Sr5ioJKDvOT2zlYF6852SGW+YVhtYrz9b49iakfDA4KdtbZbiTd8yZO3zfA78skNrvY4
         iv6YpKQhDeLJsGEDsmvVLQvfVbiKL6t5ggpGos3B0gbY+VZWwr34vG7E7cMuaHKGPmH1
         RH3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJuc6HZGZOmml+cHBZ9XFAO8jBMvvebpyNjwtt/Bov4CiV3LBM1OjANLs5mlVV94Lj8wTYT5sLTNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQWf0Vtj/7faCs46wF1kXTYC/5iGpfxun3vTAo8nfW5XqrYYsi
	VdvCq4S6ak8luJ92xkzszYL2XD/9N9VFWPvcoDpJ0aCIMCsXoztXwxSX
X-Gm-Gg: AZuq6aLxo2PNGZum+0d49peTW3p8isGezhlBgDXonBan30A305eH23ohW9tPRUfMEgQ
	iyP1NEDpR02Ipl1rKIUwDtAw9oF8vTj5bFT0w89r3RQZrrqvSH/kQlPE6OtvUnY2WLyjMpjR8jH
	pbavBq1geDoRx35TckUg/iAaZCYQKDWJBWuVzh/Q8iOX2bE05327mnvJDMnOSakW5AphZAdRRkK
	qA8EJSMzmv27PnRWGJDmu0dCVuKk68TwwXikbr60KFDRwzYk+eu16elp6xBYYcLl0tSF4Yk6mCl
	b0pXvsfXrdJGzcw3BKUoX0K8/iW69fKINp1Ux8pH3SQIHKHdNHJBedgpH89m30Ts6Oxkvy6E3qj
	iL78RJAS10ezmq0V8Hq6f2DxzAv/IcgPF+bPUMfusXHDTxLK4ipqk8KNDvaNz/r/gv4FUxvgNMp
	+MI/uhXEuT5WCS7sVlhBeRTOXTOuRWUBCJ
X-Received: by 2002:a05:600c:1f08:b0:480:1e92:dc65 with SMTP id 5b1f17b1804b1-4830e99db33mr95391745e9.31.1770287392294;
        Thu, 05 Feb 2026 02:29:52 -0800 (PST)
Received: from localhost.localdomain ([196.191.61.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830ec4a76esm67876655e9.1.2026.02.05.02.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 02:29:51 -0800 (PST)
From: Tinsae Tadesse <tinsaetadesse2015@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jean Delvare <jdelvare@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Tinsae Tadesse <tinsaetadesse2015@gmail.com>,
	linux-i2c@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] i2c: i801: Detect SPD Write Disable and expose as adapter quirk
Date: Thu,  5 Feb 2026 13:29:23 +0300
Message-ID: <20260205102942.28745-1-tinsaetadesse2015@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi I2C and HWMON maintainers,

Intel i801 SMBus controllers feature a "SPD Write Disable" bit 
in the SMBHSTCFG register. When set by firmware, the hardware 
silently blocks all write transactions to the SPD EEPROM 
address range (0x50-0x57) while allowing reads to succeed.

This creates a significant issue for the spd5118 hwmon driver. 
The SPD5118 requires write access for switching between 
register pages to read temperature data, and for cache 
synchronization during suspend/resume. When SPD Write Disable 
is set and the spd5118 driver attempts write transactions, the 
bus will generate a storm of SMBus DEV_ERR messages.

This patch series proposes a generic solution by:
1. Introducing a new adapter quirk flag in include/linux/i2c.h 
to communicate this hardware restriction.
2. Modifying drivers/i2c/i2c-i801.c to detect the SPD Write 
Disable bit and set the quirk flag.
3. Modifying drivers/hwmon/spd5118.c to check for this quirk 
during probe and fail cleanly, as write access is mandatory.

By using this mechanism, we avoid embedding device-specific 
policies in the controller driver and provide client drivers 
with the necessary information to make an informed decision.

Tinsae Tadesse (2):
  i2c: i801: Detect SPD Write Disable and expose as adapter quirk
  hwmon: spd5118: Fail probe if SPD writes are disabled

 drivers/hwmon/spd5118.c       | 15 +++++++++++++++
 drivers/i2c/busses/i2c-i801.c | 16 +++++++++++++++-
 include/linux/i2c.h           |  3 +++
 3 files changed, 33 insertions(+), 1 deletion(-)

-- 
2.52.0

