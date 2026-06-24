Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3413B42DD
	for <linux-i2c@vger.kernel.org>; Wed, 24 Jun 2026 22:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782341519; cv=none; b=EfIsFiWacn8uXvdgVDKsDJd7U38vq2iaUROJ0v1bBcsPEtCbOiBDwJ2hiRzUuim9rPEZP/Wis5e8CBAux4vGRF+UkBCfZmoAz5PmPdoEfUbAqa5xDdRnS0A1CPkSBXv697FnSOFa02GM4QPt+1AFZdS1sMPsNcbp3nF852E+DVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782341519; c=relaxed/simple;
	bh=nnK3G9bvZF1+0ahwFKA/FAyn1efCjrYKTJrfMLJSZD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UPye4/1VOv353xozc0l/67h2+B9VzJV2jhl3+jc/f00jrqsKs6u8Ewm+hdilxmVvOdcY/Xx95D5wCVcgFPcTNITUsaYC2wLpm8o8tAo5DWggREyQzRiXyKWlu/pSYk+LzFm83wpn5KJTxuHQfRISsEZbNPreo2sxk4dvpj4A+hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMykdm02; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMykdm02"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218C01F000E9
	for <linux-i2c@vger.kernel.org>; Wed, 24 Jun 2026 22:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782341517;
	bh=pWCYHrLIqYxnLxwyEEHqQaWAH4xIb6vViHhgxlk2oZc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kMykdm02rxyNzE3xcywUWJbOJQ8m8jbzq1niRnQxN1Al0EGlBxnJxrb2RiwGD9a85
	 muIoKC+SdnvVtQVFU8kxoRsMxstyJGK7tBu+C1MPglSaOnHLBcj8qL6r3I2aQF98+u
	 t4H4RmdNTURWfEjYxUHtSG6FD520SQ8tEi5t2IG/MpDaRI8We4N7dwEhRfpSZRK4US
	 TUXCOaqmzN5MLs5wic8SCmOXmUT2fWraVYDaxlt9GTK5gnsHlMt3qNROlGzfc7T/DP
	 qltmnDBsNt4c75dm+zmUX25Aky9zi4fRWcfzewjz0kRFKgOGMG/rBkwupxWiSaMn7O
	 Ldmbm+uuDEGyw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5ad4c89ecd8so1536928e87.1
        for <linux-i2c@vger.kernel.org>; Wed, 24 Jun 2026 15:51:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Roh9SWOsZjE6w4VwRXAzbyLIWn5FF89PcfufFzS0tx3SRos8kiEET7K3g+3AqDsVxR73PGCsMsuPNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/mETjNzgSWDQPjCODch8GPL5SnD4Rzpvy1bkiZeJ3D7ljWufv
	rSwGU/FbgmbYUPNxazFxO1VS1KgGYjErUPHcZghIxWb+qRqOPZMOHGgppROyTiYPVWwFR6KbLzG
	FMLc4zZTBe30Sh/E4x03l+VFs+wCCIe0=
X-Received: by 2002:a05:6512:61c:10b0:5a8:f6fd:eb15 with SMTP id
 2adb3069b0e04-5aea1f5f4abmr5434e87.24.1782341515938; Wed, 24 Jun 2026
 15:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623-i2c-fault-reporting-v1-0-6db1a8aabf18@mobileye.com> <20260623-i2c-fault-reporting-v1-3-6db1a8aabf18@mobileye.com>
In-Reply-To: <20260623-i2c-fault-reporting-v1-3-6db1a8aabf18@mobileye.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 25 Jun 2026 00:51:43 +0200
X-Gmail-Original-Message-ID: <CAD++jLmwrdhZmZ8gCQAxB5pH38mA6CD5RknUe9P7gaM=qcYe-A@mail.gmail.com>
X-Gm-Features: AVVi8CckjUpmwjTnxwtnMofTPJ22pUzvHgRCb-AcseQShrzvALH0ovgO7Bq-Rh8
Message-ID: <CAD++jLmwrdhZmZ8gCQAxB5pH38mA6CD5RknUe9P7gaM=qcYe-A@mail.gmail.com>
Subject: Re: [PATCH 3/7] i2c: nomadik: do not try to retransmit I2C message
 series on errors
To: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 6:32=E2=80=AFPM Dmitry Guzman
<Dmitry.Guzman@mobileye.com> wrote:

> i2c-nomadik driver of I2C bus controller in `xfer` callback retransmits
> the whole message series in cause of any fault, and returns fault only
> after third failed attempt. This behavior contradicts with API because
> not only it hides hardware faults, but also re-sends messages, while
> they are not guaranteed to be idempotent.
>
> Remove the triple attempt to send messages in `xfer` callback.
>
> Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>

This originally came from:

commit ebd10e0783d9fb92a147e60902e22c2d3f3ad69d
Author: Virupax Sadashivpetimath <virupax.sadashivpetimath@stericsson.com>
Date:   Fri May 13 12:30:23 2011 +0200

    i2c-nomadik: add code to retry on timeout failure

    It is seen that i2c-nomadik controller randomly stops generating the
    interrupts leading to a i2c timeout. As a workaround to this problem,
    add retries to the on going transfer on failure.

    Signed-off-by: Virupax Sadashivpetimath
<virupax.sadashivpetimath@stericsson.com>
    Reviewed-by: Jonas ABERG <jonas.aberg@stericsson.com>
    Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
    Signed-off-by: Ben Dooks <ben-linux@fluff.org>

At that time the code looked very different:

       for (j =3D 0; j < 3; j++) {
                       if (status || (dev->result)) {
(...)
                               break;
                       }
                       udelay(I2C_DELAY);
               }
               if (status =3D=3D 0)
                       break;

We would only spin here if both status and dev->result
(the number of sent bytes) was 0. This doesn't seem to be
at all the case anymore!

I suppose it's a bit dubious code, so:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
