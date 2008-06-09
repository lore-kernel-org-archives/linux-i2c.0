From: Uli Luckas <u.luckas-vFjI0mZ6VZs@public.gmane.org>
Subject: Re: Frame buffers and early i2c
Date: Mon, 9 Jun 2008 23:59:35 +0200
Message-ID: <200806092359.36080.u.luckas@road.de>
References: <200806091647.42757.u.luckas@road.de>
	<20080609205212.4b0f1ba6@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080609205212.4b0f1ba6-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adaplas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Monday 09 June 2008, Jean Delvare wrote:
> On Mon, 9 Jun 2008 16:47:42 +0200, Uli Luckas wrote:
> > I am in the process of trying out a display connected to a colibri
> > board's pxa frame buffer device. The display's power supply is switch
> > through i2c.
> >
> > In order to use the frame buffer console I have i2c and pxafb compiled
> > in.
> >
> > By default, the pxafb driver get's initialized before the i2c bus causing
> > the display power up to fail.
> >
> > What do i2c people think about changing the link order here?
>
> Why don't you ask on the i2c mailing list? Cc added.
>
I wanted to get i2c developers plus frame buffer and other i2c client 
developers involved. Crossposting to more then 2 lists seemed wrong.

> Personally I have no objection, but dependencies can be tricky so
> you'll have to be careful. video is early in the link order at the
> moment.
>
Yep. I might come back for help on that later.

> > What do other frame buffer drivers handle the absence of i2c during early
> > boot?
>
> Interestingly enough, they appear to do fine, despite the linking
> order. Maybe because i2c_init is a subsys_initcall() while framebuffer
> drivers are initialized with module_init()? Then I'm not sure why your
> own driver has a problem there.
>
Well, this is only very partially true. Try:
rgrep -l subsys_initcall drivers/i2c/
rgrep -l module_init drivers/i2c/

The last of which gives drivers/i2c/busses/i2c-pxa.c for example.

I'll change the pxa i2c driver to subsys_initcall and try if that works when I 
get back to my desk tomorrow.

regards,
Uli

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
