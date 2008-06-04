From: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c: Let bus drivers add SPD to their class
Date: Wed, 4 Jun 2008 12:59:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0806041254070.10290@shell4.speakeasy.net>
References: <20080603130221.1f819e64@hyperion.delvare>
	<200806031319.56606.david-b@pacbell.net>
	<9e4733910806031412t52e7ed1bl8fd56751bef12a7a@mail.gmail.com>
	<Pine.LNX.4.58.0806031420160.10290@shell4.speakeasy.net>
	<9e4733910806031503w46662d4fib36d3b67563bbdf1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <9e4733910806031503w46662d4fib36d3b67563bbdf1-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 3 Jun 2008, Jon Smirl wrote:
> On 6/3/08, Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org> wrote:
> > On Tue, 3 Jun 2008, Jon Smirl wrote:
> >  > >  >  drivers/i2c/busses/i2c-elektor.c       |    2 +-
> >  > >  >  drivers/i2c/busses/i2c-gpio.c          |    2 +-
> >  > >  >  drivers/i2c/busses/i2c-i801.c          |    2 +-
> >  > >  >  drivers/i2c/busses/i2c-ibm_iic.c       |    4 ++--
> >  > >  >  drivers/i2c/busses/i2c-iop3xx.c        |    2 +-
> >  > >  >  drivers/i2c/busses/i2c-isch.c          |    2 +-
> >  > >  >  drivers/i2c/busses/i2c-mpc.c           |    2 +-
> >  >
> >  > Freescale embedded, no sticks
> >
> >
> > I know you're wrong about this one, because I have a Freescale board with
> >  an mpc i2c adapter with SPD SODIMMs on the I2C bus sitting right in front
> >  of me.  The whole reason I added hexdump support the I2C tools' SPD parser
> >  was so I could parse the SPD data by hexdumping the eeproms with busybox.
>
> Which CPU are you using? Maybe we should change to a socket.

MPC8572E, but U-Boot has support for programming the DRAM controller from
SPD data for a lot of Freescale chips.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
