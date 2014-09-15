From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH RESEND 0/8] i2c: Relax mandatory I2C ID table passing
Date: Mon, 15 Sep 2014 23:46:21 +0100
Message-ID: <20140915224621.GG25162@lee--X1>
References: <1409236538-21274-1-git-send-email-lee.jones@linaro.org>
 <20140912134632.GE1930@katana>
 <CABxcv==OXd+uePcB8zDzB-DDmr9ci6zscHX5TCauWoTO6E4fpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CABxcv==OXd+uePcB8zDzB-DDmr9ci6zscHX5TCauWoTO6E4fpg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, kernel@stlinux.com, Linus Walleij <linus.walleij@linaro.org>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>
List-Id: linux-i2c@vger.kernel.org

On Fri, 12 Sep 2014, Javier Martinez Canillas wrote:

> [adding Sjoerd as cc who was the one that raised the module auto-load=
ing issue]
>=20
> Hello,
>=20
> On Fri, Sep 12, 2014 at 3:46 PM, Wolfram Sang <wsa@the-dreams.de> wro=
te:
> >>
> >> Placing this firmly back on your plate.  I truly hope we don't mis=
s
> >> another merge-window.  This patch-set has the support of some pret=
ty
> >> senior kernel maintainers, so I hope acceptance shouldn't be too
> >> difficult.
> >>
> >> As previously discussed I believe it should be okay for an I2C dev=
ice
> >> driver _not_ supply an I2C ID table to match to.  The I2C subsyste=
m
> >> should be able to match via other means, such as via OF tables.  T=
he
> >> blocking factor during our previous conversation was to keep
> >> registering via sysfs up and running.  This set does that.
> >
> > As mentioned in another thread, modaliases are one other possible s=
ide
> > effect. As Javier correctly mentions, the beaviour does not really
> > change with your patchset. Yet, if we remove i2c_device_id from dri=
vers
> > too carelessly, they might not be bound anymore.
> >
>=20
> Right, removing the I2C ID table even from drivers that don't really
> need it (e.g: IP blocks only present in DT platforms) will as you sai=
d
> break module auto-loading. Probing will work since the OF table is
> used to match the device in i2c_device_match() but is the I2C table
> what is used to fill the valid module aliases with the current
> behavior of i2c_device_uevent(), the aliases filled from the OF table
> are never used.
>=20
> So what I propose is to do it incrementally:
>=20
> 1) Merge Lee's series since that is definitely a step in the right
> direction to not make an I2C table mandatory (still will be needed fo=
r
> module auto loading though).
>=20
> 2) On a follow-up series, make sure that all I2C drivers have a prope=
r
> OF table and that are using the MODULE_DEVICE_TABLE(of,...) macro to
> fill the of:<foo> module aliases. That way the modules will have the
> proper aliases of the form "of:<foo>" besides the "i2c:<foo>" one.
> (even when always i2c:<foo> is reported to user-space currently).
>=20
> 3) Apply the patch I posted [0] that changes the behavior of
> i2c_device_uevent() to report the OF uevent env vars to user-space in
> case of DT probing which after 2) should not regress any driver modul=
e
> auto-loading since all drivers should fill the of:<foo> aliases.

This sounds resonable.

> After this, DT-only drivers will only need an OF table and legacy
> drivers will only need an I2C table. Drivers that support both will
> still need the two tables though which is a drawback of this approach
> since unnecessary duplication will exist on these drivers and can
> cause issues when both tables are not in sync as we saw on the issue
> reported by Sjoerd on [1].
>=20
> So an alternate approach could be to do the opposite, just remove the
> OF tables entirely from the I2C drivers and only use the I2C table
> even for DT-only drivers. This is possible since i2c_device_match()
> will succeed even without an OF table because i2c_match_id() matches
> for compatible strings and what is reported as uevent is what is in
> the I2C table anyways. I believe that is what Sjoerd suggested but
> I'll let him comment on that in case I misunderstood.

This would be really bad.  It would go completely against what I have
working to achieve and OF conventions.

> By the way, the SPI subsystem has the same behavior, I raised the iss=
ue on [2].
>=20
> Best regards,
> Javier
>=20
> [0]: https://lkml.org/lkml/2014/9/11/269
> [1]: https://lkml.org/lkml/2014/9/9/100
> [2]: https://lkml.org/lkml/2014/9/11/458

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
