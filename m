Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA5E1EEA54
	for <linux-i2c@vger.kernel.org>; Sun, 26 Jul 2026 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785053058; cv=none; b=dagvWJBt6PK/Env0UmArygb2phJ/h/3rUk/QX2A6KOIpeYSWzlZtyTS7rFmaf/0dJ04KoIMFtHK8GVr09f+bVEF+5HihTAfnjGC5dgzHmcgwy6DBob6eHyQzfvSgiPGg/qP/NTgCu7GY6Od3FAOFs0i6q/lO3lI623bKhWiKxlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785053058; c=relaxed/simple;
	bh=JPDvRgPMEgrp/SfBhoi+eonuQeUKz6vijZ1u2OR98K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s4xSxVmlkL3jM+8N9+doeXoNuiYZEEhXaswa1j8rAD3HA9rLucO6mCoCDrTQVJ4o/9ljb4drjEY2tDMtSHYeCgNSz+YQLT7/k4CXS6TfT4/xMMgAqMK6pCg8zpi94+k6c/iPf4ie0ou0XSK5kvx2n2J6+xy9j/fVncj5u633uYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tKOTeF7E; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKOTeF7E"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cad4170e8eso26326095ad.3
        for <linux-i2c@vger.kernel.org>; Sun, 26 Jul 2026 01:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785053057; x=1785657857; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0cSaUuxqvKb2G+bbaTUBH2R6mWDoaRfWDXnqyNQToyg=;
        b=tKOTeF7EpvgbKrfJWXlXDDlW51iMk3rtTICMCzgkNRWvpxvhKdYlvAAv6QrNzPNp11
         nwcrIpT2tb/KKC9rcyFG2XpnJCfzEy3uDyzcp2/s2uN+QJTNDNQ8/7+rD6GhYO0v8ry1
         ATLsfA/R4qiBWdJn12h7VwToj1BrsDFZI5NeLuXRXUkCKq+UEudEsjkXpqU1i/HRDMSR
         NuUIhpKuZSdlEni6we+DkDufSN7RQnIS1PDHlldeuOwghDzyfnssnHiEvhyj6EWM8HS+
         DdCk0u/jbdg3KHcu7dVgvlbiLE0BaB6h1kLghvgynrbuH0jHJc511UzY9WeS/9h+OQ3K
         saLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785053057; x=1785657857;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0cSaUuxqvKb2G+bbaTUBH2R6mWDoaRfWDXnqyNQToyg=;
        b=tS+7V2GWtTukh0tLnlN6oeLskht2sr7HJCgYJVB3cPQ1jhiv6tq5KSuRey0cz0lE99
         FiRvaVebgCKO95MRaWo6gTNnrKDRRO/dwBqbQbqkqoDREadJHVKcuugBpcPdBQ7szZva
         NUHZhO/vMjawG1YXPN4y+gjbg+Las7VafzkC2nJkJI/2NNGN5XJZsVAivCiUULWJV/dg
         67IM5ssdhkmiY+HeouKon6EC5Ddutuiq4536uDLaTWzdGDYjcSiWaR0rxABzVsDPVYwJ
         JMKtgEmynDuwA+VYMI+vCPulSvYqUbx8qGHdLkZ/OFvVQpxluxCdkHvR6jQ5jnhVg9Zm
         hovA==
X-Forwarded-Encrypted: i=1; AHgh+Ro0wNRbSuFIYJrtY7ZCf0emw85CRcmbwDFWFXn+VBXra//7UNUT9bEjp8xqmsl5FcxeXJj3uKLDdGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYx20mi8ECaB1Ua0uZNvoocAL4gT7qhxGZlqnBKyptIamcBQqv
	l/0jzwy13j+4l4oGvDfixzEh5qZaQfLmrWDPBJMG+GkkzX4O/6Fw4y/4
X-Gm-Gg: AR+sD10YBK1w2X7tGEYwd8oPz7Ncryh9iJhTd1/23B5z/b36QZJO64NVaL5f6SNArOf
	HTmYsaVRpeLj8mvapt8e+bDCLsa3Opi26zi5RyH+VQC/UW2vVOPzM7L7G62qbl3POzzrOLhynb6
	FrFEwg4V0TTyicGgm8UOa7E0fIdrxhU7qYbLuoE3g5uvBqmtzpLcKuIGUfq6Hk3OLx0V0VDPQW6
	ywGyJDWfLSUludqpudAD6aJC360YT2KZM6r/0YBYYfOcFrYumr55HAmuIrvX3l4UbLDRBfaw4XS
	zZurm8XUyOOk15lX6xWCddG/supt9hQkqmbEKcZJlM+u3tk6Oiutd1adLPPYXhDJUsgbGIIqipS
	R+/6eTXZMB11L5jSqdfSFmEPfbEgjsF6APEcWpRf1GGBY7h5Fsy1r9Hork4CWedsXpJVnX4PLEO
	eJoUBr2licE6Fh5XeeQvM/FQnSad/Tq+nzIMJ2wvJnz32kbFxVy/jUgZDs5SKIeEY=
X-Received: by 2002:a17:903:24f:b0:2c9:97a7:71af with SMTP id d9443c01a7336-2cfde885b28mr39561865ad.42.1785053056893;
        Sun, 26 Jul 2026 01:04:16 -0700 (PDT)
Received: from localhost.localdomain (211-20-143-81.hinet-ip.hinet.net. [211.20.143.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5e2b8esm17503365ad.31.2026.07.26.01.04.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Jul 2026 01:04:15 -0700 (PDT)
From: =?UTF-8?q?HE=20WEI=20=28=E3=82=AE=E3=82=AB=E3=82=AF=29?= <skyexpoc@gmail.com>
To: Israel Cepeda <israel.a.cepeda.lopez@intel.com>,
	Hans de Goede <hansg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HE WEI <skyexpoc@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] i2c: usbio: reject bridges with undersized transfer buffers
Date: Sun, 26 Jul 2026 16:59:12 +0900
Message-ID: <20260726080129.44969-3-skyexpoc@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260726080129.44969-1-skyexpoc@gmail.com>
References: <20260726080129.44969-1-skyexpoc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

usbio_i2c_read() and usbio_i2c_write() derive their per-transfer chunk
size from the bridge buffer sizes:

	u16 rxchunk = i2c->rxbuf_len - I2C_RW_OVERHEAD;
	u16 txchunk = i2c->txbuf_len - I2C_RW_OVERHEAD;

I2C_RW_OVERHEAD is sizeof(struct usbio_bulk_packet) +
sizeof(struct usbio_i2c_rw), i.e. a size_t of value 10, while the two
lengths are u16.  The subtraction is therefore done in size_t and, for a
bridge reporting less than 10, wraps before being truncated back into a
u16.  rxbuf_len = 8, a legal full speed bulk wMaxPacketSize, gives
rxchunk = 65534.

The chunk size decides whether a transfer has to be split:

	if (msg->len > rxchunk) {
		/* Need to split the input buffer */

The adapter quirks cap msg->len at 4096, so a wrapped chunk size makes
that condition permanently false, the splitting path becomes dead code,
and the single-shot path asks usbio_bulk_msg() for more than the bridge
buffer can hold.

The boundary value is worse.  rxbuf_len of exactly 10 gives rxchunk 0,
and I2C_AQ_NO_ZERO_LEN guarantees msg->len is at least 1, so the split
loop is entered and never advances:

		do {
			if (msg->len - len < rxchunk)
				rxchunk = msg->len - len;
			ret = usbio_bulk_msg(...);
			if (ret < 0)
				return ret;
			memcpy(&msg->buf[len], rbuf->data, rxchunk);
			len += rxchunk;
		} while (msg->len > len);

"msg->len - len < rxchunk" is 1 < 0, so rxchunk stays 0 and len never
grows.  The only exit is an error return, so a device that keeps
answering keeps the loop running indefinitely and uninterruptibly, while
holding both usbio->bulk_mutex and the client mutex, which blocks every
other user of the bridge.  txbuf_len is independent and can be left at a
normal value, so usbio_i2c_init() succeeds and the read is reached.

Check both lengths once at probe time.

This is a behaviour change: a bridge reporting a bulk wMaxPacketSize
below 11 no longer gets an I2C adapter at all.  Such an adapter could
never have completed a transfer.  usbio_i2c_xfer() runs usbio_i2c_init()
first and bails out on failure, and that needs obuf_len = 7 to fit in
txbuf_len - sizeof(struct usbio_bulk_packet), so anything below 12
already returned -EMSGSIZE for every single transfer.  Failing to probe
is better than registering an adapter that cannot work.  No supported
bridge is affected: they use 64, or 63 via USBIO_QUIRK_BULK_MAXP_63.

This additionally covers the case where usbio_get_txrxbuf_len() returns
without writing its output parameters because the bridge is already
gone; the lengths then stay 0 and the bridge is rejected instead of
being used.

Found by code review.  The non-terminating loop was reproduced with a
userspace model of usbio_i2c_read()'s split path; it has not been
exercised on hardware or on dummy_hcd.

Fixes: 121a0f839dbb ("usb: misc: Add Intel USBIO bridge driver")
Cc: stable@vger.kernel.org
Signed-off-by: HE WEI (ギカク) <skyexpoc@gmail.com>
---
--- a/drivers/i2c/busses/i2c-usbio.c
+++ b/drivers/i2c/busses/i2c-usbio.c
@@ -245,6 +245,20 @@
 
 	usbio_acpi_bind(i2c->adev, usbio_i2c_acpi_hids);
 	usbio_get_txrxbuf_len(i2c->adev, &i2c->txbuf_len, &i2c->rxbuf_len);
+
+	/*
+	 * usbio_i2c_read() and usbio_i2c_write() compute their chunk size as
+	 * "<buf>_len - I2C_RW_OVERHEAD".  Those lengths are u16 and the
+	 * overhead is a size_t, so a bridge reporting less than the overhead
+	 * makes the subtraction wrap and the truncated u16 chunk size then
+	 * defeats the splitting logic, while reporting exactly the overhead
+	 * makes the chunk 0 and the split loop in usbio_i2c_read() never
+	 * advance.  Refuse to attach to such a bridge.
+	 */
+	if (i2c->txbuf_len <= I2C_RW_OVERHEAD || i2c->rxbuf_len <= I2C_RW_OVERHEAD)
+		return dev_err_probe(dev, -EINVAL,
+				     "Bridge buffers too small: tx %u rx %u\n",
+				     i2c->txbuf_len, i2c->rxbuf_len);
 
 	i2c->rwbuf = devm_kzalloc(dev, max(i2c->txbuf_len, i2c->rxbuf_len), GFP_KERNEL);
 	if (!i2c->rwbuf)
-- 
2.51.0

