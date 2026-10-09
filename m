Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D3F2264C7
	for <linux-i2c@vger.kernel.org>; Fri,  9 Oct 2026 01:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791507719; cv=none; b=GAtt9Py62SMf0vZuvRG+Rcj2CKAKqxtjf2PjSgjhsSWU2njcgAtVWRxSNmhdKyk03qWSsNsRZ8+sxbdpVUOgqKvdsApDaF5F8Sfsdx54ActGVNawnbjOGLHDWVRDvGE2jYXff/e18mKAF/yDSKDDAxK40hXVaSqAts7+FTC/I4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791507719; c=relaxed/simple;
	bh=VvsfpHaXhPNuOESsbmKbjgRvCxu9b+24W1f2Ek0pgic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=N1mbbnJF/sN+l4is+a0BhI6ehylwHrsi/o8v/5CdTSZG8CmfuTbvctTVa/I984L5Xg7imtw0Bf/iwhkkjZXZNcVW/pXIeUuISET4cgA76eFYmP6yFFKCWmTQFucgGohytb5IDiuoJOu4Ng3u4FeJSAs7rFqKXorcKUQbqIaEbFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=JxjhGPKE; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="JxjhGPKE"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3518cbe59b0so852244eec.0
        for <linux-i2c@vger.kernel.org>; Thu, 08 Oct 2026 18:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1791507716; x=1792112516; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cfdw+audQWp9HNvQGo23exvCo4IIEY6hjGNhPZtb1Is=;
        b=JxjhGPKEzNITA7xktGvNciFvzlH0nUKz8Ie3c5F5t0zdMip+KWv9upe55rWVDqmQqv
         1TCKYVdjMQi+qBMhyDoH+7FF/Tvp26+/FsJGVRtrlLMszPhKpaayoaWF0NKXY3l0xCc0
         GtfbD4BNxk14rBPL6g1/7l9TfZS3L49jUAs3V6+yE8KCIxKVqGp67XelC8uPEm1LBv5e
         g5M4oP+bbTrBLE5OY7n5yBA7lM6tip/YBp2kH1c3GfC+DfYbNpezupNb/Qj87cgFovo2
         tVzQMES42u/Jt6RVqLTuJ5InwwcWhIkQ6WYJhbcOFEo4ok2SephM2KwrBvjmjg1iXkJG
         MlAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791507716; x=1792112516;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cfdw+audQWp9HNvQGo23exvCo4IIEY6hjGNhPZtb1Is=;
        b=FRtj4d6NK/SwoyHfxTjPDLb7CEXSd7q6cWDa/0LLLZRorpeazRK0HscpxHiToIq+EK
         SB05uEyWuWtJTq2OPZOsL5slw/glKNSLn6bAorrDJ04zu3+yOrM2lMxSh1QyFjZFBBYw
         ARPSzybkN7IYqt2NR9IvGmooHVuZA0B3zUN21b0rSDoq0Wmhtfw26eSmrRcHM06fXSNc
         pfQBLOIeBF3XeJYC2f6753/8LlpcTslEidxOz4wqsiRegZPSIHIVNWswFuLFIbS5lbo9
         fZyVoXQLbM45JukiGmgd6MyYP51hHQU7je2ixb0IESglRYqJN+lLQ8Larw8UHQLp8X/h
         5E7g==
X-Forwarded-Encrypted: i=1; AKwUvBxfUX8ryBYB9NWUuriYUmil6ROCp37lsR27r8B7uxnxKePZ8AccVghcleiyZnuD2lXHJI0bYOfWo+w=@vger.kernel.org
X-Gm-Message-State: AFq9FYJkiF8+ESs2PwmskJ9YLA7o0YXGSANr/1SdcqAFSZa/5dqYujWY
	HSXc/ufLJSBuNHK5jnYOpHT9l+2JlErqLpRkXxNvg+MUZ4uOBAE/UH4ZQzURlDkFslE=
X-Gm-Gg: AYBFou3BldwunpjM2FV3feiu+QNGbD93X4wBcmhE13GEIfnAFHUWI6VLjeF2Ca4eo7r
	vQRlRRFBPUOpp8DTXErGiCPMbkEHPZMPdkoZq4e/IMkq5mYYqaWXiGyNIJoncbFkX9QM/UnrTv7
	sMh1B4VppX4D7dxUGayWqsUxcZjFUPrScMwv4xW0p2La2/iizoWVAa39GwFwWknPskgJPMUjOSv
	0UvqHpqUpXAllbpEMNRyHmKwmd4FiE3Ha5o20/PMQXOvTX3ab3QO6FSQEUopgJ/WXbl1RQ/yuW5
	5zhXu+eV1tIUnLEu70B7sE8FyAON1vDrmFRwEflGMdgVszd6I1GDXNLGfAhXFg7El8sshJ87ymm
	3w4sFdcl4qZ7WQSb/rDgNPnFDd0fc0gkTv/WzJeCsH80S5/4B71BLgctuHA5qpmEPhMsfJYhlJE
	kSNXOejJI/n2/cVqreWZEbL4oA4uG4aES8iWoKuI33GTg1cctPjJ1rXSVqQ+LHDqu+yN8x0dsna
	Q==
X-Received: by 2002:a05:7301:71a4:b0:351:8d12:8d51 with SMTP id 5a478bee46e88-3537e029678mr656518eec.12.1791507716097;
        Thu, 08 Oct 2026 18:01:56 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cad9e53sm1828189eec.22.2026.10.08.18.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 18:01:54 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Thu, 08 Oct 2026 18:01:51 -0700
Subject: [PATCH v2] Revert "i2c: xiic: defer RX_FULL until all trailing
 bytes are in FIFO"
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-i2c-xiic-block-read-nack-v2-1-76735ed0b0bf@nexthop.ai>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBREf4V07TW0CBRX/odh0cdFrpqWtEgwh
 H+3YFy6m5PMzFlYxEAY2TlbWMCJInmXQBwyZnrlbghkEzORi4rneQ0kDMxEBvTTmwcEVBacSsk
 KXRelVtbagqX5ELCjeb++tl+OL31HM25/W6OnOPrw3t0T33o/jfyvmThwaE5SCtVVWDby4nAee
 z8cFbF2XdcPj+4utNMAAAA=
X-Change-ID: 20261007-i2c-xiic-block-read-nack-d2b735baddd3
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Siddarth Chilukuri <siddarth@nexthop.ai>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791507714; l=6106;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=VvsfpHaXhPNuOESsbmKbjgRvCxu9b+24W1f2Ek0pgic=;
 b=/KyL2DEQwNeonF4R2JIRTXoPa/R37jOZKzBl58ZI/KbkjAxzRoUZW15Fu1AHYWej2PQxpNhaU
 /VCjW/w3r/xB4GHtakMz3rYqKCPkhGfVPvwld0UWk/LLDV0xLnscUNd
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=

This reverts commit e6fe3ea04f0113fe4d47c03d76e03805a4768ca7.

That commit raised the Rx FIFO threshold for an SMBus block read whose
trailing bytes fit in the FIFO, on the grounds that firing RX_FULL with
the last byte still in flight made xiic_read_rx() NACK, and so truncate,
that byte. NACKing the last byte does not truncate it: it is how a
master ends a read. The byte is still clocked in and is drained on the
bytes_rem == 0 path that follows, which also issues the STOP.

What the higher threshold does instead is skip the bytes_rem == 1
branch, the only place that sets NO_ACK, so every trailing byte is now
ACKed. Having had its last byte ACKed, the target goes on to drive the
next one, and the STOP that follows lands in the middle of it.

Some targets ride this out; others are left wedged until the next
transactions clock them free. A TDK FS1412 fails the two transfers that
follow any block read, so it never probes: pmbus reads MFR_ID as a block
and then VOUT_MODE as a byte. A Renesas RAA228246 and one RAA228244 on
the same controller fail the plain block read itself and the byte read
after it.

With commit b7e6df2f52ed ("i2c: xiic: preserve PEC byte length in SMBus
block read setup") and commit 840d8acc8792 ("i2c: xiic: don't clobber
msg->len to signal block-read completion") in place, PEC block reads
pass at the original threshold. The PEC failures the reverted commit
attributed to the threshold came from the bugs those two fix; all three
were developed together against an ADM1266, which rides out the extra
ACK, so the regression did not show.

Twenty rounds per device of a block read and a PEC block read of MFR_ID,
each followed by a byte read:

               before                      after
            block  PEC   byte after     block  PEC   byte after
  FS1412    20/20  0/20  20/40 fail     20/20 20/20   0/40 fail
  RAA228246  0/20 20/20  20/40 fail     20/20 20/20   0/40 fail
  RAA228244  0/20 20/20  20/40 fail     20/20 20/20   0/40 fail

A second RAA228244 and an Infineon XDPE1A2G5B passed every round before
and after.

Fixes: e6fe3ea04f01 ("i2c: xiic: defer RX_FULL until all trailing bytes are in FIFO")
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: stable@vger.kernel.org # v6.3+
---
A follow-up to my xiic block-read series, now in 7.3-rc as
b7e6df2f52ed, e6fe3ea04f01 and 840d8acc8792. The second of those
stopped NACKing the final byte of a block read that fits in the Rx
FIFO, which leaves some PMBus targets wedged for the next couple of
transfers.

Tested on a 6.12 kernel carrying that series, against an AXI IIC
controller with an FS1412, RAA228244/RAA228246 and XDPE1A2G5B behind
it, using plain and PEC block reads and the byte reads that follow.

The same happens on a second board, where two of four ISL68225s behind
the same AXI IIC core fail plain block reads and the transfer
after them. A capture of SCL/SDA taken inside the FPGA shows the
mechanism: after the last byte of an MFR_ID block read the master
drives ACK, the target starts on the next byte with SDA low, and the
STOP the master then attempts never appears, leaving SDA held low. With
this change the last byte is NACKed and the STOP is clean, and all four
pass.

PEC block reads do not regress: 1000 PEC block reads of MFR_ID per
device, each followed by a byte read, on the FS1412, both RAA parts, the
XDPE1A2G5B and a further RAA228244 passed without a failure, both with
this revert alone and with Siddarth's patch on top of it.

With this change a block read ends with a NACK, and so with TX_ERROR,
like any other read. That puts it in the window Siddarth's patch closes,
where xiic_process() sees TX_ERROR before RX_FULL and resets the core
even though the data is already in the Rx FIFO:

  https://lore.kernel.org/linux-i2c/20261005-i2c-xiic-rx-fifo-v1-1-0177ac5f72d7@nexthop.ai/

The two touch different functions and apply cleanly to v7.3-rc6 in
either order.
---
Changes in v2:
- Revert e6fe3ea04f01 outright instead of moving the threshold back by
  truncated), and with b7e6df2f52ed and 840d8acc8792 in place PEC block
  reads pass at the original threshold. The code change is the same
  single line as v1 minus its tail == 1 branch, which could never run
  (Siddarth, Sashiko): reads with fewer than two trailing bytes are
  padded to SMBUS_BLOCK_READ_MIN_LEN first.
  Sashiko review: https://sashiko.dev/#/patchset/20261008-i2c-xiic-block-read-nack-v1-1-94882af6e598%40nexthop.ai
- Link to v1: https://patch.msgid.link/20261008-i2c-xiic-block-read-nack-v1-1-94882af6e598@nexthop.ai

To: Michal Simek <michal.simek@amd.com>
To: Andi Shyti <andi.shyti@kernel.org>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
hand: that commit's premise was wrong (a NACKed last byte is not
---
 drivers/i2c/busses/i2c-xiic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 5e397a7e63f6..76ef9c26ed57 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -569,11 +569,11 @@ static void xiic_smbus_block_read_setup(struct xiic_i2c *i2c)
 			i2c->smbus_actual_len = 1 + rxmsg_len + pec_len;
 		} else {
 			/*
-			 * All trailing bytes fit in the Rx FIFO. Defer RX_FULL
-			 * until every one of them is buffered, so the drain
-			 * takes xiic_read_rx()'s bytes_rem == 0 path.
+			 * All trailing bytes fit in the Rx FIFO. The widened
+			 * condition above guarantees rxmsg_len + pec_len >= 2,
+			 * so this cannot underflow.
 			 */
-			rfd_set = rxmsg_len + pec_len - 1;
+			rfd_set = rxmsg_len + pec_len - 2;
 			i2c->rx_msg->len = rxmsg_len + 1 + pec_len;
 		}
 		xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET, rfd_set);

---
base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
change-id: 20261007-i2c-xiic-block-read-nack-d2b735baddd3

Best regards,
--  
Abdurrahman Hussain <abdurrahman@nexthop.ai>

