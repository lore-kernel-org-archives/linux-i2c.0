From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: randconfig build error with next-20140604, in drivers/i2c/muxes/i2c-mux-pca954x.c
Date: Mon, 09 Jun 2014 15:31:40 +0200
Message-ID: <14609786.lXROpz1lS8@avalon>
References: <CA+r1Zhi9Qd4aZ2WJ02K4Gv=zg7QvG+r=t2VpiXRKXcYRc1vt=A@mail.gmail.com> <CACRpkdZO_vE1VnJ6=gEdX8P-qNADsskJkMOdaRDg-TabTSySCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdZO_vE1VnJ6=gEdX8P-qNADsskJkMOdaRDg-TabTSySCQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Jim Davis <jim.epost-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, linux-next <linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Monday 09 June 2014 15:12:01 Linus Walleij wrote:
> On Wed, Jun 4, 2014 at 6:44 PM, Jim Davis <jim.epost-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote=
:
> > Building with the attached random configuration file,
> >=20
> > drivers/i2c/muxes/i2c-mux-pca954x.c: In function =E2=80=98pca954x_p=
robe=E2=80=99:
> > drivers/i2c/muxes/i2c-mux-pca954x.c:204:2: error: implicit declarat=
ion
> > of function =E2=80=98devm_gpiod_get=E2=80=99 [-Werror=3Dimplicit-fu=
nction-declaration]
> >=20
> >   gpio =3D devm_gpiod_get(&client->dev, "reset");
> >   ^
> >=20
> > drivers/i2c/muxes/i2c-mux-pca954x.c:204:7: warning: assignment make=
s
> > pointer from integer without a cast [enabled by default]
> >=20
> >   gpio =3D devm_gpiod_get(&client->dev, "reset");
> >  =20
> >        ^
> >=20
> > drivers/i2c/muxes/i2c-mux-pca954x.c:206:3: error: implicit declarat=
ion
> > of function =E2=80=98gpiod_direction_output=E2=80=99
> > [-Werror=3Dimplicit-function-declaration]
> >=20
> >    gpiod_direction_output(gpio, 0);
> >    ^
> >=20
> > cc1: some warnings being treated as errors
> > make[3]: *** [drivers/i2c/muxes/i2c-mux-pca954x.o] Error 1
>=20
> I've sent a patch for this to Wolfram and the i2c discuss list.

https://git.kernel.org/cgit/linux/kernel/git/wsa/linux.git/commit/?h=3D=
i2c/for-next&id=3D642653d16a0f8e78b7a25d930b62aa771ebc939c

--=20
Regards,

Laurent Pinchart
