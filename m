Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B303B6340
	for <linux-i2c@vger.kernel.org>; Wed, 27 May 2026 20:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779912617; cv=none; b=WV4cRueoz4mGTCZkEMWG/IFpMKFnIOS+bDefnWy5Sovj+F5AogW2OWylQpqrTjYoAMoILwyK87qQ7zSO7JIcd4bY6ajikcu86aQ+9x6igTnh9LfniZr8RuMTWHPKJkIM/WGmtFESQu1pdw85n7aGVp0i9XMTOIdHS8B9AOYCcoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779912617; c=relaxed/simple;
	bh=znQoNKFpKH+T9cooha3b3mPmhi78mBH5UqoBp7OvjfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NZ/eOui/sT0ls9RLd4UeOFJAEXUn9kEbCabAhhUNJeujH83bmzkILF8jA8/6mRmJaNhz+myXslQ8HcNZ0g2f7UNBn0wxtUimRnlkf9ELC2Usbg67L3If3IvqnWJZeD+gDcS6FoBllTvtvj8QGN9Wg9Qgq+nXvlZSEzo9rh2hwDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b=VpHmx4Dt; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b="VpHmx4Dt"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3664df32e91so13818869a91.3
        for <linux-i2c@vger.kernel.org>; Wed, 27 May 2026 13:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20251104.gappssmtp.com; s=20251104; t=1779912615; x=1780517415; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yJYlGop0TKEOKbzHRXHcyUDP0UgfdalyI8xtfUez22k=;
        b=VpHmx4DtHTGT53WkPw3KLtYau67nTgaoqKB8VbYXU0nIxCXB9G45C4dy95ykBFiqtt
         bpiB4xtPH31CcA7ckS/8E5MdGAMXrTZxQZMurc+c1JFnNevmsabFdMyb/f1yxWA9j4Qz
         u7izjEed2FXXSOaY03xyd1dj+boiYCRShJ+2w10PRLNTYHT3jXoCJf21DG3WpFpM03fK
         pgnkQJDVlIbZQSN3v/r2uM7n3wTyTJ3caNXISTAFOKFExQlp2OU66lFG5dLnLXWr3b7f
         xvGri7MPbtoKTIQDP8z5I9XIwVSijrmEl9LawNJGsIO2K5wySmIIh9eP2GAyJRqbgqjQ
         oCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779912615; x=1780517415;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yJYlGop0TKEOKbzHRXHcyUDP0UgfdalyI8xtfUez22k=;
        b=XB1gbJMV2jpRpS8GcAyZpoQ1D+X901RHfgy3ZSLdd4LV9UkLaadkQ4Wj6/zb4HS3ia
         Mz61IxrxmpLLeqieWhyRzcnljvdvpzjgmyRKXJwC4ica3JB7m7sfIxt3PV3vZPjoWE9M
         DTuKfVvBbA6bibPc0xzGABOjgbvfgUgLBg7vtswYdhitfDQWX2g6CRvHDwm/oX9S4BlF
         wl6j038g8sBcsbcl5vSTgC9koNCT6nWmpDVsi2syU7VzGsiCqpXISzwhUdSBPNo763om
         Z1kNGI8JntAsRTZnE8dNCYi//m/u6dKbJYhvepISPQQJG4TGBZJvSjPX5yJFucopakm3
         nGnQ==
X-Gm-Message-State: AOJu0YyNa3U0vOIDskDwKavDUN/nSmZsWOipPGhPBFv7ULEI0ZD7MTOE
	KE7c9cH02z6ZtlTGahiXGMnjHitdVFZU70PgKmStlLcXuXs5BFpzlPrISd3C03DTEdY=
X-Gm-Gg: Acq92OGDXVWI3Kb07IJOPWuDt+bn9jbVrmnLuBEd75c0sqWvTsx/0yihl65JL5b6Uvf
	y9JK6tynadnlZj6WONuaA8hBGhkFTPKCHUhfhsXtogYSYoTdwkSKHEp0c95IZMJ3RGQGEkqYaQ3
	HpEHXj7mngaLH7qEkUYoA8gK5mMMJP+ihL9TXHUmQmwewqn/9InmtqEvmZAmHALqRgO/P1hwTEA
	+wItwR1htDCwmjkX0c8ZmUxx+atTG1LJoGtNr2AR9aMimOeYDrkjyJXBwLrXh35lj/2H3TCgX2L
	BQz6R59LNZev7gEFsRe0/v2CcWRKbhrkHqHL6PQGmsDejWA8yp3O/t1VIRJz2rzPyk8tc8IcAJB
	5P1bwu4uSMm0H2XsCNtcoXAyFL1DTGR8n5yZKbFREwwq+tmnnV8uSOgKhajgxa9IAcIYLmyHvor
	ua5xcQk+8sLW4tutMpfWpcHD8tMz79lpyB/7PMWClTcu/oGm0V8cQfQS0UVUFQp2Oja6rlWAlHB
	M1RR7/kz6jbgXaLTYe24KgzuET2v2WZqQ==
X-Received: by 2002:a17:90b:4986:b0:36a:f623:83a4 with SMTP id 98e67ed59e1d1-36af6238686mr10835710a91.26.1779912615387;
        Wed, 27 May 2026 13:10:15 -0700 (PDT)
Received: from wakbuild.c.googlers.com (27.117.125.34.bc.googleusercontent.com. [34.125.117.27])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a71d9416csm21875253a91.3.2026.05.27.13.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 13:10:15 -0700 (PDT)
From: "William A. Kennington III" <william@wkennington.com>
Date: Wed, 27 May 2026 20:09:51 +0000
Subject: [PATCH RESEND v5 3/4] i2c: designware: Convert platform driver to
 use shutdown hook
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-dw-i2c-v5-3-3483057f8d67@wkennington.com>
References: <20260527-dw-i2c-v5-0-3483057f8d67@wkennington.com>
In-Reply-To: <20260527-dw-i2c-v5-0-3483057f8d67@wkennington.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "William A. Kennington III" <william@wkennington.com>
X-Mailer: b4 0.14.3

Convert the platform driver to use the new i2c_dw_shutdown() hook,
allowing the controller to gracefully NACK controllers requests during
system shutdown.

Signed-off-by: William A. Kennington III <william@wkennington.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 3351c4a9ef11..da2babd6188b 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -289,9 +289,23 @@ static const struct platform_device_id dw_i2c_platform_ids[] = {
 };
 MODULE_DEVICE_TABLE(platform, dw_i2c_platform_ids);
 
+static void dw_i2c_plat_shutdown(struct platform_device *pdev)
+{
+	struct dw_i2c_dev *i_dev;
+
+	i_dev = platform_get_drvdata(pdev);
+	if (!i_dev)
+		return;
+
+	pm_runtime_disable(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		i2c_dw_shutdown(i_dev);
+}
+
 static struct platform_driver dw_i2c_driver = {
 	.probe = dw_i2c_plat_probe,
 	.remove = dw_i2c_plat_remove,
+	.shutdown = dw_i2c_plat_shutdown,
 	.driver		= {
 		.name	= "i2c_designware",
 		.of_match_table = dw_i2c_of_match,

-- 
2.54.0.794.g4f17f83d09-goog

