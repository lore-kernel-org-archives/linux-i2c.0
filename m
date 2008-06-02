From: Sergey Lapin <slapin-9cOl001CZnBAfugRpC6u6w@public.gmane.org>
Subject: Oops in i2c_smbus_read_byte_data
Date: Mon, 2 Jun 2008 17:11:18 +0400
Message-ID: <20080602131118.GA27768@fan.ossfans.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
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
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi!
sorry for stupid questions, but writing fm3130 driver (RTC+FRAM),
I have encountered kernel oops which either shows that I either miss a
lot or there's bug somewhere.
Oops text is below. It happens in i2c_smbus_read_byte_data during
attempt to get client->adaptor.

CPU: 0    Not tainted  (2.6.26-rc4 #26)
PC is at i2c_smbus_read_byte_data+0x24/0xac
LR is at fm3130_set_time+0x230/0x2e0
pc : [<c0193804>]    lr : [<c0192718>]    psr: 20000013
sp : c1fe1dc8  ip : c1fe1e18  fp : c1fe1e14
r10: 00000002  r9 : c1dbea00  r8 : 0000006c
r7 : 00000004  r6 : c1fe1edc  r5 : 00000000  r4 : 00000068
r3 : 00000000  r2 : c1fe0000  r1 : 00000000  r0 : 00000068
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0005317f  Table: 20dd4000  DAC: 00000015
Process hwclock (pid: 2010, stack limit = 0xc1fe0268)
Stack: (0xc1fe1dc8 to 0xc1fe2000)
1dc0:                   00000008 c1fe1edc 00000004 0000006c c1dbea00 00000002 
1de0: c1fe1e04 c1fe1df0 c003dce0 c003d8ec c1fe1e14 c1fe1e0c c1fe1e8c c1fe1e18 
1e00: 00000008 00000008 c1fe1e8c c1fe1e18 c0192718 c01937f0 00000000 00000000 
1e20: 00000000 00000005 00000010 00000003 00000027 00000005 00000008 00000000 
1e40: 00000000 00000081 00000081 00000081 00000081 c01907cc c1dbec20 c1dbecac 
1e60: 0000001b ffffffea c1dbe800 c1fe1edc c1dbe928 c0024d08 c1fe0000 00000000 
1e80: c1fe1eac c1fe1e90 c0190fc4 c01924f8 bea14ae8 c020dfac 4024700a c1dbe800 
1ea0: c1fe1f2c c1fe1eb0 c0191d00 c0190f6c 00000000 00000077 40154000 c02b4f60 
1ec0: 00000000 c1e0d800 00000000 00001000 c1e0dd50 c1ff5a70 c0dd4000 00000000 
1ee0: 00000005 0000000a 0000001b 00000004 0000006c 00000002 00000093 00000000 
1f00: 00000000 c0dbf6c0 c1fe1f2c c1e11f60 bea14ae8 4024700a 00000036 c0024d08 
1f20: c1fe1f4c c1fe1f30 c0099a14 c01919dc c0055dfc c1e11f60 c0d38d28 bea14ae8 
1f40: c1fe1f7c c1fe1f50 c0099cdc c00999a8 fffffffe 00000000 c1fe1f94 c1e11f60 
1f60: fffffff7 4024700a c0024d08 c1fe0000 c1fe1fa4 c1fe1f80 c0099d4c c0099a40 
1f80: c002b648 00000000 ffffffff 00075660 00000003 0008564c 00000000 c1fe1fa8 
1fa0: c0024b60 c0099d1c 00075660 00000003 00000003 4024700a bea14ae8 00075660 
1fc0: 00075660 00000003 0008564c 00000036 00000000 00000032 0006dc74 00000002 
1fe0: 00000000 bea14ae0 0000da98 4018e61c 60000010 00000003 00000000 00000000 
Backtrace: 
[<c01937e0>] (i2c_smbus_read_byte_data+0x0/0xac) from [<c0192718>] (fm3130_set_time+0x230/0x2e0)
 r5:00000008 r4:00000008
[<c01924e8>] (fm3130_set_time+0x0/0x2e0) from [<c0190fc4>] (rtc_set_time+0x68/0x7c)
[<c0190f5c>] (rtc_set_time+0x0/0x7c) from [<c0191d00>] (rtc_dev_ioctl+0x334/0x46c)
 r7:c1dbe800 r6:4024700a r5:c020dfac r4:bea14ae8
[<c01919cc>] (rtc_dev_ioctl+0x0/0x46c) from [<c0099a14>] (vfs_ioctl+0x7c/0x98)
 r8:c0024d08 r7:00000036 r6:4024700a r5:bea14ae8 r4:c1e11f60
[<c0099998>] (vfs_ioctl+0x0/0x98) from [<c0099cdc>] (do_vfs_ioctl+0x2ac/0x2dc)
 r6:bea14ae8 r5:c0d38d28 r4:c1e11f60
[<c0099a30>] (do_vfs_ioctl+0x0/0x2dc) from [<c0099d4c>] (sys_ioctl+0x40/0x64)
 r9:c1fe0000 r8:c0024d08 r6:4024700a r5:fffffff7 r4:c1e11f60
[<c0099d0c>] (sys_ioctl+0x0/0x64) from [<c0024b60>] (ret_fast_syscall+0x0/0x2c)
 r6:0008564c r5:00000003 r4:00075660
Code: e1a05001 1a000001 e59f0078 ebfaa92c (e5943018) 
---[ end trace f8f8593438e69033 ]---

Driver is the following:

/*
 * rtc-fm3130.c - RTC driver for FM3130 I2C chip.
 *
 *  Copyright (C) 2008 Sergey Lapin
 *  Based on ds1307 driver by James Chapman and David Brownell
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation. 
 */
 
#include <linux/module.h>
#include <linux/init.h>
#include <linux/slab.h>
#include <linux/i2c.h>
#include <linux/string.h>
#include <linux/rtc.h>
#include <linux/bcd.h>

#define FM3130_RTC_CONTROL	(0x0)
#define FM3130_CAL_CONTROL	(0x1)
#define FM3130_RTC_SECONDS	(0x2)
#define FM3130_RTC_MINUTES	(0x3)
#define FM3130_RTC_HOURS	(0x4)
#define FM3130_RTC_DAY		(0x5)
#define FM3130_RTC_DATE		(0x6)
#define FM3130_RTC_MONTHS	(0x7)
#define FM3130_RTC_YEARS	(0x8)

#define FM3130_ALARM_SECONDS	(0x9)
#define FM3130_ALARM_MINUTES	(0xa)
#define FM3130_ALARM_HOURS	(0xb)
#define FM3130_ALARM_DATE	(0xc)
#define FM3130_ALARM_MONTHS	(0xd)
#define FM3130_ALARM_WP_CONTROL	(0xe)

#define FM3130_CAL_CONTROL_BIT_nOSCEN (1 << 7) /* Osciallator enabled */
#define FM3130_RTC_CONTROL_BIT_LB (1 << 7) /* Low battery */
#define FM3130_RTC_CONTROL_BIT_AF (1 << 6) /* Alarm flag */
#define FM3130_RTC_CONTROL_BIT_CF (1 << 5) /* Century overflow */
#define FM3130_RTC_CONTROL_BIT_POR (1 << 4) /* Power on reset */
#define FM3130_RTC_CONTROL_BIT_AEN (1 << 3) /* Alarm enable */
#define FM3130_RTC_CONTROL_BIT_CAL (1 << 2) /* Calibration mode */
#define FM3130_RTC_CONTROL_BIT_WRITE (1 << 1) /* W=1 -> write mode W=0 normal */
#define FM3130_RTC_CONTROL_BIT_READ (1 << 0) /* R=1 -> read mode R=0 normal */

struct fm3130 {
	u8			reg_addr;
	u8			regs[0xf];
	struct i2c_msg		msg[3];
	struct i2c_client	*client;
	struct i2c_client	dev;
	struct rtc_device	*rtc;
	int			data_valid;
};
static const struct i2c_device_id fm3130_id[] = {
	{ "fm3130", 0 },
	{ }
};
MODULE_DEVICE_TABLE(i2c, fm3130_id);

static int fm3130_get_time(struct device *dev, struct rtc_time *t)
{
	struct fm3130 *fm3130 = dev_get_drvdata(dev);
	int		tmp;

	if(!fm3130->data_valid) {
		/* We have invalid data in RTC, probably due
		to battery faults or other problems. Return EIO
		for now, it will allow us to set data later insted
		of error during probing which disables device */
		return -EIO;
	}
	/* First we need to read/write control register and set R bit */
	fm3130->regs[FM3130_RTC_CONTROL] = i2c_smbus_read_byte_data(fm3130->client, FM3130_RTC_CONTROL);
	fm3130->regs[FM3130_RTC_CONTROL] |= FM3130_RTC_CONTROL_BIT_READ;
	i2c_smbus_write_byte_data(fm3130->client, FM3130_RTC_CONTROL, fm3130->regs[FM3130_RTC_CONTROL]);

	/* read the RTC date and time registers all at once */
	tmp = i2c_transfer(to_i2c_adapter(fm3130->client->dev.parent),
			fm3130->msg, 2);
	if (tmp != 2) {
		dev_err(dev, "%s error %d\n", "read", tmp);
		return -EIO;
	}

	/* At the end we need to read/write control register and clear R bit */
	fm3130->regs[FM3130_RTC_CONTROL] = i2c_smbus_read_byte_data(fm3130->client, FM3130_RTC_CONTROL);
	fm3130->regs[FM3130_RTC_CONTROL] &= ~(FM3130_RTC_CONTROL_BIT_READ);
	i2c_smbus_write_byte_data(fm3130->client, FM3130_RTC_CONTROL, fm3130->regs[FM3130_RTC_CONTROL]);

	dev_dbg(dev, "%s: %02x %02x %02x %02x %02x %02x %02x %02x %02x %02x %02x %02x %02x %02x %02x\n",
			"read",
			fm3130->regs[0], fm3130->regs[1],
			fm3130->regs[2], fm3130->regs[3],
			fm3130->regs[4], fm3130->regs[5],
			fm3130->regs[6], fm3130->regs[7],
			fm3130->regs[8], fm3130->regs[9],
			fm3130->regs[0xa], fm3130->regs[0xb],
			fm3130->regs[0xc], fm3130->regs[0xd],
			fm3130->regs[0xe]);

	t->tm_sec = BCD2BIN(fm3130->regs[FM3130_RTC_SECONDS] & 0x7f);
	t->tm_min = BCD2BIN(fm3130->regs[FM3130_RTC_MINUTES] & 0x7f);
	tmp = fm3130->regs[FM3130_RTC_HOURS] & 0x3f;
	t->tm_hour = BCD2BIN(tmp);
	t->tm_wday = BCD2BIN(fm3130->regs[FM3130_RTC_DAY] & 0x07) - 1;
	t->tm_mday = BCD2BIN(fm3130->regs[FM3130_RTC_DATE] & 0x3f);
	tmp = fm3130->regs[FM3130_RTC_MONTHS] & 0x1f;
	t->tm_mon = BCD2BIN(tmp) - 1;

	/* assume 20YY not 19YY, and ignore DS1337_BIT_CENTURY */
	t->tm_year = BCD2BIN(fm3130->regs[FM3130_RTC_YEARS]) + 100;

	dev_dbg(dev, "%s secs=%d, mins=%d, "
		"hours=%d, mday=%d, mon=%d, year=%d, wday=%d\n",
		"read", t->tm_sec, t->tm_min,
		t->tm_hour, t->tm_mday,
		t->tm_mon, t->tm_year, t->tm_wday);

	/* initial clock setting can be undefined */
	return rtc_valid_tm(t);
}

static int fm3130_set_time(struct device *dev, struct rtc_time *t)
{
	struct fm3130 *fm3130 = dev_get_drvdata(dev);
	int		result;
	int		tmp;
	u8		*buf = fm3130->regs;

	dev_dbg(dev, "%s secs=%d, mins=%d, "
		"hours=%d, mday=%d, mon=%d, year=%d, wday=%d\n",
		"write", t->tm_sec, t->tm_min,
		t->tm_hour, t->tm_mday,
		t->tm_mon, t->tm_year, t->tm_wday);

	/* first register addr */
	buf[FM3130_RTC_SECONDS] = BIN2BCD(t->tm_sec);
	buf[FM3130_RTC_MINUTES] = BIN2BCD(t->tm_min);
	buf[FM3130_RTC_HOURS] = BIN2BCD(t->tm_hour);
	buf[FM3130_RTC_DAY] = BIN2BCD(t->tm_wday + 1);
	buf[FM3130_RTC_DATE] = BIN2BCD(t->tm_mday);
	buf[FM3130_RTC_MONTHS] = BIN2BCD(t->tm_mon + 1);

	/* assume 20YY not 19YY */
	tmp = t->tm_year - 100;
	buf[FM3130_RTC_YEARS] = BIN2BCD(tmp);

	dev_dbg(dev, "%s: %02x %02x %02x %02x %02x %02x %02x %02x %02x %02x %02x %02x %02x %02x %02x\n",
		"write", buf[0], buf[1], buf[2], buf[3],
		 buf[4], buf[5], buf[6], buf[7],
		 buf[8], buf[9], buf[0xa], buf[0xb],
	 	 buf[0xc], buf[0xd], buf[0xe]);

	/* First we need to read/write control register and set W bit
	 * OOPS here \/ */
	fm3130->regs[FM3130_RTC_CONTROL] = i2c_smbus_read_byte_data(fm3130->client, FM3130_RTC_CONTROL);
	fm3130->regs[FM3130_RTC_CONTROL] |= FM3130_RTC_CONTROL_BIT_WRITE;
	i2c_smbus_write_byte_data(fm3130->client, FM3130_RTC_CONTROL, fm3130->regs[FM3130_RTC_CONTROL]);

	result = i2c_transfer(to_i2c_adapter(fm3130->client->dev.parent),
			&fm3130->msg[2], 2);
	if (result != 1) {
		dev_err(dev, "%s error %d\n", "write", tmp);
		return -EIO;
	}
	/* At the end we need to read/write control register and clear W bit */
	fm3130->regs[FM3130_RTC_CONTROL] = i2c_smbus_read_byte_data(fm3130->client, FM3130_RTC_CONTROL);
	fm3130->regs[FM3130_RTC_CONTROL] &= ~(FM3130_RTC_CONTROL_BIT_WRITE);
	i2c_smbus_write_byte_data(fm3130->client, FM3130_RTC_CONTROL, fm3130->regs[FM3130_RTC_CONTROL]);
	/* We assume here that data are valid once written */
	if(!fm3130->data_valid)
		fm3130->data_valid = 1;
	return 0;
}

static const struct rtc_class_ops fm3130_rtc_ops = {
	.read_time	= fm3130_get_time,
	.set_time	= fm3130_set_time,
};

static struct i2c_driver fm3130_driver;

static int __devinit fm3130_probe(struct i2c_client *client,
				  const struct i2c_device_id *id)
{
	struct fm3130		*fm3130;
	int			err = -ENODEV;
	int			tmp;
	// const struct chip_desc	*chip = &chips[id->driver_data];
	struct i2c_adapter	*adapter = to_i2c_adapter(client->dev.parent);

	if (!i2c_check_functionality(adapter,
			I2C_FUNC_I2C | I2C_FUNC_SMBUS_WRITE_BYTE_DATA))
		return -EIO;

	if (!(fm3130 = kzalloc(sizeof(struct fm3130), GFP_KERNEL)))
		return -ENOMEM;

	fm3130->client = client;
	i2c_set_clientdata(client, fm3130);
	fm3130->reg_addr = FM3130_RTC_CONTROL;

	fm3130->msg[0].addr = client->addr;
	fm3130->msg[0].flags = 0;
	fm3130->msg[0].len = 1;
	fm3130->msg[0].buf = &fm3130->reg_addr;

	fm3130->msg[1].addr = client->addr;
	fm3130->msg[1].flags = I2C_M_RD;
	fm3130->msg[1].len = sizeof(fm3130->regs) - 2;
	fm3130->msg[1].buf = &fm3130->regs[2];

	fm3130->msg[2].addr = client->addr;
	fm3130->msg[2].flags = 0;
	fm3130->msg[2].len = 1;
	fm3130->msg[2].buf = &fm3130->reg_addr;

	fm3130->msg[3].addr = client->addr;
	fm3130->msg[3].flags = 0;
	fm3130->msg[3].len = sizeof(fm3130->regs) - 2;
	fm3130->msg[3].buf = &fm3130->regs[2];

	fm3130->data_valid = 0;

	tmp = i2c_transfer(adapter, fm3130->msg, 2);
	if (tmp != 2) {
		pr_debug("read error %d\n", tmp);
		err = -EIO;
		goto exit_free;
	}

	fm3130->regs[FM3130_RTC_CONTROL] = i2c_smbus_read_byte_data(client, FM3130_RTC_CONTROL);
	fm3130->regs[FM3130_CAL_CONTROL] = i2c_smbus_read_byte_data(client, FM3130_CAL_CONTROL);
	/* oscillator off?  turn it on, so clock can tick. */
	if (fm3130->regs[FM3130_CAL_CONTROL] & FM3130_CAL_CONTROL_BIT_nOSCEN)
		i2c_smbus_write_byte_data(client, FM3130_CAL_CONTROL,
			fm3130->regs[FM3130_CAL_CONTROL] & ~(FM3130_CAL_CONTROL_BIT_nOSCEN));

	/* oscillator fault?  clear flag, and warn */
	if (fm3130->regs[FM3130_RTC_CONTROL] & FM3130_RTC_CONTROL_BIT_LB) {
		dev_warn(&client->dev, "Low battery!\n");
	}
	/* oscillator fault?  clear flag, and warn */
	if (fm3130->regs[FM3130_RTC_CONTROL] & FM3130_RTC_CONTROL_BIT_POR) {
		i2c_smbus_write_byte_data(client, FM3130_RTC_CONTROL,
			fm3130->regs[FM3130_RTC_CONTROL] & ~FM3130_RTC_CONTROL_BIT_POR);
		dev_warn(&client->dev, "SET TIME!\n");
	}

	/* minimal sanity checking; some chips (like DS1340) don't
	 * specify the extra bits as must-be-zero, but there are
	 * still a few values that are clearly out-of-range.
	 */
	/* TODO */
	tmp = fm3130->regs[FM3130_RTC_SECONDS];
	tmp = BCD2BIN(tmp & 0x7f);
	if (tmp > 60)
		goto exit_bad;
	tmp = BCD2BIN(fm3130->regs[FM3130_RTC_MINUTES] & 0x7f);
	if (tmp > 60)
		goto exit_bad;

	tmp = BCD2BIN(fm3130->regs[FM3130_RTC_DATE] & 0x3f);
	if (tmp == 0 || tmp > 31)
		goto exit_bad;

	tmp = BCD2BIN(fm3130->regs[FM3130_RTC_MONTHS] & 0x1f);
	if (tmp == 0 || tmp > 12)
		goto exit_bad;

	tmp = fm3130->regs[FM3130_RTC_HOURS];

	fm3130->data_valid = 1;

exit_bad:
	if(!fm3130->data_valid)
		dev_dbg(&client->dev, "%s: %02x %02x %02x %02x %02x %02x %02x %02x %02x %02x %02x %02x %02x %02x %02x\n",
			"bogus registers",
			fm3130->regs[0], fm3130->regs[1],
			fm3130->regs[2], fm3130->regs[3],
			fm3130->regs[4], fm3130->regs[5],
			fm3130->regs[6], fm3130->regs[7],
			fm3130->regs[8], fm3130->regs[9],
			fm3130->regs[0xa], fm3130->regs[0xb],
			fm3130->regs[0xc], fm3130->regs[0xd],
			fm3130->regs[0xe]);

	/* We won't bail out here because we just got invalid data.
	   Time setting from u-boot doesn't work anyway */
	fm3130->rtc = rtc_device_register(client->name, &client->dev,
				&fm3130_rtc_ops, THIS_MODULE);
	if (IS_ERR(fm3130->rtc)) {
		err = PTR_ERR(fm3130->rtc);
		dev_err(&client->dev,
			"unable to register the class device\n");
		goto exit_free;
	}
	
	return 0;
exit_free:
	kfree(fm3130);
	return err;
}

static int __devexit fm3130_remove(struct i2c_client *client)
{
	struct fm3130	*fm3130 = i2c_get_clientdata(client);

	rtc_device_unregister(fm3130->rtc);
	kfree(fm3130);
	return 0;
}

static struct i2c_driver fm3130_driver = {
	.driver = {
		.name	= "rtc-fm3130",
		.owner	= THIS_MODULE,
	},
	.probe		= fm3130_probe,
	.remove		= __devexit_p(fm3130_remove),
	.id_table	= fm3130_id,
};

static int __init fm3130_init(void)
{
	return i2c_add_driver(&fm3130_driver);
}
module_init(fm3130_init);

static void __exit fm3130_exit(void)
{
	i2c_del_driver(&fm3130_driver);
}
module_exit(fm3130_exit);

MODULE_DESCRIPTION("RTC driver for FM3130");
MODULE_LICENSE("GPL");


Thanks a lot!
S.


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
