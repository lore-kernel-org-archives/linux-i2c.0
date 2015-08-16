From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH RFC] eeprom: at24: extend driver to plug into the NVMEM
 framework
Date: Sun, 16 Aug 2015 17:37:06 +0200 (CEST)
Message-ID: <1511754934.28154.1439739426390.JavaMail.open-xchange@oxbsltgw00.schlund.de>
References: <1439693649-10809-1-git-send-email-andrew@lunn.ch> <2080648987.23864.1439713686409.JavaMail.open-xchange@oxbsltgw04.schlund.de> <20150816131130.GC10094@lunn.ch>
Reply-To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150816131130.GC10094-g2DYL2Zd6BY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Cc: srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Andrew,

> Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org> hat am 16. August 2015 um 15:11 geschrieben:
>
>
> On Sun, Aug 16, 2015 at 10:28:06AM +0200, Stefan Wahren wrote:
> > Hi Andrew,
> >
> > > Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org> hat am 16. August 2015 um 04:54 geschrieben:
> > >
> > >
> > > Add a read only regmap for accessing the EEPROM, and then use that
> > > with the NVMEM framework.
> > >
> > > Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
> > > ---
> > > drivers/misc/eeprom/at24.c | 65
> > > ++++++++++++++++++++++++++++++++++++++++++++++
> > > 1 file changed, 65 insertions(+)
> > >
> > > diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> > > index 2d3db81be099..0e80c0c09d4e 100644
> > > --- a/drivers/misc/eeprom/at24.c
> > > +++ b/drivers/misc/eeprom/at24.c
> > > @@ -22,6 +22,8 @@
> > > #include <linux/jiffies.h>
> > > #include <linux/of.h>
> > > #include <linux/i2c.h>
> > > +#include <linux/nvmem-provider.h>
> > > +#include <linux/regmap.h>
> >
> > shouldn't the dependancies in Kconfig updated (depends on REGMAP) too?
>
> Hi Stefan
>
> This is why the patch is RFC.
>
> REGMAP has stub implementations for when it is not. NVMEM also has
> stub implementations. NVMEM does however select REGMAP. So it should
> be possible to compile this driver without NVMEM support. Hopefully
> 0day will find my git branch and compile it in different ways to see
> if i've got this right.

you are right.

>
> As part of RFC, is this O.K?
>
> Another question which spring to mind is, do we want the eeprom to be
> in /sys twice, the old and the new way? Backwards compatibility says
> the old must stay. Do we want a way to suppress the new? Or should we
> be going as far as refractoring the code into a core library, and two
> wrapper drivers, old and new?

I think these are questions for the framework maintainers.

>
> > > +static int at24_regmap_write(void *context, const void *data, size_t
> > > count)
> > > +{
> > > + struct at24_data *at24 = context;
> > > +
> > > + return at24_write(at24, data, 0, count);
> >
> > Since the patch only provides read only support this function could return
> > 0.
>
> Humm, the comment is out of date. Regmap does not work too well
> without a write method. So i ended up implementing it. But it has
> hardly been tested, where as i have hammered on read.

I think you didn't understand my comment. I know the write function is
necessary, but
calling at24_write() instead of simply returning 0 does make no sense to me.

Regards
Stefan

>
> Thanks
> Andrew
