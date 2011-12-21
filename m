From: Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v4] I2C: add CSR SiRFprimaII on-chip I2C controllers
 driver
Date: Wed, 21 Dec 2011 11:47:54 +0800
Message-ID: <20111221034753.GC5983@S2101-09.ap.freescale.net>
References: <1323852927-13521-1-git-send-email-Barry.Song@csr.com>
 <20111220200750.GA2577@n2100.arm.linux.org.uk>
 <CAGsJ_4y8vwrK=UD8a10gf2aN=O3hs_R_jYBKeFYf0v+gk0hiuQ@mail.gmail.com>
 <20111221033444.GH15863@b20223-02.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20111221033444.GH15863-iWYTGMXpHj9ITqJhDdzsOjpauB2SiJktrE5yTffgRl4@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Xiangzhen Ye <Xiangzhen.Ye-kQvG35nSl+M@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org, Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>, omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>, jamie-wmLquQDDieKakBO8gow8eQ@public.gmane.org, Yuping Luo <Yuping.Luo-kQvG35nSl+M@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Dec 21, 2011 at 11:34:45AM +0800, Richard Zhao wrote:
> On Wed, Dec 21, 2011 at 11:29:29AM +0800, Barry Song wrote:
> > 2011/12/21 Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>:
> > > On Wed, Dec 14, 2011 at 04:55:27PM +0800, Barry Song wrote:
> > >> +static int __devinit i2c_sirfsoc_probe(struct platform_device *=
pdev)
> > >> +{
> > >> + =A0 =A0 struct clk *clk;
> > >> +
> > >> + =A0 =A0 clk =3D clk_get(&pdev->dev, NULL);
> > >> + =A0 =A0 err =3D clk_prepare(clk);
> > >> + =A0 =A0 err =3D clk_enable(clk);
> > > ...
> > >> + =A0 =A0 clk_disable(clk);
> > >> +
> > >> + =A0 =A0 dev_info(&pdev->dev, " I2C adapter ready to operate\n"=
);
> > >> +
> > >> + =A0 =A0 return 0;
> > >> +}
> > >> +
> > >> +static int __devexit i2c_sirfsoc_remove(struct platform_device =
*pdev)
> > >> +{
> > >> + =A0 =A0 clk_disable(siic->clk);
> > >> + =A0 =A0 clk_unprepare(siic->clk);
> > >> + =A0 =A0 clk_put(siic->clk);
> > >
> There's a handy clk_disable_unprepare function in the patch I ever se=
nt
> out. It's in Sascha or Shawn's tree.
>=20
We cannot really ask people to use that before it hits Linus' tree.

--=20
Regards,
Shawn
