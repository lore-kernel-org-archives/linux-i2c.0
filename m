From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/3] i2c: nomadik: Add Device Tree support to the Nomadik
 I2C driver
Date: Mon, 3 Sep 2012 12:32:35 +0100
Message-ID: <CAF2Aj3j25w1Nn9O6hV+=i-j1ts_p_Ucswk_M7r04S7i5BzPkHg@mail.gmail.com>
References: <1345734087-21803-1-git-send-email-lee.jones@linaro.org>
 <1345734087-21803-3-git-send-email-lee.jones@linaro.org>
 <20120831112258.GA2624@pengutronix.de>
 <20120831122323.GC5962@gmail.com>
 <CACRpkdZ=C1EV4WO2b=1YLHPNhsDsQdq7Kfnpzm8i7uGRtVjJuQ@mail.gmail.com>
 <20120903094448.GB11780@pengutronix.de>
 <20120903100656.GC5782@gmail.com>
 <CACRpkdb8owKBxawAv4LVVYx5kUgZ9cUSiQ=BV0f3Pf3bHtknuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2287677346671148817=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACRpkdb8owKBxawAv4LVVYx5kUgZ9cUSiQ=BV0f3Pf3bHtknuQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linus.walleij@stericsson.com, arnd@arndb.de, Wolfram Sang <w.sang@pengutronix.de>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

--===============2287677346671148817==
Content-Type: multipart/alternative; boundary=bcaec502d4e489650104c8ca7f1a

--bcaec502d4e489650104c8ca7f1a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Looking at this again ...

On 3 September 2012 12:07, Linus Walleij <linus.walleij@linaro.org> wrote:

> On Mon, Sep 3, 2012 at 12:07 PM, Lee Jones <lee.jones@linaro.org> wrote:
>
> (...)
> > +       if (np) {
> > +               if (!pdata) {
> > +                       pdata =3D devm_kzalloc(&adev->dev, sizeof(*pdat=
a),
> GFP_KERNEL);
> > +                       if (!pdata) {
> > +                               ret =3D -ENOMEM;
> > +                               goto err_no_mem;
> > +                       }
> > +               }
> > +               /* Provide the default configuration as a base. */
> > +               memcpy(pdata, &u8500_i2c, sizeof(struct
> nmk_i2c_controller));
>
> Here you blank out any pdata passed from say a board file or
> whatever if pdata !=3D NULL.
>

Right, this should be in 'if (!pdata) {}' . I'll correct this now.


>
> > +
> > +               nmk_i2c_of_probe(np, pdata);
> > +       }
> > +
> >         if (!pdata)
> >                 /* No i2c configuration found, using the default. */
> >                 pdata =3D &u8500_i2c;
>
> So this is still wrong, if pdata is passed to the driver it will
> not override the DT, you have the semantics the other way
> around, DT overrides pdata.
>

This is correct, however. If there is DT, it should override any platform
data.

Actually, if there is DT then no platform data should be passed in the
first place.


> Look at the switch statement in my previous comment,
> just add the allocations and a memcpy() and it still holds:
>
> if (!pdata) {
>     if (np) {
>               pdata =3D devm_kzalloc(&adev->dev, sizeof(*pdata), GFP_KERN=
EL);
>                       if (!pdata) {
>                               ret =3D -ENOMEM;
>                               goto err_no_mem;
>                       }
>               }
>               /* Provide the default configuration as a base. */
>               memcpy(pdata, &u8500_i2c, sizeof(struct nmk_i2c_controller)=
);
>               nmk_i2c_of_probe(np, pdata);
>     } else
>          /* Just use the static pdata */
>          pdata =3D &u8500_i2c;
> }
>
>
No, this is wrong. Platform data should not override DT.

If DT is enabled and passed, it should have highest priority.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--bcaec502d4e489650104c8ca7f1a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Looking at this again ...<br><br><div class=3D"gmail_quote">On 3 September =
2012 12:07, Linus Walleij <span dir=3D"ltr">&lt;<a href=3D"mailto:linus.wal=
leij@linaro.org" target=3D"_blank">linus.walleij@linaro.org</a>&gt;</span> =
wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Mon, Sep 3, 2012 at 12:=
07 PM, Lee Jones &lt;<a href=3D"mailto:lee.jones@linaro.org">lee.jones@lina=
ro.org</a>&gt; wrote:<br>

<br>
(...)<br>
</div><div class=3D"im">&gt; + =C2=A0 =C2=A0 =C2=A0 if (np) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!pdata) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 pdata =3D devm_kzalloc(&amp;adev-&gt;dev, sizeof(*pdata), GFP_KE=
RNEL);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (!pdata) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_no_mem;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Provide the defa=
ult configuration as a base. */<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(pdata, &amp;=
u8500_i2c, sizeof(struct nmk_i2c_controller));<br>
<br>
</div>Here you blank out any pdata passed from say a board file or<br>
whatever if pdata !=3D NULL.<br></blockquote><div><br></div><div>Right, thi=
s should be in &#39;if (!pdata) {}&#39; . I&#39;ll correct this now.</div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">

<div class=3D"im"><br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nmk_i2c_of_probe(np=
, pdata);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!pdata)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* No i2c conf=
iguration found, using the default. */<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pdata =3D &amp=
;u8500_i2c;<br>
<br>
</div>So this is still wrong, if pdata is passed to the driver it will<br>
not override the DT, you have the semantics the other way<br>
around, DT overrides pdata.<br></blockquote><div><br></div><div>This is cor=
rect, however. If there is DT, it should override any platform data.=C2=A0<=
/div><div><br></div><div>Actually, if there is DT then no platform data sho=
uld be passed in the first place.</div>
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
Look at the switch statement in my previous comment,<br>
just add the allocations and a memcpy() and it still holds:<br>
<br>
if (!pdata) {<br>
=C2=A0 =C2=A0 if (np) {<br>
<div class=3D"im">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pdata =
=3D devm_kzalloc(&amp;adev-&gt;dev, sizeof(*pdata), GFP_KERNEL);<br>
</div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (!pdata) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_no_mem;<br>
<div class=3D"im">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Provide the default con=
figuration as a base. */<br>
</div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(pdata, &amp;u=
8500_i2c, sizeof(struct nmk_i2c_controller));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nmk_i2c_of_probe(np, pdata=
);<br>
=C2=A0 =C2=A0 } else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Just use the static pdata */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pdata =3D &amp;u8500_i2c;<br>
}<br>
<br></blockquote><div><br></div><div>No, this is wrong. Platform data shoul=
d not override DT.=C2=A0</div><div><br></div><div>If DT is enabled and pass=
ed, it should have highest priority.</div></div><div><br></div>-- <br>Lee J=
ones
<br>Linaro ST-Ericsson Landing Team Lead
<br>Linaro.org =E2=94=82 Open source software for ARM SoCs
<br>Follow Linaro: Facebook | Twitter | Blog=C2=A0<br>

--bcaec502d4e489650104c8ca7f1a--


--===============2287677346671148817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2287677346671148817==--
