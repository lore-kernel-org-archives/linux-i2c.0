From: Laurent Navet <laurent.navet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] driver i2c-nforce2: fix pointer CodingStyle issues
Date: Tue, 18 Dec 2012 11:05:33 +0100
Message-ID: <CAH7P7Nhz2FpBct4afvAXU2Zgi-yA4TkJj7CtYMaW7pXr6weZig@mail.gmail.com>
References: <1355778259-8445-1-git-send-email-laurent.navet@gmail.com>
	<20121218105223.0184d4a3@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121218105223.0184d4a3-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi guys,

> This is correct, however there are several other checkpatch errors and
> warnings in this file and I would appreciate if you could fix them as
> well. I'm not asking that you fix them all, but please consider fixing
> the following:
>
> WARNING: space prohibited between function name and open parenthesis '('
> #63: FILE: i2c/busses/i2c-nforce2.c:63:
> +MODULE_AUTHOR ("Hans-Frieder Vogt <hfvogt-hi6Y0CQ0nG0@public.gmane.org>");
>
> WARNING: suspect code indent for conditional statements (24, 33)
> #226: FILE: i2c/busses/i2c-nforce2.c:226:
> +			if (read_write == I2C_SMBUS_WRITE) {
> +				 outb_p(data->word, NVIDIA_SMB_DATA);
>
> WARNING: line over 80 characters
> #275: FILE: i2c/busses/i2c-nforce2.c:275:
> +			data->word = inb_p(NVIDIA_SMB_DATA) | (inb_p(NVIDIA_SMB_DATA+1) << 8);
>
> WARNING: quoted string split across lines
> #282: FILE: i2c/busses/i2c-nforce2.c:282:
> +				dev_err(&adap->dev, "Transaction failed "
> +					"(received block size: 0x%02x)\n",
>
> WARNING: space prohibited between function name and open parenthesis '('
> #330: FILE: i2c/busses/i2c-nforce2.c:330:
> +MODULE_DEVICE_TABLE (pci, nforce2_ids);
>
> WARNING: line over 80 characters
> #380: FILE: i2c/busses/i2c-nforce2.c:380:
> +	dev_info(&smbus->adapter.dev, "nForce2 SMBus adapter at %#x\n",
> smbus->base);
>
> ERROR: space required before the open parenthesis '('
> #395: FILE: i2c/busses/i2c-nforce2.c:395:
> +	switch(dev->device) {
>
> These are simple coding style issues, very easy to fix.

i have planned fixing these too, do you prefer one patch fixing all or
multiple patches (one per error/warning type )?

regards,
Laurent.
