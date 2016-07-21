From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] add w1_ds28e17 driver for the DS28E17 Onewire to I2C
 master bridge
Date: Thu, 21 Jul 2016 09:02:20 +0200
Message-ID: <20160721070220.GE1664@katana>
References: <578A95E4.1080903@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wchHw8dVAp53YPj8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:43497 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751119AbcGUHC0 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 21 Jul 2016 03:02:26 -0400
Content-Disposition: inline
In-Reply-To: <578A95E4.1080903@gmx.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Kandziora <jjj@gmx.de>
Cc: Evgeniy Polyakov <zbr@ioremap.net>, linux-i2c@vger.kernel.org


--wchHw8dVAp53YPj8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 16, 2016 at 10:15:32PM +0200, Jan Kandziora wrote:
> This subpatch adds a driver for the DS28E17 Onewire to I2C master bridge.
>=20
> Signed-off-by: Jan Kandziora <jjj@gmx.de>

Thanks for the submission.

> +config W1_SLAVE_DS28E17
> +	tristate "1-wire-to-I2C master bridge (DS28E17)"
> +	select CRC16
> +	depends on I2C
> +	help
> +	  Say Y here if you want to use the DS28E17 1-wire-to-I2C master bridge.
> +	  For each DS28E17 detected, a new I2C adapter is created within the
> +	  kernel. I2C devices on that bus can be configured to be used by the
> +	  kernel as on any other "native" I2C bus.
> +
> +	  In addition, that new I2C bus is accessible from userspace through
> +	  a /dev/i2c-nnn device node if you have enabled
> +	  "Device Drivers->I2C Support->I2C device interface" (CONFIG_I2C_CHARD=
EV).

I think the last paragraph can go. This is standard I2C behaviour and
Kconfig is not the right place to document this.


> --- /dev/null
> +++ b/drivers/w1/slaves/w1_ds28e17.c
> @@ -0,0 +1,761 @@
> +/*
> + *	w1_ds28e17.c - w1 family 19 (DS28E17) driver
> + *
> + * Copyright (c) 2016 Jan Kandziora <jjj@gmx.de>
> + *
> + * This source code is licensed under the GNU General Public License,
> + * Version 2. See the file COPYING for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/device.h>
> +#include <linux/types.h>
> +#include <linux/delay.h>
> +#include <linux/slab.h>
> +#include <linux/crc16.h>
> +#include <linux/uaccess.h>
> +#include <linux/i2c.h>

If you sort these, it is easier to avoid duplicates later.

> +
> +#define CRC16_INIT 0
> +
> +#include "../w1.h"
> +#include "../w1_int.h"
> +#include "../w1_family.h"
> +
> +
> +/* Module setup. */
> +MODULE_LICENSE("GPL");

"GPL v2"

> +MODULE_AUTHOR("Jan Kandziora <jjj@gmx.de>");
> +MODULE_DESCRIPTION("w1 family 19 driver for DS28E17, 1-wire to I2C maste=
r bridge");
> +MODULE_ALIAS("w1-family-" __stringify(W1_FAMILY_DS28E17));
> +
> +
> +/* Default I2C speed to be set when a DS28E17 is detected. */
> +static char i2c_speed =3D 1;
> +module_param_named(speed, i2c_speed, byte, (S_IRUSR | S_IWUSR));
> +MODULE_PARM_DESC(speed, "Default I2C speed to be set when a DS28E17 is d=
etected");

I don't see any documentation what 0,1,2 means. I think it would be more
user friendly to actually use the kHz values here.


> +/* Default I2C stretch value to be set when a DS28E17 is detected. */
> +static char i2c_stretch =3D 1;
> +module_param_named(stretch, i2c_stretch, byte, (S_IRUSR | S_IWUSR));
> +MODULE_PARM_DESC(stretch, "Default I2C stretch value to be set when a DS=
28E17 is detected");

No documentation what the value means.

> +/* DS28E17 device command codes. */
> +#define W1_F19_WRITE_DATA_WITH_STOP      0x4B
> +#define W1_F19_WRITE_DATA_NO_STOP        0x5A
> +#define W1_F19_WRITE_DATA_ONLY           0x69
> +#define W1_F19_WRITE_DATA_ONLY_WITH_STOP 0x78
> +#define W1_F19_READ_DATA_WITH_STOP       0x87
> +#define W1_F19_WRITE_READ_DATA_WITH_STOP 0x2D
> +#define W1_F19_WRITE_CONFIGURATION       0xD2
> +#define W1_F19_READ_CONFIGURATION        0xE1
> +#define W1_F19_ENABLE_SLEEP_MODE         0x1E
> +#define W1_F19_READ_DEVICE_REVISION      0xC4
> +
> +/* DS28E17 status bits */
> +#define W1_F19_STATUS_CRC     0x01
> +#define W1_F19_STATUS_ADDRESS 0x02
> +#define W1_F19_STATUS_START   0x08
> +
> +/*
> + * Maximum number of I2C bytes to transfer within one CRC16 protected on=
ewire
> + * command.
> + * */
> +#define W1_F19_WRITE_DATA_LIMIT 255
> +
> +/* Maximum number of I2C bytes to read with one onewire command. */
> +#define W1_F19_READ_DATA_LIMIT 255
> +
> +/* Contants for calculating the busy sleep. */
> +#define W1_F19_BUSY_TIMEBASES { 90, 23, 10 }
> +#define W1_F19_BUSY_GRATUITY  1000
> +
> +/* Number of checks for the busy flag before timeout. */
> +#define W1_F19_BUSY_CHECKS 1000
> +
> +
> +/* Slave specific data. */
> +struct w1_f19_data {
> +	u8 speed;
> +	u8 stretch;
> +	struct i2c_adapter adapter;
> +};
> +
> +
> +/* Wait a while until the busy flag clears. */
> +static int w1_f19_i2c_busy_wait(struct w1_slave *sl, size_t count)
> +{
> +	const unsigned long timebases[3] =3D W1_F19_BUSY_TIMEBASES;
> +	struct w1_f19_data *data =3D sl->family_data;
> +	unsigned int checks;
> +
> +	/* Check the busy flag first in any case.*/
> +	if (w1_touch_bit(sl->master, 1) =3D=3D 0)
> +		return 0;
> +
> +	/*
> +	 * Do a generously long sleep in the beginning,
> +	 * as we have to wait at least this time for all
> +	 * the I2C bytes at the given speed to be transferred.
> +	 */
> +	usleep_range(timebases[data->speed] * (data->stretch) * count,
> +		timebases[data->speed] * (data->stretch) * count
> +		+ W1_F19_BUSY_GRATUITY);
> +
> +	/* Now continusly check the busy flag sent by the DS28E17. */
> +	checks =3D W1_F19_BUSY_CHECKS;
> +	while ((checks--) > 0) {
> +		/* Return success if the busy flag is cleared. */
> +		if (w1_touch_bit(sl->master, 1) =3D=3D 0)
> +			return 0;
> +
> +		/* Wait one non-streched byte timeslot. */
> +		udelay(timebases[data->speed]);
> +	}
> +
> +	/* Timeout. */
> +	dev_warn(&sl->dev, "busy timeout\n");
> +	return -EIO;
> +}
> +
> +
> +/* Utility function: write data to I2C slave, single chunk. */
> +static int __w1_f19_i2c_write(struct w1_slave *sl,
> +	const u8 *command, size_t command_count,
> +	const u8 *buffer, size_t count)
> +{
> +	u16 crc;
> +	u8 w1_buf[2];
> +
> +	/* Send command and I2C data to DS28E17. */
> +	crc =3D crc16(CRC16_INIT, command, command_count);
> +	w1_write_block(sl->master, command, command_count);
> +
> +	w1_buf[0] =3D count;
> +	crc =3D crc16(crc, w1_buf, 1);
> +	w1_write_8(sl->master, w1_buf[0]);
> +
> +	crc =3D crc16(crc, buffer, count);
> +	w1_write_block(sl->master, buffer, count);
> +
> +	w1_buf[0] =3D ~(crc & 0xFF);
> +	w1_buf[1] =3D ~((crc >> 8) & 0xFF);
> +	w1_write_block(sl->master, w1_buf, 2);
> +
> +	/* Wait until busy flag clears (or timeout). */
> +	if (w1_f19_i2c_busy_wait(sl, count + 1) < 0)
> +		return -EIO;
> +
> +	/* Read status from DS28E17. */
> +	w1_read_block(sl->master, w1_buf, 2);
> +
> +	/* Warnings. */
> +	if (w1_buf[0] & W1_F19_STATUS_CRC)
> +		dev_warn(&sl->dev, "crc16 mismatch\n");
> +	if (w1_buf[0] & W1_F19_STATUS_ADDRESS)
> +		dev_warn(&sl->dev, "i2c device not responding\n");

This should ideally return -ENXIO.

> +	if (w1_buf[0] & W1_F19_STATUS_START)
> +		dev_warn(&sl->dev, "i2c start condition invalid\n");

Does that mean "arbitration lost"? Then it should return "-EAGAIN".

> +	if ((w1_buf[0] & (W1_F19_STATUS_CRC | W1_F19_STATUS_ADDRESS)) =3D=3D 0
> +			&& w1_buf[1] !=3D 0) {
> +		dev_warn(&sl->dev, "i2c short write, %d bytes not acknowledged\n",
> +			w1_buf[1]);
> +	}
> +
> +	/* Check error conditions. */
> +	if (w1_buf[0] !=3D 0 || w1_buf[1] !=3D 0)
> +		return -EIO;
> +
> +	/* All ok. */
> +	return count;
> +}
> +
> +
> +/* Write data to I2C slave. */
> +static int w1_f19_i2c_write(struct w1_slave *sl, u16 i2c_address,
> +	const u8 *buffer, size_t count, bool stop)
> +{
> +	int result;
> +	int remaining =3D count;
> +	const u8 *p;
> +	u8 command[2];
> +
> +	/* Check input. */
> +	if (i2c_address > 0x7F

The i2c core checks that for you.

> +			|| count =3D=3D 0)

For that case, better return -EOPNOTSUPP;

> +		return 0;
> +
> +	/* Check whether we need multiple commands. */
> +	if (count <=3D W1_F19_WRITE_DATA_LIMIT) {
> +		/*
> +		 * Small data amount. Data can be sent with
> +		 * a single onewire command.
> +		 */
> +
> +		/* Send all data to DS28E17. */
> +		command[0] =3D (stop ? W1_F19_WRITE_DATA_WITH_STOP
> +			: W1_F19_WRITE_DATA_NO_STOP);
> +		command[1] =3D i2c_address << 1;
> +		result =3D __w1_f19_i2c_write(sl, command, 2, buffer, count);
> +	} else {
> +		/* Large data amount. Data has to be sent in multiple chunks. */
> +
> +		/* Send first chunk to DS28E17. */
> +		p =3D buffer;
> +		command[0] =3D W1_F19_WRITE_DATA_NO_STOP;
> +		command[1] =3D i2c_address << 1;
> +		result =3D __w1_f19_i2c_write(sl, command, 2, p,
> +			W1_F19_WRITE_DATA_LIMIT);
> +		if (result < 0)
> +			return result;
> +
> +		/* Resume to same DS28E17. */
> +		if (w1_reset_resume_command(sl->master))
> +			return -ENXIO;

-ENXIO? Please check Documentation/i2c/fault-codes if that fits

> +
> +		/* Next data chunk. */
> +		p +=3D W1_F19_WRITE_DATA_LIMIT;
> +		remaining -=3D W1_F19_WRITE_DATA_LIMIT;
> +
> +		while (remaining > W1_F19_WRITE_DATA_LIMIT) {
> +			/* Send intermediate chunk to DS28E17. */
> +			command[0] =3D W1_F19_WRITE_DATA_ONLY;
> +			result =3D __w1_f19_i2c_write(sl, command, 1, p,
> +					W1_F19_WRITE_DATA_LIMIT);
> +			if (result < 0)
> +				return result;
> +
> +			/* Resume to same DS28E17. */
> +			if (w1_reset_resume_command(sl->master))
> +				return -ENXIO;
> +
> +			/* Next data chunk. */
> +			p +=3D W1_F19_WRITE_DATA_LIMIT;
> +			remaining -=3D W1_F19_WRITE_DATA_LIMIT;
> +		}
> +
> +		/* Send final chunk to DS28E17. */
> +		command[0] =3D (stop ? W1_F19_WRITE_DATA_ONLY_WITH_STOP
> +			: W1_F19_WRITE_DATA_ONLY);
> +		result =3D __w1_f19_i2c_write(sl, command, 1, p, remaining);
> +	}
> +
> +	return result;
> +}
> +
> +
> +/* Read data from I2C slave. */
> +static int w1_f19_i2c_read(struct w1_slave *sl, u16 i2c_address,
> +	u8 *buffer, size_t count)
> +{
> +	u16 crc;
> +	u8 w1_buf[5];
> +
> +	/* Check input. */
> +	if (i2c_address > 0x7F
> +			|| count > W1_F19_READ_DATA_LIMIT

Since you have a quirk structure, the core checks this for you, too.

> +			|| count =3D=3D 0)
> +		return -EINVAL;

-EOPNOTSUPP.

> +
> +	/* Send command to DS28E17. */
> +	w1_buf[0] =3D W1_F19_READ_DATA_WITH_STOP;
> +	w1_buf[1] =3D i2c_address << 1 | 0x01;
> +	w1_buf[2] =3D count;
> +	crc =3D crc16(CRC16_INIT, w1_buf, 3);
> +	w1_buf[3] =3D ~(crc & 0xFF);
> +	w1_buf[4] =3D ~((crc >> 8) & 0xFF);
> +	w1_write_block(sl->master, w1_buf, 5);
> +
> +	/* Wait until busy flag clears (or timeout). */
> +	if (w1_f19_i2c_busy_wait(sl, count + 1) < 0)
> +		return -EIO;
> +
> +	/* Read status from DS28E17. */
> +	w1_buf[0] =3D w1_read_8(sl->master);
> +
> +	/* Warnings. */
> +	if (w1_buf[0] & W1_F19_STATUS_CRC)
> +		dev_warn(&sl->dev, "crc16 mismatch\n");
> +	if (w1_buf[0] & W1_F19_STATUS_ADDRESS)
> +		dev_warn(&sl->dev, "i2c device not responding\n");
> +	if (w1_buf[0] & W1_F19_STATUS_START)
> +		dev_warn(&sl->dev, "i2c start condition invalid\n");

Same as above.

> +
> +	/* Check error conditions. */
> +	if (w1_buf[0] !=3D 0)
> +		return -EIO;
> +
> +	/* Read received I2C data from DS28E17. */
> +	return w1_read_block(sl->master, buffer, count);
> +}
> +
> +
> +/* Write to, then read data from I2C slave. */
> +static int w1_f19_i2c_write_read(struct w1_slave *sl, u16 i2c_address,
> +	const u8 *wbuffer, size_t wcount, u8 *rbuffer, size_t rcount)
> +{
> +	u16 crc;
> +	u8 w1_buf[3];
> +
> +	/* Check input. */
> +	if (i2c_address > 0x7F
> +			|| wcount =3D=3D 0
> +			|| rcount > W1_F19_READ_DATA_LIMIT
> +			|| rcount =3D=3D 0)
> +		return -EINVAL;

Same comments as above

> +
> +	/* Send command and I2C data to DS28E17. */
> +	w1_buf[0] =3D W1_F19_WRITE_READ_DATA_WITH_STOP;
> +	w1_buf[1] =3D i2c_address << 1;
> +	w1_buf[2] =3D wcount;
> +	crc =3D crc16(CRC16_INIT, w1_buf, 3);
> +	w1_write_block(sl->master, w1_buf, 3);
> +
> +	crc =3D crc16(crc, wbuffer, wcount);
> +	w1_write_block(sl->master, wbuffer, wcount);
> +
> +	w1_buf[0] =3D rcount;
> +	crc =3D crc16(crc, w1_buf, 1);
> +	w1_buf[1] =3D ~(crc & 0xFF);
> +	w1_buf[2] =3D ~((crc >> 8) & 0xFF);
> +	w1_write_block(sl->master, w1_buf, 3);
> +
> +	/* Wait until busy flag clears (or timeout). */
> +	if (w1_f19_i2c_busy_wait(sl, wcount + rcount + 2) < 0)
> +		return -EIO;
> +
> +	/* Read status from DS28E17. */
> +	w1_read_block(sl->master, w1_buf, 2);
> +
> +	/* Warnings. */
> +	if (w1_buf[0] & W1_F19_STATUS_CRC)
> +		dev_warn(&sl->dev, "crc16 mismatch\n");
> +	if (w1_buf[0] & W1_F19_STATUS_ADDRESS)
> +		dev_warn(&sl->dev, "i2c device not responding\n");
> +	if (w1_buf[0] & W1_F19_STATUS_START)
> +		dev_warn(&sl->dev, "i2c start condition invalid\n");
> +	if ((w1_buf[0] & (W1_F19_STATUS_CRC | W1_F19_STATUS_ADDRESS)) =3D=3D 0
> +			&& w1_buf[1] !=3D 0) {
> +		dev_warn(&sl->dev, "i2c short write, %d bytes not acknowledged\n",
> +			w1_buf[1]);
> +	}
> +
> +	/* Check error conditions. */
> +	if (w1_buf[0] !=3D 0 || w1_buf[1] !=3D 0)
> +		return -EIO;

ditto. Maybe you should put this parsing into a seperate function?

> +
> +	/* Read received I2C data from DS28E17. */
> +	return w1_read_block(sl->master, rbuffer, rcount);
> +}
> +
> +
> +/* Do an I2C master transfer. */
> +static int w1_f19_i2c_master_transfer(struct i2c_adapter *adapter,
> +	struct i2c_msg *msgs, int num)
> +{
> +	struct w1_slave *sl =3D (struct w1_slave *) adapter->algo_data;
> +	int i =3D 0;
> +	int result =3D 0;
> +
> +	/* Return if no messages to send/receive. */
> +	if (num =3D=3D 0)
> +		return 0;

Heh, I was about to write "the core will check this for you", but it
doesn't. I'll send a patch to fix that, thanks! So please remove it
here.

> +
> +	/* Start onewire transaction. */
> +	mutex_lock(&sl->master->bus_mutex);
> +
> +	/* Select DS28E17. */
> +	if (w1_reset_select_slave(sl)) {
> +		i =3D -ENXIO;
> +		goto error;
> +	}
> +
> +	/* Loop while there are still messages to transfer. */
> +	while (i < num) {
> +		/*
> +		 * Check for special case: Small write followed
> +		 * by read to same I2C device.
> +		 */
> +		if (i < (num-1)
> +			&& msgs[i].addr =3D=3D msgs[i+1].addr
> +			&& !(msgs[i].flags & I2C_M_RD)
> +			&& (msgs[i+1].flags & I2C_M_RD)
> +			&& (msgs[i].len <=3D W1_F19_WRITE_DATA_LIMIT)) {
> +			/*
> +			 * The DS28E17 has a combined transfer
> +			 * for small write+read.
> +			 */
> +			result =3D w1_f19_i2c_write_read(sl, msgs[i].addr,
> +				msgs[i].buf, msgs[i].len,
> +				msgs[i+1].buf, msgs[i+1].len);
> +			if (result < 0) {
> +				i =3D result;
> +				goto error;
> +			}
> +
> +			/*
> +			 * Check if we should interpret the read data
> +			 * as a length byte. The DS28E17 unfortunately
> +			 * has no read without stop, so we can just do
> +			 * another simple read in that case.
> +			 */
> +			if (msgs[i+1].flags & I2C_M_RECV_LEN) {
> +				result =3D w1_f19_i2c_read(sl, msgs[i+1].addr,
> +					&(msgs[i+1].buf[1]), msgs[i+1].buf[0]);
> +				if (result < 0) {
> +					i =3D result;
> +					goto error;
> +				}
> +			}
> +
> +			/* Eat up read message, too. */
> +			i++;
> +		} else if (msgs[i].flags & I2C_M_RD) {
> +			/* Read transfer. */
> +			result =3D w1_f19_i2c_read(sl, msgs[i].addr,
> +				msgs[i].buf, msgs[i].len);
> +			if (result < 0) {
> +				i =3D result;
> +				goto error;
> +			}
> +
> +			/*
> +			 * Check if we should interpret the read data
> +			 * as a length byte. The DS28E17 unfortunately
> +			 * has no read without stop, so we can just do
> +			 * another simple read in that case.
> +			 */
> +			if (msgs[i].flags & I2C_M_RECV_LEN) {
> +				result =3D w1_f19_i2c_read(sl,
> +					msgs[i].addr,
> +					&(msgs[i].buf[1]),
> +					msgs[i].buf[0]);
> +				if (result < 0) {
> +					i =3D result;
> +					goto error;
> +				}
> +			}
> +		} else {
> +			/*
> +			 * Write transfer.
> +			 * Stop condition only for last
> +			 * transfer.
> +			 */
> +			result =3D w1_f19_i2c_write(sl,
> +				msgs[i].addr,
> +				msgs[i].buf,
> +				msgs[i].len,
> +				i =3D=3D (num-1));
> +			if (result < 0) {
> +				i =3D result;
> +				goto error;
> +			}
> +		}
> +
> +		/* Next message. */
> +		i++;
> +
> +		/* Are there still messages to send/receive? */
> +		if (i < num) {
> +			/* Yes. Resume to same DS28E17. */
> +			if (w1_reset_resume_command(sl->master)) {
> +				i =3D -ENXIO;
> +				goto error;
> +			}
> +		}
> +	}
> +
> +error:
> +	/* End onewire transaction. */
> +	mutex_unlock(&sl->master->bus_mutex);
> +
> +	/* Return number of messages processed or error. */
> +	return i;
> +}
> +
> +
> +/* Get I2C adapter functionality. */
> +static u32 w1_f19_i2c_functionality(struct i2c_adapter *adapter)
> +{
> +	/*
> +	 * Plain I2C functions only.
> +	 * SMBus is emulated by the kernel's I2C layer.
> +	 * No "I2C_FUNC_SMBUS_QUICK"
> +	 * No "I2C_FUNC_SMBUS_READ_BLOCK_DATA"
> +	 * No "I2C_FUNC_SMBUS_BLOCK_PROC_CALL"
> +	 */
> +	return I2C_FUNC_I2C |
> +		I2C_FUNC_SMBUS_BYTE |
> +		I2C_FUNC_SMBUS_BYTE_DATA |
> +		I2C_FUNC_SMBUS_WORD_DATA |
> +		I2C_FUNC_SMBUS_PROC_CALL |
> +		I2C_FUNC_SMBUS_WRITE_BLOCK_DATA |
> +		I2C_FUNC_SMBUS_I2C_BLOCK |
> +		I2C_FUNC_SMBUS_PEC;
> +}
> +
> +
> +/* I2C algorithm. */
> +static const struct i2c_algorithm w1_f19_i2c_algorithm =3D {
> +	.master_xfer    =3D w1_f19_i2c_master_transfer,
> +	.smbus_xfer     =3D NULL,

Not needed.

> +	.functionality  =3D w1_f19_i2c_functionality,

You could add the quirks struct here since it is static.

> +};
> +
> +
> +/* I2C adapter quirks. */
> +static const struct i2c_adapter_quirks w1_f19_i2c_adapter_quirks =3D {
> +	.max_read_len =3D W1_F19_READ_DATA_LIMIT,
> +};
> +
> +
> +/* Read I2C speed from DS28E17. */
> +static int w1_f19_get_i2c_speed(struct w1_slave *sl)
> +{
> +	struct w1_f19_data *data =3D sl->family_data;
> +	int result =3D -ENXIO;
> +
> +	/* Start onewire transaction. */
> +	mutex_lock(&sl->master->bus_mutex);
> +
> +	/* Select slave. */
> +	if (w1_reset_select_slave(sl))
> +		goto error;
> +
> +	/* Read slave configuration byte. */
> +	w1_write_8(sl->master, W1_F19_READ_CONFIGURATION);
> +	result =3D w1_read_8(sl->master);
> +	if (result < 0 || result > 2) {
> +		result =3D -EIO;
> +		goto error;
> +	}
> +
> +	/* Update speed in slave specific data. */
> +	data->speed =3D result;
> +
> +error:
> +	/* End onewire transaction. */
> +	mutex_unlock(&sl->master->bus_mutex);
> +
> +	return result;
> +}
> +
> +
> +/* Set I2C speed on DS28E17. */
> +static int __w1_f19_set_i2c_speed(struct w1_slave *sl, u8 speed)
> +{
> +	struct w1_f19_data *data =3D sl->family_data;
> +	const int i2c_speeds[3] =3D { 100, 400, 900 };
> +	u8 w1_buf[2];
> +
> +	/* Select slave. */
> +	if (w1_reset_select_slave(sl))
> +		return -ENXIO;
> +
> +	w1_buf[0] =3D W1_F19_WRITE_CONFIGURATION;
> +	w1_buf[1] =3D speed;
> +	w1_write_block(sl->master, w1_buf, 2);
> +
> +	/* Update speed in slave specific data. */
> +	data->speed =3D speed;
> +
> +	dev_info(&sl->dev, "i2c speed set to %d kBaud\n", i2c_speeds[speed]);
> +
> +	return 0;
> +}
> +
> +static int w1_f19_set_i2c_speed(struct w1_slave *sl, u8 speed)
> +{
> +	int result;
> +
> +	/* Start onewire transaction. */
> +	mutex_lock(&sl->master->bus_mutex);
> +
> +	/* Set I2C speed on DS28E17. */
> +	result =3D __w1_f19_set_i2c_speed(sl, speed);
> +
> +	/* End onewire transaction. */
> +	mutex_unlock(&sl->master->bus_mutex);
> +
> +	return result;
> +}
> +
> +
> +/* Sysfs attributes. */
> +
> +/* I2C speed attribute for a single chip. */
> +static ssize_t speed_show(struct device *dev, struct device_attribute *a=
ttr,
> +			     char *buf)
> +{
> +	struct w1_slave *sl =3D dev_to_w1_slave(dev);
> +	int result;
> +
> +	/* Read current speed from slave. Updates data->speed. */
> +	result =3D w1_f19_get_i2c_speed(sl);
> +	if (result < 0)
> +		return result;
> +
> +	/* Return current speed value. */
> +	return sprintf(buf, "%d\n", result);
> +}
> +
> +static ssize_t speed_store(struct device *dev, struct device_attribute *=
attr,
> +			      const char *buf, size_t count)
> +{
> +	struct w1_slave *sl =3D dev_to_w1_slave(dev);
> +	int error;
> +
> +	/* Valid values are: '0' (100kHz), '1' (400kHz), '2' (900kHz) */
> +	if (count < 1 || count > 2 || !buf)
> +		return -EINVAL;
> +	if (count =3D=3D 2 && buf[1] !=3D '\n')
> +		return -EINVAL;
> +	if (buf[0] !=3D '0' && buf[0] !=3D '1' && buf[0] !=3D '2')
> +		return -EINVAL;
> +
> +	/* Set speed on slave. */
> +	error =3D w1_f19_set_i2c_speed(sl, buf[0] & 0x03);
> +	if (error < 0)
> +		return error;
> +
> +	/* Return bytes written. */
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(speed);
> +
> +
> +/* Busy stretch attribute for a single chip. */
> +static ssize_t stretch_show(struct device *dev, struct device_attribute =
*attr,
> +			     char *buf)
> +{
> +	struct w1_slave *sl =3D dev_to_w1_slave(dev);
> +	struct w1_f19_data *data =3D sl->family_data;
> +
> +	/* Return current stretch value. */
> +	return sprintf(buf, "%d\n", data->stretch);
> +}
> +
> +static ssize_t stretch_store(struct device *dev, struct device_attribute=
 *attr,
> +			      const char *buf, size_t count)
> +{
> +	struct w1_slave *sl =3D dev_to_w1_slave(dev);
> +	struct w1_f19_data *data =3D sl->family_data;
> +
> +	/* Valid values are '1' to '9' */
> +	if (count < 1 || count > 2 || !buf)
> +		return -EINVAL;
> +	if (count =3D=3D 2 && buf[1] !=3D '\n')
> +		return -EINVAL;
> +	if (buf[0] < '1' || buf[0] > '9')
> +		return -EINVAL;
> +
> +	/* Set busy stretch value. */
> +	data->stretch =3D buf[0] & 0x0F;
> +
> +	/* Return bytes written. */
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(stretch);
> +
> +
> +/* All attributes. */
> +static struct attribute *w1_f19_attrs[] =3D {
> +	&dev_attr_speed.attr,
> +	&dev_attr_stretch.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group w1_f19_group =3D {
> +	.attrs		=3D w1_f19_attrs,
> +};
> +
> +static const struct attribute_group *w1_f19_groups[] =3D {
> +	&w1_f19_group,
> +	NULL,
> +};

sysfs files need documentation in Documentation/ABI/testing/.

> +
> +
> +/* Slave add and remove functions. */
> +static int w1_f19_add_slave(struct w1_slave *sl)
> +{
> +	struct w1_f19_data *data =3D NULL;
> +
> +	/* Allocate memory for slave specific data. */
> +	data =3D kzalloc(sizeof(*data), GFP_KERNEL);

I don't know w1 much. Isn't there a device so we could use devm_kzalloc?

> +	if (!data)
> +		return -ENOMEM;
> +	sl->family_data =3D data;
> +
> +	/* Setup default I2C speed on slave. */
> +	if (i2c_speed =3D=3D 0 || i2c_speed =3D=3D 1 || i2c_speed =3D=3D 2) {
> +		__w1_f19_set_i2c_speed(sl, i2c_speed);
> +	}	else {
> +		/*
> +		 * A module parameter of anything else than 0, 1, 2
> +		 * means not to touch the speed of the DS28E17.
> +		 * We assume 400kBaud.
> +		 */

I suggest to to use 100kHz as the default. That's what all devices have
to support. 400kHz is common, but still optional.

> +		data->speed =3D 1;
> +	}
> +
> +	/*
> +	 * Setup default busy stretch
> +	 * configuration for the DS28E17.
> +	 */
> +	data->stretch =3D i2c_stretch;
> +
> +	/* Setup I2C adapter. */
> +	data->adapter.owner      =3D THIS_MODULE;
> +	data->adapter.class      =3D 0;

Not needed with kzalloc.

> +	data->adapter.algo       =3D &w1_f19_i2c_algorithm;
> +	data->adapter.alogo_data  =3D (void *) sl;

No need to cast to void*.

> +	strcpy(data->adapter.name, "w1-");
> +	strcat(data->adapter.name, sl->name);
> +	data->adapter.dev.parent =3D &sl->dev;
> +	data->adapter.quirks     =3D &w1_f19_i2c_adapter_quirks;
> +
> +	return i2c_add_adapter(&data->adapter);
> +}
> +
> +static void w1_f19_remove_slave(struct w1_slave *sl)
> +{
> +	/* Delete I2C adapter. */
> +	i2c_del_adapter(&(((struct w1_f19_data *)(sl->family_data))->adapter));

Would be more readable if you'd use a 'family_data' variable as an
intermediate step.

> +
> +	/* Free slave specific data. */
> +	kfree(sl->family_data);
> +	sl->family_data =3D NULL;
> +}
> +
> +
> +/* Declarations within the w1 subsystem. */
> +static struct w1_family_ops w1_f19_fops =3D {
> +	.add_slave =3D w1_f19_add_slave,
> +	.remove_slave =3D w1_f19_remove_slave,
> +	.groups =3D w1_f19_groups,
> +};
> +
> +static struct w1_family w1_family_19 =3D {
> +	.fid =3D W1_FAMILY_DS28E17,
> +	.fops =3D &w1_f19_fops,
> +};
> +
> +
> +/* Module init and remove functions. */
> +static int __init w1_f19_init(void)
> +{
> +	return w1_register_family(&w1_family_19);
> +}
> +
> +static void __exit w1_f19_fini(void)
> +{
> +	w1_unregister_family(&w1_family_19);
> +}
> +
> +module_init(w1_f19_init);
> +module_exit(w1_f19_fini);

use the 'module_driver' macro?

> +
> diff --git a/drivers/w1/w1_family.h b/drivers/w1/w1_family.h
> index ed5dcb8..5016a76 100644
> --- a/drivers/w1/w1_family.h
> +++ b/drivers/w1/w1_family.h
> @@ -31,6 +31,7 @@
>  #define W1_FAMILY_SMEM_01	0x01
>  #define W1_FAMILY_SMEM_81	0x81
>  #define W1_THERM_DS18S20 	0x10
> +#define W1_FAMILY_DS28E17	0x19
>  #define W1_FAMILY_DS28E04	0x1C
>  #define W1_COUNTER_DS2423	0x1D
>  #define W1_THERM_DS1822  	0x22
> --=20
> 2.1.4
>=20

--wchHw8dVAp53YPj8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXkHN8AAoJEBQN5MwUoCm2v8wQAJX4FTatx+uCNrZzwvvxD6G6
gnVXZFQepkB3RfXwoxz3RqdCCnmH95Wt600t/O01D8yY/vRP7YqIH8uOnKrxmNZa
nIMSSvqPMXBvIA7P//lK6rxPNoG5UZbLov6Tkx5KYFelvAq2m7yQbDeuCUoZS8tG
T/Yh3Fh8uQTyPfeK/Fxd8w2v9bGWe5vzBRKa7vVV9UYY69bF1WFsVy3Ydcc9as0C
3pq62Dpf+4Zab6NlRAckpUBl4LYmxuqpNoxqZe43YLdTXf8WIDJPdzEyJsixRT4k
MGHZH05C1oHNMtk5LH46WSruk4M8BukCIggR1kOJg84maBsewvE1osgVgGBEKcwa
mWX1ezn0Fa5iaEh137CJCg8Lqq6WxCK9bABhbMiW5V2D5xIuSmV+j5vP0TOXMbnQ
E4/EYeRSjiGiSB/Ogywc+uz8X2gzMa5plWd2hct5MrSbzhAQIkQpTaMl/w7pIhaa
dMH1OxdPJs0iMMQa8KEyug0JT3C4BtviC1qSyHU8OZa/NdP03WIdQF/m/12piYV8
8JC5lzuo59qWmnd1T8W8+6YSvquhP/i5GOC7NwBsqzwu558REE0bWji38S+acEaR
HSvI/uCcHhHQgxNU90veflrNL603KNKYjBKgHCe3sD64mfSbn+XY08bcU50vsAld
KFQEer2SRImBcd4V7Pti
=JWUd
-----END PGP SIGNATURE-----

--wchHw8dVAp53YPj8--
