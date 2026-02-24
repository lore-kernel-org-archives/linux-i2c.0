Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E50372B28
	for <linux-i2c@vger.kernel.org>; Tue, 24 Feb 2026 10:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771928577; cv=none; b=rerUzjnYH67cBDUjZVZZrFdq90QyeQBfo0av3DMUoz2rBd9DUe9C+s1LEi5JI37b/f2wfFcRyn0AEUL/XX4RlRLXmPQWBqY5yp+DP/zS4/edcTPpET5FJ6gOguS0G0/RPcIlC4JtvuuwoIG6b7cQQziVqWEWsJnHMxZfudtbcOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771928577; c=relaxed/simple;
	bh=nwAnhkxrVyOUSg2Z1riTC4kP5jFWpVmE+FFtCTrRPSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mHIlmAOvSBlfPhtBYyL83XTMuB+LDN/+4w7Ha2fOxVUn4eAI6INykS2Ff5G4emUpYlrTJ93H5Bo13RuCAdelOtmTBDm5i0FJFnwM64tH1lNUX9B6siuhR2d1iq7hm0oPViB9gm0DCJh5VqSygW1JAS5zCjtviAy4zr7qzR6nVu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAa4g0di; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAa4g0di"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-436309f1ad7so4059091f8f.3
        for <linux-i2c@vger.kernel.org>; Tue, 24 Feb 2026 02:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771928573; x=1772533373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6WCNZtCDECV+3CSB6BCtAb2y4F78JMbRKKqCpKxwOY=;
        b=PAa4g0dig4yedw0iEHmKfqoPl04A6KkeUIqpB2g4SH2RX5tguwlX3fpluaNnGP28h/
         /aN8KQjQeOD+fb5GrtsppYOsCl+rBVI4puKNfh62NiJgx7cIt3P+oakx/14L6SsdkEMo
         Zk+4/eYsOoJk3BhdBxIAT1B3edYLkKRmDApMWtilwEkAReEzOHQfyuHt/TzPaZ5c7XVy
         2UL6mW9nWkJQ8wLbTI6H60zNs+GllcsZCDpp0nwBOVG/m2WmqFH/aCrEP7Uep08NY0dc
         K9V0pgBuwyHmkuNnz3OAlskfV7UIfk+ju3JQaAxIel1u+OWSG2CdUAlAK3hlOanfuAIC
         2jgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771928574; x=1772533374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t6WCNZtCDECV+3CSB6BCtAb2y4F78JMbRKKqCpKxwOY=;
        b=CSGFn8glxMbqA3WZ6ufuxqzplLjmsz1BkeuaBbaUpcjnp4KyhF+teBrwEpnz8ldSce
         NK28BczmqzWK4uK7v/XP+RUSkm/Jp8MuSk9SUfOtnbZesz2R0V31cLYc7mxh0wE9zNZT
         BoA6dWQcSY8H+fRKVFxaR1Mg5LR5/EfVNPDwYKNc+j+QtY8txOcN/zSs3uQpbyFWBOYl
         HImf+AOyvOi4YmYr/WwipLGFrg/S+Bi9fBI2Ktdh5FPw9J/J/dOnRdtRLDuEfJD2vpWk
         EYb29s4/MeMNGPEXIN8IY1oRs/YMywBG5BdAgfLxqenJYvz/5g+OdDh4T1NSaWNHs3gp
         MYRg==
X-Forwarded-Encrypted: i=1; AJvYcCXHLoTchMZwrRZV6dR5Hbr2ZjBDKre22jvp753i+nx3a5pNl2mk3VN6Tyn4GU6HeFYPL5C3+KJ1t9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeLHl/WK66y1zFenrHR2e+qxB/a+awkNE5I3eUH+cwzivOQUhy
	uaI0dmqhNPHiTTpnRzSuPe1wVmeQGpyP+t8kMR9jz8NbV3Lkh54HgIBY
X-Gm-Gg: ATEYQzz0Rp/UFKzvhwjMdt+XlHLkXyKuSNMytab7zeXN3RYxAnKD3d32LhjbK2thw1L
	myUSsHNuBwmP1KN8G7beoBSqFK3nR7M/mQaJovr+MkLNeBZeeRTcO3M1VaUZUzWQR0WVRNfoeiZ
	J0vuGQ6XPYq6xnafzGcgqDGpT34wd5q/W8rOhhoygr0awrnQmCb7upEX6A+nrTr0Z9AEwd2sjPp
	3ApbOD5IPkJZyKkbMk3/CoxVWMzn3BBhbvnqSATtPFjVYi8NZKbCsr120u26bzCWek2x76XvHoy
	bQUi31oT2BskMyeP+KpPRZ03sb3Ja0JZjMMZPb9n2ZwvdjcebxT3o+RWwwrqLCsmvNwfBNiFL3K
	R4YNVkBS1o337wh/KU9VJgT2Wu0y158HiKdzEfGD8mPn7AYQ8fFjSU1zLG2Erg2HEk8nsgUpomR
	MBPpYFgylUDQnQfG+yYIZ+SNQhg3VM
X-Received: by 2002:a05:6000:a90:b0:439:881a:656c with SMTP id ffacd0b85a97d-439881a6686mr1398838f8f.6.1771928573385;
        Tue, 24 Feb 2026 02:22:53 -0800 (PST)
Received: from fedora ([101.57.210.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3ff6dsm27211843f8f.25.2026.02.24.02.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 02:22:53 -0800 (PST)
From: =?UTF-8?q?Filippo=20Muscher=C3=A0?= <filippo.muschera@gmail.com>
To: jdelvare@suse.com,
	andi.shyti@kernel.org
Cc: andriy.shevchenko@intel.com,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Filippo=20Muscher=C3=A0?= <filippo.muschera@gmail.com>
Subject: [PATCH] i2c: amd8111: Switch to pcim_enable_device() and pcim_request_region()
Date: Tue, 24 Feb 2026 11:22:16 +0100
Message-ID: <20260224102216.17606-1-filippo.muschera@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <aZx_Yvo_an2_13Lq@black.igk.intel.com>
References: <aZx_Yvo_an2_13Lq@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Following the conversion to managed devm_* APIs, update the driver to use
the PCI-specific managed APIs.

Use pcim_enable_device() to properly enable the PCI device and
pcim_request_region() to manage the I/O port region.

Switching to pcim_enable_device() also addresses the fact that
pci_disable_device() was  missing in the driver lifecycle, as the
managed API now automatically handles the disablement when the driver
unbinds.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Filippo Muscherà <filippo.muschera@gmail.com>
---
 drivers/i2c/busses/i2c-amd8111.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
index dd9ac4bb6704..3e8f7a59df51 100644
--- a/drivers/i2c/busses/i2c-amd8111.c
+++ b/drivers/i2c/busses/i2c-amd8111.c
@@ -427,6 +427,10 @@ static int amd8111_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (!(pci_resource_flags(dev, 0) & IORESOURCE_IO))
 		return -ENODEV;
 
+	error = pcim_enable_device(dev);
+	if (error)
+		return error;
+
 	smbus = devm_kzalloc(&dev->dev, sizeof(struct amd_smbus), GFP_KERNEL);
 	if (!smbus)
 		return -ENOMEM;
@@ -439,8 +443,9 @@ static int amd8111_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (error)
 		return -ENODEV;
 
-	if (!devm_request_region(&dev->dev, smbus->base, smbus->size, amd8111_driver.name))
-		return -EBUSY;
+	error = pcim_request_region(dev, 0, amd8111_driver.name);
+	if (error)
+		return error;
 
 	smbus->adapter.owner = THIS_MODULE;
 	snprintf(smbus->adapter.name, sizeof(smbus->adapter.name),
-- 
2.52.0

