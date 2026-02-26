Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EDA318ECA
	for <linux-i2c@vger.kernel.org>; Thu, 26 Feb 2026 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772111502; cv=none; b=opyGDgGlddFWWLFwwJCO6W9OHLS+zr/neWaRhVBb5bPwtqIEL6gwjxml9WArHnfWiG5wpCPJdamAvBTAEgu3sr81/UQE2LM208kPT7ymU53EhV0zd5uehcV6Ns/hY3so4OmyBLvpwccXcsSYvv1UQUwHGXwsEO7bv2ZHwF1ugUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772111502; c=relaxed/simple;
	bh=BjoqhXFbnW4O6mRBJ4tlQbQzL834URssLT4o7VANrbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JzeKRGI1FAb1omCcw7q9t1rZj41Myi3AcdaY1++JaPtlNT+2UI/rteEAxEpbIP8XuqkzOVGhSUAIBRITEPLkZrY3XFvrR2MO3GPJc79zc9Ncj+qQwNe7g6Y3jUeAtkOPAurrbwfhBdYcPr6U0+9ekkzMrFkZd5VXF1B/vZXZ3AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/EiG1Kw; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/EiG1Kw"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4837907f535so8011475e9.3
        for <linux-i2c@vger.kernel.org>; Thu, 26 Feb 2026 05:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772111498; x=1772716298; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0gpTv0cQ1xaud3+6Hv+n3cMevQTI+cIYX2yYWA3C2vw=;
        b=R/EiG1Kwf3dl2WGPK8JaAdZwH/pZCfau/wpmzbhY3w0KUBWfrGLeN+K8h+ZChIJru6
         k/oCSOFX8xzdxuhj0hDQTOMl7qIn86OQWYeRk7EPUmjw19qAfghgy3O2yq3tL78bd1Uy
         qf1XiTiTVYGF1EaEm2GW3U3U8QUaq5FqaBAE/dahkYD6H4GOEclP76Cb4008mFVRXkWC
         TYh+4z5KYOi2JRPUaiYtauuTTioiyrekKXQRJsZZbZWuzUQMbnjdcyXM6EBaXzrv6372
         HOHajvY3NeUr7xVD8kc+7MFEP1h8qh1fVLt8qAps1iN2v+jm8LzEnB27MgFmY7tL6nyF
         Bayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772111498; x=1772716298;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0gpTv0cQ1xaud3+6Hv+n3cMevQTI+cIYX2yYWA3C2vw=;
        b=oYYm5W+jV/HyHv/YXMX/0UfWXh+9nP+MKQiobuBe9Svt7X+qjEBnp8eqYbN8pqilb3
         mA4N+xeynPUgDySni9HF7Kfe/Z5E17cGAfSrU8kNJwvnKJOlXkGu5Eu0O510E+P6rHZ7
         fhy4bNVyQ+rY5AXTmDk3Xjbn5bZ70pRG8tyK/3srp0WsAFF+fOhcbafnfbTQgIhiJjeA
         /HCDZvPAMKpG9fF8wikcNrTSHUeOHt6xxYEyw2ZteWsgFoVnoR+6+LQe3TolQYYmh7Em
         yNE9qgwIiHOL6Ls5uWuIWwICKyNeUxxpeePwlaoJZ3DnOEAFtYUJkRF7i8OZqBb755qY
         kNHA==
X-Forwarded-Encrypted: i=1; AJvYcCUM1cSFgQHQjcXvmpDOBL9kUSmJZw2iUc0CO9L5RLP/h75lR6xPbDJpgWp69+bqEOaZNCZiB9Dlyz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YynsfTAFrpAjQvKIoVotyJIMmjLJ3LUvCcS62+qXULyWev1lZxD
	1XlmIfVaLTG7EfOa8/6HQZtHRbCqnMU7nucAz9VCRK4uZ0D0iRzkuwNn
X-Gm-Gg: ATEYQzyjBPHPbf6BZ62J3EGKhegLbUIu0bLCFxq2YaNVdShxQ1BFZ2nXD+JaIOqyXsI
	kglPN7kxr++ysPfNnz93pnZEczXyCAPUzQvAEucOXn7aBFiBCUAfRU8xtqlrHafLnD8/78UoW2Y
	3UjQuvsArmyEolk/5fUHZrJpiiWhH/oJHVZLtOjtLcjvDxl78fG67lkVyl9FK+Wwr/Z5p/dtkE/
	U91BFt4o+ztmZRNc5o6mxYjFQS4UjvPU85u/QBrwkSSjjP0VEahC52kcEjzY1lrV/dISHA/RtJQ
	KKPq/VH2kXgTpr3ryIzlVOf9+iwqX3cY0ws77ZAGQobbkcISV/Hi2LhUezz4CyK/F62nYVzGyJa
	hDHV/vE5Z45dthWSdeTlC5m5s5OzV72gd2n90ucf1VluDcldA1mZCndkUjHqX5OtsMsUzkEx+IW
	L6urY6gOC2RQfHj01PZZI4psx2C1V4fHAg7keKtTxd+9gVePImTL0eGByISvO//0E=
X-Received: by 2002:a05:600c:83ce:b0:477:7b16:5f9f with SMTP id 5b1f17b1804b1-483c21a9ab7mr73637575e9.31.1772111497833;
        Thu, 26 Feb 2026 05:11:37 -0800 (PST)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-483bfb789efsm64827145e9.2.2026.02.26.05.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 05:11:37 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 26 Feb 2026 14:11:27 +0100
Subject: [PATCH v4 1/2] i2c: pxa: defer reset on Armada 3700 when recovery
 is used
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-i2c-pxa-fix-i2c-communication-v4-1-797a091dae87@gmail.com>
References: <20260226-i2c-pxa-fix-i2c-communication-v4-0-797a091dae87@gmail.com>
In-Reply-To: <20260226-i2c-pxa-fix-i2c-communication-v4-0-797a091dae87@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>, Wolfram Sang <wsa@kernel.org>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Russell King <rmk+kernel@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Hanna Hawa <hhhawa@amazon.com>
Cc: Robert Marko <robert.marko@sartura.hr>, linux-i2c@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>, Linus Walleij <linusw@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2

The I2C communication is completely broken on the Armada 3700 platform
since commit 0b01392c18b9 ("i2c: pxa: move to generic GPIO recovery").

For example, on the Methode uDPU board, probing of the two onboard
temperature sensors fails ...

  [    7.271713] i2c i2c-0: using pinctrl states for GPIO recovery
  [    7.277503] i2c i2c-0:  PXA I2C adapter
  [    7.282199] i2c i2c-1: using pinctrl states for GPIO recovery
  [    7.288241] i2c i2c-1:  PXA I2C adapter
  [    7.292947] sfp sfp-eth1: Host maximum power 3.0W
  [    7.299614] sfp sfp-eth0: Host maximum power 3.0W
  [    7.308178] lm75 1-0048: supply vs not found, using dummy regulator
  [   32.489631] lm75 1-0048: probe with driver lm75 failed with error -121
  [   32.496833] lm75 1-0049: supply vs not found, using dummy regulator
  [   82.890614] lm75 1-0049: probe with driver lm75 failed with error -121

... and accessing the plugged-in SFP modules also does not work:

  [  511.298537] sfp sfp-eth1: please wait, module slow to respond
  [  536.488530] sfp sfp-eth0: please wait, module slow to respond
  ...
  [ 1065.688536] sfp sfp-eth1: failed to read EEPROM: -EREMOTEIO
  [ 1090.888532] sfp sfp-eth0: failed to read EEPROM: -EREMOTEIO

After a discussion [1], there was an attempt to fix the problem by
reverting the offending change by commit 7b211c767121 ("Revert "i2c:
pxa: move to generic GPIO recovery""), but that only helped to fix
the issue in the 6.1.y stable tree. The reason behind the partial succes
is that there was another change in commit 20cb3fce4d60 ("i2c: Set i2c
pinctrl recovery info from it's device pinctrl") in the 6.3-rc1 cycle
which broke things further.

The cause of the problem is the same in case of both offending commits
mentioned above. Namely, the I2C core code changes the pinctrl state to
GPIO while running the recovery initialization code. Although the PXA
specific initialization also does this, but the key difference is that
it happens before the controller is getting enabled in i2c_pxa_reset(),
whereas in the case of the generic initialization it happens after that.

Change the code to reset the controller only before the first transfer
instead of before registering the controller. This ensures that the
controller is not enabled at the time when the generic recovery code
performs the pinctrl state changes, thus avoids the problem described
above.

As the result this change restores the original behaviour, which in
turn makes the I2C communication to work again as it can be seen from
the following log:

  [    7.363250] i2c i2c-0: using pinctrl states for GPIO recovery
  [    7.369041] i2c i2c-0:  PXA I2C adapter
  [    7.373673] i2c i2c-1: using pinctrl states for GPIO recovery
  [    7.379742] i2c i2c-1:  PXA I2C adapter
  [    7.384506] sfp sfp-eth1: Host maximum power 3.0W
  [    7.393013] sfp sfp-eth0: Host maximum power 3.0W
  [    7.399266] lm75 1-0048: supply vs not found, using dummy regulator
  [    7.407257] hwmon hwmon0: temp1_input not attached to any thermal zone
  [    7.413863] lm75 1-0048: hwmon0: sensor 'tmp75c'
  [    7.418746] lm75 1-0049: supply vs not found, using dummy regulator
  [    7.426371] hwmon hwmon1: temp1_input not attached to any thermal zone
  [    7.432972] lm75 1-0049: hwmon1: sensor 'tmp75c'
  [    7.755092] sfp sfp-eth1: module MENTECHOPTO      POS22-LDCC-KR    rev 1.0  sn MNC208U90009     dc 200828
  [    7.764997] mvneta d0040000.ethernet eth1: unsupported SFP module: no common interface modes
  [    7.785362] sfp sfp-eth0: module Mikrotik         S-RJ01           rev 1.0  sn 61B103C55C58     dc 201022
  [    7.803426] hwmon hwmon2: temp1_input not attached to any thermal zone

Link: https://lore.kernel.org/r/20230926160255.330417-1-robert.marko@sartura.hr #1

Cc: stable@vger.kernel.org # 6.3+
Fixes: 20cb3fce4d60 ("i2c: Set i2c pinctrl recovery info from it's device pinctrl")
Tested-by: Robert Marko <robert.marko@sartura.hr>
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes in v4:
  - rebase on tip of i2c/i2c-host-fixes
  - add Tested-by tag from Robert
  - Link to v3: https://lore.kernel.org/r/20250827-i2c-pxa-fix-i2c-communication-v3-1-052c9b1966a2@gmail.com

Changes in v3:
  - rebase on tip of i2c/for-current
  - rework the patch and use a different approach which does not requires
    modification in the I2C core code and update commit description
    acccordingly
  - remove Imre's SoB tag, it should have been a Reviewed-by tag, but due
    to the rework this is an entirely different patch so that does not
    apply anyway
  - use Link tag for the URL of the referenced LKML thread
  - Link to v2: https://lore.kernel.org/r/20250811-i2c-pxa-fix-i2c-communication-v2-2-ca42ea818dc9@gmail.com

Changes in v2:
  - rebase and retest on tip of i2c/for-current
  - Link to v1: https://lore.kernel.org/r/20250511-i2c-pxa-fix-i2c-communication-v1-2-e9097d09a015@gmail.com
---
 drivers/i2c/busses/i2c-pxa.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 09af3b3625f1107d2722cb026e67b69b07cca2e3..f55840b2eb9ab70aad43bd7f4f44c39aa4d9c67f 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -268,6 +268,7 @@ struct pxa_i2c {
 	struct pinctrl		*pinctrl;
 	struct pinctrl_state	*pinctrl_default;
 	struct pinctrl_state	*pinctrl_recovery;
+	bool			reset_before_xfer;
 };
 
 #define _IBMR(i2c)	((i2c)->reg_ibmr)
@@ -1144,6 +1145,11 @@ static int i2c_pxa_xfer(struct i2c_adapter *adap,
 {
 	struct pxa_i2c *i2c = adap->algo_data;
 
+	if (i2c->reset_before_xfer) {
+		i2c_pxa_reset(i2c);
+		i2c->reset_before_xfer = false;
+	}
+
 	return i2c_pxa_internal_xfer(i2c, msgs, num, i2c_pxa_do_xfer);
 }
 
@@ -1521,7 +1527,16 @@ static int i2c_pxa_probe(struct platform_device *dev)
 		}
 	}
 
-	i2c_pxa_reset(i2c);
+	/*
+	 * Skip reset on Armada 3700 when recovery is used to avoid
+	 * controller hang due to the pinctrl state changes done by
+	 * the generic recovery initialization code. The reset will
+	 * be performed later, prior to the first transfer.
+	 */
+	if (i2c_type == REGS_A3700 && i2c->adap.bus_recovery_info)
+		i2c->reset_before_xfer = true;
+	else
+		i2c_pxa_reset(i2c);
 
 	ret = i2c_add_numbered_adapter(&i2c->adap);
 	if (ret < 0)

-- 
2.53.0

