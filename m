Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEF7369219
	for <linux-i2c@vger.kernel.org>; Sun, 26 Jul 2026 11:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785065779; cv=none; b=YbifSQ+tt9n7SaEzgvsC6dWKa3bMzJqE5I7N9BgdsbEATtaUoJQsNyCV0JdBsMTSlpZpDxNlJSMIltjKU21Dj+Zi8xgEr/LEtw3Jzpyd1Z62RsgZmNS2Hvz4zYwuGU8lj06KuHzg/gUC6RmGKW51hoIP46nk9whpT1nsNIPLy6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785065779; c=relaxed/simple;
	bh=4z8eM0cKeCyXbRHvPUN9qHpHHeoMX4H6TniZUzF+ub0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E37r9Kil/A3epEU5rYqLO35pNatcXv9/zYPUkbUHZez12dhcX44ctZ7oj1vQ8ln2STHyR5qY6wHLUvTLCsbq5TRvCc9S7icZOhDZvd8F3NCsCXuJvGxRXm2zhC6AIPx1YVKhJ6twfOjZnI5hU5Z1MmLdotzl8oqwE1l+/uK8R7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTxOZMWr; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTxOZMWr"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c99eaa1f020so1680721a12.2
        for <linux-i2c@vger.kernel.org>; Sun, 26 Jul 2026 04:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785065777; x=1785670577; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j2GR/wd/0U3YmX9j0u62PZTjxH1UGLTsIPyNwJj0EQE=;
        b=eTxOZMWr4XOUk6yHOgD1hsF6MNjNgmAWZfoKNWmMsmYb4SLZDXJrbmHkPO5dt/utp3
         qBPyqiWxWxribT3t1ImoFhrjTdHk5405SmLUHAl6V5VZU313unlWhZmC3T8Yqt/LFKW7
         jdv6yyN1Jc5GequzChFExrZTp0UP/DckPod4hGEqHoCuXCy5OOj6oykWptJvBzD2wTVN
         WP7Jt9omTaIH6L5maJFyHQc01VuJI1hPpEb9KBIiXYRbp43nTO/N5XbCIPLAxiq8btpx
         mkoA2UFx0mx5jNbUwyiCgJouLYqmVWLqJwaiQpkXDIRzxjKLR2EbyyWRSWm/YrxqeHY6
         lx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065777; x=1785670577;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j2GR/wd/0U3YmX9j0u62PZTjxH1UGLTsIPyNwJj0EQE=;
        b=QsCHBlJLZfP5vGWStCPGXRkIdro/AXuv71K1DDAiW8HwzxYyzHgT7XpgKHKDi8071c
         MNnisrxLn19U+RTUZ+e3B8qwZHvt+IKiGlnwD8Ldtjl9fxQSPcwwL3+G4t37tKmFNdJV
         AyX1RLqVaX8iTzwXWzblbMg9CWIRQGkZlJgHAD0I2orjb0PtV4ylGWDXKnCRxYTcXyU8
         SUMbksJekNcjnjiGZRHdf2Geq0/BbE6YZWrvOc0idHpRdUty55xv4ceTj+SjapdH0kyy
         IflyFgDApN4Hic/+TAF7IAfLj5oei6P53yhX/sZj0/l9AIp88rFD02PwtHE1ndkbmeko
         qYbA==
X-Forwarded-Encrypted: i=1; AHgh+RpXXUuOUvA8s0WUy8shhMmW5SxKzKpeZ9MerVhYgfrz+UeIROMuu+69mg6t5y8kzA/YkJXpodRRwvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFLayDAkWkc39lkmCfTdd2EclG0oTEs0WSKGqI6jGlkFDEWDyP
	7qDumSMbWGYmaxqj3xJxD/OTPa3w3NOs9SPEfvFlsBSNfNIsuM9bPmRS
X-Gm-Gg: AR+sD13+bPLXDMfeGB05LP2vfWFPoBEwpMmS95xQNVhu628zayqQ6MytsxCJkF0UdHc
	URvbqoF4ldLE0Jx2TY0xfIqpOkepMAXMJUTo0QgrWw2USvSmVns/91AwwVu2GbxpNLAMXpL+gbX
	jeqwldQulWYv8b4XU4k18LPZygl+Pfejbqx7saGvtywjTOD0rCHwt+g5w+sBptex27wCW/ZIUXr
	r3iD8pm2kLCsN1M42tgq3awwM/FVqMdFjYOqR8wtuc/GSrAh2V56qH4tGnV68aseMZfM4iCwbdf
	vSVi3rTGIowhXwVjJaKtkUeZVxkga3PcXWddk8aR95ew5KO/UFvE10OqiRVIBBKnQGaaoCL29K1
	xJ5Ylk2t/5/FyTTCjDL2Ii9AGrahletx9qB7Q9dBAAlBqsRVmnmqWczFw2mTK5sQVc/GE/mkYZg
	FdmaM+ADsaWsG+qj3NX03mrWf7XkhPUmcftNAkj7yXy1CgtXx/phX21OtW0Fvf21A=
X-Received: by 2002:a05:6a00:348a:b0:848:46ea:bbe7 with SMTP id d2e1a72fcca58-84e5946f4b8mr4265594b3a.19.1785065777095;
        Sun, 26 Jul 2026 04:36:17 -0700 (PDT)
Received: from localhost.localdomain (211-20-143-81.hinet-ip.hinet.net. [211.20.143.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e532585edsm1785051b3a.4.2026.07.26.04.36.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Jul 2026 04:36:16 -0700 (PDT)
From: =?UTF-8?q?HE=20WEI=20=28=E3=82=AE=E3=82=AB=E3=82=AF=29?= <skyexpoc@gmail.com>
To: Hans de Goede <hansg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HE WEI <skyexpoc@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] usb: misc: usbio: reject endpoints smaller than the packet header
Date: Sun, 26 Jul 2026 20:35:07 +0900
Message-ID: <20260726113511.57596-2-skyexpoc@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260726113511.57596-1-skyexpoc@gmail.com>
References: <20260726113511.57596-1-skyexpoc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

usbio_ctrl_msg() and usbio_bulk_msg() bound the caller's transfer sizes
against the endpoint packet size minus the fixed protocol header:

	if ((obuf_len > (usbio->txbuf_len - sizeof(*bpkt))) ||
	    (ibuf_len > (usbio->txbuf_len - sizeof(*bpkt))))
		return -EMSGSIZE;

usbio->txbuf_len is a u16 and sizeof(*bpkt) is a size_t, so the
subtraction is done in size_t.  struct usbio_bulk_packet is 5 bytes and
struct usbio_ctrl_packet is 4 bytes, so any endpoint smaller than that
makes the expression wrap to a value close to ULONG_MAX, both
comparisons become false and the check is disabled.

txbuf_len and rxbuf_len come from the bulk endpoint wMaxPacketSize.
usb_parse_endpoint() only clamps wMaxPacketSize downwards, it never
enforces a lower bound:

	if (maxp > j) {
		dev_notice(ddev, "... has invalid maxpacket %d, setting to %d\n",
		    ..., maxp, j);
		maxp = j;
		endpoint->desc.wMaxPacketSize = cpu_to_le16(i | maxp);
	}

A wMaxPacketSize of 0 is merely logged with dev_notice(), and a bulk
endpoint declaring 1 is accepted verbatim.  usb_submit_urb() rejects
maxpacket 0, but nothing rejects 1.

A device claiming one of the ids in usbio_table[] and advertising a bulk
out endpoint with wMaxPacketSize 1 therefore ends up with a one byte
usbio->txbuf, and the very first I2C transfer reaches usbio_bulk_msg()
via usbio_i2c_init() with obuf_len = 7.  The wrapped check passes and the
packet header stores overflow the slab object before memcpy() is even
reached:

	bpkt = usbio->txbuf;
	bpkt->header.type = type;	/* txbuf[0] */
	bpkt->header.cmd = cmd;		/* txbuf[1], out of bounds */
	bpkt->header.flags = ...;	/* txbuf[2], out of bounds */
	bpkt->len = cpu_to_le16(obuf_len);	/* txbuf[3..4] */
	memcpy(bpkt->data, obuf, obuf_len);	/* txbuf[5..] */

Note that this is all complete before usb_bulk_msg() is called, so it
does not depend on the host controller being willing to run a transfer
on such an endpoint.  With KASAN it is a slab-out-of-bounds write.
Through usbio_i2c_write() obuf_len becomes sizeof(struct usbio_i2c_rw) +
msg->len, so the length and the contents of the overflow are controlled
by whoever can issue I2C transfers, up to the 4096 byte adapter limit.

wMaxPacketSize 0 is worse in a different way: devm_kzalloc(dev, 0)
returns ZERO_SIZE_PTR rather than NULL, so the existing

	if (!usbio->txbuf)
		return -ENOMEM;

does not catch it and the same header stores dereference ZERO_SIZE_PTR.
usbio_bulk_recv() has the same problem on the receive side: it reads
bpkt->header.flags at offset 2 of usbio->rxbuf before any length
validation.

The control side is different.  For low, full and high speed hub.c
forces ep0 wMaxPacketSize to 8, 16, 32 or 64, all larger than the
control header, so usbio_ctrl_msg()'s check cannot wrap there.  For
SuperSpeed it accepts any bMaxPacketSize0 that encodes a non-zero value:

	i = maxp0;
	if (udev->speed >= USB_SPEED_SUPER) {
		if (maxp0 <= 16)
			i = 1 << maxp0;
		else
			i = 0;		/* Invalid */
	}

combined with "(udev->speed >= USB_SPEED_SUPER && i > 0)" below, so
bMaxPacketSize0 of 0 or 1 gives a ctrlbuf of 1 or 2 bytes and the same
wrap, during the five usbio_ctrl_msg() calls in usbio_probe().  Whether
a given host controller will operate such an ep0 has not been
established; the control length is checked here regardless so that the
invariant is stated once for all three buffers.

Validate the three lengths in usbio_probe(), which is the only place
that assigns them, instead of hardening each arithmetic site.  A bridge
whose endpoints cannot even carry the protocol header is unusable, so
refusing to probe is the correct outcome.  Rejecting the equal case as
well is deliberate: it does not wrap, but it leaves no room for a
payload, and excluding it makes every "<buf>_len - sizeof(*pkt)" in the
driver a valid size of at least one.

No supported bridge is affected.  The low, full and high speed devices
this driver binds to have an ep0 packet size of at least 8, and they use
bulk endpoints of 64, or 63 via USBIO_QUIRK_BULK_MAXP_63.

Found by code review, doing variant analysis on the code around
8c6314489550.  The overflow was reproduced under AddressSanitizer with a
userspace model of usbio_probe() and usbio_bulk_msg() that uses this
driver's struct definitions, checks and stores verbatim; it has not been
exercised on hardware or on dummy_hcd.

Fixes: 121a0f839dbb ("usb: misc: Add Intel USBIO bridge driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5 asan
Signed-off-by: HE WEI (ギカク) <skyexpoc@gmail.com>
---
--- a/drivers/usb/misc/usbio.c
+++ b/drivers/usb/misc/usbio.c
@@ -577,6 +577,24 @@
 
 	usbio->ctrl_pipe = usb_endpoint_num(&udev->ep0.desc);
 	usbio->ctrlbuf_len = usb_maxpacket(udev, usbio->ctrl_pipe);
+
+	/*
+	 * Every transfer starts with a fixed size packet header and the length
+	 * checks in usbio_ctrl_msg() and usbio_bulk_msg() are computed as
+	 * "<buf>_len - sizeof(*pkt)".  Those lengths are u16 while sizeof() is
+	 * size_t, so an endpoint smaller than its header makes the subtraction
+	 * wrap to a huge value, disabling the checks and overflowing the
+	 * buffers.  An endpoint exactly the size of the header does not wrap
+	 * but leaves no room for a payload, so reject that too and every
+	 * "<buf>_len - sizeof(*pkt)" below is a valid size of at least one.
+	 * usbio_probe() is the only place assigning these lengths, so
+	 * validating them once here covers every user.
+	 */
+	if (usbio->ctrlbuf_len <= sizeof(struct usbio_ctrl_packet))
+		return dev_err_probe(dev, -EINVAL,
+				     "Control endpoint maxpacket too small: %u\n",
+				     usbio->ctrlbuf_len);
+
 	usbio->ctrlbuf = devm_kzalloc(dev, usbio->ctrlbuf_len, GFP_KERNEL);
 	if (!usbio->ctrlbuf)
 		return -ENOMEM;
@@ -596,6 +614,11 @@
 	else
 		usbio->txbuf_len = usb_endpoint_maxp(ep_out);
 
+	if (usbio->txbuf_len <= sizeof(struct usbio_bulk_packet))
+		return dev_err_probe(dev, -EINVAL,
+				     "Bulk out endpoint maxpacket too small: %u\n",
+				     usbio->txbuf_len);
+
 	usbio->txbuf = devm_kzalloc(dev, usbio->txbuf_len, GFP_KERNEL);
 	if (!usbio->txbuf)
 		return -ENOMEM;
@@ -607,6 +630,11 @@
 	else
 		usbio->rxbuf_len = usb_endpoint_maxp(ep_in);
 
+	if (usbio->rxbuf_len <= sizeof(struct usbio_bulk_packet))
+		return dev_err_probe(dev, -EINVAL,
+				     "Bulk in endpoint maxpacket too small: %u\n",
+				     usbio->rxbuf_len);
+
 	usbio->rxbuf = devm_kzalloc(dev, usbio->rxbuf_len, GFP_KERNEL);
 	if (!usbio->rxbuf)
 		return -ENOMEM;
-- 
2.51.0

