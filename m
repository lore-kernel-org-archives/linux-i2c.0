From: Ben Gardner <gardner.ben-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] max6875: Discard obsolete detect method
Date: Tue, 22 Sep 2009 15:05:35 -0500
Message-ID: <808c8e9d0909221305g468c02f7xd66d7a0f1a844928@mail.gmail.com>
References: <20090920120746.5bc4e1f0@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090920120746.5bc4e1f0-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, Sep 20, 2009 at 5:07 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> There is no point in implementing a detect callback for the MAX6875, as
> this device can't be detected. It was there solely to handle "force"
> module parameters to instantiate devices, but now we have a better sysfs
> interface that can do the same.
>
> So we can get rid of the ugly module parameters and the detect callback.
> This basically divides the binary module size by 2.
>
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Ben Gardner <gardner.ben-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Thanks for taking care of this.

Acked-by: Ben Gardner <gardner.ben-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Ben
