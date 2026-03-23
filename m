Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEB2399004
	for <linux-i2c@vger.kernel.org>; Mon, 23 Mar 2026 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774276478; cv=pass; b=Pzyu0PwSr2WStuprA/9gB1zxova7YPHF3fWGpUfxs/gG6gr/n47N7BovpieQF1tNIYjl+nu/UPSAlGsVJtBmk79aSsAIGJDdNbUC8/GoRmLgL3WHH6029vfeSbLw9bxeJhZlbtVKkZiTiaCZVYs70WyUFJ+s6SIVJO6xTwn6ags=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774276478; c=relaxed/simple;
	bh=vxPDw7or47fxtPpxapUmMGp6UDZhFhul7mz8eYtaK8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pyXyfFV+lApptj75ZrkQtZzaKblZu3ZOUZ+tQ/Eyk/WOmJFNv2PyfHTK+4g4sKjZnedP0nJVTIcXjiah6zbt8HwuVCJlZQl/yc5bfsnFO3ZbZ71WAUF9zTkeV07IYFACaZOR3UWQwQclrS9y/fRsQ9x21oj6XHJSV9Qyi0OCtHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTlz1cNP; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTlz1cNP"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35a211df8e3so162250a91.2
        for <linux-i2c@vger.kernel.org>; Mon, 23 Mar 2026 07:34:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774276477; cv=none;
        d=google.com; s=arc-20240605;
        b=NZNXZvbCuY8ntAMvlyFJD07wsE1xP4KTeXF6a1iVzWeX/We/b5mg2OD1mLRiz93zLJ
         /e3vZBCgdwZHJ1m6vHEK75wzvYi4Ye4sCETK0Nc5JOLYtzidv0rWlhazI3yrXXEdA8S/
         llzAp/phPznuQagLrp4150MheYLYUpdOf72M4HaFsKx55BWetv30JJlJjk/MQ9BubDYF
         +ApqaHSMxModsJ9VzMNYxmUF7l9wrfNIn2DDPWWSbIyI+K7Q1yHl4LmHI/GJ/U3E8jjY
         XTtNtudoaHpf5w0vvPydRsmLiSMztIlBzeqaTKWDvUiOfpGDaDKr3u/YSX0R8LNO4WD0
         SE9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WVYH7xVGA2teNLj1Bfrz6my9P8EY5ujLY9EoEeuqJnU=;
        fh=sL4VuXPoQ7Gee2N/yq+pJySlF0hROK4U9hT//PJSBL8=;
        b=M1igKI+VHnDXjGiH1hWUdUwSp085JHSFTBKjWGo7LCAp7TAsMLoWvSL9fAVvzRQogZ
         xZNJPXz4rxYn8oxkqMZV/8ctX/HCDGytZo31UpGqjqekD7SgtK3b4Xpb81he76RA0aBt
         0QjEt8y9YbSdwb3vaomJUVXAMKgrITZAGkOAdDGSuQjirma6lMMjO592N5v0PrntlR8Z
         l1t021aP4GrdalbIZLMFa1EngHCaTCmvy02qSi5A5EWBJpJ+WgSUvLhbC5LbpwnKRPRC
         LfiLJfDfQm00w8/3E2Bnp1n3Fh9dHcznVSSfzSKC2ETDBfAZ9PCGqzpGMDIPTGD47Dl3
         zUDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774276477; x=1774881277; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WVYH7xVGA2teNLj1Bfrz6my9P8EY5ujLY9EoEeuqJnU=;
        b=WTlz1cNPmhKDfKSB/pPon8JKMObghzhqMZqQYxbbxUiDhkmJBCnMBiUyFOWxxJo8d2
         l+a/uqZPEB6hpePSssD3pjMO7zIgw4eJmgQ7tLRBK1gTM8kCy3Dim+Wir741o51GVoGQ
         7DPzATr1EiutfHFl7EVHutO9Z4sW242vnXRkG4fJbYSVtvw4NV1IbWhK5AHxJkRCuDN8
         69u8TnG6ucn8g7ZZkgTWBmohvNgs5KREvSTt68SGkLz7FdPAHhiAv8tYYCajf2a3Il3N
         TvY73NGv3lvyrucNwTkkdz3wSXUJNYQbHcodoCx09KPGBpcONTyA4LEY9NvNMC3g5bXH
         bJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774276477; x=1774881277;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVYH7xVGA2teNLj1Bfrz6my9P8EY5ujLY9EoEeuqJnU=;
        b=L4KWjy4F1HA4zHyM4eFsuOvvFl0A9SpiGknsOW9+vJl4XE1a2yJ7tQHNxsxDr3Xgxz
         TIr5utmrGf0Ppc0oDSHnjr9Sjc5glenVLVZS4mevnbQDmv1trt/6xOY/pn65Iu0n92o8
         vOQ31cPDQ+shd+yse8xqzNL3uR8CVnQILnqL6mFJhHoCIbR9eEDQBHp2ITEU2GW3PiMm
         EFYqJPKprgPrvvKkfTguE8zlyyrN2LwJVbdeAWIPORTYcUFah1ieXQ3jbxEHOJCU6U/9
         zD56QyEpWd3/t0jQVlsLZju/x+AeNoCUC8zBqxAD9E7N4ngSCWTGyb+IlvwV1+vmYPkT
         y/5A==
X-Forwarded-Encrypted: i=1; AJvYcCVoYVK9u9W/V1UJfwn4FCpKc2sznl8vvUIctz3bP7IPOf0OfGYNbZsxdw9TfDcHZcaqm4GI3DRcAfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpJeGwAK71TV+tw5qcX1zW4E76LlZaHnPmgz3HOxzuoYR2+QDr
	GdK2B5ZcOuV495o4qveYlkR3kwfgsTBSWRKkeo5r09eietrKXemdYKcYguMrZBMh0LGV5ySftuQ
	XqSS3ZmkTnR4qyr5D5WuAleot2F2MILU=
X-Gm-Gg: ATEYQzy+wGgfuk8gCDoXLwNEtZOjQ96tFQrjnVASOWyaOYdsRL9hBJQcWPQkEbh8Wm/
	JI0ji9wpnk3K2rYJn/Q86oeDTQu1L1JbrUB/PQzVkeyeGrbYXOtL3SlzynJrG+uSdk32l/mOSs4
	Ho1fLHXAyPzI27zp5NMzQexuRvdfZ24jpYhVEz/Qmqdu3pdYMSpvlHXGerlsxwJ3DXw6j9Jtm3e
	WxQl6MriZufqn4AnxjkA+ZyTosV+w2Kq939EZo7kYbvKPRU0Odh2mWJtwzeYp0MsWHQY+35gfAe
	o92RLmyOlV7MeE85KgDngCBEBUL4jQBluPuwGQ==
X-Received: by 2002:a17:90b:3902:b0:35b:99f8:966d with SMTP id
 98e67ed59e1d1-35bd2d1460bmr10070628a91.24.1774276476552; Mon, 23 Mar 2026
 07:34:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323135249.550925-1-martin.aberer@bachmann.info>
In-Reply-To: <20260323135249.550925-1-martin.aberer@bachmann.info>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Mon, 23 Mar 2026 15:34:24 +0100
X-Gm-Features: AaiRm534_Ifawxle-7bh1yPoxYBzLb1c7xP5h-pAxJW2cnyPYGXqA0fpe2M7bUw
Message-ID: <CAH9NwWdLtaSsS=B-hq1WV2RF81o6NcO4mai9M0ts+fuq-YkH+Q@mail.gmail.com>
Subject: Re: [PATCH] i2c: ocores: re-check status after poll timeout to avoid
 false errors
To: Martin Aberer <martin.aberer@bachmann.info>
Cc: peter@korsgaard.com, andrew@lunn.ch, andi.shyti@kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hey Martin

> The polling task can be preempted at any point inside ocores_wait(),
> including just before the time_after() check. If the scheduler does
> not resume the task until after the 1ms deadline, ocores_wait()
> returns -ETIMEDOUT even though the hardware already cleared the
> status bit.
>
> Re-read the status register after a timeout before declaring failure.
> This avoids spurious timeout warnings under high CPU load.
>
> Signed-off-by: Martin Aberer <martin.aberer@bachmann.info>
> ---
>  drivers/i2c/busses/i2c-ocores.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
> index 0f67e57cdeff..6f5aece94d57 100644
> --- a/drivers/i2c/busses/i2c-ocores.c
> +++ b/drivers/i2c/busses/i2c-ocores.c
> @@ -313,12 +313,24 @@ static int ocores_poll_wait(struct ocores_i2c *i2c)
>         /*
>          * once we are here we expect to get the expected result immediately
>          * so if after 1ms we timeout then something is broken.
> +        *
> +        * The polling task can be preempted at any point inside ocores_wait(),
> +        * including just before the time_after() check. If the scheduler does
> +        * not resume the task until after the 1ms deadline, ocores_wait()
> +        * returns -ETIMEDOUT even though the hardware already cleared the
> +        * status bit.
> +
> +        * Re-read the status register after a timeout before declaring failure.
> +        * This avoids spurious timeout warnings under high CPU load.
>          */
>         err = ocores_wait(i2c, OCI2C_STATUS, mask, 0, msecs_to_jiffies(1));
> -       if (err)
> +       if (err) {
> +               if ((oc_getreg(i2c, OCI2C_STATUS) & mask) == 0)
> +                       return 0;
>                 dev_warn(i2c->adap.dev.parent,
>                          "%s: STATUS timeout, bit 0x%x did not clear in 1ms\n",
>                          __func__, mask);
> +       }
>         return err;
>  }
>

In my view, a proper fix would be to switch to read_poll_timeout_atomic().
Something like this - untested:

---8<----

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 0f67e57cdeff..df6ebf32d6e8 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -24,6 +24,7 @@
#include <linux/io.h>
#include <linux/log2.h>
#include <linux/spinlock.h>
+#include <linux/iopoll.h>
#include <linux/jiffies.h>
/*
@@ -258,7 +259,7 @@ static void ocores_process_timeout(struct ocores_i2c *i2c)
* @reg: register to query
* @mask: bitmask to apply on register value
* @val: expected result
- * @timeout: timeout in jiffies
+ * @timeout_us: timeout in microseconds
*
* Timeout is necessary to avoid to stay here forever when the chip
* does not answer correctly.
@@ -267,21 +268,14 @@ static void ocores_process_timeout(struct ocores_i2c *i2c)
*/
static int ocores_wait(struct ocores_i2c *i2c,
int reg, u8 mask, u8 val,
- const unsigned long timeout)
+ unsigned long timeout_us)
{
- unsigned long j;
+ u8 status;
- j = jiffies + timeout;
- while (1) {
- u8 status = oc_getreg(i2c, reg);
-
- if ((status & mask) == val)
- break;
-
- if (time_after(jiffies, j))
- return -ETIMEDOUT;
- }
- return 0;
+ return read_poll_timeout_atomic(oc_getreg, status,
+ (status & mask) == val,
+ 0, timeout_us, false,
+ i2c, reg);
}
/**
@@ -314,7 +308,7 @@ static int ocores_poll_wait(struct ocores_i2c *i2c)
* once we are here we expect to get the expected result immediately
* so if after 1ms we timeout then something is broken.
*/
- err = ocores_wait(i2c, OCI2C_STATUS, mask, 0, msecs_to_jiffies(1));
+ err = ocores_wait(i2c, OCI2C_STATUS, mask, 0, 1000);
if (err)
dev_warn(i2c->adap.dev.parent,
"%s: STATUS timeout, bit 0x%x did not clear in 1ms\n",

---8<---

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
