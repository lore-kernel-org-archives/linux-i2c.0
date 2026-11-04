Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793794277;
	b=dNO4341xbx0eKWq4k4+k6ULJ13fYrZ+4881NHth00ghqhzXAzvodm5P5og+8oaMQ6j+L
	 9O39m9MdAyEHcPWLzRakFD/95MCHAt/VxkUJran8YeZIz/KoLFrA01hgCPKy3Cl5GL7oF
	 BvB97etQP/0r5wD4jVy0bLMQbp+07XzlEcuDhbX3KIwISyE+Bh7HkH5rxvuTWGCqSOlN/
	 DBJcjdqB4jHAw/bldvOwOtGSL7NXgLb22aBsHo46KNyS4HI1ZL3SORmnIZgBXHUZIQDVQ
	 RrIVoSQAwyNd8ssU1pzvG2PkF7Yq2sxnTIirLLrSkvgXqkbjq+Yk21miDbbW0yCB5mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793794277;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/f5A3hR3Bm+usn2244B9GDUzSk90oqC+oGYIPpnfKec=;
	b=10hU2f9af6QZs/n8idyn7ditO9J62ifDwRExGkq9EIiDtSL6Mk4RFh/w7TAzjThNtUUS
	 d4AHweX7WO4940UA6Vcs/wLDZxVHeCRRB5Nm3VnNWoCJIC3gO3pMGLaQl8RJtQSKaMVmn
	 IX3vX0vhRAzpJGPUTcSe8iKFRv6Ic7jCg4mUXPaOM0RAx0Ivu7/21Y++jgjGS0PKDONXm
	 C6vako8pX8RV4nVipha4gItxwCtejNeAfuf1IX2KXGeI7EuWkon77zlE3SGlAik9xu9eN
	 KhlgRnQn0UwtM3sNFbqVLGvKOBkjHHh+j9OT0/KYK40E/4YtZBkliYlnOHVf9rd6x1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gndPHB8K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C9D606A31B;
	Wed,  4 Nov 2026 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gndPHB8K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1BF1F000C1;
	Wed,  4 Nov 2026 12:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793794277;
	bh=/f5A3hR3Bm+usn2244B9GDUzSk90oqC+oGYIPpnfKec=;
	h=From:To:Cc:Subject:Date;
	b=gndPHB8KuXtUVdAEjeHq+VK7vBVz5TBIJ0SP2svlUxclb5ES5qbzqlmr2ZqCGq+lS
	 s8rNm70hl3s/OP6OBzTapLtBZcR1GLxIJ3+t5QnuavyviANZ9uqbxgW1KUwAugygoc
	 EeI9K++Clc5XJVybgyEMJNCUQcvRZ0hmmp4bdqNJ7c3d11Wggq21aEaCulOdrILlev
	 +IsUrOB4GY9Scq5tV2ler70t0aXDIskR6k4Ja8/ipzPaj14bpUU4IIEJ/BIuNvMcGF
	 EvDJDODLhWn05YDlm1tVq4nNOpEm63CDOrVUZRRnyU3p03f2wJT4s4GKrIW7o/b4HN
	 Q5L0kmWVX3/5A==
From: Michael Walle <mwalle@kernel.org>
To: Dong Aisheng <aisheng.dong@nxp.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Carlos Song <carlos.song@nxp.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH 1/2] i2c: imx-lpi2c: fix SMBus block read with PEC
Date: Wed,  4 Nov 2026 13:10:35 +0100
Message-ID: <20261104121108.659820-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
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

If PEC is enabled, the I2C core sets msgs->len to 2 instead of 1. The
length calculation for the second receive command assumes it's always
1. This will lead to a short read and eventually a timeout because the
PEC byte is never received.

Take msgs->len into account when calculating the remaining bytes.

This was tested on a board which uses an IPMI SSIF BMC.

Fixes: efdc383d1cc2 ("i2c: imx-lpi2c: fix SMBus block read NACK after byte count")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/i2c/busses/i2c-imx-lpi2c.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index 7302464c371a..f57e800ac3b5 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -563,7 +563,7 @@ static unsigned int lpi2c_SMBus_block_read_length_byte(struct lpi2c_imx_struct *
 static int lpi2c_imx_read_init(struct lpi2c_imx_struct *lpi2c_imx,
 			       struct i2c_msg *msgs)
 {
-	unsigned int temp, val, block_len;
+	unsigned int temp, val, block_len, remaining;
 	int ret;
 
 	lpi2c_imx->rx_buf = msgs->buf;
@@ -612,9 +612,13 @@ static int lpi2c_imx_read_init(struct lpi2c_imx_struct *lpi2c_imx,
 		 * keep MTDR non-empty and ensuring continuous ACKs. Only update command register
 		 * here. All block bytes will be read out at IRQ handler or lpi2c_imx_read_atomic()
 		 * function.
+		 *
+		 * msgs->len is 1 - or if PEC enabled msgs->len is 2. Two bytes
+		 * have already been requested.
 		 */
-		if (block_len > 1)
-			writel((RECV_DATA << 8) | (block_len - 2), lpi2c_imx->base + LPI2C_MTDR);
+		remaining = msgs->len + block_len - 2;
+		if (remaining)
+			writel((RECV_DATA << 8) | (remaining - 1), lpi2c_imx->base + LPI2C_MTDR);
 
 		lpi2c_imx->msglen += block_len;
 		msgs->len += block_len;
-- 
2.47.3

