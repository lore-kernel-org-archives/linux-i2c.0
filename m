Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ABF38330A
	for <linux-i2c@vger.kernel.org>; Fri, 22 May 2026 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779482132; cv=none; b=K9LUPjGsTXD+IKwp/jIedkAsv7+gi6jRM+ez7XnW5ULj6X3MFySfYduHZl5fnlREIpxUqqx/VN7DG9CvmWWxdKA9YgXf0+5YRqqf6i4vG3oJQUy0tkaq9TpUYApuvD2KL+Y3CkFbLl5xOYfhvE+XfKr8w4NjvKxzW4CY8kEU65Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779482132; c=relaxed/simple;
	bh=XsQeauVTolZLw/WE5yaR3kSabXw9uT3RwHwYaU/KBoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UpB5AcwWr4wOhWdMaKgl7esL8gzxj8sCWJQIVII3nHwWz6tBD/6HegNnc+mJwsYnfvOWnV1C4pUxojbJqYY0/cWRiMFhSnS07Ie2lR3EEkfyHAhMIXiJpLMe46oQbJO01Hkx6fJJWmGGWfYKo/eeP99QOguxgXxkYCRBRR4kPnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=WiW/YxXK; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="WiW/YxXK"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48fde648a71so53326525e9.0
        for <linux-i2c@vger.kernel.org>; Fri, 22 May 2026 13:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779482128; x=1780086928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PAH6l1IDivpLuD9Co7wUqyHLicvDel2ikw9LY+7h8eU=;
        b=WiW/YxXKbPX8M5ILvkEm9ii/wkTT8xxUp7rAmP+h4v7cjV3vZTjw8IxHRmsb6x13gr
         gu1LA1OOFhV2NsdP3oxBcLfsB7PkMSwDOpu7SEqcIi78aRO6TVHk+i73YGvuREzDfvQE
         8m9tjS7HM4mTqk3PcjBeHchqIi+60LEg27ev7Yi/vlfT0L0Qwd2umtkGUP2gO72zT67G
         X1z1eGrkUqBjk3qh35HylBgkmz28k5PQ0rgc+bxLJy8LrCoAM4KJ+29zliO9mrrVoDzB
         bN3Sp3n7Zf4+mkwtgKe1XHRE2+dNPIM3zVAxZRNSKScUwe+bRSc6hlaRnh6Xemn/8kcy
         kORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779482128; x=1780086928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAH6l1IDivpLuD9Co7wUqyHLicvDel2ikw9LY+7h8eU=;
        b=dfomK+pfHqdG42KudMWmdXzcFHj0o+yu0xPAGGAl5CDfY5Fvy96rM6oJ7ua/TYFTlj
         NwsBNsriX7JDr2trm9kbLYVw+GpJ6YkVw94tNDmZ9Hn9i91JEsG1hd0t5tO4hGiXOkMw
         rLpPgmWqgTdbx/qTqgKiMEOjk1QPpVMUjQNOJThPOasYfvDz7x1D5jWRl9kOoYezWld1
         7OC/bP8LA3Gz8+AymVZ+znmgUJOkMXsWOdZmtYgDkCYK3yxiSZm0gAmJkNLu32b1WVbA
         sgvruI9Y1VkduX3B/mgkAYecL0F7wh5I3kz0T66JIsKA8XB2QQA5Bwl3uevaqY51sahm
         wdcw==
X-Forwarded-Encrypted: i=1; AFNElJ8laGsygcfTnq5dFVwaH8mtPSeAY2Q3IcywV9DMhsBwCJNfXwzHJMKBimlfb7oz3p6yMYzj/BGsto0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0xureB3S0ph1/h0L3n10RovnEpuQ53laPfn5HqivUkf4bAcxa
	sL8dNMfDgbDrT5lhckKbNZNhjL2uvkDFqQNEIH2U2Xf6U51t/7DAuKVY09gb3HhQENs=
X-Gm-Gg: Acq92OHs42sQuDUMsKdwtZ4tf4Bp3iQHJJ1LLd+kYjX8Mn53gOk+++ID++jMR9jPWCz
	52HcIKXn8/EAOm5/JCk7yu9bJ1stjNCb/oU7vyzWd3GrCgAPK1eQaypAo4acgJGbkWDnBx5Vpe4
	iCrFbpUD6YWymJsUTgzjFUYqt00DPBB0jWeZd3RzAaMqcGt4U1es6E6Od0F0Qh6yZYOpLgVX5dj
	AeasWrIAKqu0NmYlag+HrQ61aWCiXZbtavG8EEwFgvvmlCje41phBni8VVYip1HCdIFGyfnSvkJ
	lKcDSqkviUS/7oSjd/YXgrvrExOXD3U7SMaTMlUZyHI2F7RR4kFQCxUGaxRWoeXaScGxXl5fWLt
	IJNy1xjtVSosEcJOZuDUSjR5ekm+56CugoKvL6FIX2kgfcGNzE1BJeDwv2Ur5LbdzQ8rJZYcfyf
	GAXHzwhIu/s08mCCT3jpDGI7YD8owkr5Nw9PqMfyQ=
X-Received: by 2002:a05:600c:46cb:b0:48f:e044:927d with SMTP id 5b1f17b1804b1-49042480f2dmr60597425e9.10.1779482128409;
        Fri, 22 May 2026 13:35:28 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4904333146bsm44658825e9.0.2026.05.22.13.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 13:35:27 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] i2c: Consistently define pci_device_ids using named initializers
Date: Fri, 22 May 2026 22:35:12 +0200
Message-ID: <cover.1779481436.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1083; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=XsQeauVTolZLw/WE5yaR3kSabXw9uT3RwHwYaU/KBoc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqEL4BBIT9SVZavB3N4x04S9OkEommJ8h+TaRjJ E6Vqz6h5+KJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCahC+AQAKCRCPgPtYfRL+ TlHbCACCeGG+j73ZvR9IELkjbuxhpsDE/L+n9hRwxNarql3VQcGgjnX2QmYlyPSAdNRWPXVbkV+ H2YKUfSdb3FUnFmAOFWWl65MQnCTV2HjzQ9DhjsItWx9iGY+ZN8r/5OudOrmLyJoBN7wftDpY66 o/m6cDXv0I/CJtbvqOoozhBCx6iYVD/D40JWuBC0dExsGfuFmBUmX8eknriLEah4RJftrlzywuq PeR6ZOhgQLrLnzs2OFBYcTYyX38btIoVrEtMqzLtLpihS6zw85BHmC3rDE80/nY9ip6pvky19Kl v1mIlsJrILhwY4G5E5YJJfEciVwEBnpfChcikor/JJVkPcLI
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

Changes since (implicit) v1 (available at
https://lore.kernel.org/all/20260504142639.2119645-2-u.kleine-koenig@baylibre.com/
):

 - split by driver (requested by Andy)

Andy also suggested to use PCI_DEVICE_DATA() in the designware driver. I didn't
implement that, because I think its advantages don't outweight its downsides.
We two already discussed that in other threads where I sent similar patches and
didn't find a compromise. I think
https://lore.kernel.org/all/af7yKdRdDSJjkoIk@monoceros/ is the most detailed
discussion if you want to read about our arguments.

Best regards
Uwe

Uwe Kleine-König (The Capable Hub) (2):
  i2c: designware-pcidrv: Consistently define pci_device_ids using named
    initializers
  i2c: eg20t: Consistently define pci_device_ids using named
    initializers

 drivers/i2c/busses/i2c-designware-pcidrv.c | 78 +++++++++++-----------
 drivers/i2c/busses/i2c-eg20t.c             | 10 +--
 2 files changed, 44 insertions(+), 44 deletions(-)


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3
