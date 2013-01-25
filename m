From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-isch: Add module parameter for backbone clock rate
 if divider is unset
Date: Fri, 25 Jan 2013 10:59:10 +0100
Message-ID: <20130125105910.017c86d8@endymion.delvare>
References: <1358937274-14908-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1358937274-14908-1-git-send-email-alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Alexander,

On Wed, 23 Jan 2013 11:34:34 +0100, Alexander Stein wrote:
> It was observed the Host Clock Divider was not written by the driver. It
> was still set to (default) 0, if not already set by BIOS, which caused
> garbage on SMBus.
> This driver adds a parameters which is used to calculate the divider
> appropriately for a default bitrate of 100 KHz. This new divider is only
> applied if the clock divider is still default 0.
> 
> Signed-off-by: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
> ---
> This patch supersedes the older patch
>  i2c-isch: Add module parameter which actually set the clock divider
> from 2012. It now has only one parameter to set the backbone clock rate which
> is guessed to 33 MHz which is the maximum for both device the lpc_sch driver
> is for. It registers a single i2c_smbus platform device.
> To my knowledge we can't determine if we have 33 or 25 MHz clock for SMBus,
> so expect 33 MHz and calculate a bus clock of 100 kHz. If we actually run
> at 25 MHz the bus will be run ~75 kHz instead which should do no harm.
> 
>  drivers/i2c/busses/i2c-isch.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-isch.c b/drivers/i2c/busses/i2c-isch.c
> index 4099f79..495d28f 100644
> --- a/drivers/i2c/busses/i2c-isch.c
> +++ b/drivers/i2c/busses/i2c-isch.c
> @@ -40,6 +40,7 @@
>  /* SCH SMBus address offsets */
>  #define SMBHSTCNT	(0 + sch_smba)
>  #define SMBHSTSTS	(1 + sch_smba)
> +#define SMBHSTCLK	(2 + sch_smba)
>  #define SMBHSTADD	(4 + sch_smba) /* TSA */
>  #define SMBHSTCMD	(5 + sch_smba)
>  #define SMBHSTDAT0	(6 + sch_smba)
> @@ -58,6 +59,7 @@
>  
>  static unsigned short sch_smba;
>  static struct i2c_adapter sch_adapter;
> +static int backbone_speed = 33000; /* backbone speed in KHz */

Although I know it is a very common mistake, the proper casing is kHz.

>  
>  /*
>   * Start the i2c transaction -- the i2c_access will prepare the transaction
> @@ -156,6 +158,14 @@ static s32 sch_access(struct i2c_adapter *adap, u16 addr,
>  		dev_dbg(&sch_adapter.dev, "SMBus busy (%02x)\n", temp);
>  		return -EAGAIN;
>  	}
> +	temp = inw(SMBHSTCLK);
> +	if (!temp) {
> +		int smbus_speed = 100;
> +		dev_notice(&sch_adapter.dev, "clock divider unitialized. Setting module defaults\n");

Start the log message with a capital. Move the string to the next line
to limit line length. "Setting module defaults" is not useful
information for the user, not to mention that it is incorrect (the
module default is uninitialized, that's exactly the problem.)

> +		dev_dbg(&sch_adapter.dev, "access speed: %d KHz\n", smbus_speed);
> +		outw((backbone_speed / 4) / smbus_speed, SMBHSTCLK);

Useless debug statement. Just hardcode smbus_speed to 100 in the
formula. BTW I suspect that backbone_speed / (4 * 100) would be more
efficient.

> +	}
> +
>  	dev_dbg(&sch_adapter.dev, "access size: %d %s\n", size,
>  		(read_write)?"READ":"WRITE");
>  	switch (size) {
> @@ -312,3 +322,4 @@ MODULE_AUTHOR("Jacob Pan <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>");
>  MODULE_DESCRIPTION("Intel SCH SMBus driver");
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS("platform:isch_smbus");
> +module_param(backbone_speed, int, (S_IRUSR | S_IWUSR));

Please group the variable declaration and the module parameter
declaration. The parentheses around S_IRUSR | S_IWUSR aren't needed.
Please add a module parameter description, including the unit and
default value.

-- 
Jean Delvare
