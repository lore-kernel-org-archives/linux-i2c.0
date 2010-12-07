From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] I2C: SiByte: Convert the driver to make use of
 interrupts
Date: Mon, 6 Dec 2010 22:23:44 -0800
Message-ID: <20101207062344.GA20673@ericsson.com>
References: <1291617494-18430-1-git-send-email-mattst88@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1291617494-18430-1-git-send-email-mattst88-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Turner <mattst88-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org" <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, "Maciej W. Rozycki" <macro-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Dec 06, 2010 at 01:38:14AM -0500, Matt Turner wrote:
> From: Maciej W. Rozycki <macro-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
> 
> This is a rewrite of large parts of the driver mainly so that it uses
> SMBus interrupts to offload the CPU from busy-waiting on status inputs.
> As a part of the overhaul of the init and exit calls, all accesses to the
> hardware got converted to use accessory functions via an ioremap() cookie.
> 
> Minimally rebased by Matt Turner.
> 
> Tested-by: Matt Turner <mattst88-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Matt Turner <mattst88-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

[ .. ] 
> 
> -static struct i2c_algo_sibyte_data sibyte_board_data[2] = {
> -       { NULL, 0, (void *) (CKSEG1+A_SMB_BASE(0)) },
> -       { NULL, 1, (void *) (CKSEG1+A_SMB_BASE(1)) }
> +static struct i2c_algo_sibyte_data i2c_sibyte_board_data[2] = {
> +       {
> +               .name   = "sb1250-smbus-0",
> +               .base   = A_SMB_0,
> +               .irq    = K_INT_SMB_0,
> +       },
> +       {
> +               .name   = "sb1250-smbus-1",
> +               .base   = A_SMB_1,
> +               .irq    = K_INT_SMB_1,

Found my problem. The .irq settings don't work for BCM1480.
It needs K_BCM1480_INT_SMB_0 and K_BCM1480_INT_SMB_1 from asm/sibyte/bcm1480_int.h.

For a clean fix, i2c_sibyte_board_data[] should probably be defined in a platform file, 
not in the i2c bus driver.

Guenter
