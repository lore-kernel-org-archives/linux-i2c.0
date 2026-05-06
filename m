Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9678178F3A
	for <linux-i2c@vger.kernel.org>; Wed,  6 May 2026 04:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778042906; cv=none; b=LzuuDhAJ1lIYKXfJqWsFjMM0mf3IT47UEboJDTvfhNeUSqYVlRAx46KsK2abkq46uahUf+U7yZrxLdpPX/BRXrMFekCpdt63D3UUPS2zVlcinQjVbpD+pIi+NxAhHh9HeBkmczJ+DrgjVcVEgH3hOO7hfxAtvjVvMVzw8J/z0bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778042906; c=relaxed/simple;
	bh=q6MCnjjiiAA6XEBjXoX7t110UPkBrtsvcKObX5TlmwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=odVuHuTgZ1ssFo/0EFK6yItjGsJfdHgxS03cERYihOyQYk0rKwd/2xgj548v/eNK6giDX0JoTuKYrcxHHWkQjmJ2AYOzVWYL+hBYN8g2aKZhmbS0f1C6hykvfTSMA3nE0Tom8I3aVIEK3T84px7DVNurZzHBC9bIKUYR4iDKYFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgROnDw9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgROnDw9"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so75405095e9.0
        for <linux-i2c@vger.kernel.org>; Tue, 05 May 2026 21:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778042904; x=1778647704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7WpJ1AVTNAxUwDumuBHKlCo6q9UU+vYNT76TcKLCKYI=;
        b=LgROnDw9JbVdxNi+WQW4T1Pox6N9bpwx9R2DzW3onf7jCDPI1bOQKaQZAVK1SBiKRn
         Zl80AbiwEuzfNDJ4BadoknyTpAd3JbuVo/WEV6HHgcAZIV17ZflGKUzlmZnp1AoZnH22
         WEfjN0Y7dgNp61XAiCqWv5bj1MosH1A+wd0FwriKl/2smwErZaM0EOZVJQEajhX4OBbD
         tQ5xF7qme52/WIX/n+hipDxCSn4StzfyuSDEhtOC6tZV9+VMYiUBOXDAZ8/r+hJ5qnOw
         LrFZZ1ppI2fuDeYA8f+xpaL1x9YTAKO/qb52zbmqu6Zpi/Iy4MTYgKS7acapVhB72hBa
         pGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778042904; x=1778647704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WpJ1AVTNAxUwDumuBHKlCo6q9UU+vYNT76TcKLCKYI=;
        b=ocksVUItLCigcaQXiWD3uqYyxftOFV1BzBa9cCtVFyvoNg6DknT0peqrY4ocFQ+g1e
         e0CitqdPMN8NsRyUzSCTlxm+5lEv8nCS+ZVVTAVx59mExtqkcIzPxn+ik+fdyFoS7f+3
         /tKfDaqpPGIQqhT3DMmoKb2t8tFtn+uZk6RnZ/yxAcWWXAAeS3PBNnebtWJnzAeaAbl/
         8HIbGz8KDqNxBlxDSEZioVuLXZk52zDAyYSB5ZZxNrHwXwzxpukkivoNKztwzT61DlUh
         b+9GKY/cHtoxMrxCyS2epMR2xAs9GyKoN/Jxvd69yaCIJaq26Qwlmn/dP4qQD9cLGCn0
         x6cA==
X-Forwarded-Encrypted: i=1; AFNElJ8LusDGhSgiW25OXHMrS5eWNHXySzgXvWk1C6gzAh3IUwo1dmk1ZTRcmTw5fHGgca1m7WJr+mFrmAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YynWnNpHl5xvC30joKN9SA76XzMteCPP6VrT2wDbe4Ovymqur0M
	gveB6RFvjCcxKAHW2wnyfEAx9FgY7cDX9/kWcQtoyminZTg32Iwgf4UB
X-Gm-Gg: AeBDieui5MPCpo6Mk4VJCjyq4JKGQKN1U12ndjWdiFsb4mQS0G6ODWhzp2ZUMCagn+5
	p5Fmbw5EysdDUNXY8XS3E24P4tAziwBuESTU3uGCcr0JH17VsutAaHT+QhSTQBK+U6Ww3DiWTWX
	/O246FTmKZlBx4JXBlYxIIdSoxs/sXdx3qOedi5eoEN8aFieqK4iJJtpGOvAyXirB+QkD6HQl+Z
	ICi/m5jmDlGw49/1zx8xdgSOBMn7m7frcV05A8/jR9uJVlsOExLUeKC5ZJuHKVGcu4wUnzpnuOS
	pSIzkOoKfWqOsMtZDmpOsDAjuC6qwGGlhAcQhe4Nli/+8Htl5SntR/kRSHpvafFtDHxZj/yapG9
	GdmqBxtz+0sz1jbORAX1gRSZlunKD3zzuH04t/wTbs7L5sy0hG9RJ/q+eLh5Tlc9gu5ukQJ1eby
	RcokhbcJnoDAWkVZRlxid778l2OF/Z6hlKoRRdw7XSgF9cgd9in5sWpLPKgz/Lga9K1gwDhdMkA
	DFOaKg1Dm3Cjx1l5nej0g==
X-Received: by 2002:a05:600c:3b17:b0:489:5022:39a4 with SMTP id 5b1f17b1804b1-48e51e20705mr26763075e9.9.1778042903769;
        Tue, 05 May 2026 21:48:23 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538a547bsm18974335e9.5.2026.05.05.21.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 21:48:22 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] i2c: ls2x-v2: return IRQ_HANDLED after servicing an error
Date: Wed,  6 May 2026 05:48:18 +0100
Message-ID: <20260506044818.19842-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The event ISR reads SR1 and, when an error flag (ARLO/AF/BERR) is set,
calls loongson2_i2c_isr_error() which clears the offending flag, issues
STOP for the AF case, records msg->result, masks every CR2 interrupt
enable and completes the waiter. The handler then returns IRQ_NONE,
declaring to the IRQ core that the device did not interrupt.

That report is wrong. The device did interrupt and the handler fully
serviced it. Because the IRQ is requested with IRQF_SHARED, the genirq
spurious-IRQ tracker counts each error as unhandled. A bus that emits
sporadic NACKs, arbitration losses or bus errors will therefore march
toward the spurious-IRQ threshold and the line can end up disabled,
wedging the controller.

Return IRQ_HANDLED on this path. The other IRQ_NONE site, taken when
neither an event nor an error bit is set, remains correct.

Fixes: 6d1b0785f6d5 ("i2c: ls2x-v2: Add driver for Loongson-2K0300 I2C controller")
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/i2c/busses/i2c-ls2x-v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-ls2x-v2.c b/drivers/i2c/busses/i2c-ls2x-v2.c
index 517760d70169..9df73557ecc4 100644
--- a/drivers/i2c/busses/i2c-ls2x-v2.c
+++ b/drivers/i2c/busses/i2c-ls2x-v2.c
@@ -304,7 +304,7 @@ static irqreturn_t loongson2_i2c_isr_event(int irq, void *data)
 	regmap_read(priv->regmap, LOONGSON2_I2C_SR1, &status);
 	if (status & LOONGSON2_I2C_SR1_ITERREN_MASK) {
 		loongson2_i2c_isr_error(status, data);
-		return IRQ_NONE;
+		return IRQ_HANDLED;
 	}
 
 	regmap_read(priv->regmap, LOONGSON2_I2C_CR2, &cr2);
-- 
2.53.0

