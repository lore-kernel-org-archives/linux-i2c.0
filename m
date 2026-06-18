Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A88C3C1402
	for <linux-i2c@vger.kernel.org>; Thu, 18 Jun 2026 09:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781776690; cv=none; b=ZSRJ0vl58suzG8hNhgxUkXzOAeNH6Qai11/V0nmB73EuxJxrXQCTopKs9/Enku1tRnw1abc8WXZ3ZjR+rTG6d1mIKAjtc6y/CIEqETnFKwr0Xt+3OugL7tccMO4WeO/3fp1sYI3KuGgQRNlX4sOTJ2QnuF1k5S4DMmzUf9BlTmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781776690; c=relaxed/simple;
	bh=E4CIP9e7SN8QS9bEj4j9Tn6NZZDZmnAQ490wK2tXosg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VEnlUJmYVUhlbGHqMeN+MIiodRpZjdqpZ1l7qI8ZzGOGnuBhf5ZBUArCtWHUUBrO/jnr+lG83VG1/n3jjCf3ONdQz3YlPRZOX0FJPJTkpV9aek+CviAfsEOedJojxWxErMGA8+D7YNT/5kMNrw3rFexSg1wO04/mnh0edUNv4ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZJiMkMJ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZJiMkMJ"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84229481d44so320812b3a.0
        for <linux-i2c@vger.kernel.org>; Thu, 18 Jun 2026 02:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781776689; x=1782381489; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4K6O9A6ZIPIwawi/mHt/L2KDbFirhOEnERbsSxy54+Q=;
        b=YZJiMkMJV8RKqBtRpCI74oMCtKa6c4xJ2OvdWwfnxTIqbio+lr0PG+8GZlvjasWPkk
         f58owNqPGkdh/g5laeMwO6HxcitgxVD+RdmnfbSKw2YkjUTtoq69DdNYSUMyDBIUa9p1
         joxY8+qvdFFfHe2DyLu2l1dy7bdVydQTeEwhvdtdXi58cz1sEL2c7TvPi1sGzi/TYhTi
         f8Kj16lNzVsmdQbAeBiNtVVHJPIdthZn/vJj/Qz+6sxSkOCgpW3CX5KY9QbgnCO6ylXm
         jWqhndspzIKZUgwT/y9BG5lHutXkt1cKvQyveTRnKOPG0Q6dH01vi2mQVWUAmCxxREC8
         n0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781776689; x=1782381489;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4K6O9A6ZIPIwawi/mHt/L2KDbFirhOEnERbsSxy54+Q=;
        b=FYQBu9IU2nJCY5Zt3AuNFsiRIGf7Lu6mYYN+28B/Gl5sFrcSR4U1j6xrwbioOuL6/t
         ZeIlFwkCUXt35OWCobX5K9ZgmZZyye2jhD2Tn4i85C+Dd29cX1ZiSTqnthKJC+L+Vxfb
         n1ETZh2qWjGa91Pkqa3F1/JLiAbsFUHjT82yDCdLIietDdbr0BxtO96StqJIFlLNI0Ye
         598GrKhc+w7o8CrzvG8zvj3BW3hS2uSAAqgk88rHMFMTobEsWj/o80i7nzFfkXzjgtpf
         SJqmonk+7A/JkgyqOafQG+xuSW/1NQubPb5Nc9hWndjW/kGS1q+YwVIWXdgymhil9dbN
         UScw==
X-Forwarded-Encrypted: i=1; AFNElJ8CQemVz1J17b35BPI+RfMoiarBZVYHBmZ6gyq7RJvMzxtaMi9jnmIDailMjOHzSvM4z7Wu+xcbHag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0XGPY14L1AUd9aJgL84hWZjOlMMA61ZsdE3haICceHxXyiMAp
	lwssxyzAjJhJCPVBCrKc6QUwqNAmZNVEMW55SqZjpzLe9VgI2i4B1rlX
X-Gm-Gg: AfdE7cmOBQNrcKg38q4Yjo8DPRRHjG3AUp11TDhOu92ne2Rqn3HYpPbNrxMWDBxbbyL
	eWDLcyRxaSvUPjeO+PqtYx+9YyWDJ070KB8hWzzBdXivx05oqt0+0FdbdMGG3dQcX3zNe5rJUaP
	+d0QkZ6CBrWq+/2kn4rjecdSQuGQ4oE22RgqwAoNqOJjeM3M253T8c/TivEhcnkfDlj6WifsVgV
	xtAj5A8f5xaHcvTJOwjaJfWA21VqNLDIajz4HEQPQKA1bWj3pjLODctCEuFuHkhFWOgbjmXplpP
	XQeQS7FpKWxUzFktvqKIvR8CueRT45QMB/RC3vjubC9jRa73aX1LMJlI698N8u7CeVBtsu51qxh
	nvcOe7tHJo82Q6+jruwlkYIseMuYbjd/KOkmwn5xL5DoMnWcGjWYsNHRKERLVHHpdiFMGIuNNvn
	yn8VKGnho23uNj1Blo161sjSmVvgwCxVQNdoXhXQ==
X-Received: by 2002:a05:6a00:4409:b0:842:7cb7:a3aa with SMTP id d2e1a72fcca58-8453b256227mr3175442b3a.33.1781776688584;
        Thu, 18 Jun 2026 02:58:08 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c88d0fa539bsm2922513a12.8.2026.06.18.02.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 02:58:07 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Jan Kandziora <jjj@gmx.de>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: w1: ds28e17: possible out of bounds write from a device length byte
Date: Thu, 18 Jun 2026 17:58:03 +0800
Message-ID: <178177668382.3462209.6459868495361731106@maoyixie.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi all,

I think w1_f19_i2c_master_transfer() in drivers/w1/slaves/w1_ds28e17.c can
write past the SMBus buffer when an I2C device behind the DS28E17 bridge
reports a large length. I would appreciate it if you could take a look.

On an I2C_M_RECV_LEN read the driver takes the length from the device.

	if (msgs[i].flags & I2C_M_RECV_LEN) {
		result = w1_f19_i2c_read(sl, msgs[i].addr,
			&(msgs[i].buf[1]), msgs[i].buf[0]);

buf[0] is the length byte a previous read filled in from the device, so it
can be anything from 0 to 255. w1_f19_i2c_read() only rejects a zero count
and then writes that many bytes into buf[1].

The buffer the SMBus core hands in is I2C_SMBUS_BLOCK_MAX + 2, so 34 bytes,
with msg.len set to 1. A device that reports a length above 32 makes the
read run past the 34 byte buffer, up to about 222 bytes out of bounds.

The SMBus emulation does check buf[0] against I2C_SMBUS_BLOCK_MAX, but that
runs after the transfer returns, so it cannot stop the write that already
happened. A compliant bit banging adapter rejects the over long length
before copying, in i2c-algo-bit.

The attacker here is a malicious or faulty I2C device sitting behind a
DS28E17 1-wire to I2C bridge. It controls the length byte it returns.

I reproduced it under KASAN on 7.1-rc7. With a length of 32 the write stays
inside the buffer. With a length of 255 KASAN reports a slab out of bounds
write past the 34 byte allocation.

The fix I tried rejects a length above I2C_SMBUS_BLOCK_MAX at the two
I2C_M_RECV_LEN sites, before the second read.

Does this look like a real bug to you? If it does I am happy to send a
proper patch with a Fixes tag pointing at ebc4768ac497 ("add w1_ds28e17
driver for the DS28E17 Onewire to I2C master bridge").

Thanks,
Maoyi
https://maoyixie.com/
