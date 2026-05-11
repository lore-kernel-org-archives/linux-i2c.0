Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF473A381A
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 07:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485601; cv=none; b=cdZ5bp8pyNr8FbYied9GiJR4ZMgRP/W/3qWNuhFUwcQ0X2/Q7SLqM+CKnWnP6C1ChhfcyMGZUDnrhUwxGW2/whO7eXGM7yC4owxOXBjMC0QmqW7Ck9pWZBvBFCJZhDDHHiSrs22IzH59DF7RwCg8QxpyNAucTQ2qP8SIblZNvuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485601; c=relaxed/simple;
	bh=u5XSrbEDmvqVlQGoyi69nKTGBePD+Zlvy4U3aX6kxbQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iLSebrjfh9lzos+eZEhaLo+y4e7SystHuqjY37bcWMp9366fuh7Bxntxtf5Xxl6fEMsWe/XJ9OuOZSvFF82Q9VnWRsPbDQiL8rPe0Nk8hjiWcEP0cfNRmlYIcM2EdxlGH83xTL8B4lQESQtaMMGp+j6gFk2O/265HDiriiFHg6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=BkGq0twi; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="BkGq0twi"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so10097659eec.0
        for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 00:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1778485584; x=1779090384; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ApVd1CA9+2PtZ+qnzo0V8UDDKzunnP6ByyqG2o/Ag0U=;
        b=BkGq0twiR2hcRiQqAyUf6djlmXTiQEadzWATZuKi0UeSeiWfL4KAZYM2QeGLVX7gv5
         6sKUtIX4T7SbLVToJAYdGjrLST1kf015hZ31EXSXz57YR2C4c0iJ1ajE7/ZtI/DTVraR
         h3xTsfGj08EXQnka1HeZs+NJlB53qBjRDzWiVMdKj1/jHcKZUIQlJgrSL/D+kcnki3UX
         Z7fYmU4eXVR+kGa00CMGRVu4dB+DdIHdC5sUGQi6ceNML7Mt0TgwcDUHd+tX0CfEDNXu
         Qry27AiObmNcClqunAm3sWElljmnqt6Evihao3yYCn5LS1psFlb1LxOiHklyB98utKfq
         Y0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778485584; x=1779090384;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApVd1CA9+2PtZ+qnzo0V8UDDKzunnP6ByyqG2o/Ag0U=;
        b=bCghJEmOCrFd56bsJnN3KHuc5ZhbQc70FOOHem8uEIRgdJI3X9bm5E14sRnwuWRUP8
         xxVPNQrPn3nLHawL5SVv12W4aTCerYHL9t1K3myOKNF0e23GJKmni5yE2vzg1XSVIO1Y
         MhmQ4mUljBNXVvgiJHXR1qE6sAfKyt/uOYC4ljjypBJw2+GmtNcugv+x/cOtZ+mkS9Ad
         7lmxXvjcZh9o3KERvDsLRSjbUUeoh5RmoLOFEvpZDbKFvd5S3xoDdltmUfwNTe2wxVt5
         vOTBTu6L87z99uZ1iR+jB9PJUIko77hdbF2tilod14bQZHdpGtS0hkPiMKvGCVnGbaei
         8jyw==
X-Forwarded-Encrypted: i=1; AFNElJ/6NfNRGd6LPnE3WBn2/mYsiWuCidnWJWJiGD5OToZn/zL20hNFE32Kzdu4HpSaCLXWMK/S8aR7Wrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJzhQhSnhW6XCLQBEVMLJNTqAF0/rMjSxs7nkH13eDwvwnNGaK
	8fuagxWZyAgL3SnsP0nKi2uMXyAt4BHgMsJxzLU1qRwOkHMREnuvszavXfkcebxOQeQ=
X-Gm-Gg: Acq92OH4bDOSiurY2U3AvvL6p2w/bijC/bmbfT1+dhl9M8BxwuK7iZNBH3MPKg0MH9r
	zacr67podaFhEP5gQnRurLqG6gYrqfBj3++KPF6bFgcdCJ/sJTgdbqgtPkVNGnI6CRylYOZtLxS
	0YlNdfWeilR/BCDVUlIDMD/+V+nm49yWnsTQQvBmtIh+FPLbWRlKvAPEzo5rL3GPZR27/Vh3XYF
	2b11y7AUDxTFTMAW3Z1qTG3g4odv+StisdHF6OF8lGLgc8BsQm2nZHpn18W6sUIlr3W3Ex3BSN1
	7zqZ9gq0YSr8CbLa0rISjaHULOd4eJ35g8YDSpVP0wb5ghHFLxjm1R1fzhcGdho4DXSHiNnoUvW
	Il31nUWGDTiebQaEDIkyDEaEIFgH4oASBjmGQ6S6K2cFNy5o6hqQtUnS7K1xas2yBBgHmwFaViw
	AI0AhUeM8z1bdOScrMNgSBNutotdELnatX1807
X-Received: by 2002:a05:7300:214f:b0:2ed:e15:c924 with SMTP id 5a478bee46e88-2f54bd89309mr11460917eec.32.1778485583962;
        Mon, 11 May 2026 00:46:23 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888e381c9sm12205702eec.26.2026.05.11.00.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:46:23 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Subject: [PATCH v2 0/3] i2c: xiic: fix SMBus block read and PEC support
Date: Mon, 11 May 2026 00:46:11 -0700
Message-Id: <20260511-i2c-xiic-v2-0-c16380cb1594@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEOJAWoC/22NQQ6CMBBFr0JmbU2ZCERX3sOwGMpgxwWQtjY1p
 HeX4tblS95/fwPPTtjDrdrAcRQvy7wDniowluYnKxl3BtTY6gt2StCoJGIUEg+NrtloJNj11fE
 k6Ug9+h/79/BiE8q+GFZ8WNzn+Ip18f5kY6204hZ1N12JGhrvM6dgl/VMAn3O+Qtj5QGuswAAA
 A==
X-Change-ID: 20260427-i2c-xiic-2aeb501ec02a
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778485583; l=2988;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=u5XSrbEDmvqVlQGoyi69nKTGBePD+Zlvy4U3aX6kxbQ=;
 b=DJATSELAqT/i4+OB5Z0NXKmIkGtocX0gHTh2oeoSuMdLxJjkQaymTAncaH3TG31vcQty5no9O
 /H42oDuNzIIC99+4uE1bcYEAVDACo7KExF2gTv7ubbpjLnAMEiv6jwt
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=

This series fixes three independent bugs in the Xilinx AXI IIC driver
that together make SMBus block reads with PEC return -EBADMSG or -EIO
on otherwise clean transfers. They only surface when the client has
I2C_CLIENT_PEC set; non-PEC block reads happen to mask each issue in
turn.

The problems were uncovered driving an adm1266 PMBus device behind a
Xilinx AXI IIC FPGA block and reading its 64-byte blackbox record.

Patch 1 stops xiic_smbus_block_read_setup() from truncating rx_msg->len.
The i2c core appends a byte to msg->len when PEC is enabled, so
overwriting the length to "block size + 1" silently drops the PEC byte
and i2c_smbus_check_pec() then reads the last payload byte as the PEC.

Patch 2 raises the RX_FULL threshold so the interrupt only fires once
every remaining byte (payload plus optional PEC) is already buffered in
the FIFO. The previous threshold of rxmsg_len - 2 caused the
bytes_rem == 1 path in xiic_read_rx() to NACK a byte still on the wire.
The chunk-vs-defer guard now also accounts for the PEC byte so a
rxmsg_len == IIC_RX_FIFO_DEPTH PEC-enabled read does not push
XIIC_RFD_REG_OFFSET past its 4-bit range.

Patch 3 stops the BNB handler from forcing tx_msg->len = 1 to signal
completion. tx_msg and rx_msg alias the same i2c_msg during a receive,
so this also clobbered rx_msg->len; and because tx_pos is already at 2
in the PEC case, the unsigned subtraction in xiic_tx_space() underflowed
and the STATE_DONE check fell through to STATE_ERROR. Advancing tx_pos
up to msg->len drives tx_space to zero without touching the length.

All three patches are pure bug fixes; non-PEC behaviour is unchanged.
Tested on real hardware -- a Xilinx AXI IIC controller talking to an
adm1266, where 64-byte PEC-checked block reads now complete cleanly.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
Changes in v2:
- Patch 2: widen the chunk-vs-defer guard in xiic_smbus_block_read_setup()
  to include pec_len, so a 16-byte PEC-enabled block read routes through
  the chunked drain rather than writing 16 into the 4-bit
  XIIC_RFD_REG_OFFSET register. No tree-level change to patches 1 or 3.
- Link to v1: https://patch.msgid.link/20260427-i2c-xiic-v1-0-e6207f9aa5ad@nexthop.ai

To: Michal Simek <michal.simek@amd.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Abdurrahman Hussain (3):
      i2c: xiic: preserve PEC byte length in SMBus block read setup
      i2c: xiic: defer RX_FULL until all trailing bytes are in FIFO
      i2c: xiic: don't clobber msg->len to signal block-read completion

 drivers/i2c/busses/i2c-xiic.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260427-i2c-xiic-2aeb501ec02a

Best regards,
--  
Abdurrahman Hussain <abdurrahman@nexthop.ai>

