Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C00351C0C
	for <linux-i2c@vger.kernel.org>; Sun, 26 Jul 2026 11:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785065767; cv=none; b=eGft6jqCK1zwrzdz4koXLcH0iPdiNsc5y1+ynXRfpLQGbg9KdUCPwxiaNeKDMdjv0UkfRLX/nz/oV0WMa/E0YGzudLgJ35Fny6sAD2h1USujqmti5sPyB3LTpd8TVHgu9+U+krShM7CMIqOL0BWpmj717Qdr6DeO/oQIucZ2kmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785065767; c=relaxed/simple;
	bh=6dk15sgoyOiyds44KXwldDcLaJF3LPzQpjlu5xc9SPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i1yJ9y25+daPKRVc7uQEXYGvMpTqup1Ztw/8gHHxL5HXkcZ+V1hzoFQHJ9nJEpIJfJR42TgX6YNrVfDGn0PykD7iphocmTNZCM/LjgABFjrUfTLDaBDHEcDIIjs/kZeDLoAEvOMPa8ezg8AMQMD2oA68UOf0YQeYOdPEBvowg6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvOYxkns; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvOYxkns"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8484f229529so1153369b3a.2
        for <linux-i2c@vger.kernel.org>; Sun, 26 Jul 2026 04:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785065765; x=1785670565; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MohrJ9pzF755XkyjyUrpoZ9dJSZxwvRs1bPeqXYYDSM=;
        b=NvOYxknsCSaXa7HfXYHvbx8p9guC8zt2cIAYr0Vxgd0+E28ez4ILmCx8DKy4AtmP6j
         +Wa0L8lgIRlCNT9K9cVteLH5VwSIKNDM9u0cV/BOK6FuHrJRPbfmBL55JTiQ6Hj4ToK/
         UePKlMIyTNkRsYMfL8TTobLq8h1eAy0AWwQCUwtbT4f4lZYAYwX32cyvzdbPFysUN7br
         0IdbNz7E7UMiCABKerOgNM7QXOBzD3MILXBfhFtfvt0P3qghuYhr3vs9W2kMadwMtpmg
         st9OTdsgr+1JAYrTC6oGHWj+yk9lYZfypzuVkm42PTzCFopZT0Hj9Za+5mhD6F1mE0cB
         Z/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065765; x=1785670565;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MohrJ9pzF755XkyjyUrpoZ9dJSZxwvRs1bPeqXYYDSM=;
        b=nmnCq4qhDiT5vMTfw4yJxbgucHJDZaZhTd/FL2sfTOOVld+QJzCzG8CeqkNHvWfxlW
         8qKDnplrX5Z/0dvz7gKGqsnpgSNnvAJa1gOIO1zFuhhJj7Q9qZstt/P5UvuteHbc1slM
         WDJc642LvY7iODmhU4zHAY4jrmiCmG7yT/IQYmaPKUecyGA7OHsNfLdyDvAEM9T7JFNv
         qr00EijyDk6r3ec7D9SAJmPWSYR98v+PIkfvl1i1k6zDXd30U/MFqivxI1Ce4qiJZeU+
         Z8j+gSe7UOiZB3gLtCyFfEIa/XCLX0AE8qklmY3uuvBJBATm6aNIxWeUMwVifo9IoJrr
         gAgA==
X-Forwarded-Encrypted: i=1; AHgh+RqFTmlK10M/WVwcsJ/ZE8U4IHSd56v+uTQpvHigRAI+O8N7CTXbErXHV0EOdkZNRFebX1HYpZFgd8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP6JcFDBv3UzFTU5ToJBRdvhDUI3G+g1s3LdrR+S04bkAnzyL0
	eLAmptKG8cY9Fxa4NdvUOthlpyHlq7LWxcAcT56NQVshwtxdsWIFed60
X-Gm-Gg: AR+sD12fodkXLqxi6XCl9nMydd7SNfJTp1JCGs+WCAJp4Wd3U1q4OVdhmjcjbXi09IE
	aMy6ZXzjPtMa9cIlZTlSTF9REdpcxuq+lkPvhhBlUXKdr/FurWMqtTSfhdyOXXb5qa2C+RjHudC
	Opb3leunWNRAJY2zKCBGVLqJQiYd4I/FzydZAwYy0IQTHXVg217wWOTSwp7zxTbDiRcXUyPDx9D
	M1ZvQwRj8uJOHwrHHCEQVo30W6TVkh7H5HVx3Ff+czvQWvKbgxzPFZre0EqHCix5Q0ZOxvRSyxf
	KN3ofZTq+5RVOVBmNP4SLMLRttgDoE1oEQdjnBzsf+43dVc3Advi27CDKcIl6VaC+dXJYUAqGKh
	JIiVdUSnlVEFk3PoupNeFSMbDKHcLhvMjpH2uZuxNjkkUsdAoMcxJRTHeTHS3fOKCclliLITJyn
	GuuFL+6c0nNU+3V4pCRJ9rgjomd/tHk77+dQ4oqsjcunYjcnbxwz3Scfsn9tuTBQ5gpxRutAgGk
	w==
X-Received: by 2002:a05:6a00:392a:b0:848:2f74:d8d2 with SMTP id d2e1a72fcca58-84e595d15b7mr3720663b3a.67.1785065764827;
        Sun, 26 Jul 2026 04:36:04 -0700 (PDT)
Received: from localhost.localdomain (211-20-143-81.hinet-ip.hinet.net. [211.20.143.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e532585edsm1785051b3a.4.2026.07.26.04.36.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Jul 2026 04:36:04 -0700 (PDT)
From: =?UTF-8?q?HE=20WEI=20=28=E3=82=AE=E3=82=AB=E3=82=AF=29?= <skyexpoc@gmail.com>
To: Hans de Goede <hansg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HE WEI <skyexpoc@gmail.com>
Subject: [PATCH v2 0/3] usbio: fix two out-of-bounds accesses and a hang
Date: Sun, 26 Jul 2026 20:35:06 +0900
Message-ID: <20260726113511.57596-1-skyexpoc@gmail.com>
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
than memory corruption, and patch 1 does not address it.  It is also the
only patch here that changes behaviour.  A bridge whose bulk
wMaxPacketSize is below 11 no longer gets an I2C adapter.  The commit
message explains why such an adapter could never have completed a
transfer anyway.

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

Documentation/process/generated-content.rst asks where the content came
from.  I used Claude (claude-opus-5).  I gave it this driver,
8c6314489550, and asked for variant analysis of the code around it.  It
found the three issues and wrote the patches, the changelogs, this cover
letter, the userspace model used for the AddressSanitizer runs, and the
sweep program described below.  It also ran the mechanical checks and
re-read its own code quotes back against the tree.

I ran the builds, read the result, decided what was worth sending, and
sent it.  The Signed-off-by is mine.  I am answerable for the content
and will answer review comments on it.

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

Changes in v2:
 - Add the Assisted-by tag and the provenance note above, per
   Documentation/process/coding-assistants.rst and
   generated-content.rst.  No code changes: the
   three patches are byte-identical to v1.

HE WEI (ギカク) (3):
  usb: misc: usbio: reject endpoints smaller than the packet header
  i2c: usbio: reject bridges with undersized transfer buffers
  usb: misc: usbio: bound the debug hex dumps by the received length

 drivers/i2c/busses/i2c-usbio.c | 14 ++++++++++++
 drivers/usb/misc/usbio.c       | 50 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 60 insertions(+), 4 deletions(-)

-- 
2.51.0

