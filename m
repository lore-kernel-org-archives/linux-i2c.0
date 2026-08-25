Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF20134404E
	for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 08:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787645331; cv=none; b=EwzKdNQ+WwTzp54Y3xqe43dZtWHvZh9Hal2UCPNTHin4qM41M09l7pQGlU0Y2tqgkTEc2WL9hw2D7mVlkxVynr1yHgo8MWZq8QjeRrFPQUJzE0b6fDiNtI17SxFDooqD0DdxmBmPNPyLyC+EQ+mwJBitq/vKBvvGqMFBmwG/xtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787645331; c=relaxed/simple;
	bh=ZlG3aDbT6g3ggbFldXxyW324NWS7rBB/ZuIAPZWd/sI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bKwA74rbB/ZpIFQct9WfCdey/VfDE8e6QskRqmYOHVel3GNqN7qUBJF3I1uDoA5NwWFNSgsCPesAdyLRH68MrsWiX0IVslif1G5kqK3w9atp4Qtz9PeavW5SWNNaqtEIREEbgZtL+DLJYJw9rd+5vbjdyTugdRsb3V1jWT2TQGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNd42RWz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNd42RWz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CEC61F00ACA
	for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 08:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787645327;
	bh=ZlG3aDbT6g3ggbFldXxyW324NWS7rBB/ZuIAPZWd/sI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jNd42RWzB9Pmw5z78scArksYsakcOCcji4EfrEae8qjBqhrNsJWKefMdRNUfdwDyz
	 /Aunz0TDkWlcEOO7qXAmNfNjvFEhRcaQMO+qxZmcVjNmmeBjz6JR0n1N3lxEsMr/Ay
	 VOUZqNMeRmakUGMdXNauao4z4emJPhUbOODuabOEZ4MIYrzrqvKGJep9cFjayNkdGv
	 25CLQStF4uzlqSEaOOg80YCuyjTKtmV/+vP5NmBphsBrcJn0hlj2zwhONgmXEU7VEz
	 b8kp7OkEGLviZXdpIW8orU5sD2QzTb/1WDkKl3RPF7Im2jl+5ySp44fA4NYzYEm81e
	 yvt6aEbcaFYUQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39c7ef2b1e2so39687311fa.1
        for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 01:08:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrbif3eKmpkdEZRF1sqqEu6bAdFIIykEKZkxU7gJOoNmduPf6WBBBnNtykYFQXxRcE+QwEJq0//VFw=@vger.kernel.org
X-Gm-Message-State: AFuF++l/4bACdXMTPZsU7y/YXNOCJnKuC01NdSJ/gNpUQAOLLZWULcyd
	fOtkQPprL9IjODTPae8Khkb2/BWmwb8KSimxO/8gguy1ZxaOspKHHngQsw1N2WgxOm60frIWcYP
	PMvUU6a+02n/SXE15nrhEveqCs0ymmfI=
X-Received: by 2002:a2e:be10:0:b0:3a1:acdd:374c with SMTP id
 38308e7fff4ca-3a1aec4c8a2mr75822671fa.12.1787645325865; Tue, 25 Aug 2026
 01:08:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822213941.98882-1-michael.zaidman@gmail.com> <20260822213941.98882-9-michael.zaidman@gmail.com>
In-Reply-To: <20260822213941.98882-9-michael.zaidman@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 25 Aug 2026 10:08:32 +0200
X-Gmail-Original-Message-ID: <CAD++jLnKXqbV0xB3wvTF9Ri7g1MuWV6csO0MGzCtv5LBwmSr4g@mail.gmail.com>
X-Gm-Features: AcwNN1X_y8BVViWPfdjrcjjRoPyeZetZ6yFaPG1GGvpja5aDfGm34bwxzVsOpXY
Message-ID: <CAD++jLnKXqbV0xB3wvTF9Ri7g1MuWV6csO0MGzCtv5LBwmSr4g@mail.gmail.com>
Subject: Re: [PATCH 08/13] HID: ft260: uart: add modem pins control via ioctl
To: Michael Zaidman <michael.zaidman@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Germain Hebert <germain.hebert@ca.abb.com>, Rio Liu <rio@r26.me>, 
	Bruno Giacomazzi <brunoceg1@gmail.com>, Christina Quast <contact@christina-quast.de>, 
	linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

thanks for your patch!

On Sat, Aug 22, 2026 at 11:40=E2=80=AFPM Michael Zaidman
<michael.zaidman@gmail.com> wrote:

> Add TIOCMGET/TIOCMSET (and thus TIOCMBIS/TIOCMBIC) support so userspace
> can drive DTR/RTS when the modem pins are in GPIO mode. This enables
> programming an ESP32 over the FT260 with esptool, which resets the chip
> via those lines.
>
> Also key GPIO sysfs registration off chip_mode rather than USB interface
> number 0, and include DCD/RI in UART mode 3/4 GPIO sets so the modem
> mask matches the pins esptool needs.
>
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

I'm not the authortative expert on modem control using GPIO,
but what I think you should do is to

select GPIOLIB
select SERIAL_MCTRL_GPIO

On Kconfig, so that gpiolib is always available and you can use
the generic modem control helpers for modem control over GPIO.

This can be a bit delicate in this case since the gpiochip that you
use for mctrl is also registered in this driver, so you need to
register the gpiochip *first*, then add a look-up table for the
GPIOs, then register this modem control.

I don't think this has been done before for this type of device
so it could be a bit tricky, but it is probably the right thing to
do.

#include <linux/gpio/machine.h>
#include <linux/gpio/consumer.h>

Then look in e.g. drivers/mfd/sm501.c which is an
MFD device that register a gpiochip and then consume
GPIOs from itself. In the function
sm501_register_gpio_i2c_instance() this driver registers
a table of dynamic gpios associated with a separate subdevice.
A separate subdevice probably isn't needed but
something like this will be needed, albeit with the gpiochip
spawn off the main device for FT260.

The core idea is that the serial modem control should look
up the GPIOs from its own gpiochip and use the MCTRL
library helpers, then this should result in very little and
compact code that is easy to read.

Yours,
Linus Walleij
