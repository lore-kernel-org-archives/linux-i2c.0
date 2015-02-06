From: Dmitry Torokhov <dtor-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [v7,2/3] i2c: iproc: Add Broadcom iProc I2C Driver
Date: Fri, 6 Feb 2015 14:48:31 -0800
Message-ID: <CAE_wzQ-POweLLmTyHoMvs_NESjW5UmPxh2ZQCaW4-W74MsrHag@mail.gmail.com>
References: <1421704310-26857-3-git-send-email-rjui@broadcom.com>
	<20150206223149.GB345@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150206223149.GB345-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dtor-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Feb 6, 2015 at 2:31 PM, Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> On Mon, Jan 19, 2015 at 01:51:49PM -0800, Ray Jui wrote:
>> +
>> +     dev_dbg(iproc_i2c->device, "xfer %c, addr=0x%02x, len=%d\n",
>> +             (msg->flags & I2C_M_RD) ? 'R' : 'W', msg->addr,
>> +             msg->len);
>> +     dev_dbg(iproc_i2c->device, "**** data start ****\n");
>> +     for (i = 0; i < msg->len; i++)
>> +             dev_dbg(iproc_i2c->device, "0x%02x ",  msg->buf[i]);
>> +     dev_dbg(iproc_i2c->device, "**** data end ****\n");
>
> It might be simpler to just do:
>
>     print_hex_dump_bytes("iproc_i2c:", DUMP_PREFIX_NONE, msg->buf, msg->len);
>
> although you'd lose the ability to see the I2C device name.

We can also do:

dev_dbg(iproc_i2c->device, "*** data: %*ph\n", msg->len, msg->buf);

if we are OK with limiting output to 64 bytes.

Thanks,
Dmitry
