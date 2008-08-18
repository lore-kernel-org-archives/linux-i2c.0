From: Herbert Poetzl <herbert-dBHVzrDq9nF4Lj/PQRBjDg@public.gmane.org>
Subject: Re: [PATCH] i2c: Floppy controller bus driver (V0.2)
Date: Mon, 18 Aug 2008 21:58:45 +0200
Message-ID: <20080818195845.GC1947@MAIL.13thfloor.at>
References: <20080818031046.GE8052@MAIL.13thfloor.at>
	<20080818104539.480ba532@hyperion.delvare>
	<20080818164053.GA32376@MAIL.13thfloor.at>
	<20080818205708.324961c4@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080818205708.324961c4-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: I2C ML <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Aug 18, 2008 at 08:57:08PM +0200, Jean Delvare wrote:
> Hi Herbert,
> 
> On Mon, 18 Aug 2008 18:40:53 +0200, Herbert Poetzl wrote:
> > On Mon, Aug 18, 2008 at 10:45:39AM +0200, Jean Delvare wrote:
> > > On Mon, 18 Aug 2008 05:10:46 +0200, Herbert Poetzl wrote:
> > > > diff -NurpP --minimal linux-2.6.27-rc3/drivers/i2c/busses/Kconfig linux-2.6.27-rc3-fi2c-v0.2/drivers/i2c/busses/Kconfig
> > > > --- linux-2.6.27-rc3/drivers/i2c/busses/Kconfig	2008-08-15 21:19:24.000000000 +0200
> > > > +++ linux-2.6.27-rc3-fi2c-v0.2/drivers/i2c/busses/Kconfig	2008-08-18 03:46:31.000000000 +0200
> > > > @@ -490,6 +490,22 @@ config I2C_VERSATILE
> > > >  
> > > >  comment "External I2C/SMBus adapter drivers"
> > > >  
> > > > +config I2C_FLOPPY
> > > > +	tristate "Floppy controller adapter"
> > > > +	select I2C_ALGOBIT
> > > > +	default n
> > > > +	help
> > > > +	  This supports a simple do-it-yourself floppy controller to
> > > > +	  I2C adapters using the motor control lines for SDA and SCL,
> > > > +	  and the drive change input for SDA readback.
> > > > +
> > > > +	  This support is also available as a module.  If so, the module
> > > > +	  will be called i2c-floppy.
> > > > +
> > > > +	  If you do not have such a device, and do not plan to build one,
> > > > +	  it's safe to say N here. Do not say Y here and to the floppy
> > > > +	  driver unless you know exactly what you are doing.
> > > 
> > > Good point. In fact it would be safer to depend on !BLK_DEV_FD. There's
> > > no "if you know exactly what you are doing" that holds: if any of these
> > > drivers is built in, the other one _must_ be excluded.
> > 
> > well, actually not true ... I build both drivers
> > as module, and can then decide wether I want to
> > attach a floppy or an I2C adapter ... and except
> > for the fact that floppy access to the I2C adapter
> > is not the best idea, this works perfectly fine
> 
> What I propose wouldn't prevent you from doing that. "depend
> on !BLK_DEV_FD" means that both drivers can't be built-in. Both drivers
> as modules is OK. Remember that the Kconfig language is based on
> ternary logic.
> 
> > 
> > but as far as I know, there is no (sane) way to
> > say building both 'M' is fine, but 'Y' is a nono
> > (I think that is why many drivers write it this
> > way in the help)
> 
> There _is_ a way do to this and that's exactly what I proposed.
> 
> > 
> > making it mutually exclusive is kind of problematic
> > as you need to disable one _beforehand_ to see the
> > other in the config ...
> 
> This is true, but I don't expect this to be a problem in practice. Most
> users have the standard floppy driver built as module, so they will see
> i2c-floppy and will be able to build it as a module. Worst case is if
> the standard floppy driver is built-in, but I don't expect this to be a
> popular choice these days, with all the PCs out there without a floppy
> disk drive. If this is really a problem, it's easy to add a message in
> Kconfig to tell people what they need to do to get access to
> i2c-floppy. But I don't expect your driver to be popular enough to
> warrant this.
> 
> >                          magically disabling the 
> > floppy driver from the i2c-floppy is not an option
> > either, as the build system doesn't support that
> 
> Agreed. Even if the build system could do that, this would be highly
> unfriendly.
> 
> > 
> > so I personally think the 'default n' + warning
> > is fine for everyday use, but of course, the final
> > call is yours
> 
> I'll add the dependency. If I don't, somebody will quickly complain
> that floppy support is broken by allyesconfig.
> 
> No need to resend, I'll do that in a incremental patch. I think I'll
> add a dependency on EXPERIMENTAL as well - after all your driver has
> seen little testing so far.

okay, no problem with that .. thanks!

best,
Herbert

> -- 
> Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
