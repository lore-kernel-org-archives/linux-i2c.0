From: =?iso-8859-15?Q?Lothar_Wa=DFmann?= <LW@KARO-electronics.de>
Subject: Re: [PATCH 05/25] drivers/i2c: Use static const char arrays
Date: Tue, 14 Sep 2010 09:36:23 +0200
Message-ID: <19599.9719.562406.692216@ipc1.ka-ro>
References: <cover.1284406638.git.joe@perches.com>
	<b0c83cb1b42c6adf38f6322066fb457693f7ac3b.1284406638.git.joe@perches.com>
	<4C8E84A0.1010606@jic23.retrosnub.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4C8E84A0.1010606@jic23.retrosnub.co.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jonathan Cameron <arm@jic23.retrosnub.co.uk>
Cc: Linus Walleij <linus.walleij@stericsson.com>, linux-kernel@vger.kernel.org, "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>, linux-i2c@vger.kernel.org, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, Joe Perches <joe@perches.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hi,

Jonathan Cameron writes:
>  Commit message is  somewhat inaccurate...
> =

> On 09/13/10 20:47, Joe Perches wrote:
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> >  drivers/i2c/busses/i2c-stu300.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses/i2c-s=
tu300.c
> > index 495be45..2f7c09c 100644
> > --- a/drivers/i2c/busses/i2c-stu300.c
> > +++ b/drivers/i2c/busses/i2c-stu300.c
> > @@ -871,7 +871,7 @@ stu300_probe(struct platform_device *pdev)
> >  	struct resource *res;
> >  	int bus_nr;
> >  	int ret =3D 0;
> > -	char clk_name[] =3D "I2C0";
> > +	char clk_name[sizeof("I2Cx")];
> >  =

> >  	dev =3D kzalloc(sizeof(struct stu300_dev), GFP_KERNEL);
> >  	if (!dev) {
> > @@ -881,7 +881,7 @@ stu300_probe(struct platform_device *pdev)
> >  	}
> >  =

> >  	bus_nr =3D pdev->id;
> > -	clk_name[3] +=3D (char)bus_nr;
> > +	sprintf(clk_name, "I2C%c", '0' + bus_nr);
> I'm guessing that there are never more than a couple of these.
> Why is this method a better bet than just putting %d?
>
'%c' will only ever produce one byte of output while '%d' may
produce up to 11 bytes depending on the value of bus_nr thus
overflowing the buffer.


Lothar Wa=DFmann
-- =

___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=DFe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=E4ftsf=FChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
