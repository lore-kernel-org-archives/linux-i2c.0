From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/4 v2] mfd: add STw481x driver
Date: Tue, 17 Sep 2013 09:06:29 +0100
Message-ID: <20130917080629.GT16984@lee--X1>
References: <1379094851-26385-1-git-send-email-linus.walleij@linaro.org>
 <20130916091956.GF3999@lee--X1>
 <20130916104009.GA29403@sirena.org.uk>
 <CACRpkdatiELF3WK9qE_Mgcq3iCgv5w3X22xp1=232JJq9sWggQ@mail.gmail.com>
 <20130916135118.GD29403@sirena.org.uk>
 <20130916152104.GA3909@katana>
 <20130916153414.GN16984@lee--X1>
 <20130916160001.GC3909@katana>
 <20130916160537.GO16984@lee--X1>
 <20130916162428.GE29403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130916162428.GE29403-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wang Shilong <wangshilong1991-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 16 Sep 2013, Mark Brown wrote:

> On Mon, Sep 16, 2013 at 05:05:37PM +0100, Lee Jones wrote:
> > > > So in the mean time are you happy with this "dummy" approach?
>=20
> > > No. "dummy" is reserved for a dummy device in case an i2c slave n=
eeds
> > > more than one address. The proper solution would be if
> > > i2c_sysfs_new_device() could recognize the of_device_ids.
>=20
> > Okay, thanks for clarifying.
>=20
> Or for now to use something like stw481x (even if it's never expected=
 to
> actually make a difference).

If Linus wants to resubmit, I'm happy with that.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
