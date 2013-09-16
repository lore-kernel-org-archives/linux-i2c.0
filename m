From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/4 v2] mfd: add STw481x driver
Date: Mon, 16 Sep 2013 16:34:14 +0100
Message-ID: <20130916153414.GN16984@lee--X1>
References: <1379094851-26385-1-git-send-email-linus.walleij@linaro.org>
 <20130916091956.GF3999@lee--X1>
 <20130916104009.GA29403@sirena.org.uk>
 <CACRpkdatiELF3WK9qE_Mgcq3iCgv5w3X22xp1=232JJq9sWggQ@mail.gmail.com>
 <20130916135118.GD29403@sirena.org.uk>
 <20130916152104.GA3909@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130916152104.GA3909@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wang Shilong <wangshilong1991@gmail.com>
List-Id: linux-i2c@vger.kernel.org

On Mon, 16 Sep 2013, Wolfram Sang wrote:

>=20
> On Mon, Sep 16, 2013 at 02:51:18PM +0100, Mark Brown wrote:
> > On Mon, Sep 16, 2013 at 02:44:35PM +0200, Linus Walleij wrote:
> >=20
> > > I've tried to fix this for DT-only I2C devices
> > > and this very driver was the reason.
> >=20
> > > But a tiresome regression due to drivers relying on this
> > > i2c_device_id not being NULL and inability to remove it from the =
I2C
> > > core without refactoring the world ensued, see:
> > > commit c80f52847c50109ca248c22efbf71ff10553dca4
> >=20
> > Oh, that was the change...
> >=20
> > > Reverted in:
> > > commit 661f6c1cd926c6c973e03c6b5151d161f3a666ed
> >=20
> > > For this reason I think:
> > > http://marc.info/?l=3Dlinux-next&m=3D137148411231784&w=3D2
> >=20
> > > I have tentatively given up getting pure DT I2C drivers
> > > to probe, I don't think I have the whole picture, but
> > > Wolfram has serious doubts about this and say we have
> > > to be careful ....
> >=20
> > > Wolfram, do you have some ideas on how we should
> > > proceed or ar you happy with merging this as-is?
> >=20
> > I'd have expected that it should be possible to change things such =
that
> > the change in the core doesn't produce any change in behaviour for
> > existing drivers.  Can we not change the patch so that i2c_match_id=
()
> > copes with getting a NULL id_table?  Something like this:
>=20
> I hacked something like this after Linus posted his approach. However=
, I
> found out that run time instanciating ('new_device' file) needs an
> id_table. I wasn't to keen on disabling the feature for dt-only drive=
rs.
> That's where I stopped, due to lack of time.

So in the mean time are you happy with this "dummy" approach?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
