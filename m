Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B2C319610
	for <linux-i2c@vger.kernel.org>; Wed, 18 Feb 2026 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771427395; cv=none; b=GY0a4Vv4Cxc/lzE2VIwsc9OBqJWyLS9kxL68oLakGcn8nlF7A2bdQB8BJaLk1CAbC668UzLn38hrZYlg+sTafWZlS1oICLiwgNoNG6zVL1OsU2THQ4J5pgsVfWDXTYAGGG6y0I9fkvHL/mZBt9P6h9ZzWaE9DDONK7ngeAFS3go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771427395; c=relaxed/simple;
	bh=d0C2EuuXownzQl6U6rFAHJMKSwZtCyEBVouZSQ+2XTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ObIQjkpWHzZls3hbOaIh3wghiTgzoFz9BEb8eI7pOBVFQbXwPf6GvTLDf+Qwab5bjwzaLMeqpDj3gKYWkVA6HSA2V/aXp6iigYBEthmHVseQWI4vLW6ysU2Zai4iAp4KtuzZOpF9tgIzqPrAsPZ/OOnFV1ssYPBbIdxqPhaEfLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfWitjns; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfWitjns"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-435f177a8f7so5824842f8f.1
        for <linux-i2c@vger.kernel.org>; Wed, 18 Feb 2026 07:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771427393; x=1772032193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiGM3saLexQq7QJjFVEPfTJjnwZ/SSpdBYTl//BH56U=;
        b=bfWitjns0o6B9UUPYCzQ4EUjDwuuTCG8P369VfstxdAi1M7tkT8h2S+grY6EyERYjC
         2WiZ8CWNZgBlFI7wZbnc6yN+iPuqc9ux3qpNR2gFRrm9lNotXCfWCxu10XdCkOrJqk+8
         SV0BX+4ovK1e4c7uQf32TFcXwylLiS1+GmGLoyDSwm3guT1VdDuFsbogSzVLFe74I7Sy
         86w3ZV+xex0vTC4KCxSMliG4bHaUV0GXsw3nLRwZO9N3AMlJWEFOoLCQ527KrdGY+sse
         NW7MduVyThJW8EXOHmptr3nP0RaOLe5GezM0D7OWo6FixcTQHa8/BHiL3w64v80juBEp
         ycMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771427393; x=1772032193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DiGM3saLexQq7QJjFVEPfTJjnwZ/SSpdBYTl//BH56U=;
        b=qXC27NdK39C+QIoZC5CGdevg6jFt7fWg4zsHWCS6Bm7QS0aDUbALUoPu9hqVuRFYUB
         K7dVDpi5Qp6+3YX9xHKLxt5rdhOWK7ovwVXcQeP2Ln+PIvlhN9gc8GN9Tc5orYo4vQVs
         Xsv0DxtEMjh5qa0Km6aWwOPhMikZNfVbuhjTkB9TE5IIn1BwMD4SDPThDfBlw76XsNV2
         OCz603t8Uj8HpNUP8Eq+oBbjWrodSTKDpXkkgA74ZW2PPDT5G3isJhPdiV6rfvj3po9V
         6GpPXGGRGWetKXT/I6bdcPWsp5p4f+nvF0fZ/auHVtridtDWycqcATF9CuKGmJtTMdnR
         7G2w==
X-Gm-Message-State: AOJu0YyZVVNHG9Q8t7GEun4eI1nrOxwn7nkdw0u+b5QPwitZkALLdVuD
	AhTSNf+LpDydgU9TVYfumdYHJ9uiZxMdoWUj2knkzlan7hPb77MCDdC9Vx8RhQ==
X-Gm-Gg: AZuq6aI2RD0wve95PS/1qWjGwE06LcxrMfkk35X+LuzgFRSfesoDEAQtgOmSoGZUtFq
	UXxE6uZcmgw821hSbchMXwDWcllq6Cjo9ET1kCezYva/yygjxfdh2+Ycet0ND7qWsOEXF+NGBfq
	zoTOeDRxnrnZILqYs+OwHQxnhiaisstLWIqzvKfPbeTbk5efLGeqA33QTeiIwZgYvHT3WjIHUD8
	1YQBHjKQ1msZpA1aRHm4JV09ENFV1h7DB47kdMQNLca0KtyU14tlEUA5TwevZb/Izjfrw++Ien6
	aWPy6NBZOQiXdGeDjL7Y+WYPnsyLjQ986DYf0zeVFzyQRat9UZMrTwHEm5x/dBuypGLTgvkihNk
	qogEvbjEEDND4seFk/DVA5YZaeYCYqYf6hCESH8favG4ltqUKDGVljr5UMT6+VthoqZnYW6pHVq
	9tosLeBcoNkRw8gf8behLLEJqgsXMGQgS1c144XvpJgdG81riqDcQBF08deiY1rUNbJSuWyHDj2
	8RA4nBl0o4TmhUUfWy6CqKqKLd7czimZHHv
X-Received: by 2002:a5d:5f93:0:b0:435:e060:8071 with SMTP id ffacd0b85a97d-4379db61767mr23486335f8f.16.1771427392709;
        Wed, 18 Feb 2026 07:09:52 -0800 (PST)
Received: from eichest-laptop.corp.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac7d91sm44333116f8f.26.2026.02.18.07.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 07:09:52 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: o.rempel@pengutronix.de,
	kernel@pengutronix.de,
	andi.shyti@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	stefan.eichenberger@toradex.com,
	francesco.dolcini@toradex.com
Cc: linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1 1/2] i2c: imx: fix i2c issue when reading multiple messages
Date: Wed, 18 Feb 2026 16:08:49 +0100
Message-ID: <20260218150940.131354-2-eichest@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260218150940.131354-1-eichest@gmail.com>
References: <20260218150940.131354-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

When reading multiple messages, meaning a repeated start is required,
polling the bus busy bit must be avoided. This must only be done for
the last message. Otherwise, the driver will timeout.

Here an example of such a sequence that fails with an error:
i2ctransfer -y -a 0 w1@0x00 0x02 r1 w1@0x00 0x02 r1
Error: Sending messages failed: Connection timed out

Fixes: 5f5c2d4579ca ("i2c: imx: prevent rescheduling in non dma mode")
Cc: <stable@vger.kernel.org> # v6.13+
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 drivers/i2c/busses/i2c-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 85f554044cf1e..56e2a14495a9a 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1522,7 +1522,7 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
 		dev_err(&i2c_imx->adapter.dev, "<%s> read timedout\n", __func__);
 		return -ETIMEDOUT;
 	}
-	if (!i2c_imx->stopped)
+	if (i2c_imx->is_lastmsg && !i2c_imx->stopped)
 		return i2c_imx_bus_busy(i2c_imx, 0, false);
 
 	return 0;
-- 
2.51.0

