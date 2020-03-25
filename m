From: Sergey Semin <Sergey.Semin-UN2wsyeM1qLJ45LvJ/SUn8gurn75+9Lz@public.gmane.org>
Subject: Re: [PATCH 3/6] dt-bindings: i2c: dw: Add Baikal-T1 SoC I2C
 controller
Date: Thu, 26 Mar 2020 00:09:41 +0300
Message-ID: <20200325210941.x6wqnlmauxmfkd4j@ubsrv2.baikal.int>
References: <20200306131955.12806-1-Sergey.Semin@baikalelectronics.ru>
 <20200306132018.C268A8030792@mail.baikalelectronics.ru>
 <20200312214340.GA30360@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200312214340.GA30360@bogus>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Alexey Malahov <Alexey.Malahov-UN2wsyeM1qLJ45LvJ/SUn8gurn75+9Lz@public.gmane.org>, Thomas Bogendoerfer <tsbogend-I1c7kopa9pxLokYuJOExCg@public.gmane.org>, Paul Burton <paulburton-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Mar 12, 2020 at 04:43:40PM -0500, Rob Herring wrote:
> On Fri, 6 Mar 2020 16:19:52 +0300, <Sergey.Semin-UN2wsyeM1qLJ45LvJ/SUn8gurn75+9Lz@public.gmane.org> wrote:
> > From: Serge Semin <Sergey.Semin-UN2wsyeM1qLJ45LvJ/SUn8gurn75+9Lz@public.gmane.org>
> > 
> > Just add the "be,bt1-i2c" compatible string to the bindings. The rest of
> > the DW APB I2C properties can be freely used to describe the Baikal-T1
> > I2C controller dts-node.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin-UN2wsyeM1qLJ45LvJ/SUn8gurn75+9Lz@public.gmane.org>
> > Signed-off-by: Alexey Malahov <Alexey.Malahov-UN2wsyeM1qLJ45LvJ/SUn8gurn75+9Lz@public.gmane.org>
> > Cc: Thomas Bogendoerfer <tsbogend-I1c7kopa9pxLokYuJOExCg@public.gmane.org>
> > Cc: Paul Burton <paulburton-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > Cc: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
> > ---
> >  Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> 
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Seeing you and us having doubts regarding our vendor prefix and the
corresponding patch still hasn't been accepted, in the next patchset release
perhaps I will have to change the compatible string of this driver. It depends
on a result of the discussion: https://lkml.org/lkml/2020/3/13/239

Rob, could you get back to it, so we could come up with a solution?

Currently most of our team members are leaning towards "baikal,t1" = "vendor,chip"
prefixes to all the SoC specific devices. So the Baikal-T1 I2C compatible string
would be renamed to "baikal,t1-i2c". What do you think?

Regards,
-Sergey
