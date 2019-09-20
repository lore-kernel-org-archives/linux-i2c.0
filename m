From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [BUG] sun4i: axp209: no atomic i2c transfer handler
Date: Fri, 20 Sep 2019 16:39:41 +0800
Message-ID: <CAGb2v65JrZXV9vb6pbCHfJvE3AawBxcWEpQH7C3woxnXpbN7vw@mail.gmail.com>
References: <20190920083237.GA11657@plaes.org>
Reply-To: wens-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBBXFASLWAKGQEAUPVXDQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20190920083237.GA11657-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
Cc: Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, priit.laes-RQIl3+LPqAc@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Sep 20, 2019 at 4:32 PM Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org> wrote:
>
> Heya!
>
> I have seen following warning message for few times when shutting down the
> machine (Olinuxino Lime2-emmc) running the mainline kernel.
>
> [snip]
> WARNING: CPU: 0 PID: 1 at drivers/i2c/i2c-core.h:41 i2c_transfer+0xe8/0xf4
> No atomic I2C transfer handler for 'i2c-1'
> Modules linked in: enc28j60
> CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted 5.3.0-rc8-paf+ #28
> Hardware name: Allwinner sun7i (A20) Family
> [<c010ee08>] (unwind_backtrace) from [<c010b5b8>] (show_stack+0x10/0x14)
> [<c010b5b8>] (show_stack) from [<c06bf2b4>] (dump_stack+0x88/0x9c)
> [<c06bf2b4>] (dump_stack) from [<c011e044>] (__warn+0xd4/0xf0)
> [<c011e044>] (__warn) from [<c011dbe4>] (warn_slowpath_fmt+0x48/0x6c)
> [<c011dbe4>] (warn_slowpath_fmt) from [<c051ce20>] (i2c_transfer+0xe8/0xf4)
> [<c051ce20>] (i2c_transfer) from [<c051ce78>] (i2c_transfer_buffer_flags+0x4c/0x70)
> [<c051ce78>] (i2c_transfer_buffer_flags) from [<c046c2a4>] (regmap_i2c_write+0x14/0x30)
> [<c046c2a4>] (regmap_i2c_write) from [<c0468180>] (_regmap_raw_write_impl+0x588/0x63c)
> [<c0468180>] (_regmap_raw_write_impl) from [<c0468b50>] (regmap_write+0x3c/0x5c)
> [<c0468b50>] (regmap_write) from [<c046f554>] (axp20x_power_off+0x2c/0x38)
> [<c046f554>] (axp20x_power_off) from [<c013e8a4>] (sys_reboot+0x14c/0x1e0)
> [<c013e8a4>] (sys_reboot) from [<c0101000>] (ret_fast_syscall+0x0/0x54)
> Exception stack(0xef04ffa8 to 0xef04fff0)
> ffa0:                   00427954 00000000 fee1dead 28121969 4321fedc 16814300
> ffc0: 00427954 00000000 00000000 00000058 bec15c78 00000000 bec15c10 004266f8
> ffe0: 00000058 bec15b6c b6f69d45 b6eeb746
> [/snip]
>
> The enc28j60 module is SPI, so it has nothing to do with the message.
>
> Any ideas where to look?

This looks like it's complaining that i2c-1 (i2c-mv64xxx) does not have
.master_xfer_atomic , which should be used in atomic contexts.

include/linux/i2c.h says:

   @master_xfer_atomic: same as @master_xfer. Yet, only using atomic context
     so e.g. PMICs can be accessed very late before shutdown. Optional.

ChenYu
