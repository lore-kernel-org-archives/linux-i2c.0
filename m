From: Eugeni Dodonov <eugeni@dodonov.net>
Subject: Re: [PATCH 6/7] drm/i915: i2c: unconditionally set up gpio fallback
Date: Tue, 14 Feb 2012 21:47:01 -0200
Message-ID: <CAC7LmnvP0wUroQq6VJ3QeoWDy=WEk_UcfkKiuYx=hWZ8WT6tMQ@mail.gmail.com>
References: <1329255445-6312-1-git-send-email-daniel.vetter@ffwll.ch>
	<1329255445-6312-6-git-send-email-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1833558520=="
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1329255445-6312-6-git-send-email-daniel.vetter@ffwll.ch>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>, linux-i2c@vger.kernel.org, DRI Development <dri-devel@lists.freedesktop.org>
List-Id: linux-i2c@vger.kernel.org

--===============1833558520==
Content-Type: multipart/alternative; boundary=047d7b10ccdb7ea53404b8f538b1

--047d7b10ccdb7ea53404b8f538b1
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Feb 14, 2012 at 19:37, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:

>        /* Hardware may not support GMBUS over these pins? Try GPIO
> bitbanging instead. */
> -       bus->force_bit = intel_gpio_create(bus, bus->reg0 & 0xff);
> -       if (!bus->force_bit)
> -               ret = -ENOMEM;
> -       else
> -               ret = intel_i2c_quirk_xfer(bus, bus->force_bit, msgs, num);
> +       ret = -EIO;
> +       if (bus->has_gpio) {
> +               bus->force_bit = true;
> +               ret = intel_i2c_quirk_xfer(bus, msgs, num);
> +       }
>

<bikeshedding>
Wouldn't it be cleaner and more consistent with the rest of the code to use:

if (!bus->has_gpio)
    ret = -EIO;
else {
    bus->force_bit = true;
    ret = intel_i2c_quirk_xfer(bus, msgs, num);
}

instead?
</bikeshedding>

Other than that, it looks correct to me, and certainly makes code more
clean.

Reviewed-by: Eugeni Dodonov <eugeni.dodonov@intel.com>

-- 
Eugeni Dodonov
<http://eugeni.dodonov.net/>

--047d7b10ccdb7ea53404b8f538b1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Tue, Feb 14, 2012 at 19:37, Daniel Vetter <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:daniel.vetter@ffwll.ch">daniel.vetter@=
ffwll.ch</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

=A0 =A0 =A0=A0 /* Hardware may not support GMBUS over these pins? Try GPIO =
bitbanging instead. */<br>
- =A0 =A0 =A0 bus-&gt;force_bit =3D intel_gpio_create(bus, bus-&gt;reg0 &am=
p; 0xff);<br>
- =A0 =A0 =A0 if (!bus-&gt;force_bit)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;<br>
- =A0 =A0 =A0 else<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D intel_i2c_quirk_xfer(bus, bus-&gt;for=
ce_bit, msgs, num);<br>
+ =A0 =A0 =A0 ret =3D -EIO;<br>
+ =A0 =A0 =A0 if (bus-&gt;has_gpio) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus-&gt;force_bit =3D true;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D intel_i2c_quirk_xfer(bus, msgs, num);=
<br>
+ =A0 =A0 =A0 }<br></blockquote><div><br>&lt;bikeshedding&gt;<br>Wouldn&#39=
;t it be cleaner and more consistent with the rest of the code to use:<br><=
br>if (!bus-&gt;has_gpio)<br>=A0=A0=A0 ret =3D -EIO;<br>else {<br>=A0=A0=A0=
 bus-&gt;force_bit =3D true;<br>

=A0=A0=A0 ret =3D intel_i2c_quirk_xfer(bus, msgs, num);<br>}<br><br>instead=
?<br>&lt;/bikeshedding&gt;<br><br>Other than that, it looks correct to me, =
and certainly makes code more clean.<br clear=3D"all"></div></div><br>Revie=
wed-by: Eugeni Dodonov &lt;<a href=3D"mailto:eugeni.dodonov@intel.com">euge=
ni.dodonov@intel.com</a>&gt;<br>

<br>-- <br>Eugeni Dodonov<a href=3D"http://eugeni.dodonov.net/" target=3D"_=
blank"><br></a><br>

--047d7b10ccdb7ea53404b8f538b1--

--===============1833558520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============1833558520==--
