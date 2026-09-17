Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B5A4E06C5
	for <linux-i2c@vger.kernel.org>; Thu, 17 Sep 2026 12:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789647714; cv=none; b=gZJ0gDfyNDEOf7d4f7iooXAZQYSkEqcKjr53+jHpq1wJNaHijTn5+H3HXB/b1k6vIDdM1eC2gW1birzqX2ONeJuSlB2Vf01uHrmr6Nym1xTehfB09SYuiAtDJvlJZWohh2m2Q3B/X6aAJC8QD2B7gkHxrgN79OrCHo+4gIEdYss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789647714; c=relaxed/simple;
	bh=p+IXiJ+EE2Fjypax+gxoHE3ZHGysplGrD9n927sEoQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PxErPD5cFDQb6SHWNQk4QnZ6SwUT/OidZlwrOEjsWkk9WMiULSaKeeT25saYpJAJPwiK18dtfamTrpwNB8ESl/3NTbWFmiFr3zEhXUMrQu2CP9lS2wh755HoCVFX81AWjYPkcbyyMYjHaTJ1XMqYG3yyouMi+L+VacJ/zt1/Pgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=nLiaUjzu; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="nLiaUjzu"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912df756so5578975e9.3
        for <linux-i2c@vger.kernel.org>; Thu, 17 Sep 2026 05:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1789647699; x=1790252499; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hBTjOuIbpjCrSgc+53G/q1SlCRXTaO4XMWMEj7JJEBM=;
        b=nLiaUjzu8wf6gCJN+MpVFTZB35jrtNSrgdXW6L9Wpf617bT20by6KPOGVAOJXgoHGe
         7mRHIqVFSACTPs9GRNKQnbpazlr6Gij/mHQhDOgdQTJebF8I//EF1EPy3t+hhoHmPtOu
         9+AWEISmriiHd+R1u5W9CFTLm2FslTrqC46+WbKax9+cDHtt+Djt5YQo+dC1G8pSLn7s
         DVmMl700CywIkAWcblYYr1ynIux/Io3QwOq50iQoEDNAgj5ktYMPpTXBtftlq2A5VjAk
         9DWAw0pNNOKCW2EX3KphyEiuxoRMTZayY3xzWlys/x8gAdkrpiP0QV0U/E4X+vD1KZII
         iYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789647699; x=1790252499;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hBTjOuIbpjCrSgc+53G/q1SlCRXTaO4XMWMEj7JJEBM=;
        b=lSfmszt5fLCPuh5wH4XGFtbALkiQSWN5OBgjOfpV771M8R99lZaiJmLRj+driUagly
         +BTL34s7NoONFc9TxTA8FMF6/i4CHkEVfZ8sSAOr2c4ZcgiID8rXoJ+NrtskYap8W+ut
         9bnVAghzAzVYsjbPoXLqPa9kGrOdgjhaT/pWzE7D25yNV0mwGET1UYIY/Qb4ybkem60w
         9qiFd+Onbo+dYJiAvfHleukmptsEiORuJV8L3sPinCqOVM1H5T5CxbceYYtjdZ1xkaT3
         IClc42sm7R/ZlgyRirS5eqiRhUxNekGTr5/wH7z5PHvCWUVuB7TK5/n7DiwrJ5xRSEV/
         ntUw==
X-Forwarded-Encrypted: i=1; AKwUvBzevN9gDzq9lrbS04Uo2uaam/9GFr5wq5BDOHvbwxOVBXk8pnsvzGnKkkqsPKG7cvmOtEqoAlgOsQU=@vger.kernel.org
X-Gm-Message-State: AFuF++mN4tB6vG8CyQ17qS1fbMGlVB0Xr1uB03+BQx3tj4M+PUDCyxCB
	cjWvUC5TSS9UXYbsLM9rwBi8zQqlhEpZOFyhhSIFXK/qkYpjdEMRkv6R8wCe0p2ye8MRnN8DziE
	qBhaY6epXRQ==
X-Gm-Gg: AYBFou1JTNf0SSzfNkR5vAZXYogRC8i7pLztXcFA9Nn//NYhNKeKoWlhCjuTpSqh3ZF
	Sat+OQYmCw4rr6epGV3qQp3TxRuUHt/vRWynAe+Sd/Qe44PxuE5u6ajy434iOcyYY8H6EDSSZSH
	QPM+Z9bgryaV9MR0Tfv+B5dfsz6oV5+2iRcVtqdUWEwzp6IAyt761eCftsUh9YFcd5MV2hh96+n
	zYqM2C+7KtW0qHvHaIx5WWQWBhPg3v5viYT+q/7QP5pybDqsJJKlexPVtJmGSYaIWE6rJXmf+fT
	+tK42R2ToZZQHg0CuwmL/LkR1EGxwGJTzWYwso4qwym3qotXkafMrZjv42ahE/MDO0jG0TnPpbi
	G3XoYsLWOpatCBSdZA8l7fOPl5/8jQC8vkxwDdwHEdlETBosb5aKU2ljc11Cu9rZf0umEz1jjea
	9HzyPo6LU0NyJDYt2BtbrnuC1SxZYLpFqUVWRAV2iefQ2QKUtC9w+qn4Qgv1n+r6uiQXBlILdkg
	IObWaw2+K56X1wpFjzqoXkBZvrAXi2laT91z2XHWFQeeBTI21s=
X-Received: by 2002:a05:600c:190e:b0:49c:f4ff:e872 with SMTP id 5b1f17b1804b1-49eb7314d54mr75624565e9.5.1789647698761;
        Thu, 17 Sep 2026 05:21:38 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae. [2.51.220.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd1ce79csm81949715e9.0.2026.09.17.05.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 05:21:38 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 17 Sep 2026 16:21:30 +0400
Subject: [PATCH] i2c: rk3x: Do not dispatch stale pending bits after a NAK
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-rk-i2c-stop-v1-1-e6ad83d8c888@flipper.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBBA0avIrE3SdqHhKmJBTRkSpINIGndXL
 N/i/whCgUmgyiIEOll4XRJ0noEb22Ug5D4ZjDKFKrXFMCMbh7KvG3qvSNuOlLY9pGIL5Pn6bnX
 zW45uIre/C7jvB3WgLmlvAAAA
X-Change-ID: 20260917-rk-i2c-stop-ff0e17be017d
To: Heiko Stuebner <heiko@sntech.de>, Andi Shyti <andi.shyti@kernel.org>, 
 Max Schwarz <max.schwarz@online.de>, Wolfram Sang <wsa@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2125; i=alchark@flipper.net;
 h=from:subject:message-id; bh=p+IXiJ+EE2Fjypax+gxoHE3ZHGysplGrD9n927sEoQk=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWStvu3LHF2g33ulsnL7R2OZ6QF3zs/u2rRTOGtz+CQ5D
 +u+vQ0yHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEx19WGGf8aTBR7cs2K0+fjW/3j61vLEVw2u+pzG1kl7Wldc/L2TR5uR4ZyJlmP
 y/9DXb1hK9Ex+x3sE7VGaU2tq+W3m/nmP3aU4mAA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

A read that gets NAKed raises NAKRCV alongside the spurious START flag
which the controller sets on every read. The NAK branch acks NAKRCV and
calls rk3x_i2c_stop(), moving the state to STATE_STOP, but the leftover
START bit survives the REG_INT_ALL mask, so the state machine below runs
once more and dispatches it into rk3x_i2c_handle_stop().

That path finds no STOP bit, reports a bogus "unexpected irq in STOP",
replaces -ENXIO with -EIO and calls rk3x_i2c_clean_ipd(), which clears
the pending bit of the STOP that rk3x_i2c_stop() has just started. The
completion interrupt is lost, so the transfer only ends when the 1s
timeout expires, holding the adapter lock and stalling every other client
on the bus.

Return from the handler once the NAK has been acted upon.

Fixes: c41aa3ce938b ("i2c: rk3x: add driver for Rockchip RK3xxx SoC I2C adapter")
Cc: stable@vger.kernel.org
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/i2c/busses/i2c-rk3x.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index fcede9f6ed54..7629ea7b6ac2 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -507,8 +507,18 @@ static irqreturn_t rk3x_i2c_irq(int irqno, void *dev_id)
 
 		ipd &= ~REG_INT_NAKRCV;
 
-		if (!(i2c->msg->flags & I2C_M_IGNORE_NAK))
+		/*
+		 * rk3x_i2c_stop() moves us to STATE_STOP and arms the STOP
+		 * interrupt. The remaining pending bits belong to the state we
+		 * just left, so stop processing them here: dispatching them
+		 * into rk3x_i2c_handle_stop() would report a bogus "unexpected
+		 * irq in STOP", replace -ENXIO with -EIO and clear the pending
+		 * bits of the STOP we are waiting for.
+		 */
+		if (!(i2c->msg->flags & I2C_M_IGNORE_NAK)) {
 			rk3x_i2c_stop(i2c, -ENXIO);
+			goto out;
+		}
 	}
 
 	/* is there anything left to handle? */

---
base-commit: 0d9d0dbf2fddcff5859d623e90ca73c4054276e1
change-id: 20260917-rk-i2c-stop-ff0e17be017d

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

