From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: Floppy controller bus driver (V0.6.1)
Date: Fri, 3 Oct 2008 14:23:45 +0200
Message-ID: <20081003142345.2cbbca2a@hyperion.delvare>
References: <20081001170827.GB1173@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20081001170827.GB1173-ZD0Mn47LIGX0Pe/G4T7+5F6hYfS7NtTn@public.gmane.org>
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

Hi Herbert,

On Wed, 1 Oct 2008 19:08:27 +0200, Herbert Poetzl wrote:
> 
> here is the latest version of the I2C floppy 
> controller bus driver, which is now completely
> configurable and can handle 'single floppy' type
> controllers (where the second motor control is
> missing).
> 
> please consider for (mainline) inclusion!
> 
> TIA,
> Herbert
> 
> Signed-off-by: Herbert Poetzl <herbert-dBHVzrDq9nF4Lj/PQRBjDg@public.gmane.org>
> 
> diff -NurpP --minimal linux-2.6.27-rc8/Documentation/i2c/busses/i2c-floppy linux-2.6.27-rc8-fi2c-v0.6.1/Documentation/i2c/busses/i2c-floppy
> --- linux-2.6.27-rc8/Documentation/i2c/busses/i2c-floppy	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.27-rc8-fi2c-v0.6.1/Documentation/i2c/busses/i2c-floppy	2008-09-30 22:56:14.000000000 +0200
> @@ -0,0 +1,151 @@
> +Kernel driver i2c-floppy
> +
> +Author: Herbert Poetzl <herbert-dBHVzrDq9nF4Lj/PQRBjDg@public.gmane.org>
> +
> +This driver is for a simple do-it-yourself floppy controller
> +to I2C adapter which uses direct I/O access and the sense
> +command to control the output lines and query the input lines.
> +
> +Potential output lines are (for now):
> +
> + Motor Enable A  [/MOTEA,  10]
> + Drive Select B  [/DRVSB,  12]
> + Drive Select A  [/DRVSA,  14]
> + Motor Enable B  [/MOTEB,  16]
> + Head Select     [/SIDE1,  32]
> +
> +Potential input lines are (for now):
> +
> + Track 0         [/TRK00,  26]
> + Write Protect   [/WPT,    28]
> + Disk Change     [/DSKCHG, 34]
> +
> +Not all possible combinations are useable, as for example
> +the Drive Select lines depend on the respective Motor Enable
> +line. Nevertheless, the possible combinations can be selected
> +from the following table:
> +
> + Mode             ENA             SDA          SCL

I don't understand what "ENA" is supposed to represent.

> +-------------------------------------------------------
> +   1               -          /MOTEA [10]  /MOTEB [16]
> +   2          /SIDE1 [32]     /MOTEA [10]  /MOTEB [16]
> +  -----------------------------------------------------
> +   3               -          /MOTEA [10]  /DRVSB [12]
> +   4          /MOTEB [16]     /MOTEA [10]  /DRVSB [12]
> +   5          /SIDE1 [32]     /MOTEA [10]  /DRVSB [12]
> +  -----------------------------------------------------
> +   6               -          /MOTEA [10]  /SIDE1 [32]
> +   7          /MOTEB [16]     /MOTEA [10]  /SIDE1 [32]
> +   8          /DRVSB [12]     /MOTEA [10]  /SIDE1 [32]
> +  -----------------------------------------------------
> +   9               -          /MOTEB [16]  /DRVSA [14]
> +  10 [0a]     /MOTEA [10]     /MOTEB [16]  /DRVSA [14]
> +  11 [0b]     /SIDE1 [32]     /MOTEB [16]  /DRVSA [14]
> +  -----------------------------------------------------
> +  12 [0c]          -          /MOTEB [16]  /SIDE1 [32]
> +  13 [0d]     /MOTEA [10]     /MOTEB [16]  /SIDE1 [32]
> +  14 [0e]     /DRVSA [14]     /MOTEB [16]  /SIDE1 [32]
> +  -----------------------------------------------------
> +  15 [0f]          -          /SIDE1 [32]  /DRVSA [14]
> +  16 [10]     /MOTEA [10]     /SIDE1 [32]  /DRVSA [14]
> +  17 [11]     /MOTEB [16]     /SIDE1 [32]  /DRVSA [14]
> +  18 [12]     /DRVSB [12]     /SIDE1 [32]  /DRVSA [14]
> +  -----------------------------------------------------
> +  19 [13]          -          /SIDE1 [32]  /DRVSB [12]
> +  20 [14]     /MOTEA [10]     /SIDE1 [32]  /DRVSB [12]
> +  21 [15]     /MOTEB [16]     /SIDE1 [32]  /DRVSB [12]
> +  22 [16]     /DRVSA [14]     /SIDE1 [32]  /DRVSB [12]

What's the value of numbering modes both in decimal and hexadecimal? I
think it adds to confusion more than it helps. You should pick one and
stick to it.

> +-------------------------------------------------------
> +
> +The following modifiers can be added to the selection:
> +
> +  32 0x0020      Swap SCL and SDA
> +  64 0x0040      Invert SDA Output
> + 128 0x0080      Invert SCL Output
> + 256 0x0100      Invert ENA Output
> +
> +
> +The input can be selected in a similar way, although it is
> +probably easier to use the autodetect feature there.
> +Nevertheless here is the table:
> +
> + Mode            ENA            SDA           SCL
> +-------------------------------------------------------
> +   0         auto detect    auto detect   auto detect
> +  -----------------------------------------------------
> +   1              -         /DSKCHG [34]       -
> +   2              -         /TRK00  [26]       -
> +   3              -         /WPT    [28]       -
> +  -----------------------------------------------------
> +   4              -         /DSKCHG [34]  /TRK00  [26]
> +   5              -         /TRK00  [26]  /WPT    [28]
> +   6              -         /WPT    [28]  /DSKCHG [34]
> +  -----------------------------------------------------
> +   7         /DSKCHG [34]   /TRK00  [26]       -
> +   8         /DSKCHG [34]   /WPT    [28]       -
> +   9         /DSKCHG [34]   /TRK00  [26]  /WPT    [28]
> +  -----------------------------------------------------
> +  10 [0a]    /TRK00  [26]   /DSKCHG [34]       -
> +  11 [0b]    /TRK00  [26]   /WPT    [28]       -
> +  12 [0c]    /TRK00  [26]   /WPT    [28]  /DSKCHG [34]
> +  -----------------------------------------------------
> +  13 [0d]    /WPT    [28]   /DSKCHG [34]       -
> +  14 [0e]    /WPT    [28]   /TRK00  [26]       -
> +  15 [0f]    /WPT    [28]   /DSKCHG [34]  /TRK00  [26]
> +-------------------------------------------------------
> +
> +In addition, the same modifiers can be applied as for the
> +output.
> +
> +
> +The following (minimal) circuit is not suited to be used
> +together with a Floppy drive (which would need some logic
> +to work properly) but as replacement.
> +
> + +---+
> + | F |  Motor Enable A [/MOTEA,10] -------------- SCL
> + | L |
> + | O |  Motor Enable B [/MOTEB,16] ------+------- SDA
> + | P |                                   |
> + | P |                                   |
> + | Y |  Disk Change   [/DSKCHG,34] ------+    +-- GND
> + +-+-+                                        |
> +   |                                          |
> +  GND	                                     GND

This apparently corresponds to mode 1/1, you may want to mention it.

> +
> +The Motor Enable output of floppy disk controllers is an open
> +drain output (48mA), usually pulled up to +5V via 1k or higher,
> +and the Disk Change is a Schmitt Trigger (0.8V/2.2V) input with
> +max 150uA input current (data taken from the WD/FDC 37C6xx
> +Floppy Disk Subsystem Controller datasheets, which basically
> +combine all the necessary parts of the PC floppy circuit).
> +
> +So it should be fine to connect it to all 5V I2C devices, and
> +most 3.3V devices (which are usually capable of handling 5V
> +I2C bus voltages).
> +
> +Power for those devices can be drawn from either the Floppy
> +power connector (+5V/+12V) or from the SATA 3.3V lines
> +(or if you prefer from some external source).
> +
> +
> +Here is a slightly more advanced circuit, which works on
> +controllers with reduced functionality (i.e. without control
> +lines for a second drive), while allowing for SCL readback
> +(and thus clock stretching):
> +
> +
> + +---+
> + |   |  Motor Enable A [/MOTEA,10] -------------- ENA
> + | F |
> + | L |  Drive Select A [/DRVSA,14] ------+------- SDA
> + | O |                                   |
> + | P |  Write Protect  [/WPT,28] --------+
> + | P |
> + | Y |  Head Select    [/SIDE1,32] ------+------- SCL
> + |   |                                   |
> + |   |  Disk Change    [/DSKCHG,34] -----+    +-- GND
> + +-+-+                                        |
> +   |                                          |
> +  GND	                                     GND

And this is mode 16/6 with SDA and SCL swapped?

As I already said on IRC, my personal feeling is that this complexity
is overkill, and you could basically have only 2 or 3 modes, like the
i2c-parport-light driver is doing. At least you would be able to test
them and ensure that they really work, while with the above, you just
can't test all combinations, so I expect surprises. In particular, what
will happen, for every possible combination, if your driver is loaded
while a real floppy disk driver is connected? Can you guarantee that no
harm will be done to the hardware and no data will be lost?

> +
> diff -NurpP --minimal linux-2.6.27-rc8/drivers/i2c/busses/i2c-floppy.c linux-2.6.27-rc8-fi2c-v0.6.1/drivers/i2c/busses/i2c-floppy.c
> --- linux-2.6.27-rc8/drivers/i2c/busses/i2c-floppy.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.27-rc8-fi2c-v0.6.1/drivers/i2c/busses/i2c-floppy.c	2008-10-01 18:34:32.000000000 +0200
> @@ -0,0 +1,626 @@
> +/* ------------------------------------------------------------------------ *
> + * i2c-floppy.c I2C bus over floppy controller                              *
> + * ------------------------------------------------------------------------ *
> +   Copyright (C) 2008 Herbert Poetzl <herbert-dBHVzrDq9nF4Lj/PQRBjDg@public.gmane.org>
> +
> +   Somewhat based on i2c-parport-light.c driver
> +   Copyright (C) 2003-2007 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> +
> +   This program is free software; you can redistribute it and/or modify
> +   it under the terms of the GNU General Public License as published by
> +   the Free Software Foundation; either version 2 of the License, or
> +   (at your option) any later version.
> +
> +   This program is distributed in the hope that it will be useful,
> +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +   GNU General Public License for more details.
> +
> +   You should have received a copy of the GNU General Public License
> +   along with this program; if not, write to the Free Software
> +   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + * ------------------------------------------------------------------------ */
> +
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/ioport.h>
> +#include <linux/i2c.h>
> +#include <linux/i2c-algo-bit.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +
> +static struct platform_device *pdev;
> +static unsigned char dor;
> +
> +static u16 base;
> +module_param(base, ushort, 0);
> +MODULE_PARM_DESC(base, "Base I/O address");
> +
> +static u16 delay;
> +module_param(delay, ushort, 0);
> +MODULE_PARM_DESC(base, "Signal delay");

What is this supposed to be? "Signal delay" doesn't mean anything to
me. I suspect you mean half-period of the I2C clock expressed in us?

> +
> +
> +#define DEFAULT_BASE	0x3F0		/* for PC style hardware */
> +#define DRVNAME		"i2c-floppy"
> +
> +
> +#define FOFF_DOR	0x02
> +#define FOFF_MSR	0x04
> +#define FOFF_DATA	0x05
> +#define FOFF_CCR	0x07

You don't use this define anywhere, so why define it? (Also it looks
strange that FOFF_CCR and FOFF_DIR have the same value.)

> +#define FOFF_DIR	0x07
> +
> +
> +#define	FDOR_MOA	0x10
> +#define	FDOR_MOB	0x20
> +#define	FDOR_DS0	0x01
> +#define	FDOR_DS1	0x02
> +
> +#define	FDOR_RESET	0x04

Why is there a blank line before that one? Is it special?

> +
> +#define	FDIR_CHG	0x80
> +
> +#define	FMSR_RQM	0x80
> +#define	FMSR_DIO	0x40
> +#define	FMSR_CMD	0x10
> +
> +#define	FCMD_SENSE	0x04
> +#define	FCMS_HDS	0x04
> +
> +#define	FST3_T0		0x10
> +#define	FST3_WP		0x40
> +
> +
> +/* ----- Low-level floppy access ------------------------------------------ */
> +
> +static inline void port_dor_out(unsigned char d)
> +{
> +	outb(d, base + FOFF_DOR);
> +}
> +
> +static inline unsigned char port_dir_in(void)
> +{
> +	return inb(base + FOFF_DIR);
> +}
> +
> +static inline unsigned char port_msr_in(void)
> +{
> +	return inb(base + FOFF_MSR);
> +}
> +
> +static inline void port_data_out(unsigned char d)
> +{
> +	outb(d, base + FOFF_DATA);
> +}
> +
> +static inline unsigned char port_data_in(void)
> +{
> +	return inb(base + FOFF_DATA);
> +}
> +
> +
> +/* ----- Floppy controller sense ------------------------------------------ */
> +
> +
> +static inline unsigned char msr_wait(
> +	unsigned mask, unsigned val, int timeout)

Odd indentation.

> +{
> +	unsigned char st;
> +
> +	/* wait for controller */
> +	while (((st = port_msr_in()) & mask) != val)
> +		if (!--timeout)
> +			break;
> +
> +	if (timeout)
> +		return st;
> +
> +	pr_err(DRVNAME ": timeout reached ... %02x/%02x\n", dor, st);
> +	return 0;
> +}
> +
> +unsigned char cmd_sense(unsigned char head)

Should be static.

> +{
> +	unsigned char st;
> +
> +	/* wait for controller */
> +	msr_wait(FMSR_RQM|FMSR_CMD, FMSR_RQM, 5000);
> +
> +	port_data_out(FCMD_SENSE);
> +	st = msr_wait(FMSR_RQM, FMSR_RQM, 5000);
> +
> +	if (!(st & FMSR_CMD))
> +		return 0;

The usual coding style is no blank line before a function call and
testing the result.

> +
> +	port_data_out(head ? FCMS_HDS : 0);
> +	st = msr_wait(FMSR_RQM, FMSR_RQM, 5000);
> +
> +	if (!(st & FMSR_CMD))
> +		return 0;
> +
> +	return port_data_in();
> +}
> +
> +
> +/* ----- Output and input lines ------------------------------------------- */
> +
> +#define	LINE_OFF	0x00
> +
> +	/* output lines */
> +
> +#define	LINE_MOA	FDOR_MOA
> +#define	LINE_MOB	FDOR_MOB
> +#define	LINE_DS0	FDOR_DS0
> +#define	LINE_DS1	FDOR_DS1
> +
> +#define	LINE_MASK_DOR	(LINE_MOA | LINE_MOB | LINE_DS0 | LINE_DS1)
> +
> +#define	LINE_HDS	0x08
> +
> +struct i2c_floppy_lines {
> +	unsigned ena:8;
> +	unsigned sda:8;
> +	unsigned scl:8;

Err, why don't you just use 3 unsigned chars? I suspect this would be
more efficient.

> +};
> +
> +static struct i2c_floppy_lines i2c_floppy_lines_out[] = {
> +	{ LINE_OFF, LINE_OFF, LINE_OFF },	/*  0 */
> +
> +	{ LINE_OFF, LINE_MOA, LINE_MOB },	/*  1 */
> +	{ LINE_HDS, LINE_MOA, LINE_MOB },	/*  2 */
> +
> +	{ LINE_OFF, LINE_MOA, LINE_DS1 },	/*  3 */
> +	{ LINE_MOB, LINE_MOA, LINE_DS1 },	/*  4 */
> +	{ LINE_HDS, LINE_MOA, LINE_DS1 },	/*  5 */
> +
> +	{ LINE_OFF, LINE_MOA, LINE_HDS },	/*  6 */
> +	{ LINE_MOB, LINE_MOA, LINE_HDS },	/*  7 */
> +	{ LINE_DS1, LINE_MOA, LINE_HDS },	/*  8 */
> +
> +	{ LINE_OFF, LINE_MOB, LINE_DS0 },	/*  9 */
> +	{ LINE_MOA, LINE_MOB, LINE_DS0 },	/* 10 */
> +	{ LINE_HDS, LINE_MOB, LINE_DS0 },	/* 11 */
> +
> +	{ LINE_OFF, LINE_MOB, LINE_HDS },	/* 12 */
> +	{ LINE_MOA, LINE_MOB, LINE_HDS },	/* 13 */
> +	{ LINE_DS0, LINE_MOB, LINE_HDS },	/* 14 */
> +
> +	{ LINE_OFF, LINE_HDS, LINE_DS0 },	/* 15 */
> +	{ LINE_MOA, LINE_HDS, LINE_DS0 },	/* 16 */
> +	{ LINE_MOB, LINE_HDS, LINE_DS0 },	/* 17 */
> +	{ LINE_DS1, LINE_HDS, LINE_DS0 },	/* 18 */
> +
> +	{ LINE_OFF, LINE_HDS, LINE_DS1 },	/* 19 */
> +	{ LINE_MOA, LINE_HDS, LINE_DS1 },	/* 20 */
> +	{ LINE_MOB, LINE_HDS, LINE_DS1 },	/* 21 */
> +	{ LINE_DS0, LINE_HDS, LINE_DS1 },	/* 22 */
> +};
> +
> +	/* input lines */
> +
> +#define	LINE_T0		FST3_T0
> +#define	LINE_WP		FST3_WP
> +
> +#define	LINE_MASK_ST3	(LINE_T0 | LINE_WP)
> +
> +#define LINE_CHG	FDIR_CHG
> +
> +static struct i2c_floppy_lines i2c_floppy_lines_in[] = {
> +	{ LINE_OFF, LINE_OFF, LINE_OFF },	/*  0 - auto*/

Missing space at end of comment.

> +
> +	{ LINE_OFF, LINE_CHG, LINE_OFF },	/*  1 */
> +	{ LINE_OFF, LINE_T0,  LINE_OFF },	/*  2 */
> +	{ LINE_OFF, LINE_WP,  LINE_OFF },	/*  3 */
> +
> +	{ LINE_OFF, LINE_CHG, LINE_T0  },	/*  4 */
> +	{ LINE_OFF, LINE_T0,  LINE_WP  },	/*  5 */
> +	{ LINE_OFF, LINE_WP,  LINE_CHG },	/*  6 */
> +
> +	{ LINE_CHG, LINE_T0,  LINE_OFF },	/*  7 */
> +	{ LINE_CHG, LINE_WP,  LINE_OFF },	/*  8 */
> +	{ LINE_CHG, LINE_T0,  LINE_WP  },	/*  9 */
> +
> +	{ LINE_T0,  LINE_CHG, LINE_OFF },	/* 10 */
> +	{ LINE_T0,  LINE_WP,  LINE_OFF },	/* 11 */
> +	{ LINE_T0,  LINE_WP,  LINE_CHG },	/* 12 */
> +
> +	{ LINE_WP,  LINE_CHG, LINE_OFF },       /* 13 */
> +	{ LINE_WP,  LINE_T0,  LINE_OFF },       /* 14 */
> +	{ LINE_WP,  LINE_CHG, LINE_T0  },       /* 15 */
> +};
> +
> +	/* parameters */
> +
> +#define	LM_SWAP		0x0020
> +#define	LM_INV_SDA	0x0040
> +#define	LM_INV_SCL	0x0080
> +#define	LM_INV_ENA	0x0100
> +
> +
> +static unsigned int line_mode = 0xe1;

I would rather not default to a specific wiring. To make sure that the
user knows what he/she is doing, it's better to have him/her pass the
parameter mode he/she needs. This is what the i2c-parport-light driver
is doing.

> +module_param(line_mode, uint, 0);
> +MODULE_PARM_DESC(line_mode, "Output line mode");
> +
> +static unsigned int line_mode_in = 0x00;

Do not initialize static variables to 0, let the compiler do it for you.

> +module_param(line_mode_in, uint, 0);
> +MODULE_PARM_DESC(line_mode_in, "Input line mode");
> +
> +
> +	/* calculated */
> +
> +static unsigned char lo_inv;
> +static unsigned char lo_mask;
> +
> +static unsigned char li_inv;
> +static unsigned char li_mask;
> +
> +static struct i2c_floppy_lines lines;
> +static struct i2c_floppy_lines lines_in;
> +
> +
> +/* ----- Output and input helpers ----------------------------------------- */
> +
> +static unsigned char i2c_lo;

What is this one for? This deserves a comment.

> +
> +static void update_lo(unsigned char lo)
> +{
> +	static unsigned char lo_prev;
> +	unsigned char chg = lo ^ lo_prev;
> +
> +	if (!chg)
> +		return;
> +
> +	lo_prev = lo;
> +
> +	if (chg & LINE_MASK_DOR) {
> +		dor &= ~LINE_MASK_DOR;
> +		dor |= (lo ^ lo_inv) & LINE_MASK_DOR;
> +		port_dor_out(dor);
> +	}
> +
> +	if (chg & LINE_HDS)
> +		cmd_sense((lo ^ lo_inv) & LINE_HDS);
> +}
> +
> +
> +static unsigned char i2c_li;

Same here, especially when you never use the value of this variable.

> +
> +static unsigned char update_li(void)
> +{
> +	unsigned char li = 0;
> +
> +	/* conditionally retrieve st3 flags */
> +	if (li_mask & LINE_MASK_ST3)
> +		li |= cmd_sense((i2c_lo ^ lo_inv) & LINE_HDS)
> +			& LINE_MASK_ST3;
> +
> +	/* conditionally map in disk change */
> +	if (li_mask & LINE_CHG)
> +		li |= port_dir_in() & FDIR_CHG;
> +
> +	i2c_li = li;
> +	return li;
> +}
> +
> +
> +/* ----- I2C algorithm call-back functions and structures ----------------- */
> +
> +static void floppy_setena(void *data, int state)
> +{
> +	if (state)
> +		i2c_lo |= lines.ena;
> +	else
> +		i2c_lo &= ~lines.ena;
> +
> +	update_lo(i2c_lo);
> +}
> +
> +static void floppy_setscl(void *data, int state)
> +{
> +	if (state)
> +		i2c_lo |= lines.scl;
> +	else
> +		i2c_lo &= ~lines.scl;
> +
> +	update_lo(i2c_lo);
> +}
> +
> +static void floppy_setsda(void *data, int state)
> +{
> +	if (state)
> +		i2c_lo |= lines.sda;
> +	else
> +		i2c_lo &= ~lines.sda;
> +
> +	update_lo(i2c_lo);
> +}
> +
> +
> +static int floppy_getena(void *data)
> +{
> +	return (update_li() ^ li_inv) & lines_in.ena;
> +}
> +
> +static int floppy_getscl(void *data)
> +{
> +	return (update_li() ^ li_inv) & lines_in.scl;
> +}
> +
> +static int floppy_getsda(void *data)
> +{
> +	return (update_li() ^ li_inv) & lines_in.sda;
> +}
> +
> +
> +static struct i2c_algo_bit_data floppy_algo_data = {
> +	.setsda		= floppy_setsda,
> +	.setscl		= floppy_setscl,
> +	.getsda		= floppy_getsda,
> +	.getscl		= floppy_getscl,
> +	.udelay		= 50,
> +	.timeout	= HZ,
> +};
> +
> +
> +/* ----- Driver setup ----------------------------------------------------- */
> +
> +static void swap_sda_scl(struct i2c_floppy_lines *lines)
> +{
> +	unsigned char tmp = lines->sda;
> +
> +	lines->sda = lines->scl;
> +	lines->scl = tmp;
> +}
> +
> +
> +static void setup_lo(void)
> +{
> +	/* avoid undefined line modes */
> +	if ((line_mode & 0x1F) > 22)

Please use ARRAY_SIZE(i2c_floppy_lines_out).

> +		line_mode &= ~0x1F;

Bad idea. Better return an error and bail out. If the user asked for a
mode that doesn't exist, he/she messed up, and silently defaulting to
an arbitrary mode has little chance to work.

> +
> +	lines = i2c_floppy_lines_out[line_mode & 0x1F];
> +
> +	/* swap scl and sda */
> +	if (line_mode & LM_SWAP)
> +		swap_sda_scl(&lines);
> +
> +	if (line_mode & LM_INV_SDA)
> +		lo_inv ^= lines.sda;

Wouldn't it be more intuitive to use |= here?

> +	if (line_mode & LM_INV_SCL)
> +		lo_inv ^= lines.scl;
> +	if (line_mode & LM_INV_ENA)
> +		lo_inv ^= lines.ena;
> +
> +	/* calculate line mask */
> +	lo_mask = lines.ena | lines.sda | lines.scl;
> +
> +	pr_info(DRVNAME ": line output config: "
> +		"%02x/%02x/%02x [%02x/%02x]\n",
> +		lines.ena, lines.scl, lines.sda, lo_mask, lo_inv);

This message isn't too helpful, as you have to look at the source code
to figure out which value corresponds to what. Why don't you put the
names in the message? "ENA=%02x, SCL=%02x, ..."

> +}
> +
> +
> +static unsigned char lo_state(int ena, int sda, int scl)
> +{
> +	floppy_setena(NULL, ena);
> +	floppy_setsda(NULL, sda);
> +	floppy_setscl(NULL, scl);
> +	return update_li();
> +}
> +
> +static void auto_setup_li(void)

This function clearly deserves a comment explaining what you are doing,
why you are doing it, and why it is safe to do it.

> +{
> +	unsigned char a, b, m;

More explicit variable names wouldn't hurt.

> +
> +	li_mask = ~0;
> +	li_inv = 0;
> +
> +	/* reset controller */
> +	dor = 0;
> +	port_dor_out(dor);
> +
> +	/* enable controller */
> +	dor |= FDOR_RESET;
> +	port_dor_out(dor);
> +
> +	udelay(100);
> +
> +	a = lo_state(0, 1, 1);
> +	b = lo_state(1, 1, 1);
> +	m = a ^ b;	/* maybe only one bit? */

I don't understand this comment.

> +
> +	/* calculate enable input */
> +	lines_in.ena = m;
> +	li_inv |= a & m;
> +
> +	a = b;
> +	b = lo_state(1, 1, 0);
> +	m = a ^ b;	/* maybe only one bit? */
> +
> +	/* calculate scl input */
> +	lines_in.scl = m;
> +	li_inv |= b & m;
> +
> +	a = b;
> +	b = lo_state(1, 0, 0);
> +	m = a ^ b;	/* maybe only one bit? */
> +
> +	/* calculate sda input */
> +	lines_in.sda = m;
> +	li_inv |= b & m;
> +}

This assumes that nobody is holding the I2C lines (excluding
multi-master setups.) This should be mentioned. BTW, I am surprised
that this function can't fail? What if the line change you expect
doesn't happen? This should be handled.

> +
> +static void setup_li(void)
> +{
> +	/* automatic setup if selected */
> +	if (!line_mode_in) {
> +		auto_setup_li();
> +		goto calc_mask;
> +	}
> +
> +	lines_in = i2c_floppy_lines_in[line_mode_in & 0x0F];

You should test line_mode_in against ARRAY_SIZE(i2c_floppy_lines_in).
It happens that this value is a power of 2 right now, but this is by
chance, not design, and may not always be the case in the future.

> +
> +	/* swap scl and sda */
> +	if (line_mode_in & LM_SWAP)
> +		swap_sda_scl(&lines_in);
> +
> +	if (line_mode_in & LM_INV_SDA)
> +		li_inv ^= lines_in.sda;
> +	if (line_mode_in & LM_INV_SCL)
> +		li_inv ^= lines_in.scl;
> +	if (line_mode_in & LM_INV_ENA)
> +		li_inv ^= lines_in.ena;
> +
> +calc_mask:
> +	/* calculate line mask */
> +	li_mask = lines_in.ena | lines_in.sda | lines_in.scl;
> +
> +	pr_info(DRVNAME ": line input config:  "
> +		"%02x/%02x/%02x [%02x/%02x]\n",
> +		lines_in.ena, lines_in.scl, lines_in.sda,
> +		li_mask, li_inv);
> +}

Most of my comments on setup_lo() apply here as well.

> +
> +
> +/* ----- Driver registration ---------------------------------------------- */
> +
> +static struct i2c_adapter floppy_adapter = {
> +	.owner		= THIS_MODULE,
> +	.class		= I2C_CLASS_HWMON,
> +	.algo_data	= &floppy_algo_data,
> +	.name		= "Floppy controller adapter",
> +};
> +
> +static int __devinit i2c_floppy_probe(struct platform_device *pdev)
> +{
> +	int err;
> +
> +	floppy_adapter.dev.parent = &pdev->dev;
> +	err = i2c_bit_add_bus(&floppy_adapter);
> +	if (err)
> +		dev_err(&pdev->dev, "Unable to register with I2C\n");
> +	return err;
> +}
> +
> +static int __devexit i2c_floppy_remove(struct platform_device *pdev)
> +{
> +	i2c_del_adapter(&floppy_adapter);
> +	return 0;
> +}
> +
> +static struct platform_driver i2c_floppy_driver = {
> +	.driver = {
> +		.owner	= THIS_MODULE,
> +		.name	= DRVNAME,
> +	},
> +	.probe		= i2c_floppy_probe,
> +	.remove		= __devexit_p(i2c_floppy_remove),
> +};
> +
> +static int __init i2c_floppy_device_add(u16 address)
> +{
> +	int err;
> +
> +	pdev = platform_device_alloc(DRVNAME, -1);
> +	if (!pdev) {
> +		err = -ENOMEM;
> +		pr_err(DRVNAME ": Device allocation failed\n");
> +		goto exit;
> +	}
> +
> +	err = platform_device_add(pdev);
> +	if (err) {
> +		pr_err(DRVNAME ": Device addition failed (%d)\n",
> +		       err);
> +		goto exit_device_put;
> +	}
> +
> +	return 0;
> +
> +exit_device_put:
> +	platform_device_put(pdev);
> +exit:
> +	return err;
> +}
> +
> +static int __init i2c_floppy_init(void)
> +{
> +	int err;
> +
> +	if (base == 0) {
> +		pr_info(DRVNAME ": using default base 0x%x\n",
> +			DEFAULT_BASE);
> +		base = DEFAULT_BASE;
> +	}
> +
> +	err = -EBUSY;
> +	if (!request_region(base, 5, DRVNAME))
> +		goto exit;
> +
> +	if (!request_region(base + 7, 1, DRVNAME))
> +		goto exit_rel0;

This gives you access to offsets 0, 1, 2, 3, 4 and 7, while your code
accesses offsets 2, 4, 5 and 7. Seems incorrect.

> +
> +	/* Sets global pdev as a side effect */
> +	err = i2c_floppy_device_add(base);
> +	if (err)
> +		goto exit_rel7;
> +
> +	err = platform_driver_register(&i2c_floppy_driver);
> +	if (err)
> +		goto exit_device;
> +
> +	setup_lo();
> +	setup_li();

You are doing things in the wrong order: everything should be setup by
the time i2c_bit_add_adapter() is called. Otherwise there's a
possibility that someone (e.g. a hwmon kernel driver) starts using the
adapter before it's ready.

It's unclear to me why you want to setup the adapter here in
i2c_floppy_init() rather than in i2c_floppy_probe(), where it would be
way clearer in which order things happen.

> +
> +	dor &= ~FDOR_RESET;
> +	/* do we need the controller active? */
> +	if ((li_mask & LINE_MASK_ST3) ||
> +		(lo_mask & LINE_HDS))

Should fit on a single line.

> +		dor |= FDOR_RESET;
> +	port_dor_out(dor);
> +
> +	lo_state(1, 1, 1);
> +	pr_info(DRVNAME ": input line check %02x/%02x/%02x\n",
> +		floppy_getena(NULL),
> +		floppy_getscl(NULL),
> +		floppy_getsda(NULL));

Same comment as the other pr_info.

> +
> +	/* disable getscl if no mapping */
> +	if (!lines_in.scl)
> +		floppy_algo_data.getscl = NULL;
> +
> +	/* update udelay with param */
> +	floppy_algo_data.udelay = delay;

delay is 0 by default, this will break. values of delay < 5 would
better be rejected, as I doubt they will work.

> +
> +	return 0;
> +
> +exit_device:
> +	platform_device_unregister(pdev);
> +exit_rel7:
> +	release_region(base + 7, 1);
> +exit_rel0:
> +	release_region(base, 5);
> +exit:
> +	return err;
> +}
> +
> +static void __exit i2c_floppy_exit(void)
> +{
> +	platform_driver_unregister(&i2c_floppy_driver);
> +	platform_device_unregister(pdev);
> +	release_region(base + 7, 1);
> +	release_region(base, 5);
> +}
> +
> +
> +MODULE_AUTHOR("Herbert Poetzl <herbert-dBHVzrDq9nF4Lj/PQRBjDg@public.gmane.org>");
> +MODULE_DESCRIPTION("I2C bus over floppy controller");
> +MODULE_LICENSE("GPL");
> +
> +module_init(i2c_floppy_init);
> +module_exit(i2c_floppy_exit);
> diff -NurpP --minimal linux-2.6.27-rc8/drivers/i2c/busses/Kconfig linux-2.6.27-rc8-fi2c-v0.6.1/drivers/i2c/busses/Kconfig
> --- linux-2.6.27-rc8/drivers/i2c/busses/Kconfig	2008-09-30 22:53:59.000000000 +0200
> +++ linux-2.6.27-rc8-fi2c-v0.6.1/drivers/i2c/busses/Kconfig	2008-09-30 22:57:12.000000000 +0200
> @@ -490,6 +490,21 @@ config I2C_VERSATILE
>  
>  comment "External I2C/SMBus adapter drivers"
>  
> +config I2C_FLOPPY
> +	tristate "Floppy controller adapter"
> +	select I2C_ALGOBIT
> +	help
> +	  This supports a simple do-it-yourself floppy controller to
> +	  I2C adapters using the motor control lines for SDA and SCL,
> +	  and the drive change input for SDA readback.

This description is now a bit too specific given that the driver can
actually use a variety of combination for input and output lines.

> +
> +	  This support is also available as a module.  If so, the module
> +	  will be called i2c-floppy.
> +
> +	  If you do not have such a device, and do not plan to build one,
> +	  it's safe to say N here. Do not say Y here and to the floppy
> +	  driver unless you know exactly what you are doing.

As explained before, this can be enforced by adding:

depends on !BLK_DEV_FD

I have a patch doing that and I will push it together with yours if
needed, but it would make more sense to merge it directly in your patch.

I would also like you to add a dependency on EXPERIMENTAL, as this is
what your driver is at the moment.

> +
>  config I2C_PARPORT
>  	tristate "Parallel port adapter"
>  	depends on PARPORT
> diff -NurpP --minimal linux-2.6.27-rc8/drivers/i2c/busses/Makefile linux-2.6.27-rc8-fi2c-v0.6.1/drivers/i2c/busses/Makefile
> --- linux-2.6.27-rc8/drivers/i2c/busses/Makefile	2008-09-30 22:53:59.000000000 +0200
> +++ linux-2.6.27-rc8-fi2c-v0.6.1/drivers/i2c/busses/Makefile	2008-09-30 22:56:14.000000000 +0200
> @@ -48,6 +48,7 @@ obj-$(CONFIG_I2C_SIMTEC)	+= i2c-simtec.o
>  obj-$(CONFIG_I2C_VERSATILE)	+= i2c-versatile.o
>  
>  # External I2C/SMBus adapter drivers
> +obj-$(CONFIG_I2C_FLOPPY)	+= i2c-floppy.o
>  obj-$(CONFIG_I2C_PARPORT)	+= i2c-parport.o
>  obj-$(CONFIG_I2C_PARPORT_LIGHT)	+= i2c-parport-light.o
>  obj-$(CONFIG_I2C_TAOS_EVM)	+= i2c-taos-evm.o
> diff -NurpP --minimal linux-2.6.27-rc8/Makefile linux-2.6.27-rc8-fi2c-v0.6.1/Makefile
> --- linux-2.6.27-rc8/Makefile	2008-09-30 22:53:29.000000000 +0200
> +++ linux-2.6.27-rc8-fi2c-v0.6.1/Makefile	2008-10-01 18:43:54.000000000 +0200
> @@ -1,7 +1,7 @@
>  VERSION = 2
>  PATCHLEVEL = 6
>  SUBLEVEL = 27
> -EXTRAVERSION = -rc8
> +EXTRAVERSION = -rc8linux-2.6.27-rc8-fi2c-v0.6.1
>  NAME = Rotary Wombat
>  
>  # *DOCUMENTATION*

This last chunk was probably not meant to be included in the patch.

OTOH, your driver has reached a level of complexity such that I do not
want to be the one maintaining it. So, if you want it in mainline,
you'll have to add an entry in MAINTAINERS for this driver with your
name on it.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
