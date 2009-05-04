From: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Subject: Re: [PATCH] i2c: Do not give adapters a default parent
Date: Mon, 4 May 2009 14:40:36 +0200
Message-ID: <ac3eb2510905040540k65afe3f8k7e6c696d11bf7e1d@mail.gmail.com>
References: <20090426103025.4525edd3@hyperion.delvare> <20090504124341.42405e79@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090504124341.42405e79-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, May 4, 2009 at 12:43, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> We don't need to give adapters a parent if they don't have one. The
> driver core will put them in the virtual device directory and all will
> be fine.
>
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> ---
> Much better than my first attempt. Not sure what will happen if we ever
> turn i2c-adapters into bus devices. I see that the driver core puts
> class devices without a parent in virtual, but what about _bus_ devices

I'm sure, that "virtual" logic could be done for bus devices too, if
it's needed. I don't see any reason why that wouldn't be fine.

(The less difference between classes and buses the better. It is wrong
to have two types of subsystems, doing almost the same thing. One
could argue that it could be useful inside the kernel, which it isn't,
I think, but exporting them to userspace was definitely the wrong
thing.)

Thanks,
Kay
