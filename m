From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RESEND 0/8] i2c: Relax mandatory I2C ID table passing
Date: Fri, 29 Aug 2014 09:58:04 +0100
Message-ID: <20140829085804.GE24579@lee--X1>
References: <1409236538-21274-1-git-send-email-lee.jones@linaro.org>
 <20140829084538.GC1329@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140829084538.GC1329@katana>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 29 Aug 2014, Wolfram Sang wrote:
> > Placing this firmly back on your plate.  I truly hope we don't miss
> > another merge-window.
>=20
> Nope, we won't. I'll still need a week or so due to other duties.

Perfectly reasonable.

> > This patch-set has the support of some pretty
> > senior kernel maintainers, so I hope acceptance shouldn't be too
> > difficult.
>=20
> Cool, then they could ack it like Grant did? That surely helps.

I was talking about Grant (and Linus - I'll poke him seperately). ;)

> > As previously discussed I believe it should be okay for an I2C devi=
ce
> > driver _not_ supply an I2C ID table to match to.
>=20
> I agree...
>=20
> > The I2C subsystem
> > should be able to match via other means, such as via OF tables.  Th=
e
> > blocking factor during our previous conversation was to keep
> > registering via sysfs up and running.  This set does that.
>=20
> ... yet it also should not cause regressions. If you fixed that, soun=
ds
> great!
>
> > After thinking more deeply about the problem, it occurred to me tha=
t
> > any I2C device driver which uses the sysfs method and issues an
> > of_match_device() would also fail their probe().  Bolted on to this
> > set is a new, more generic way for these devices to match against
> > either of the I2C/OF tables.
>=20
> Even better :) I am generally positive with your patchset, but need t=
o
> review the implementation. For core stuff, this simply needs more
> attention.

Agree.

Thanks Wolfram.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
