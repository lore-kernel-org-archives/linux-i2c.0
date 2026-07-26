Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8132372EF5
	for <linux-i2c@vger.kernel.org>; Sun, 26 Jul 2026 08:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785053043; cv=none; b=ORgvR2fXgOU9cM9ldqLZ5oNe4+AtyF2NQVzpyBQpC6NANYC9li4+15xX6KbQyuSD46HcJdFBCh5xWrrwfH6m0M6WMu8sJ2R97adqyuHdxjYL0dynVzltWn6JdH+rfF3JQivuCnev58pRhM9dJpJxcSzsa1FQ/1apxh71S0la34M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785053043; c=relaxed/simple;
	bh=eBiYeqRNOonyekOJrJqCQgTXAFtBAqkEfIJs/qQdiKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t0rpcXOKT7+G25uIGLzr3akuyG4boIUcGqPfSLcBxJW9ibU3jt5cTm78IaMHa2lu8UeDJOgw8PttqWEVUY0PuwoUfQWjZ67b/adJyBXNtqdLOsu40PyhUbwPnhlhhQ+EqUgwnNbG8sDp2DCCpJMOCuBoql5LPH9u7i+QD8OV5No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9FE78d1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9FE78d1"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cf27856f9cso21875445ad.2
        for <linux-i2c@vger.kernel.org>; Sun, 26 Jul 2026 01:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785053041; x=1785657841; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0vwye3bYt271MSx9qRm7lxJP4TvzZMND6qAgc6WLmrE=;
        b=P9FE78d1HGGeARsExt2f7fztq/9m4wBIg3d7T+CB8S5GjBucwMdDiJTIRlsMRNTojz
         5rATMUSjZyQdNd7wBCkCGu6VCbsXzP+4dX/7fmRTXjx59tYNOAV+dbGKl5d+vjYAOVWf
         Rx73FRVt3ubUuD8vXr/BHdKX5X6XHzV/2gR1j8r2f/XweBX7WExuwwDh877Wy6ByBFBA
         VYbg1OsZSZXmzYtr5TuJzXACv94W2VGHF9KaMG3djs/xoCYYR6IF1U0c64Zlnijm2L15
         PblKVxpYOz2z9Vx7UdjazIlULIsXM0r/97CqMimy/7IgGHv8UE5NTmeoa7ZrcT7gRTTC
         0pqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785053041; x=1785657841;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0vwye3bYt271MSx9qRm7lxJP4TvzZMND6qAgc6WLmrE=;
        b=hOG6dxRRzSTQr377lcGV3dkm7KG3KtInBlrDuXHdHrF0+YUFNq+tRLoDPkjk+GDhmB
         D7wXbsVtPgTgYepk5Vdv/dTWzeNZnH4WK/d0yXaU6hwJO44YwCurBuFukZHeEHe6pHdB
         U3Zo/AFOfEqUR7uBM/YzB4FRjRfhOHCXkjpHeV3685bpGPwmfFjAEGMk5v0ceKpRMtf7
         DlfgW8rFi/m5hQnatFnIj6ZPK4OhL3+vONHH7ueUfJv1IaUfbXtOR2ahZygLSD0Twa6l
         oeZFC1dQwrpzGSBsdBw1kEhcmPCKE5VyYFUa34fplTJ+LdxdfVncYE5CRIHG3JZt2jVz
         dC6g==
X-Forwarded-Encrypted: i=1; AHgh+Ro+D9ZWbyhpT8YjIMVPA3NRH1eJQUZZ+Na9hkcCv4lGh+asapAZZXmMuB2XbCq96X+0w2BiJ47rg9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOzB4cRwt8sx+C0tMdhpBZclOQAGpVb/RLgbZ/SXW2VVdfgfuu
	OCTQ3NQlGyOe3wMPCMudZqpM31iLIvmT6beW4lCA0qYLLjW+/+DmDbaH
X-Gm-Gg: AR+sD13C8URjUNJZbrxQwcL+1tid3nWemJRMDPiDA1ZC0z/wvUPVUnvpezUvB4kLk1S
	hpsDKCmRE9zmCcQF3j3uqVMmj5xrGAPBfkfqxxz1hAXCyqOi8tC+WxOfjDehBpkc+EKB4eYLlSv
	cqjfjCndI4gpBe4FevzsPPBWJD3DbNleU5H7Zrn/Kx9qskLR7VPoT+DC97ZQmuzlCyPMEMQEciu
	ISfH+xrlbwxUTsJRY3jguaJdIHe3KPMl0g1VMxqbZSl+45+uYIGYb4UO2Z35pgnLLapmrzXqaRj
	ogJ5u0PnM3azORQIwKGTfwJay2574MPq178hs4dLqEnjEEC1U3uzye3oEnayyXMlyxNmTsgp9xS
	Xz4fl4QJUYfl2QnfbyIVPwWpawB78CVSd+Ju1BK3S5iH7oabDBk9TygL+cQ7RoTas0iBRf0JY0e
	PXhRdaAcFpF+V5ATFiK/FMVawX5Zyhato0p8fFf5XLJGPCUcG316S8qQHuzRl68ns=
X-Received: by 2002:a17:902:d2c9:b0:2ca:53e9:1277 with SMTP id d9443c01a7336-2cfde6877c3mr43661925ad.1.1785053040874;
        Sun, 26 Jul 2026 01:04:00 -0700 (PDT)
Received: from localhost.localdomain (211-20-143-81.hinet-ip.hinet.net. [211.20.143.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5e2b8esm17503365ad.31.2026.07.26.01.03.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Jul 2026 01:04:00 -0700 (PDT)
From: =?UTF-8?q?HE=20WEI=20=28=E3=82=AE=E3=82=AB=E3=82=AF=29?= <skyexpoc@gmail.com>
To: Israel Cepeda <israel.a.cepeda.lopez@intel.com>,
	Hans de Goede <hansg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HE WEI <skyexpoc@gmail.com>
Subject: [PATCH 0/3] usbio: fix two out-of-bounds accesses and a hang
Date: Sun, 26 Jul 2026 16:59:10 +0900
Message-ID: <20260726080129.44969-1-skyexpoc@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is variant analysis around 8c6314489550 ("usb: misc: usbio: bound
bulk IN response length to the received transfer"), which fixed a slab
out-of-bounds read in usbio_bulk_msg().  Re-reading that function,
usbio_ctrl_msg() and the I2C client built on top of them turned up three
further issues.

Patch 1 fixes the length checks in usbio_ctrl_msg() and
usbio_bulk_msg().  They are computed as "<buf>_len - sizeof(*pkt)", u16
minus size_t, which wraps for any endpoint smaller than the protocol
header.  usb_parse_endpoint() only clamps wMaxPacketSize downwards, so
a device can advertise 1 and turn the check off entirely; the first I2C
transfer then overflows a one byte slab object.  The overflow completes
before usb_bulk_msg() is reached, so it does not depend on the host
controller accepting the transfer.  Fixed by validating the three
lengths once in usbio_probe(), which is the only place that assigns
them.

Patch 2 is the equivalent arithmetic in i2c-usbio.c, where the overhead
is 10 rather than 5.  The interesting value there is exactly 10: the
chunk size is then 0 and the split loop in usbio_i2c_read() never
advances, so a device that keeps answering keeps the loop alive
uninterruptibly while holding usbio->bulk_mutex.  That is a hang rather
than memory corruption, and patch 1 does not address it.  This is also
the one patch in the series with a behaviour change -- a bridge whose
bulk wMaxPacketSize is below 11 no longer gets an I2C adapter -- and the
commit message spells out why such an adapter could never have
completed a transfer in the first place.

Patch 3 is a different bug from the two above, and the one that affects
existing hardware.  usbio_ctrl_msg() and usbio_bulk_msg() hex dump the
reply with "%*phN" using a length the device supplied and that has not
been validated yet.  hex_string() caps the field width at 64, not at
the buffer size, so the dump reads up to byte 67 of ctrlbuf and byte 68
of rxbuf: out of bounds for every low, full and high speed ep0 packet
size and for the bulk sizes these bridges actually use.  It needs no
malformed descriptor at all, only the dev_dbg() calls enabled.

The new probe checks do not reject any supported bridge: the low, full
and high speed devices this driver binds to have an ep0 packet size of
at least 8, and they use bulk endpoints of 64, or 63 via
USBIO_QUIRK_BULK_MAXP_63.

What was verified, and what was not:

 - All three build cleanly with x86_64 gcc 14.2.0 at W=1, with
   CONFIG_DYNAMIC_DEBUG both disabled and enabled.

 - The out-of-bounds accesses in patches 1 and 3, and the
   non-terminating loop in patch 2, reproduce against a userspace model
   that copies the struct definitions from usbio.h and the checks and
   stores from usbio.c and i2c-usbio.c verbatim, with only
   devm_kzalloc(), usb_bulk_msg() and usb_control_msg() replaced; the
   memory errors are reported by AddressSanitizer.  The same source
   built with the patches applied is clean, and both a normal device
   (ep0 64, bulk 64/64) and the USBIO_QUIRK_BULK_MAXP_63 path still
   work.

 - The decision space was swept exhaustively, endpoint sizes 0..2048
   against caller lengths 0..4101: the mainline bulk check can be
   bypassed for exactly 0..4 and the control check for exactly 0..3.
   After patch 1 no accepted endpoint size admits an overflow, and no
   size that could carry a payload byte is rejected.

 - I have not run any of this on hardware or on dummy_hcd.  The
   reachability arguments are read from usbcore and from
   lib/vsprintf.c, not observed at runtime.  I am happy to build a
   raw-gadget reproducer if that would help review.

Patches 1 and 3 touch drivers/usb/misc/usbio.c and patch 2 touches
drivers/i2c/busses/i2c-usbio.c; MAINTAINERS lists all three files under
the same INTEL USBIO entry, so they are sent as one series.  They apply
to mainline 3dab139d4795, to usb-next and to usb-testing.

HE WEI (ギカク) (3):
  usb: misc: usbio: reject endpoints smaller than the packet header
  i2c: usbio: reject bridges with undersized transfer buffers
  usb: misc: usbio: bound the debug hex dumps by the received length

 drivers/i2c/busses/i2c-usbio.c | 14 ++++++++++++
 drivers/usb/misc/usbio.c       | 50 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 60 insertions(+), 4 deletions(-)

-- 
2.51.0

