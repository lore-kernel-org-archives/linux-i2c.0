From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: Floppy controller bus driver
Date: Mon, 18 Aug 2008 09:41:15 +0200
Message-ID: <20080818094115.7c5f5136@hyperion.delvare>
References: <20080815205012.GA20308@MAIL.13thfloor.at>
	<20080817224511.06e82a74@hyperion.delvare>
	<20080818012739.GD8052@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080818012739.GD8052-ZD0Mn47LIGX0Pe/G4T7+5F6hYfS7NtTn@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Herbert Poetzl <herbert-dBHVzrDq9nF4Lj/PQRBjDg@public.gmane.org>
Cc: I2C ML <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 18 Aug 2008 03:27:39 +0200, Herbert Poetzl wrote:
> On Sun, Aug 17, 2008 at 10:45:11PM +0200, Jean Delvare wrote:
> > On Fri, 15 Aug 2008 22:50:12 +0200, Herbert Poetzl wrote:
> > > (...)
> > > +static void port_dor_out(unsigned char d)
> > > +{
> > > +	outb(d ^ LO_INV, base + FOFF_DOR);
> > > +}
> > > +
> > > +static unsigned char port_dir_in(void)
> > > +{
> > > +	return inb(base + FOFF_DIR) ^ LI_INV;
> > > +}
> > 
> > These two functions are certainly worth inlining.
> 
> okay, static inline fine?

Yes.

> > (...)
> > In general, "remove" functions should avoid accessing globals. You
> > should always be able to get access to everything you need based on the
> > device that is passed into parameter. Just use platform_get_drvdata
> > (and use platform_set_drvdata in the "probe" function.)
> 
> hmm, is that something you plan to change in the
> i2c-parport-light driver too, if so, please point
> me to the patch, I'll gladly adjust it to match that

In fact, I was counting on you to fix your driver and then send a patch
cleaning up i2c-parport-light in a similar way ;)

> > (...)
> > This lacks a warning that this driver is meant for do-it-yourself
> > hardware and most people can safely say no.
> > 
> > Out of curiosity, what would happen if someone was to run this driver
> > with actual floppy disk drives connected?
> 
> I'd say the drive(s) will spin up a little, but
> that's about all that can happen, the driver doesn't
> do anything 'bad' with the floppy controller

No risk that the relatively fast motor on/off switching could damage it?

> the other way round is probably more a problem, as
> the floppy driver will not handle the changing input
> line that gracefully, but that is a problem users
> of this kind of hardware should be able to deal with

Correct, but that's still worth a warning in the documentation. Better
safe than sorry.

> > (...)
> > Your patch misses Documentation/i2c/busses/i2c-floppy explaining 
> > how to build the hardware, things to pay attention to, etc.
> 
> okay, something like the i2c-parport-light is fine?
> (including the pinout description of course)

Yes.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
