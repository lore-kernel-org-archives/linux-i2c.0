From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 4/5] dt-bindings: at25: add reference for the wp-gpios
 property
Date: Tue, 14 Jan 2020 15:42:14 +0100
Message-ID: <20200114144214.GA1898224@kroah.com>
References: <20200107092922.18408-1-ktouil@baylibre.com>
 <20200107092922.18408-5-ktouil@baylibre.com>
 <20200108205447.GA16981@bogus>
 <CAMpxmJXffr-S51udNmUyMHz687jAoBKrYspNypfUUqjOD45zxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727285AbgANOmR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 14 Jan 2020 09:42:17 -0500
Content-Disposition: inline
In-Reply-To: <CAMpxmJXffr-S51udNmUyMHz687jAoBKrYspNypfUUqjOD45zxQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Khouloud Touil <ktouil@baylibre.com>, baylibre-upstreaming@groups.io, LKML <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>, linux-devicetree <devicetree@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>

On Thu, Jan 09, 2020 at 10:47:56AM +0100, Bartosz Golaszewski wrote:
> śr., 8 sty 2020 o 21:54 Rob Herring <robh@kernel.org> napisał(a):
> >
> > On Tue,  7 Jan 2020 10:29:21 +0100, Khouloud Touil wrote:
> > > As the at25 uses the NVMEM subsystem, and the property is now being
> > > handled, adding reference for it in the device tree binding document,
> > > which allows to specify the GPIO line to which the write-protect pin
> > > is connected.
> > >
> > > Signed-off-by: Khouloud Touil <ktouil@baylibre.com>
> > > ---
> > >  Documentation/devicetree/bindings/eeprom/at25.txt | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Hi Greg,
> 
> AT25 patches usually go through the char-misc tree. In this case
> however, the change depends on the other patches in this series. Can
> you ack this and I'll take it through the AT24 tree exceptionally?

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
