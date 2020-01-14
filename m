From: Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v4 4/5] dt-bindings: at25: add reference for the wp-gpios property
Date: Tue, 14 Jan 2020 16:05:57 +0100
Message-ID: <CAMpxmJW8edEZw81iQkwDr-Umdb1ibb85s=EshQs4yXRFh5LP=A@mail.gmail.com>
References: <20200107092922.18408-1-ktouil@baylibre.com> <20200107092922.18408-5-ktouil@baylibre.com>
 <20200108205447.GA16981@bogus> <CAMpxmJXffr-S51udNmUyMHz687jAoBKrYspNypfUUqjOD45zxQ@mail.gmail.com>
 <20200114144214.GA1898224@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200114144214.GA1898224-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Khouloud Touil <ktouil-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, baylibre-upstreaming-GWfripvEmMdhl2p70BpVqQ@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

wt., 14 sty 2020 o 15:42 Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> napisa=C5=82(=
a):
>
> On Thu, Jan 09, 2020 at 10:47:56AM +0100, Bartosz Golaszewski wrote:
> > =C5=9Br., 8 sty 2020 o 21:54 Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> napisa=C5=82=
(a):
> > >
> > > On Tue,  7 Jan 2020 10:29:21 +0100, Khouloud Touil wrote:
> > > > As the at25 uses the NVMEM subsystem, and the property is now being
> > > > handled, adding reference for it in the device tree binding documen=
t,
> > > > which allows to specify the GPIO line to which the write-protect pi=
n
> > > > is connected.
> > > >
> > > > Signed-off-by: Khouloud Touil <ktouil-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/eeprom/at25.txt | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > >
> > > Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> >
> > Hi Greg,
> >
> > AT25 patches usually go through the char-misc tree. In this case
> > however, the change depends on the other patches in this series. Can
> > you ack this and I'll take it through the AT24 tree exceptionally?
>
> Acked-by: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>

Patch applied with Greg's Ack.

Bart
