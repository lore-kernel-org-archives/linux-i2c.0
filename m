Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ED33A4F51
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 07:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485594; cv=none; b=ojqqjueWYKKDMSHI/Iwv9gH0VgCPNtjLOzcbgOfLzAgKkgtm5+ZeYwkgZuqb4epEc2CcxEzHM06ZxBeQSQYJGrwSi71mVwUG9/dUN05pXMnUGP0yBG0b5+MmFcPXAONe8XdHcHU4Zgc+Qb18C77gOThZTZDVHEkBw8lRKHPq5jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485594; c=relaxed/simple;
	bh=WbRNSgR6fF75ujIFRpZT+WIk0CWNPjAlMacuue3U6KE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uhIUmhstUYq10o7ZfjePLXdrVnbXziywLAf+tfMBlBk2uZUdcMoWY+fxv0aXFMnnsNNuYsl9J2xpI7nfyH7wKVH/Drm2LS0r5B0Ms+AmnGp01vVRrs9zJdGLE4N/L9n3qIYQBpyBPWcSn3kYyvYX3bHt1YrBMxC5fGEz94RrBSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=I6kyPiil; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="I6kyPiil"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so10097675eec.0
        for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 00:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1778485585; x=1779090385; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wErO40OAlXA0m7VCC6f5qpf//Pf9vFknfGugsyxSfv4=;
        b=I6kyPiil6x4HbUnOn6duJGGHVv/TK4DuJf/IFFx1P97/p/i0IKH0gsmex1CPhUXGMa
         Zz2FwxnOQBGWeT27B7LpJapqdcct3VKXFVaRka1I1i+PaYZcQZAUwkTKZcKdfgn8C237
         K3/BBl0U+GOxCIUMcO0DfVL4OXuh4Rf7suiKyg11StKxnRF6IESpQngVhLfi9pfbC4L9
         Uzioa5C8eF6BX0NV/BLLkrn4l8pxmFw/F7dugqeFd39DFd2EYCf4gqKcb2l3Z0U1JRWG
         XEaJIXJZmgduhAbeN3OLNzfFCqF2wuLIEka1Jc8SZNbOq14IYvX+OPQ73i5yazl9tg3V
         a3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778485585; x=1779090385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wErO40OAlXA0m7VCC6f5qpf//Pf9vFknfGugsyxSfv4=;
        b=UDj4I8mYCRf+onDKIOypJmoL4vtL4Ee27eFfL6cqReqGmtlKxkZei06VN1p0NtxbPN
         90m9X6qHaVfnXEUF1u/cbJto+1teWYHBARmRAfJDCml0fZR5jxQdKwgF3A6nBVQbrkLo
         UVJaprf3FyderUBUB/wPsNvM6lZ5le1IMLlg6oAMZPoYJabM46PISAf+rKcw/+SrytbM
         2y8LA+gR0AP480ArRM+oSmkTVzX5itX1xV5N12+PmglpbKD67CJM6hr/6VuN3+HPqV4e
         uLRG7FHO+bnj2AuGIBfIDiu8yF7np1L6LsWcAh80QmGIv/v6leMBv0+Zx62xQ/Uggfgz
         04iw==
X-Forwarded-Encrypted: i=1; AFNElJ+hRBw4Suno6poFiaOZs1ci/sTD0UK2WaTAjaIXXyYoL5s7/WUiYfTicToO+rKTO+LfkAyaomQzmyI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2rnO/oIwpIYkTtWYjcEftVVJSB+53nbOHG3isYF++ifNYDePC
	O59mKVs7oe0WEy7xyzRre6e3wWQ6Jh4koGGRRBW63HY5XDVhD1u6ohh1zQ9W+XhNo3g=
X-Gm-Gg: Acq92OG1M1rcYNb4U3XhHM6UBrnHDu1/2G/CKqDXbgfa47JYt0E9/llC7FT4tOwcen1
	kW6M8J91taYd8ZCicn5f1pHwgAMSY51dBvURePNd5SsPjGJzPbKIQ6iTP/WY20HdDcc/Ssbzys7
	HmI1VPMFhKszleXefrmH/HNimCP7Wk/68BOe5CgxQIt6qjAJE0mNS2/rVnd6YMyTyMYrb5GRpLX
	ZnOPMzI3j0xLdMYRfEV56nHE+AeL1P0g9yZFWyKQ1beoU0FtwAo8w27cj5yfYUb3DnYBt3HxAc3
	OjY9JOGFecVDdTKtNkyCyFj4lBsV7ikgUFeePCMpCDcyBkSedqOYfVIf7cuaRESv/itArz7bOeu
	Drvj8kh8IqY6rNbECW5x+cl9qt3iezuUG+SYDzbJqzAEJvzjU4TTZ8DRivlSdS+osPXG6u0XTVX
	FSTDtmIZJwQmOKpHGoHmsfhGI0JQ==
X-Received: by 2002:a05:7301:578b:b0:2df:7fe3:96a with SMTP id 5a478bee46e88-2f545c976a8mr11709144eec.0.1778485584615;
        Mon, 11 May 2026 00:46:24 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888e381c9sm12205702eec.26.2026.05.11.00.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:46:24 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Mon, 11 May 2026 00:46:12 -0700
Subject: [PATCH v2 1/3] i2c: xiic: preserve PEC byte length in SMBus block
 read setup
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-i2c-xiic-v2-1-c16380cb1594@nexthop.ai>
References: <20260511-i2c-xiic-v2-0-c16380cb1594@nexthop.ai>
In-Reply-To: <20260511-i2c-xiic-v2-0-c16380cb1594@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778485583; l=2279;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=WbRNSgR6fF75ujIFRpZT+WIk0CWNPjAlMacuue3U6KE=;
 b=bHXgIxBPq/DfWG3LxVv/I1TZyOj4J79btpDvtIwXuTBO0Ws8u8ehEVZEILe7jCdUbb1OnVDKz
 n2XCDgSp0gzAUAwLKPexATrF9DHZFFJLSA2gM4gzPlMhOQiiItOoVOy
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=

xiic_smbus_block_read_setup() overwrites rx_msg->len based on the
announced block length byte, but the i2c core appends an extra byte to
msg->len when PEC is enabled on the client (see
__i2c_smbus_xfer_emulated in i2c-core-smbus.c). Before this handler
runs, rx_msg->len is therefore 1 + pec_len, where pec_len is 0 or 1.

Overwriting rx_msg->len to rxmsg_len + 1 drops that PEC byte from the
caller's buffer: the PEC byte is never drained from the FIFO and the
core's i2c_smbus_check_pec() reads the last payload byte instead of
the actual PEC, returning -EBADMSG even on clean transfers. Capture
pec_len before the overwrite and add it back when recomputing
rx_msg->len.

This is a pure bug fix; non-PEC behaviour is unchanged (pec_len == 0).
Tested on a Xilinx AXI IIC FPGA block driving an adm1266 PMBus
blackbox read -- with PEC enabled the full 64-byte record transfers
cleanly after this change.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 3e7735e1dae0..959a47b645a5 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -539,6 +539,8 @@ static void xiic_smbus_block_read_setup(struct xiic_i2c *i2c)
 
 	/* Check if received length is valid */
 	if (rxmsg_len <= I2C_SMBUS_BLOCK_MAX) {
+		unsigned int pec_len = i2c->rx_msg->len - 1;
+
 		/* Set Receive fifo depth */
 		if (rxmsg_len > IIC_RX_FIFO_DEPTH) {
 			/*
@@ -546,7 +548,7 @@ static void xiic_smbus_block_read_setup(struct xiic_i2c *i2c)
 			 * Receive fifo depth should set to Rx fifo capacity minus 1
 			 */
 			rfd_set = IIC_RX_FIFO_DEPTH - 1;
-			i2c->rx_msg->len = rxmsg_len + 1;
+			i2c->rx_msg->len = rxmsg_len + 1 + pec_len;
 		} else if ((rxmsg_len == 1) ||
 			(rxmsg_len == 0)) {
 			/*
@@ -562,7 +564,7 @@ static void xiic_smbus_block_read_setup(struct xiic_i2c *i2c)
 			 * Receive fifo depth should set to Rx msg len minus 2
 			 */
 			rfd_set = rxmsg_len - 2;
-			i2c->rx_msg->len = rxmsg_len + 1;
+			i2c->rx_msg->len = rxmsg_len + 1 + pec_len;
 		}
 		xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET, rfd_set);
 

-- 
2.53.0

