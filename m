Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694600;
	b=OIFcLybFrKePvSrrs5gTWyr8PW97buy3kQxwRaI9hRDWHmN9ti4945ksultC+ax6UmE3
	 FwQVfI+xSH84IF6Pvy71NHOuwUqzfhbpKUdEjUTCp+83IvqX0qP7jz753YNeL1nbmUZkZ
	 b6vV4hc9Oetvy1uBcvD27vdocgJtlDijYjugOgUjAN7bMiRqQNQZqfNCWbokgQMiddfR6
	 8bpPQnl8No6H8rKFUGSo6aN/Ha+YSp+1ViE5ihFE71hy0j9qKc+Ss1jYgTuvWaXMDVepQ
	 +ALevq4soPygD2TZuWLtdWQzoK3YcZehua/nGTNXF9EIJkEXQTxJNrYke9P+HSDFYPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694600;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=uw3KvG+PK8eM2CabI2O1bfrEegYb6WR8U15r7XjoD6o=;
	b=SZBiKlRugKDTXaG8fUAg8+HiS0YqbSnbfCdkq7/7JzAjb4VZ+kSDK32DLwBBCCnbNfsY
	 bAnUQPhAFNeInav/zejWPyiVvxJGySkJ4JzdbC7Wo03CMHUkgjGrkDXPuM2R9tiCVvVP6
	 LhHdAiRbJRdaiVhQSRGkjcsbIg4Jc22uOFYnP9RUbSauoAn8o9iyG05UMov8pIgI1lXdM
	 BHAtzX977aF/CmJrzl40aTIXaxL1onKNrIukWksK/b/lV8Hqh1jgJX3EPiVWq+vJ2c2S6
	 T1YndRu1IjwX22YcQjt9VQRumK+4m7zeTI8fF78dk5U3hGcLvROampdilVQ9hQlSMng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.144
Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FD6606A327;
	Tue,  3 Nov 2026 08:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4FD6606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1793694603; x=1825230603;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=UphLcdo9RHlivP4kKmdKbKimucYDRR+v25gGpEyZICw=;
  b=pc/BPG9QcQoRymeBfEmvjAVIEuPI0rT0Z7Q+cjV5BxNZilX6JZN6W1Lw
   T8kTj+DyRb7+2XGQ1VEol2BNmaiyX6PEbPa8FthdJroWDhtRiTIco9G4M
   objRlQzIZAjDnNrA6ONmkNemwUvQiOefHiTMDqvwHzAvK/8eVBaoowF6J
   jhmXrs7lgPiecYAnrm3fYXJMPKalzJ6htn8lTj85F3EuS3/Lzu6mVf2I1
   K+G2f0HxL0XjXsrQuwL4q5UpFUSsenUA78VmQ7upbtCAkECqOpecDB3MG
   z+R8HnYqItpQJK1kdkbS/PP5aRVP6W/wlAsdLkxW8wS+JpFcjwVuz2+8T
   g==;
X-CSE-ConnectionGUID: mkHVKEemQYKyShKrAcDMuQ==
X-CSE-MsgGUID: llb/BxV2RhKESl6Q7qy66w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 10:29:57 +0200
X-CSE-ConnectionGUID: Z/IpEXidQsevqic4iwnu5w==
X-CSE-MsgGUID: RFQ4CpKzSaWSVJGFKkqrYQ==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.2])
  by ces03_data.me-corp.lan with SMTP; 03 Nov 2026 10:37:36 +0200
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Tue, 03 Nov 2026 10:29:50 +0200
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Tue, 03 Nov 2026 10:29:39 +0200
Subject: [PATCH 3/8] i2c: nomadik: return proper fault codes
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-i2c-nomadik-fixes-v1-3-655c6af2cb70@mobileye.com>
References: <20261103-i2c-nomadik-fixes-v1-0-655c6af2cb70@mobileye.com>
In-Reply-To: <20261103-i2c-nomadik-fixes-v1-0-655c6af2cb70@mobileye.com>
To: Linus Walleij <linusw@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 srinidhi kasagar <srinidhi.kasagar@stericsson.com>, 
 Ben Dooks <ben-linux@fluff.org>, Andrea Gallo <andrea.gallo@stericsson.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Dmitry Guzman <Dmitry.Guzman@mobileye.com>
X-Mailer: b4 0.16.0

I2C documentation Documentation/i2c/fault-codes.rst defines fault codes
for different negative results in I2C transmittion. Previously,
i2c-nomadik driver didn't implement them properly - it returned
ETIMEDOUT on most errors and EIO on master arbitration lost.

To comply with the documentation, return the proper fault codes for
different conditions, namely:

- EAGAIN if arbitration lost
- EOVERFLOW if message is too long (>2047 bytes)
- ENXIO if target address is not acknowledged
- EIO on other errors detected by controller (for example, NACK on data)
- ETIMEDOUT if driver gets timeout waiting for message completion
  without any fault condition detected by the controller (for example,
too long message, or SDA/SCL line stuck on 0).

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 drivers/i2c/busses/i2c-nomadik.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index ca9366e09e71..a3cef4b66190 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -226,6 +226,18 @@ static const char *abort_causes[] = {
 	"overflow, maxsize is 2047 bytes",
 };
 
+/* Linux fault codes for controller abort causes */
+static int fault_codes[] = {
+	ENXIO,
+	EIO,
+	EIO,
+	EAGAIN,
+	EIO,
+	EIO,
+	EOVERFLOW,
+	EIO
+};
+
 static inline void i2c_set_bit(void __iomem *reg, u32 mask)
 {
 	writel(readl(reg) | mask, reg);
@@ -653,6 +665,8 @@ static int nmk_i2c_xfer_one(struct nmk_i2c_dev *priv, u16 flags)
 				cause >= ARRAY_SIZE(abort_causes) ?
 				"unknown reason" :
 				abort_causes[cause]);
+			priv->result = -fault_codes[cause];
+			status = priv->result;
 		}
 
 		init_hw(priv);
@@ -865,7 +879,7 @@ static irqreturn_t i2c_irq_handler(int irq, void *arg)
 
 	/* Master Arbitration lost interrupt */
 	case I2C_IT_MAL:
-		priv->result = -EIO;
+		priv->result = -EAGAIN;
 		init_hw(priv);
 
 		i2c_set_bit(priv->virtbase + I2C_ICR, I2C_IT_MAL);

-- 
2.43.0

