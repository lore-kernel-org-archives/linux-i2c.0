Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399848;
	b=2daAEveJFkbCflk8KYomobt19vJVXYjYdu0pSuag/nLWO2/mfhD6ShgMjzGY5Nv4nf9e
	 xUznGq/CWygzwQLmA57zVj4/AwtGQ1wtBL5m0PGTFIHJzAtXEk4hrBLgsZYZSzylb/QIF
	 tSRSugl+bAy9jTc+C6Dj+jQadHzqrQQGf4Xz0u8LZt6IibkoEKpzX/BXY2p000SQKPWT2
	 q7XW1WmaW3hdfxT/WrVI/MDMyfWjtYfXo2ttye6ckY6L+MGYZpy8TYaITaQ5n2plhjsn6
	 tvV/ktCCcYkK4oMi0IrCB0QCdXfscsIh6UP0/w9Sc16OgX9sSrbOrKTW7w9qSEwNi9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399848;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=smxd6atDvW+XcNIEKcY809Fe9dqPoq4HuHxsaG6+qd0=;
	b=Lv2nw0WBk62yGmPDAwXI67Y2hCHK6LKSgjzUii7sGSbDnWMkfCH4M7OmcesP20BzK32K
	 5CUksVUqMusloOoNN6bB0fnIahGdBuGXEGsn5k1NWnhR4eaXzxW0JlkkERb96IVVErzyk
	 2JDx7PqXX7q/qVnk10aZhxNfuAaGSoPYqqo4v45R9HI5n6FvKM6wSSDGk7sZnNaNr4m3U
	 kI1DFSwkuWFC0+N32jxUA7zd6Hxzdu8vC4WGajAfl2nwoNhoDWwU9/hcAYkBrjqy1hln5
	 G1C7vt6lez8VTz2Usax26UkqoTfDuEfG8c1zB0vuF6STmfC2DytMGwOM73SlXbhwI3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M2I9t4hp;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66477606A335
	for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 22:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66477606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M2I9t4hp
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so9994695e9.3
        for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 15:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793399847; x=1794004647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=smxd6atDvW+XcNIEKcY809Fe9dqPoq4HuHxsaG6+qd0=;
        b=M2I9t4hplWMbO8tPuee3YyWYgEo3wyjcr0/4BG4YKzu3NCWdVKYAMmKMUvw6UbDvx8
         BcX4QsuLLNI3QShg+6TAx6QfEBf68vsNfxrxlN8naod6hf6myRsr0HkCry0hYrdWCcus
         L64wCfLUnofWYSxXo2tF9h41gd2jGhtnHCcBjBz2pmOic55Yq+F+E3fJFGdlUWdZDvrt
         NdJEUlNXC79r72UKiAgOBXdnjy7b/kw1mYOjqhjZ7J7DbLKb3GW+cm14TLJfWP5er6Km
         7tPZrlHXLlrek2xUExAq6V6GQVUhH0faZ0GJK/JU8xJwzv0Fg0PINfnJnb6sHm94jy1q
         eZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793399847; x=1794004647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=smxd6atDvW+XcNIEKcY809Fe9dqPoq4HuHxsaG6+qd0=;
        b=ARLBoJoifphwkT59KcysNx4kIpyTElhya0YZssX3YXH08EybZybILo3Gg6jagv6iVs
         9mIGsDHXjl15lX/Oe3ZQrWcKRJ8XeA9RGRFIOFyBLQJ9VMqWS4cKNxrnjwbw0tMvqZH9
         gG0a5l9c787cx3faziddDP+Y3PVR7XvMCc4+DS51W6cRpFKN3llFjV8d5knMTtcVVeAJ
         Kmih54PYdcDf8eylULlUZe8SDJEatfNvoq0ZHNY5zcOOroTqADML/YkSbY0L8POXjJZg
         TX9F56f4486ZtSbuiETBhpo2I9V4h9y6dm1mGKuVL4VUCJrX2LzY/7tf9jzZuhG6Xj+0
         +J1Q==
X-Forwarded-Encrypted: i=1; AKwUvBzs7eYHCxZHP071QRaGTg8UeWePOhSBXXCeWWmShHeq6oLISALcndWw598iv+WaZl9Fa5H0PNv66LA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKsSvSf6Ch8AMRXx2urxZdYio8MAR7KbJugsCKjsYQJnZ+rfykq
	hdqQcJic7ApX2ERmZpQ55/kvnNAE0Itb0bSA2h0QWyRefUHiQF3S06gk
X-Gm-Gg: AYBFou2rqYW1iPregmRcqXtsuG2Mw/WGIos1vRccsHdEv184O4QyoQfoAHwN2umQN9c
	LJ7xUI2SykhDXUscLY8OcDV/Wu0NCDm7ezbtjFucOoCqu7RmdHvqQzLCfGZ6RU4pPPeN7yMz4Fp
	iwUc419GxiGy72hXcKNApYbq5aC3HlEtz9MJAyUkXSeu1fh9XvTQaL/7BXnxyT5kjJ3ajI61OL+
	+qu0DjLRMh6L8ZDYWIe9V3KC+RduymHdjqYJJJALVtDxEUzG+at+Dtr3siWFoTmlRl1fKiMQhUh
	3Uss4o/5CEAduJvxW8jizXSua8X1HQ+lFYKybN9rWshynd2gLUf3qcA6ecJ08YbFzHNuKHXpoB3
	TWQk2r87RyXWOvY+KEfj3KU0JXgL7zEbX2P8sGD/t1PZ0U3cSP1yGK8vD721EWHy0o8++OLyA8K
	a67Pckjcgjg0uOvM3ed80L8O5NYScIXYxFdFhzzrrS+olxkGzW6ptOezE+nJKOGtRnRxUR+/2kW
	pPpgO3RNMqsxByY/8EoBJPHPzYRW1/y8H3rqnRF4WCO8jDmx9yp3SYyCMiDxwim/h3WqQZzIHKG
	W1mxjstcNXR5qI7uQJ/UcMoUlNkb6V09TQXymtM9TdE+b0b9sBw=
X-Received: by 2002:a05:600c:8b0a:b0:4a2:191f:7cbd with SMTP id 5b1f17b1804b1-4ac17191009mr83697245e9.11.1793399846753;
        Fri, 30 Oct 2026 15:37:26 -0700 (PDT)
Received: from m2.. ([37.142.145.227])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e71b959c1sm5457300f8f.45.2026.10.30.15.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 15:37:26 -0700 (PDT)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Christina Quast <contact@christina-quast.de>,
	Rio Liu <rio@r26.me>,
	Bruno Giacomazzi <brunoceg1@gmail.com>,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: [PATCH v2 14/15] HID: ft260: i2c: fix i2c_reset sysfs store return value
Date: Sat, 31 Oct 2026 00:36:36 +0200
Message-ID: <20261030223637.86907-15-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030223637.86907-1-michael.zaidman@gmail.com>
References: <20261030223637.86907-1-michael.zaidman@gmail.com>
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

A sysfs store must return the number of bytes it consumed. kernfs
hands that value straight to write(2). i2c_reset_store() returns
whatever ft260_i2c_reset() returns, which is the length of the
feature report it sent, 2, not 0. The "return count" below it never
runs, so every write to i2c_reset returns 2 whatever its size.

A write of two bytes is right by coincidence, because the report is
two bytes long. A caller that leaves out the newline, as C and Python
code usually does, writes one byte and gets 2 back, which is more
than it asked for:

  echo -n 1 > i2c_reset   1 byte, write() returns 2, bash ignores it
  printf 1  > i2c_reset   1 byte, dash reports an I/O error
  echo 1    > i2c_reset   2 bytes, correct by coincidence

Return 0 from ft260_i2c_reset() on success. The value is discarded by
its other callers, ft260_hid_output_report_check_status(),
ft260_i2c_probe() and ft260_i2c_abort(), whose own four callers
discard it as well.

Fixes: 6a82582d9fa4 ("HID: ft260: add usb hid to i2c host bridge driver")
Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index f7d01d9e07f7..cd1117c170e1 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -551,7 +551,7 @@ static int ft260_i2c_reset(struct hid_device *hdev)
 	}
 
 	ft260_dbg("done\n");
-	return ret;
+	return 0;
 }
 
 static int ft260_hid_output_report(struct hid_device *hdev, u8 *data,
-- 
2.43.0

