Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6A2316184
	for <linux-i2c@vger.kernel.org>; Thu, 26 Feb 2026 13:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772111499; cv=none; b=S2pM5dVT6VGvgsteovx47dKJwZqi9rdyG7mSBFJFXqnqX6SFIqSeZzHdI3T4T5Oh51nXzQBKUM4pHlxDdTZuc1TFoYa/RJPhnkG/wRkIMB+6aEzv8YgAUE1exD6bDNaif+mM+z47p7eTc62YF3cOn6nVszTg0XtgrjY7xvqr92E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772111499; c=relaxed/simple;
	bh=0R1WoZ5pqlXLkimXuZO/hVP+ydmsIeNVMtvfxguyoe4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=a5BdXtaDrIaRIcKuSk1I2dTM2Sji3o6Fkl2mgIm9rxO6gRnCssKV/fUNtznh4Dz2yqMWcR62K353d7ZKo/BXYLms8uqGlr8AobZftbrY8yG8PY4NECdfjfW2jza0tZVRnyE/laLZbluEmZkcumFSH8yx2W9MhKL2iquOlbrN9UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kytDZLgU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kytDZLgU"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so9562865e9.2
        for <linux-i2c@vger.kernel.org>; Thu, 26 Feb 2026 05:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772111495; x=1772716295; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RPnwn7qk3luW4iML714eLyIf29N08tbW9a1oS6Qc5EU=;
        b=kytDZLgUcQ2DtCvMAn0RdWolHA7V5DU3tNee4Vpzpa340bXDGv3SijKxK9uVJhNDaP
         pY85SYEQ7l+A7XU9S6JzbYQB8c/ODTBBKJixHYhWI/gyAQLEECXEuOdmvqsDiS+7+eir
         f6uvvzXNDcMxSG4jAxXXKwB7AJGNViusbFW49CnxBlNYZyNM6Q5l5BIRZqKzgK8D+Wu9
         ZrN4la2Gx4qEl1GcVKlwwph7raClu8aSXRSQKOih9NAE98g7V0dyBK4SrSWoJZpvoHdZ
         Mg3ffqoxCec+ASUd4HS0x1ioWVoIggLvJEIWoo4eoEnjPKIHWK57Rzaj690dCOXMysYs
         VTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772111495; x=1772716295;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPnwn7qk3luW4iML714eLyIf29N08tbW9a1oS6Qc5EU=;
        b=sN6wCT3k/eNXvhI8pePt1Js2oVdGIVI0BAyVDP+CfGd6pCvXNwc/FE3OX8Tby0gQca
         ccVLMx+xOnxqTxAPGQ0W4ahsypyMs4Yp3Gq+LETX8yfaexymBxpfcrPM0YRyoLe7Moln
         kaXdhPh6u0Isq0hQ9Y17hPoimzEh7nDpqIORPnLrdPR+LE3lTjiD+T7fyo17iZQaZJlH
         JVSWvAPPOcn3KGymHbl8j2S3NBBOPQ9+ngdL4Ua+kNvkeMQb8RaPLXc4zsjR7E07Av+i
         g8vQB7tBUgKkMgYKXBVxZvWY6T99LvaR1dE8oF5/WNJObe56D1ILq5m+fYnOhrPuxM1D
         rqxQ==
X-Forwarded-Encrypted: i=1; AJvYcCURpsFqFFrM/vlpMdtCjKDlUTQBEn6m5c2xrfD5R4NdKIT6j2y/EEtnu0GNRN0yVo6Iir09croIdsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvTSTPk6GkWjhQ43nIOx8Y2rl/2/68zENqBVPDHj1J+rTsEbwv
	RnbNtnKG8ivAk97DcKMBcAVVeMFv3TvMiIFL9MHj3GRSzcCoy0r+WE2B
X-Gm-Gg: ATEYQzzHasClY5JhU4HBkVWjo9kRMI+q/+BusuII8dQ2jeqzlisfygVHnmcFld6MXuA
	bF0mgARdGdPfbS6fKhKuH6RabXCaIW04dplOMCfbdgbXuDiJq4CUm86UyRQEBMPL1kk5tkvnWQ0
	12NiSLNQ8MCEnzKVhDyMri8HBUIdRtgwtRRxFGpz2PPufDh9h7Tg8Bm4d88IQS8cSaI+9yU1xqa
	3WMyjB1McVWwqQlVzPbyHW+KLm/aVN0kf6UP3j3o5T4xOoI0pohiaJyJxtjgl5eEEpUUvnpLzce
	qEskvE/onHM1TVykA4R9/ibRWmAk4EnEb7NsvEB6Te8IoxgTTg/ONAMXUcjQpC/4pz9vvRJpaXF
	Whd2oGlnjarFr5pxHc1OnuvLSGtd0ZOh/Cc+QqmwlXGqr3bjO4HJ93Hcs4ZQCE4CmX5RcCp8i4Z
	7+vdebbtFOyH9pkUH7JENCqJZXt8ibjXXQIE+PPr/ofcUm4EC+SQd5
X-Received: by 2002:a05:600c:5250:b0:465:a51d:d4 with SMTP id 5b1f17b1804b1-483c3db3180mr31418995e9.6.1772111495342;
        Thu, 26 Feb 2026 05:11:35 -0800 (PST)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-483bfb789efsm64827145e9.2.2026.02.26.05.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 05:11:34 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Subject: [PATCH v4 0/2] i2c: pxa: fix I2C communication on Armada 3700
Date: Thu, 26 Feb 2026 14:11:26 +0100
Message-Id: <20260226-i2c-pxa-fix-i2c-communication-v4-0-797a091dae87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH5GoGkC/4XNywrCQAwF0F+RWTuSSZ/jyv8QF+NMbAP2QVuLI
 v1304JY3HSXG25O3qqnjqlXx91bdTRyz00tId7vlC9dXZDmIFkhYAKJAc3odft0+sbPZfZNVT1
 q9m6QSx1RGshQFMCnSoy2Iyku/vkiueR+aLrX8m408/Yrmw15NBo0WbBZAOvAJKeicnw/SEvN8
 og/Ld/WUDTvYiSXmzx4+69FKw2zLS0SDRL09mpsmjpca9M0fQCKjgAFZgEAAA==
X-Change-ID: 20250510-i2c-pxa-fix-i2c-communication-3e6de1e3d0c6
To: Andi Shyti <andi.shyti@kernel.org>, Wolfram Sang <wsa@kernel.org>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Russell King <rmk+kernel@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Hanna Hawa <hhhawa@amazon.com>
Cc: Robert Marko <robert.marko@sartura.hr>, linux-i2c@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>, Linus Walleij <linusw@kernel.org>, 
 stable@vger.kernel.org, Imre Kaloz <kaloz@openwrt.org>
X-Mailer: b4 0.14.2

There is a long standing bug which causes I2C communication not to
work on the Armada 3700 based boards. The first patch in the series
fixes that regression. The second patch improves recovery to make it
more robust which helps to avoid communication problems with certain
SFP modules.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes in v4:
  - rebase on tip of i2c/i2c-host-fixes
  - collect Tested-by tags
  - Link to v3: https://lore.kernel.org/r/20250827-i2c-pxa-fix-i2c-communication-v3-0-052c9b1966a2@gmail.com

Changes in v3:
  - rebase on tip of i2c/for-current
  - remove Imre's tag from the cover letter, and replace his SoB tag to
    Reviewed-by in the individual patches
  - rework the second patch so it does not need changes in the I2C core code,
    and drop the first one as it is not needed now
  - Link to v2: https://lore.kernel.org/r/20250811-i2c-pxa-fix-i2c-communication-v2-0-ca42ea818dc9@gmail.com

Changes in v2:
  - collect offered tags
  - rebase and retest on tip of i2c/for-current
  - Link to v1: https://lore.kernel.org/r/20250511-i2c-pxa-fix-i2c-communication-v1-0-e9097d09a015@gmail.com

---
Gabor Juhos (2):
      i2c: pxa: defer reset on Armada 3700 when recovery is used
      i2c: pxa: handle 'Early Bus Busy' condition on Armada 3700

 drivers/i2c/busses/i2c-pxa.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)
---
base-commit: b4b4d88ebfbfd3aadb4c9a0f2bfe1abdbaf5822c
change-id: 20250510-i2c-pxa-fix-i2c-communication-3e6de1e3d0c6

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>

