From: Po-Yu Chuang <ratbert.chuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: add Faraday FTIIC010 I2C controller support
Date: Thu, 23 Jun 2011 14:16:27 +0800
Message-ID: <BANLkTim=xdGKaCg0HzirYX5zs1TQn7Gu_g@mail.gmail.com>
References: <1308032369-1615-1-git-send-email-ratbert.chuang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1308032369-1615-1-git-send-email-ratbert.chuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Po-Yu Chuang <ratbert-w0jeGXs5+AWXmMXjJBpWqg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi all,

On Tue, Jun 14, 2011 at 2:19 PM, Po-Yu Chuang <ratbert.chuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
> wrote:
> From: Po-Yu Chuang <ratbert-w0jeGXs5+AWXmMXjJBpWqg@public.gmane.org>
>
> Support for Faraday FTIIC010 I2C controller. It is used on
> Faraday A320, A369 and some other ARM SoC's.
>
> Signed-off-by: Po-Yu Chuang <ratbert-w0jeGXs5+AWXmMXjJBpWqg@public.gmane.org>
> ---
> =C2=A0drivers/i2c/busses/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =
=C2=A07 +
> =C2=A0drivers/i2c/busses/Makefile =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0=
1 +
> =C2=A0drivers/i2c/busses/i2c-ftiic010.c | =C2=A0434 +++++++++++++++++=
++++++++++++++++++++
> =C2=A0drivers/i2c/busses/i2c-ftiic010.h | =C2=A0155 +++++++++++++
> =C2=A04 files changed, 597 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 drivers/i2c/busses/i2c-ftiic010.c
> =C2=A0create mode 100644 drivers/i2c/busses/i2c-ftiic010.h

Any comments are appreciated.

Best regards,
Po-Yu Chuang
