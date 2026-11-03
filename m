Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694602;
	b=tELU0+8GFuusjzXcdfTSqCFh/wQbXYT+NmXbRlvKRjvMJKkSiME7YQyb+GggR+M577jB
	 zgAu88TPPRxu19HL4nvm8baMWdRo4XaslbKrRO1ydwLAT5Ilvle/GpVfehC0MOi+8SZUt
	 PftgRHBJqFWMyaDJ3bQErP/ikbWB8vAayt7LroFGBTrF7JwkaMMHZz4xglOb/BeSwrMhF
	 O/zJugLSUTMaaNSyVU/qFP1W61EyNczoEIA970AmNFVKSZcKI7Cp4Ut2hqF53zLTXrPV3
	 5/GGsJDXPLJgfIgBjAiR8130WcBGMJG97rkqvjDJEbo6Ts5g9h4++dxfAxdt4vigqhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694602;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=n9UzS+0yoynIRHmX7RFL35r5qc5ZU/OmMg2n54yvo4I=;
	b=dadEa8cgRLLdjMWVbVo65cGMsGpNMV6fVgLbmXzOUytTBUDW8udGN0nqbcgX47lgJMHJ
	 Rb8pqmLRxv3xbsNwzxBX62b8UETpTATZPT2zJrMCTs8/LZm8L1mJf+/R2PQ+vnCb2C7ST
	 Y2fUUOmscJOH62BU6JO+qn01qoj9cHlF9l7hNClbTbOiztxAkR+Y4zTmDHN6VO//8ehDh
	 du5NnySlMie8qooXvuzk9Kefym8Kd2fRe5s7aF/ybHAQD5D6UDWs9ZSs3PSaZMIffJPZY
	 fCHkmooD8JgPZHpgse5hozBGSt3v7AdgRuKOuZtWYK0q0dRNErvDQLeCCoq6hOgdl9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.147
Received: from esa2.hc555-34.eu.iphmx.com (esa2.hc555-34.eu.iphmx.com [23.90.104.147])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF11606D812;
	Tue,  3 Nov 2026 08:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAF11606D812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1793694608; x=1825230608;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=9ihnjzFxJvJl8h5oChA4G/zXh2wj+4MuoWnoqC0/TW0=;
  b=fLd5oducjhITP50ljOlMaVJW469l8bEdrhw1cMePbZWiyKm8tt2XnBpJ
   0V0oXvTHtG62TzV2F7ehwpnlUaOWJgMjx+YBBZMtWnXTEYtlodxjGr3LV
   sRHn2SKuI2/7VtqmhRGByFkafRZ2r4uCkd9/aoexyLft2R+CIKAOewXpl
   chq/uH6dNZzYFs0GY4kieoDasf4u3VAGCiCPSmU60rtF6lXMOBckCSf4/
   yX92EpYELBqf0oa/xpZIbBNMMgig9Yt5w5aHMydtboIrkmiwRWBsvQirE
   972q4DxQmRLaQD+Bv3B8/QckoDr7q1ktawKiSU78JdPUSxsvgJqIeCDZv
   w==;
X-CSE-ConnectionGUID: 934Ie9vNTzGq9yPtCoPvOQ==
X-CSE-MsgGUID: FEmvPFZ8SNe032lKFoIKRA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces01_data.me-corp.lan) ([146.255.191.134])
  by esa2.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 10:30:00 +0200
X-CSE-ConnectionGUID: klZl+CP9Rxy8oF4EFwvFXg==
X-CSE-MsgGUID: td+SdMnxQb2fLPb9q9wA+g==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.3])
  by ces01_data.me-corp.lan with SMTP; 03 Nov 2026 10:37:53 +0200
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Tue, 03 Nov 2026 10:29:51 +0200
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Tue, 03 Nov 2026 10:29:40 +0200
Subject: [PATCH 4/8] i2c: nomadik: change print level for fault messages to
 debug
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
Message-Id: <20261103-i2c-nomadik-fixes-v1-4-655c6af2cb70@mobileye.com>
References: <20261103-i2c-nomadik-fixes-v1-0-655c6af2cb70@mobileye.com>
In-Reply-To: <20261103-i2c-nomadik-fixes-v1-0-655c6af2cb70@mobileye.com>
To: Linus Walleij <linusw@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 srinidhi kasagar <srinidhi.kasagar@stericsson.com>, 
 Ben Dooks <ben-linux@fluff.org>, Andrea Gallo <andrea.gallo@stericsson.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Dmitry Guzman <Dmitry.Guzman@mobileye.com>
X-Mailer: b4 0.16.0

i2c-nomadik driver prints error message on every faulted message. This
is not a good practice, because in I2C a fault not always is an error,
sometimes it is the expected result. For example, scanning bus with
`i2cdetect` prints over 100 messages in dmesg (two messages per each
target address).

To avoid excessive prints in the log, change the print level from err to
debug.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 drivers/i2c/busses/i2c-nomadik.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index a3cef4b66190..9c7658148bd4 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -627,7 +627,7 @@ static int write_i2c(struct nmk_i2c_dev *priv, u16 flags)
 
 	if (!xfer_done) {
 		/* Controller timed out */
-		dev_err(&priv->adev->dev, "write to slave 0x%x timed out\n",
+		dev_dbg(&priv->adev->dev, "write to slave 0x%x timed out\n",
 			priv->cli.slave_adr);
 		status = -ETIMEDOUT;
 	}
@@ -661,7 +661,7 @@ static int nmk_i2c_xfer_one(struct nmk_i2c_dev *priv, u16 flags)
 		i2c_sr = readl(priv->virtbase + I2C_SR);
 		if (FIELD_GET(I2C_SR_STATUS, i2c_sr) == I2C_ABORT) {
 			cause = FIELD_GET(I2C_SR_CAUSE, i2c_sr);
-			dev_err(&priv->adev->dev, "%s\n",
+			dev_dbg(&priv->adev->dev, "%s\n",
 				cause >= ARRAY_SIZE(abort_causes) ?
 				"unknown reason" :
 				abort_causes[cause]);

-- 
2.43.0

