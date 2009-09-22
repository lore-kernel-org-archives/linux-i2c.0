From: Ben Gardner <gardner.ben-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ds2482: Discard obsolete detect method
Date: Tue, 22 Sep 2009 15:08:07 -0500
Message-ID: <808c8e9d0909221308u44798896u9a0e87d63e6feab7@mail.gmail.com>
References: <20090920133459.1455416e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090920133459.1455416e-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, Sep 20, 2009 at 6:34 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> There is no point in implementing a detect callback for the DS2482, as
> this device can't be detected. It was there solely to handle "force"
> module parameters to instantiate devices, but now we have a better sysfs
> interface that can do the same.
>
> So we can get rid of the ugly module parameters and the detect callback.
> This shrinks the binary module size by 21%.
>
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Ben Gardner <gardner.ben-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Acked-by: Ben Gardner <gardner.ben-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

> +$ echo ds2482 0x18 > /sys/bus/i2c/devices/i2c-0/new_device

I learned something new today. =)

Thanks,
Ben
