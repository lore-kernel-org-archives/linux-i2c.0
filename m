Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432A235F199
	for <linux-i2c@vger.kernel.org>; Thu,  8 Oct 2026 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791475364; cv=none; b=dCkq1dKPVE0VeRNJJV4I1NHkFyB2CnIE0SPM8svTFme/Xf4yeBa29Qdi68Aiy9JO4OC6q5DetKFFalXUiVOGa8K6gAZIAueN2+O29RwjT7nDJqNyJT3tvng8jgMV9GG1HcIq5G0Lk/1zvqkJQi0Q2CLW690N8cFF3st3uN9KyEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791475364; c=relaxed/simple;
	bh=1I3B0zE9Jl3k4SV939nOeTDGmvV7FCqaULnQQve9RFk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SF/78HUehE5fiMzADgo42r2JfhaTNwVgav1/pHeZnwMFwVRRDNvcJxcZsQyt3Y5iCF1lclZLYllqn0XXeLGfxjCY2zVIvVTBkjOH0CD8eJIHrcEAWGjLflXHl40EnoZoZaea0FdDsXMV1raE7zKwjbniahjG092V9PkvQL2jzKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=fA21ARmn; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="fA21ARmn"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d032846c95so27333805ad.1
        for <linux-i2c@vger.kernel.org>; Thu, 08 Oct 2026 09:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1791475362; x=1792080162; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=85BR7qHH4G0CBb5vxlCQpLUFJ3RuaLjxlde617uk3v4=;
        b=fA21ARmngWFTKNZTyIgU5t90upxl99EZIhrACLg0dyl2vZpePPYWr/i/9TMKBDr82j
         4ah4iBT9TzepMOAnWkKASXuwexqv04NrJBF3qn00zIyNcoFCJa756Ldh2GozIz81WLkb
         jFRomPB+2PodOEWzv3I35C4sttDSIdb/9fkxf2zYWQBDexe++hsKaUtyw9PuHWcbVcJX
         o1eZn++LdFkcOJ7n6AnH5NTFQrkbCu3PX4iGAWHDZBK2/6o1c24dCjnQceLeqlfbAQGW
         cXic4LbEbN9qRdUzHcRpm10L3eN4CqkbtE6Oo2vR7WH/JmgNgrddqkfy+RJ4UTEZbrOn
         QCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791475362; x=1792080162;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=85BR7qHH4G0CBb5vxlCQpLUFJ3RuaLjxlde617uk3v4=;
        b=JzGf3r9lSDQydj9tYeeEf2KYFmHAdNDXSEGqvbrVtPqVydhXNp+JNyO4nwcBFIph9+
         bD7EWKheavC8r2M1kZfRm5JvJlKpuXN7Xwqn3XYWAUryC0bJxK+EItBRybhZaghu/nMV
         JlNxfB7OHGIpsTxhbSy0goBhTqyASEL82wpBGPA29SPH+y6gO/Ke99c6rL6+oYDSHB+x
         QiWYMmCekPImyF3taHZYXxnFEcaRV/5OkcKtRVhfydskxSQ+5gX2c/49L3OF7Jq5HHH/
         EM5l73hff/gk0NWhTalcjgbDCg5gIUIGdVXm6PGbNf5PoWmwYSTzYirgSb5uDVPbfDdG
         eRgQ==
X-Forwarded-Encrypted: i=1; AKwUvBzD1ynLUONvCGicRygUtoQhlnfQmmFVPGUt+5pFDqJ5OWXykw06rr/31oyQrMIxUdqGgi6wCdjZkbs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIj9Zp2ERuUibySkucbeYYG/3WhxP0dLui49lAVjTV0yyTEwM40
	zNE71BV/ufRiK0ooDiRMtq6w/xnpWAdV57tdzTlhHCWfCw/WqmnB6PWkwLBdgIMCu7k=
X-Gm-Gg: AYBFou1fmOllpBq00Tg7lKwO1GjP9Yk3OC/Gz16GVeOVunaQW5JSDQiXw6enL36ELv4
	qdl7j1UUcjJZzddy5TQQgRXrRMgC3+lM2GlZQyoHy12AYtQXfO69L9acoBfOh3r8PxLrQ47VWXT
	zdiDy+C0pMrcjqOoieOY2f5MDLVhGGe6ZUUxSziDQ1JAz7AKtdF9XTOawf3GMj9Kbu68WMQjT7t
	u41xkSH3q+duHRe5thHsyr2wo/DOCuNZKQ6QPzPCykdb6Q5onyFcc1LytnTSUbCvtKIv4u4eGkY
	caYtFEiyk7pmpwpwwjpZUZJNrIgJd4bZp74eopVTXV8GZYjOK/mVsu49BOvyJUJWPaBnUmXI3IC
	GqwI+zDE+DGfJjC915cQj9r7T3wlr8lTfnMSasFUA30Lqb+xQUw5ItkNFC4zBZob5zst5SjMYak
	1qxMkuL0zZeiKxiLVc8h7n8ksQqQe0kOPXAd69pMgajaw46lWJL/bDNLTH69Ms8km+8Inw8Hgzr
	Q==
X-Received: by 2002:a17:903:2a84:b0:2e3:980:dfd6 with SMTP id d9443c01a7336-2e6004e9e7fmr50032605ad.38.1791475362381;
        Thu, 08 Oct 2026 09:02:42 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e60494c323sm27461895ad.69.2026.10.08.09.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 09:02:41 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Thu, 08 Oct 2026 09:02:38 -0700
Subject: [PATCH] i2c: xiic: NACK the last byte of an SMBus block read
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-i2c-xiic-block-read-nack-v1-1-94882af6e598@nexthop.ai>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBCF4avIrDsQIyr0KtJFMjPW0RIl0SKId
 2+0u/ct3n9AkqiS4FkcEOWrSeeQUT4KoMGFt6ByNlhjm9KYFtUS7qqE/jPThFEcY3B5sfVtVXv
 HzBXk+xKl1/1Od6+/0+ZHofXqwXn+AHNvzQZ8AAAA
X-Change-ID: 20261007-i2c-xiic-block-read-nack-d2b735baddd3
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Siddarth Chilukuri <siddarth@nexthop.ai>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791475360; l=4822;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=1I3B0zE9Jl3k4SV939nOeTDGmvV7FCqaULnQQve9RFk=;
 b=WCxGw45Y+qEC2HCOsv+UZ77Ta8l/WlwVssXmZA2am4P0cqqr8eMPr1NWWN5yHOfRg+bHusd3a
 4omlow0Y9A9BczNCaat7wN3FVEnQikLdXd1ANff9FGIVbAKr2Elz5GB
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=

Commit e6fe3ea04f01 ("i2c: xiic: defer RX_FULL until all trailing bytes
are in FIFO") raised the Rx FIFO threshold for an SMBus block read whose
trailing bytes fit in the FIFO, so that the drain takes xiic_read_rx()'s
bytes_rem == 0 path. That path skips the bytes_rem == 1 branch, the only
place that sets NO_ACK, so every trailing byte is now ACKed. Having had
its last byte ACKed, the target goes on to drive the next one, and the
STOP that follows lands in the middle of it.

Some targets ride this out; others are left wedged until the next
transactions clock them free. A TDK FS1412 fails the two transfers that
follow any block read, so it never probes: pmbus reads MFR_ID as a block
and then VOUT_MODE as a byte. A Renesas RAA228246 and one RAA228244 on
the same controller show the same pattern.

Program the threshold so that RX_FULL fires with one trailing byte still
to come, letting xiic_read_rx() set NO_ACK for it on the bytes_rem == 1
path, and set NO_ACK straight away when only one trailing byte remains.

Twenty rounds per device of a block read and a PEC block read of MFR_ID,
each followed by a byte read:

               before                      after
            block  PEC   byte after     block  PEC   byte after
  FS1412    20/20  0/20  20/40 fail     20/20 20/20   0/40 fail
  RAA228246  0/20 20/20  20/40 fail     20/20 20/20   0/40 fail
  RAA228244  0/20 20/20  20/40 fail     20/20 20/20   0/40 fail

A second RAA228244 and an Infineon XDPE1A2G5B passed every round before
and after. PEC block reads, which that commit fixed, still pass.

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
the same AXI IIC core fail plain block reads and the two transfers
after them. A capture of SCL/SDA taken inside the FPGA shows the
mechanism: after the last byte of an MFR_ID block read the master
drives ACK, the target starts on the next byte with SDA low, and the
STOP the master then attempts never appears, leaving SDA held low. With
this change the last byte is NACKed and the STOP is clean, and all four
pass.

With this change a block read ends with a NACK, and so with TX_ERROR,
like any other read. That puts it in the window Siddarth's patch closes,
where xiic_process() sees TX_ERROR before RX_FULL and resets the core
even though the data is already in the Rx FIFO:

  https://lore.kernel.org/linux-i2c/20261005-i2c-xiic-rx-fifo-v1-1-0177ac5f72d7@nexthop.ai/

The two touch different functions and apply cleanly to v7.3-rc6 in
either order.
---
 drivers/i2c/busses/i2c-xiic.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 5e397a7e63f6..2714fd2231b4 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -568,12 +568,24 @@ static void xiic_smbus_block_read_setup(struct xiic_i2c *i2c)
 			i2c->rx_msg->len = SMBUS_BLOCK_READ_MIN_LEN;
 			i2c->smbus_actual_len = 1 + rxmsg_len + pec_len;
 		} else {
+			unsigned int tail = rxmsg_len + pec_len;
+
 			/*
-			 * All trailing bytes fit in the Rx FIFO. Defer RX_FULL
-			 * until every one of them is buffered, so the drain
-			 * takes xiic_read_rx()'s bytes_rem == 0 path.
+			 * All trailing bytes fit in the Rx FIFO. The last one
+			 * must be NACKed or the slave keeps driving SDA into
+			 * the STOP. With one byte left, NACK it now; otherwise
+			 * fire RX_FULL with one byte still to come so
+			 * xiic_read_rx() sets NACK in its bytes_rem == 1 path.
 			 */
-			rfd_set = rxmsg_len + pec_len - 1;
+			if (tail == 1) {
+				u8 cr = xiic_getreg8(i2c, XIIC_CR_REG_OFFSET);
+
+				xiic_setreg8(i2c, XIIC_CR_REG_OFFSET,
+					     cr | XIIC_CR_NO_ACK_MASK);
+				rfd_set = 0;
+			} else {
+				rfd_set = tail - 2;
+			}
 			i2c->rx_msg->len = rxmsg_len + 1 + pec_len;
 		}
 		xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET, rfd_set);

---
base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
change-id: 20261007-i2c-xiic-block-read-nack-d2b735baddd3

Best regards,
--  
Abdurrahman Hussain <abdurrahman@nexthop.ai>

