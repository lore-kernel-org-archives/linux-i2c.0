From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: mxs: Do not disable the I2C SMBus quick mode
Date: Tue, 20 Nov 2012 09:36:58 -0200
Message-ID: <CAOMZO5C2KgCZKNsudwJmxqFcG-kZ0eaTU5Uu1vYCZ0QaOQi=0g@mail.gmail.com>
References: <1353216308-7338-1-git-send-email-marex@denx.de>
	<1353216308-7338-2-git-send-email-marex@denx.de>
	<CANqk_c-3t2Kn3cQjwzoSzMrKMD-W_0JByD4U=Bp_ZA3_seyuig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CANqk_c-3t2Kn3cQjwzoSzMrKMD-W_0JByD4U=Bp_ZA3_seyuig-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tim Michals <tcmichals-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fadil Berisha <f.koliqi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Tim,

On Mon, Nov 19, 2012 at 1:05 PM, Tim Michals <tcmichals-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> I tested both patches using Linux version 3.7.0-rc4 with the following
> command:
> #  i2cdetect -r 0 20 30
> Usage: i2cdetect [-y] [-a] [-q|-r] I2CBUS [FIRST LAST]
>        i2cdetect -F I2CBUS
>        i2cdetect -l
>   I2CBUS is an integer or an I2C bus name
>   If provided, FIRST and LAST limit the probing range.
> # i2cdetect -r 0 20 30
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0 using read byte commands.
> I will probe address range 0x14-0x1e.
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:
> 10:             -- [   31.830000] mxs-i2c 80058000.i2c: Failed to get PIO
> reg. .
> -- -- [   32.830000] mxs-i2c 80058000.i2c: Failed to get PIO reg. write
> descrip.
> -- -- [   33.830000] mxs-i2c 80058000.i2c: Failed to get PIO reg. write
> descrip.
> -- -- [   34.830000] mxs-i2c 80058000.i2c: Failed to get PIO reg. write
> descrip.
> -- -- [   35.830000] mxs-i2c 80058000.i2c: Failed to get PIO reg. write
> descrip.

Which I2C device you have in the bus? Can you share your dts?

Regards,

Fabio Estevam
