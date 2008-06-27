From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2] Driver for NS LP3944 FunLight Chip
Date: Fri, 27 Jun 2008 22:42:56 +0200
Message-ID: <20080627224256.718e5dc8@hyperion.delvare>
References: <20080618094645.1a7c8c26.ospite@studenti.unina.it>
	<20080625201409.5df975d4@hyperion.delvare>
	<20080627175649.6c0e717e.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080627175649.6c0e717e.ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, stefan-OrPQZGeq07wqhVmZOOOmNx2eb7JE58TQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Antonio,

On Fri, 27 Jun 2008 17:56:49 +0200, Antonio Ospite wrote:
> On Wed, 25 Jun 2008 20:14:09 +0200, Jean Delvare wrote:
> > On Wed, 18 Jun 2008 09:46:45 +0200, Antonio Ospite wrote:
> > > +	mutex_lock(&lp3944->lock);
> > > +	err = lp3944_reg_write(lp3944->client, psc_reg, psc_value);
> > > +	mutex_unlock(&lp3944->lock);
> > 
> > What are you trying to protect yourself from with this locking?
> 
> I must admit I was in doubt about this one, and the following one. Can I
> consider my lp3944_reg_write and lp3944_reg_read as "atomic" operations
> because they simply call the i2c_smbus_*_byte_data functions which are
> already safe?

Yes. There's a mutex protecting each i2c_adapter, so only one
transaction can be running at a given time (from the Linux host, at
least.)

> > > + */
> > > +int lp3944_led_set(unsigned led, unsigned status)
> > > +{
> > > +	unsigned reg;
> > > +	unsigned val;
> > > +	int err;
> > > +
> > > +	switch (led) {
> > > +	case LP3944_LED0:
> > > +	case LP3944_LED1:
> > > +	case LP3944_LED2:
> > > +	case LP3944_LED3:
> > > +		reg = LP3944_REG_LS0;
> > > +		break;
> > > +	case LP3944_LED4:
> > > +	case LP3944_LED5:
> > > +	case LP3944_LED6:
> > > +	case LP3944_LED7:
> > > +		led -= LP3944_LED4;
> > > +		reg = LP3944_REG_LS1;
> > > +		break;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	if (status > LP3944_LED_STATUS_DIM1)
> > > +		return -EINVAL;
> > > +
> > > +	mutex_lock(&lp3944->lock);
> > > +	lp3944_reg_read(lp3944->client, reg, &val);
> > > +
> > > +	val &= ~(LP3944_LED_STATUS_MASK << (led << 1));
> > > +	val |= (status << (led << 1));
> > > +
> > > +	pr_debug("%s: led %d, status %d, val: 0x%02x\n",
> > > +		 __func__, led, status, val);
> > > +
> > > +	/* set led status */
> > > +	err = lp3944_reg_write(lp3944->client, reg, val);
> > > +	mutex_unlock(&lp3944->lock);
> > > +
> > > +	return err;
> > > +}
> > > +EXPORT_SYMBOL_GPL(lp3944_led_set);
> > >
> 
> Just to be sure:
> the locking is needed here because I am _updating_ a value and I need
> explicit consistency, right? When I simply read or write "atomically" I
> have no problem, is that what you meant before?

Correct. Locking might not even be needed in the case of
read-modify-write operations, if that's the only function accessing
this register and the modified bits are always the same. But I guess
it's OK to leave the locking in place, in case the driver is extended
in the future, or if user-space might access the device directly too.

> > > +	/* Let's see whether this adapter can support what we need. */
> > > +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
> > > +		printk(KERN_ERR "%s: insufficient functionality!\n", __func__);
> > > +		err = -EIO;
> > 
> > That's not an I/O error, so I'd rather return -ENODEV. Not that I
> > expect this check to ever fail anyway.
> 
> So, if you know that single byte-transfer is universally available, and
> it is quite safe to assume that, indeed, I can just remove that part.

Functionality checking was mainly needed for "legacy" drivers which
were probing buses in search of supported devices. For new-style
drivers like this one, which rely on platform code explicitly creating
devices where it knows they exist, it's somewhat redundant, indeed. But
it also doesn't hurt so I am fine if people leave the check in place.
But returning -EIO in the unlikely event the check file, is IMHO
confusing because no I/O has been actually performed. That's why I
suggested -ENODEV (but -EOPNOTSUPP or -EPROTONOSUPPORT would do as
well.)

> > (...)
> > Apparently this implies that your driver (or at least this interface
> > thereof) can only support one device? That's unfortunate.
> 
> How can I support multiple devices? Passing a i2c_client variable I
> guess, but then, how can I get the client, say, inside a leds-class
> driver before I can talk to it?

Question is, why do you have separate drivers for the i2c interface and
the leds-class parts in the first place? Just put everything in the
same driver and you're problem is solved, I think.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
