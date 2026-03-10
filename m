Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7333B9D84
	for <linux-i2c@vger.kernel.org>; Tue, 10 Mar 2026 17:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773162505; cv=pass; b=kkcaxjUdRooEG9dugkXUTeipJG8cpGk1ueDFqlPBeT5Rbua9PluDCjRQhrRnOHbyPR0kHf74ADi8pRBSoaSldFQP6UqMRCnRJwftR93NalZO7XG/EOxLM0KAXz8/htNtgKpwRmuZdW1I2BL7pQwClC29UIh2W2/wZNHhVqH7Spw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773162505; c=relaxed/simple;
	bh=2U/YHmnNSMXb4kAlU6UnBe9Ek70iIOR2VlkPsQRm5tI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWFk3D7VwXNn9Dew6ZDn8yEyxmB0ZwdVWLPvNsL8SpDXKuxeK7Yuc52EGBZ97zfCbuhrxQBMjqrHxcguaF8G89YnqnKYBSwRK+yFVyxhQjFsoaaZIMel3Ce4DMjaa9sxl6HuhoMDpoD4veFuHdC3VfzaQFW9L9lMJprSSFZqtdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akWo6Vlr; arc=pass smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akWo6Vlr"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-466ec4c6846so934172b6e.3
        for <linux-i2c@vger.kernel.org>; Tue, 10 Mar 2026 10:08:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773162503; cv=none;
        d=google.com; s=arc-20240605;
        b=PmFX3wvxfO6x6MgPZ2KS3TeeKdJaMpdpUuRBjOmRJisUQoBO6H1zZvmATXq53ODRvc
         PesfhjJOfpWutVDwAFXYKpiKpLrimD5P/mD5bMjjBjzx0DSCxfe5BHiaICP1y/DXLbv0
         n7L4XqyI9V1Wd9GAddQOfwRiX+ow8BhfOUzBMRFfUFa3Xnu68OPA4mltocvCkAGs7XOH
         YuVazG53ucqrFv+6kmYWncoShpA6Nbi6e6zXy7C1EoaMlhRWIu+s5s+ADU7I5prlS7Kx
         ewzYwjbx0qxrmrF5w6vH6omDUgu/ZV+arUO8Gdx6zB8SgCBc7quhFmZSBdDyPVEOl8H5
         7LyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SGjIKYsVg8+/FngR4cBfWixXzW+UJX175bX4IGrA7TU=;
        fh=eLiy26T+TepqQJs+1MY9pQfG+pUL6zPbNgJyGj6zQ/A=;
        b=AIyiE2+8lkMp8h/3EOJS1qio4//K1clhkzhJ/XCsR7IJrK70GIyzXLP0h4ZlgxrErB
         VzKQJoAyblELi5SZTQEowQofuKS4N4AzX29bSd4cO0wYpo1yzGdl77Hj08cU1Nu47Kmj
         O4MQfrDZQRsIrvyHKg6UpUYuDnORGD5TwjwlazX9oHOmCe9ZUMQjMJAJpVWsLD+KvAF9
         axxoVM4yTzcj0QXf1TMFPioOXUBFSWGcQV1qLaMfiZFKDOqZfPvbLicBZ6DAH8VJVY9G
         fIEyq4URWy9aZMd7kFciy8hXpdItln/ClR4hRumkiZmGz9ZqKXvjTRfI7f55Qan9+NiD
         nI6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773162503; x=1773767303; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SGjIKYsVg8+/FngR4cBfWixXzW+UJX175bX4IGrA7TU=;
        b=akWo6Vlr4NXjvz5bBws3d9a85JYE9evL0eumw5OmUhbTB0w+esakD+2ZyOd5aIgnCX
         1gqYQFlfByH1Kw3+86WvB/Kh4vJMZG/qqVfCTY5HVKr21Q1cZirZaf7tNpan89oJM1eN
         0kaIqA3Qq5/1l+qFlWfzwwt3xursrG/ea1gjiVoMJJVJUF8V6YtnIMGu9gAkUySNQfAS
         TUw0Q8o7IoXeFhb7N/kz56S8i1VTqo/1AzGaS76e41Zuzl2m+qtc8tUP9TejW5KOLW0S
         W/ZyPfYrDKvxS5/rilgKaBk+rkX8NB/jO+0SPtFLwTb+/TPoQ4auOl9mC3vakF05bOCF
         n/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773162503; x=1773767303;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGjIKYsVg8+/FngR4cBfWixXzW+UJX175bX4IGrA7TU=;
        b=gtk+oPJ3ZL+hKTYpy+qd/MWQnAzYd3V/UCWjK6oLjt5R2FRqOU/uRMcnmh7Iwxe8KT
         2l1rp+fDmF7GNk7G72k7w9+RXKqm4brJVfw7cHrhjBQOtYa7uYPGSBhBZGXsTzaTnEj/
         b4EICg6L1qrk3E0tUHUB56yUMommz6R3rOpQiIo7dJ3tblkuHKWLWAbRq6+CuFf2aVus
         tDk+06PRmwUWzeMPR6JP8Gs9INeBiEs/khDM6rFb5RbZN73m2ahfkOwMzm+oU0UYL7Aa
         eqm+4UpbYY7AJW+/wAoE6f83rssjNov2ycWehYuZVBWRsTwO4zqP77TSd4GEbl6PKrfm
         EHhA==
X-Forwarded-Encrypted: i=1; AJvYcCV9mOi6H48N9fMC6bbPkqLTEGKibh/niZx+NcYJdWUIC3Snd7wnd8Y5AYiF71myxpkC5qVAl6TCrhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsdjk1f+53h1NPA+jn8LJLgGOTzcbzFIHpEajGU1ti2Zm8hFPV
	lpQBynxouWRg0fQLmlZLGHmP7bPwdC6tB/YpVOT4C9iks9U0yLe8HKS9rpoh3CRkGurvFmBOrNN
	9QoUep0RHDCqhjQRSot995qDhKudFkyQ=
X-Gm-Gg: ATEYQzx8DMbC+9LP5DpBzoQw9KSTiyr7Qj1lzMEagkP1qD+wi94IhN+kHzEjVIIa9kn
	ECAtBEMa6uZea2FarUR5B8xhUpwjGolBxmyRAjS9JqLnKNj2QQDXvhZNQMpGD04vHGUy7sWJua8
	QCM8vI/HqySvH8ipNOlU3BI2OouuN5QF9w7AszHtWuBrRpBgAYYe3c9hTBHNA7xOYa9paIxxsWt
	2Wy4qDlCENSJ/ha5sYxrR5iyoFRtNs3J2KosgwHTt4RyNZKOcdLsJG5TVkNNjcfymZcaQkeKTRy
	9ZQY6VugNtuwWZcgdMH0MogHOws+PLZHxJktetTW
X-Received: by 2002:a05:6808:1a01:b0:467:3f4:907d with SMTP id
 5614622812f47-46703f4faa0mr4092974b6e.56.1773162503370; Tue, 10 Mar 2026
 10:08:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANkKV92bTD11PCXYzz60WSxcP-0UCM8xtnY4_WraEwQx6TMjaw@mail.gmail.com>
 <CANkKV91Zfp_Bn_koM=Tb5vHQbog2Ja72C819aL-49kQ6PWA_Ow@mail.gmail.com>
 <CANkKV93wfs7oxU8kiyPWeafOs+ugpZSPLQrea7wtoSuGEG+pPw@mail.gmail.com>
 <68d90523-33dc-451f-a825-72eaa1c4bcb8@leemhuis.info> <CANkKV91attPiZ4+6DQKcgG10apUbF6k5hs7aJBrfsnfc5jQCew@mail.gmail.com>
In-Reply-To: <CANkKV91attPiZ4+6DQKcgG10apUbF6k5hs7aJBrfsnfc5jQCew@mail.gmail.com>
From: =?UTF-8?B?UsOhY3ogTcOhdMOp?= <raczm0812@gmail.com>
Date: Tue, 10 Mar 2026 18:08:12 +0100
X-Gm-Features: AaiRm53_m8RHubFk28jWl6i2BWsGSUZYGC84-yNOq9y5C3SysgD3CzDC2At4lhQ
Message-ID: <CANkKV93zUMy3333wpsqyMjxOKecMh8-hdABVaG8sVfnKusaE8g@mail.gmail.com>
Subject: Re: [6.18.] ThinkPad T14 Gen 2 AMD (LEN2073) - Synaptics touchpad
 remains PS/2, intertouch=1 ineffective, lost sync events
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, 
	Linux kernel regressions list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi Thorsten and all,

I tested the issue on the latest mainline kernel release candidate 7.0-rc3:

1. Built and booted 7.0-rc3 without any additional patches:
   - The touchpad (LEN2073) still exhibits the same "lost sync" behaviour.

2. Applied a local patch adding LEN2073 to the Synaptics SMBus
whitelist in drivers/input/mouse/synaptics.c:
   - Rebuilt and booted the kernel with this patch.
   - Behaviour did not change; the touchpad still does not work properly.
   - The patch simply adds the LEN2073 PNP ID to the SMBus whitelist.
     Patch content (for reference):

--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -191,6 +191,7 @@ static const char * const smbus_pnp_ids[] = {
  "LEN2054", /* E480 */
  "LEN2055", /* E580 */
  "LEN2068", /* T14 Gen 1 */
+ "LEN2073", /* T14 Gen 2 */
  "SYN1221", /* TUXEDO InfinityBook Pro 14 v5 */
  "SYN3003", /* HP EliteBook 850 G1 */
  "SYN3015", /* HP EliteBook 840 G2 */

Additional observations:
- psmouse is compiled as builtin.
- Verified both with and without the `psmouse.synaptics_intertouch=1`
boot parameter.
- I2C devices are visible under /sys/bus/i2c/devices/.
- dmesg output shows:

[    2.288744] psmouse serio1: synaptics: Touchpad model: 1, fw:
10.32, id: 0x1e2a1, caps: 0xf014a3/0x940300/0x12e800/0x500000, board
id: 3471, fw id: 2909640
[    2.331172] input: SynPS/2 Synaptics TouchPad as
/devices/platform/i8042/serio1/input/input6
[  252.979513] psmouse serio1: TouchPad at isa0060/serio1/input0 lost
sync at byte 1
[  252.980606] psmouse serio1: TouchPad at isa0060/serio1/input0 lost
sync at byte 1
[  252.981855] psmouse serio1: TouchPad at isa0060/serio1/input0 lost
sync at byte 1
[  253.008752] psmouse serio1: TouchPad at isa0060/serio1/input0 lost
sync at byte 1
[  253.009947] psmouse serio1: TouchPad at isa0060/serio1/input0 lost
sync at byte 1

- The trackpoint was previously disabled in BIOS; after enabling it,
the touchpad behaves slightly better, but the "lost sync" issue
persists and PS/2 fallback is still active.

It seems that on this hardware, adding the device to the whitelist
alone does not enable proper I2C/SMBus operation, and the device does
not function as a Synaptics touchpad under Linux.


Best regards,
Mate
