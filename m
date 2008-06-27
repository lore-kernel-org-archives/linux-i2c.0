From: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Subject: Re: [PATCH v2] Driver for NS LP3944 FunLight Chip
Date: Fri, 27 Jun 2008 17:56:49 +0200
Message-ID: <20080627175649.6c0e717e.ospite@studenti.unina.it>
References: <20080618094645.1a7c8c26.ospite@studenti.unina.it>
	<20080625201409.5df975d4@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080625201409.5df975d4-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, stefan-OrPQZGeq07wqhVmZOOOmNx2eb7JE58TQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 25 Jun 2008 20:14:09 +0200
Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:

> Hi Antonio,
>

Hi Jean, thanks for all the comments.

This is the first kernel driver I write from scratch and the code
reflects my inexperience. Yes, I know that there are also some more
general style issues, I am still learning :)

> On Wed, 18 Jun 2008 09:46:45 +0200, Antonio Ospite wrote:
>
> > Index: linux-2.6.26-rc6/drivers/i2c/chips/lp3944.c
> > ===================================================================
> > --- /dev/null
> > +++ linux-2.6.26-rc6/drivers/i2c/chips/lp3944.c
> 
> Led drivers have their dedicated subsystems. They go to drivers/leds.
> Please check MAINTAINERS for the maintainer of this subsystem and send
> your patch to that person.
> 
> (To make it clear: I'm not taking this driver under drivers/i2c/chips.
> I'm trying to empty this directory, chip drivers must go to their
> respective subsystems.
>

Ok, I'll address the issues you pointed out and resubmit for review to the
right maintainer, but let's have another small talk on some topics before I
leave.

> Random comments:
> 
> > +#define LP3944_REG_INPUT1	0x00	/* LEDs 0-7 InputRegister (Read Only) */
> > +#define LP3944_REG_REGISTER1	0x01	/* None (Read Only) */
> > +#define LP3944_REG_PSC0		0x02	/* Frequency Prescaler 0 (R/W) */
> > +#define LP3944_REG_PWM0		0x03	/* PWM Register 0 (R/W) */
> > +#define LP3944_REG_PSC1		0x04	/* Frequency Prescaler 1 (R/W) */
> > +#define LP3944_REG_PWM1		0x05	/* PWM Register 1 (R/W) */
> > +#define LP3944_REG_LS0		0x06	/* LEDs 0-3 Selector (R/W) */
> > +#define LP3944_REG_LS1		0x07	/* LEDs 4-7 Selector (R/W) */
> > +#define LP3944_REG_REGISTER8	0x08	/* None (R/W) */
> > +#define LP3944_REG_REGISTER9	0x09	/* None (R/W) */
> 
> None? Why do you care about these registers at all then?
>

I could still access them with the sysfs interface, and store arbitrary
values inside them, but as you stated, this interface is pretty useless,
so also these two can go away. 

> > +int lp3944_dim_set_period(unsigned dim, unsigned period)
> > +{
> > +	unsigned psc_reg;
> > +	unsigned psc_value;
> > +	int err;
> > +
> > +	if (dim == LP3944_DIM0)
> > +		psc_reg = LP3944_REG_PSC0;
> > +	else if (dim == LP3944_DIM1)
> > +		psc_reg = LP3944_REG_PSC1;
> > +	else
> > +		return -EINVAL;
> > +
> > +	/* Convert period to Prescaler value */
> > +	if (period > LP3944_PERIOD_MAX)
> > +		return -EINVAL;
> > +
> > +	if (period == LP3944_PERIOD_MIN)
> > +		psc_value = 0;
> > +	else
> > +		psc_value = (period * LP3944_PERIOD_MAX) - 1;
> 
> That's pretty confusing. Why would you want to multiply a period value
> by another period value? Maybe it happens to be numerically correct but
> from a physical unit point of view that doesn't make much sense.
>

Well, you're right, to be dimensionally correct it can be
psc_value = (period * 255) / LP3944_PERIOD_MAX;
which is a more conventional way to scale values and which saves me also the
if(), many thanks again.
I really should take more care to dimensional analysis.

The previous formula was just by chance numerically equivalent to this
one, because LP3944_PERIOD_MAX is 16 which is equal to 256/16...

> > +
> > +	mutex_lock(&lp3944->lock);
> > +	err = lp3944_reg_write(lp3944->client, psc_reg, psc_value);
> > +	mutex_unlock(&lp3944->lock);
> 
> What are you trying to protect yourself from with this locking?
>

I must admit I was in doubt about this one, and the following one. Can I
consider my lp3944_reg_write and lp3944_reg_read as "atomic" operations
because they simply call the i2c_smbus_*_byte_data functions which are
already safe?

> > + */
> > +int lp3944_led_set(unsigned led, unsigned status)
> > +{
> > +	unsigned reg;
> > +	unsigned val;
> > +	int err;
> > +
> > +	switch (led) {
> > +	case LP3944_LED0:
> > +	case LP3944_LED1:
> > +	case LP3944_LED2:
> > +	case LP3944_LED3:
> > +		reg = LP3944_REG_LS0;
> > +		break;
> > +	case LP3944_LED4:
> > +	case LP3944_LED5:
> > +	case LP3944_LED6:
> > +	case LP3944_LED7:
> > +		led -= LP3944_LED4;
> > +		reg = LP3944_REG_LS1;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (status > LP3944_LED_STATUS_DIM1)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&lp3944->lock);
> > +	lp3944_reg_read(lp3944->client, reg, &val);
> > +
> > +	val &= ~(LP3944_LED_STATUS_MASK << (led << 1));
> > +	val |= (status << (led << 1));
> > +
> > +	pr_debug("%s: led %d, status %d, val: 0x%02x\n",
> > +		 __func__, led, status, val);
> > +
> > +	/* set led status */
> > +	err = lp3944_reg_write(lp3944->client, reg, val);
> > +	mutex_unlock(&lp3944->lock);
> > +
> > +	return err;
> > +}
> > +EXPORT_SYMBOL_GPL(lp3944_led_set);
> >

Just to be sure:
the locking is needed here because I am _updating_ a value and I need
explicit consistency, right? When I simply read or write "atomically" I
have no problem, is that what you meant before?

> > +/* low-level sysfs interface */
[...]
> > +static DEVICE_ATTR(reg, S_IWUSR | S_IRUGO, lp3944_get_reg, lp3944_set_reg);
> 
> I would get rid of this interface altogether, it doesn't make much
> sense.
>

Ok, will do that.

> > +	pr_debug("%s: reg: 0x%02x value: 0x%02x\n", __func__, reg, *value);
> > +
> > +	return 0;
> > +}
> > +
> > +static int lp3944_reg_write(struct i2c_client *client, unsigned reg,
> > +			    unsigned value)
> > +{
> > +	unsigned tmp;
> > +	int ret;
> > +
> > +	tmp = i2c_smbus_read_byte_data(client, reg);
> > +	pr_debug("%s: before write reg: 0x%02x value: 0x%02x\n",
> > +		 __func__, reg, tmp);
> > +
> > +	ret = i2c_smbus_write_byte_data(client, reg, value);
> > +
> > +	tmp = i2c_smbus_read_byte_data(client, reg);
> > +	pr_debug("%s: after write reg: 0x%02x value: 0x%02x\n",
> > +		 __func__, reg, tmp);
> 
> That's fairly inefficient. Is there any reason why you have to read
> from the register twice as you write to it? I2C is slow enough as is.
> If that's only for debugging, then you should make it conditional upon
> DEBUG being defined. But quite frankly this doesn't seem to be very
> useful debugging.
> 

yes, these prints and also the sysfs interface were used during
development (when I started I was even more inexperienced, you know).
I used them also to discover the leds configuration, I agree they can
go away now.

> > +
> > +	return ret;
> > +}
> > +
> > +static int lp3944_init_client(struct i2c_client *client)
> > +{
> > +	struct lp3944_data *data = i2c_get_clientdata(client);
> > +	int tmp;
> > +
> > +	/* Try to read a byte, if it fails, return an error */
> > +	tmp = i2c_smbus_read_byte_data(client, LP3944_REG_INPUT1);
> > +	if (tmp < 0)
> > +		return -ENODEV;
> 
> What's the point of doing this?
>

Just a stupid test to see if a chip is here? Useless, eh?
I'll trust the subsystems in future, thanks for making me reflect about
that.

> > +
> > +	/* Default values, taken from official datasheet */
> 
> If these are the default values, why do you write them to the chip?
> Instead of, say, just use what the registers hold, so you don't
> overwrite previous configuration done by the BIOS or firmware?
> 
> > +	lp3944_reg_write(client, LP3944_REG_PSC0, 0x00);
> > +	lp3944_reg_write(client, LP3944_REG_PWM0, 0x80);
> > +	lp3944_reg_write(client, LP3944_REG_PSC1, 0x00);
> > +	lp3944_reg_write(client, LP3944_REG_PWM1, 0x80);
> > +	lp3944_reg_write(client, LP3944_REG_LS0, 0x00);
> > +	lp3944_reg_write(client, LP3944_REG_LS1, 0x00);
> > +
> > +	data->LP3944_REGS[0] = 0x00;
> > +	data->LP3944_REGS[1] = 0x80;
> > +	data->LP3944_REGS[2] = 0x00;
> > +	data->LP3944_REGS[3] = 0x80;
> > +	data->LP3944_REGS[4] = 0x00;
> > +	data->LP3944_REGS[5] = 0x00;
> 
> Why do you write these values in data->LP3944_REGS? You never access
> them after that.
> 

Now I get it, I already have that functionality covered by suspend(), yes, it
is not needed on init.

> > +
> > +	if (lp3944) {
> > +		dev_dbg(&client->dev, "only one lp3944 chip allowed.\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	/* Let's see whether this adapter can support what we need. */
> > +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
> > +		printk(KERN_ERR "%s: insufficient functionality!\n", __func__);
> > +		err = -EIO;
> 
> That's not an I/O error, so I'd rather return -ENODEV. Not that I
> expect this check to ever fail anyway.
> 

So, if you know that single byte-transfer is universally available, and
it is quite safe to assume that, indeed, I can just remove that part.

> > +
> > +	lp3944_reg_write(client, LP3944_REG_LS0, 0x00);
> > +	lp3944_reg_write(client, LP3944_REG_LS1, 0x00);
> 
> Why are these commands doing? Please add a comment.
> 

They turn leds off, but maybe I have to handle that in the leds-class
driver, because a led could be wired also to stay ON when lp3944 put
it in LP3944_LED_STATUS_OFF.

> > +	.suspend = lp3944_suspend,
> > +	.resume  = lp3944_resume,
> 
> This is missing a .id_table for i2c-core to do the device/driver
> matching (probably this didn't exist yet when you wrote your driver.)
> 

I'll check that too.

> > +#define LP3944_LED0 0
> > +#define LP3944_LED1 1
> > +#define LP3944_LED2 2
> > +#define LP3944_LED3 3
> > +#define LP3944_LED4 4
> > +#define LP3944_LED5 5
> > +#define LP3944_LED6 6
> > +#define LP3944_LED7 7
> > +
> > +#define LP3944_DIM0 0
> > +#define LP3944_DIM1 1
> 
> These defines don't look terribly useful.
> 

Right, but I'll keep them, they are just to make the user code more
readable (according to my taste, at least).

> > +		},
> > +	};
> > +
> > +and register it in the platform init function
> > +
> > +	i2c_register_board_info(0, a910_i2c_board_info,
> > +			ARRAY_SIZE(a910_i2c_board_info));
> > +
> > +
> 
> This is only one way to use register a device. i2c_new_device() is
> another.
>

I'll add that to the documentation.

> > +Accessing LP3944 via exported interface
> > +---------------------------------------
> > +The driver exposes a friendly interface to abstract the chip functionalities
> > +for other drivers to use.
> > +
> > +Including include/linux/i2c/lp3944.h one can use these calls:
> 
> Probably better written "Including <linux/i2c/lp3944.h> ...".
> 
> > +
> > +extern int lp3944_dim_set_period(unsigned dim, unsigned period);
> > +extern int lp3944_dim_set_dutycycle(unsigned int dim, unsigned duty_cycle);
> > +extern int lp3944_led_set(unsigned led, unsigned status);
> > +
> > +in a leds-class driver.
> 
> Apparently this implies that your driver (or at least this interface
> thereof) can only support one device? That's unfortunate.
>

How can I support multiple devices? Passing a i2c_client variable I
guess, but then, how can I get the client, say, inside a leds-class
driver before I can talk to it?

> > +
> > +
> > +Accessing LP3944 via /sys interface
> > +-----------------------------------
> > +Standard i2c sysfs interface can be found at
> 
> What "standard i2c sysfs interface" are you talking about?
> 

I meant Standard sysfs conventions for <bus>-<addr>, but the whole sysfs
interface will go away as you suggested.

Thanks for the review.

Regards,
   Antonio

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
