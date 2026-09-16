Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15D82F8E84
	for <linux-i2c@vger.kernel.org>; Wed, 16 Sep 2026 02:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789525060; cv=pass; b=JHiFZ7eVcXjZyddOR2ahQLj7fuETsjxadZ1fb/gseLT1m59sEXClUThYyxKcr0kHr5ZnBIXXXXvrLMIcH8ReiwvW7ycRoSR8IRp2u/kYhJQ5pWyZt4WCSxFimglDgGfPly2Ea0OLFF1ZoaTSphEniCO9nOeup2URCcyY/HWN14c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789525060; c=relaxed/simple;
	bh=54qaMNvX84LihabUIKKX9MFlFiugZNCJrolAMMRbI6E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=PCjq9SeaMe637AB7ZujIU3Fx4UCvd1r4Ux0J5nlIsT1cO4wJpon4e4ppy9uiVSaOYLZLOGkFjRqNf7Ai3atKykqyqcOQtsghOpmUTZbRnfzdT2lksYRDnFGuShDDHZ69chqEF04jzdDdvSJKFVGbf7buyU/FjEKiBsHdXmZFlg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oz2dN5tU; arc=pass smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oz2dN5tU"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6aa22408406so315265a12.3
        for <linux-i2c@vger.kernel.org>; Tue, 15 Sep 2026 19:17:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789525053; cv=none;
        d=google.com; s=arc-20260327;
        b=i96XExCW53nI5qr+1IUHTOnGJ3/NVrCYGZxrMmy/eddBoJ9EalBrcjuc1zh+BKjGCG
         mQJBrJp2QRlZXyib5KS05KkPz/C/yK76CPWFGazry9S5i8HZ0+t4vlSmOGLJJot2y9VL
         OBQZ998bC+z6SbsLGcA/l3nFiPMqI1gZtC+xYtNpRHvX3D2Snd/6hUtMcHEjXlM9DJrT
         eQ+YhcSVCWolXyxxu7wgQddskOZsKv6kqeY+fnKbsmOK0ZJljJPFl95l5HGzZINmBrbg
         1i6Ypd690LCNnLwY3xf97AU0o1wGNF7vuKG89wpm3SyH74DRZ860u8z7srFvMx9j4EdL
         eY2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=54qaMNvX84LihabUIKKX9MFlFiugZNCJrolAMMRbI6E=;
        fh=9LAB41RZR5jDK/YasSa/qATdJ3wVoo9orGkiNjYOSyw=;
        b=o98J+tIbUvM4sa/y2nXfZOGbArb6PphaZJCLJev1MgmYC7f9U8vMPit1/nyvxI7bjs
         bOzp1Ga5x7M/DkgKsXqbLk0/1VSzXcKcT+sVcvmvdSrdLm9WV99/K90wqKAL+8yjnFhx
         vxosofu8YnzmssT4x+QyNcK96zFDkRVu4SpmyzpGp/PAwBfnP9WwFPEWI2ew8A6i13cl
         13C7wiag3G9uHHpJB9lqveK4/WczGlLB+Up63CDUUwDxmFTK/MuEiq1eYbx8HAtX8h/0
         UT61013kerOuQr5InBdeVlEkqGgA3fXxMlCMymRqwyluAqWIEUjBbtUaYHJ6mfGjRcwR
         Ex+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789525053; x=1790129853; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=54qaMNvX84LihabUIKKX9MFlFiugZNCJrolAMMRbI6E=;
        b=Oz2dN5tUqi4OcOZk/UFTk+Z+ZadbyGfwHoSXrfRbAPEr28/DW2BZkM69EzvlREzwmN
         SKPnaZMbFq2It+ycXcqRd/NAOypJHwX0q3hscWShwUrJqRaXAn62kQD3fVmM+A4Tg8iD
         CZRFirKDJcGklXY+VRnQtDtZ2oZ6xmj0GKqVWfrq+9Z5eZzOOO8rxCPGkRliy5JoOmge
         uZ0DDGStjCF/goau/LVBjlEltuO10nB+085cRWrnmdFsYDMc5y+zHhdP26EJhM6U1HWI
         ZJNVQd+9wekZOwbny3BufBoRdI+0pZJP3Hy1PtnKM+3gSDZyTt7ckrp/PTo+5pAKXcH1
         +qeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789525053; x=1790129853;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=54qaMNvX84LihabUIKKX9MFlFiugZNCJrolAMMRbI6E=;
        b=vtDvDlvEJ7BKyftWeMyDpewq5D8iRvGIp6JJyoKDyokwPQHyKi8ZiIjF7OXJGs4kxP
         qsd3rGL0lSih2zCD3gAd4h3HpTM1oIfhY8Q/DQkXwPMdPzQPuvbpiQ2wHkumY1F9Q4nB
         30za0aFvSvV09GjXEugzYeh1fIsrlD6CiHM9PUmZyzDT4hoAr60GaRFTW4JBc/XWBt5m
         Mu1x3ym3Kz5MTl65GE6JETSx6UG5nVxTTAf5ydpv1kI3wt1sLiaTq3U+Hchxd+aBES0G
         o3TBjogKykPZ//6Ezh9guHm0lsKbzcFACWiBxlDfVVdBH8iQTheW/d/0Ep+3uksC5ew9
         pVfQ==
X-Forwarded-Encrypted: i=1; AKwUvBwXIfFrMyCtlnLqlQgiXbuzo7T9sx+VN+3SnLPYpfivvAZ5auQFzqH3bBE8tyTkG9EdDhi04tB8U9E=@vger.kernel.org
X-Gm-Message-State: AFuF++kp9N63dZAkJ9kaZG6VC3qU8/ppQXcJlR4smuynWUWOlKJU5nK+
	FtmqoZuqab24BSJbKypY5+6xhAOLvSa3YCCiV+8qaKJ2mmms/gC/OYiGcKe01jKOAtpW1BI4iAx
	rVBv2OWGgTlqtor1YmGzEBk9nnlmgEBA=
X-Gm-Gg: AYBFou3yt+E8ctHQN/VSOrii32p58hoemIo3NXNg3iO+ZwM8joTkun2uVT832B8f2BY
	LEAj1wYikxD5+hb6lRbz/OqLjQPeruQXKkGRujK9BRoY6lM/KGeW20ehhV1wJFCMPWcQcImMtFH
	kwQ6JBC55oQhochkb3hAJc9cGrIl/kPvXiYNdo4NWuue5K6S+i3oor8/h6753/3GmBfOFx+NoYY
	2UfxA1ePC7Jr4PRj0rJrUHEgEPrNswUKrJKRATIXzGOX5HHTPdm+rE8Y6UMRXyAKEpVXH/WLNIa
	UfAEGYoQ3YlANt5jwos2wmKbk+dha0nS6h+/ANilnCIRFaDWTqVxjdrwRA==
X-Received: by 2002:a17:907:9309:b0:c29:60c1:7e55 with SMTP id
 a640c23a62f3a-c29e523d53dmr34794466b.12.1789525053165; Tue, 15 Sep 2026
 19:17:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kenny Hsieh <kenny111575@gmail.com>
Date: Wed, 16 Sep 2026 10:17:22 +0800
X-Gm-Features: AcwNN1XxfOvvKrV2F5QzPoOkWrOGLBKZFdGKKdmcyH8Ac85pDEwI-499SN0DF1o
Message-ID: <CAKUyoTvQbO=6ed1p3iC_n9Jm9gSTwtHm7_NRAiJmuaNaKjuOvA@mail.gmail.com>
Subject: i2c: sysfs interface to enable MCTP on mux child busses
To: andi.shyti@kernel.org, peda@lysator.liu.se, linux-i2c@vger.kernel.org
Cc: matt@codeconstruct.com.au, jk@codeconstruct.com.au, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andi, Peter

I would like to gauge whether a small sysfs attribute on i2c adapters
would be acceptable before writing code.

MCTP over I2C (drivers/net/mctp/mctp-i2c.c) creates one netdev per I2C
bus that carries MCTP, and which busses those are is declared by an
'mctp-controller' property in the devicetree. We ship one firmware
image across several chassis whose I2C topologies differ, so we
describe only the root busses in the devicetree and instantiate the
muxes at runtime over the i2c sysfs interface.

What we would like is a writable attribute on adapters below an
mctp-i2c-controller root, creating an mctp-i2c netdev when enabled and
removing it when disabled. Entity Manager would enable it on the
channels that need MCTP after instantiating the muxes. The driver side
already exists: mctp_i2c_add_netdev() and its counterpart are what the
i2c bus notifier calls today, so this only adds a second trigger.

Our preference would be for mctp-i2c to add the attribute group itself
with sysfs_create_group() on the adapter's device, leaving
drivers/i2c/ untouched. That does mean one subsystem adding files to
another subsystem's devices, which is why I would rather ask than
assume. Do you have any thoughts or concerns on this, or a shape you
would suggest instead?

(Resending as plain text; the previous copy was rejected by the vger lists.)

Thanks,
Kenny
