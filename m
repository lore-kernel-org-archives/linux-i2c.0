From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC PATCH] i2c:mux: Driver for PCA9641 I2C Master Arbiter
Date: Tue, 14 Feb 2017 00:39:29 -0800
Message-ID: <7765e617-7004-72c5-ad0b-3a15ae8db4fb@roeck-us.net>
References: <1486723418-13311-1-git-send-email-vidya@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38299 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751490AbdBNIjd (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 14 Feb 2017 03:39:33 -0500
In-Reply-To: <1486723418-13311-1-git-send-email-vidya@cumulusnetworks.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Vidya Sagar Ravipati <vidya@cumulusnetworks.com>, jdelvare@suse.de, wsa@the-dreams.de, linux-i2c@vger.kernel.org
Cc: roopa@cumulusnetworks.com, vidya.chowdary@gmail.com

On 02/10/2017 02:43 AM, Vidya Sagar Ravipati wrote:
> From: Vidya Sagar Ravipati <vidya@cumulusnetworks.com>
>
> This patch adds support for PCA9641, an I2C Bus Master Arbiter.
> NXP PCA9641 arbiter is modeled as single channel I2C Multiplexer
> to be able to utilize the I2C multiplexer framework similar to
> PCA9541.
>
> Enhancing PCA9541 driver to support PCA9641 i2c master arbiter
> http://www.nxp.com/documents/data_sheet/PCA9641.pdf
>
> Signed-off-by: Vidya Sagar Ravipati <vidya@cumulusnetworks.com>
> Signed-off-by: Luffy<Luffy.Cheng@quantatw.com>
> ---
>  drivers/i2c/muxes/i2c-mux-pca9541.c | 157 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 152 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
> index 77840f7..89d8518 100644
> --- a/drivers/i2c/muxes/i2c-mux-pca9541.c
> +++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
> @@ -59,6 +59,36 @@
>  #define PCA9541_ISTAT_MYTEST	(1 << 6)
>  #define PCA9541_ISTAT_NMYTEST	(1 << 7)
>
> +#define PCA9641_ID		0
> +#define PCA9641_ID_MAGIC	0x38
> +#define PCA9641_CONTROL		0x01
> +#define PCA9641_STATUS		0x02
> +
> +#define PCA9641_CONTROL		0x01
> +#define PCA9641_CTL_LOCK_REQ		(1 << 0)
> +#define PCA9641_CTL_LOCK_GRANT		(1 << 1)
> +#define PCA9641_CTL_BUS_CONNECT		(1 << 2)
> +#define PCA9641_CTL_BUS_INIT		(1 << 3)
> +#define PCA9641_CTL_SMBUS_SWRST		(1 << 4)
> +#define PCA9641_CTL_IDLE_TIMER_DIS	(1 << 5)
> +#define PCA9641_CTL_SMBUS_DIS		(1 << 6)
> +#define PCA9641_CTL_PRIORITY		(1 << 7)
> +
> +#define PCA9641_STATUS		0x02
> +#define PCA9641_STS_OTHER_LOCK		(1 << 0)
> +#define PCA9641_STS_BUS_INIT_FAIL	(1 << 1)
> +#define PCA9641_STS_BUS_HUNG		(1 << 2)
> +#define PCA9641_STS_MBOX_EMPTY		(1 << 3)
> +#define PCA9641_STS_MBOX_FULL		(1 << 4)
> +#define PCA9641_STS_TEST_INT		(1 << 5)
> +#define PCA9641_STS_SCL_IO		(1 << 6)
> +#define PCA9641_STS_SDA_IO		(1 << 7)
> +
> +#define PCA9641_RES_TIME       0x03
> +
> +#define other_lock(x)  ((x) & PCA9641_STS_OTHER_LOCK)
> +#define lock_grant(x)  ((x) & PCA9641_CTL_LOCK_GRANT)
> +
>  #define BUSON		(PCA9541_CTL_BUSON | PCA9541_CTL_NBUSON)
>  #define MYBUS		(PCA9541_CTL_MYBUS | PCA9541_CTL_NMYBUS)
>  #define mybus(x)	(!((x) & MYBUS) || ((x) & MYBUS) == MYBUS)
> @@ -73,13 +103,20 @@
>  #define SELECT_DELAY_LONG	1000
>
>  struct pca9541 {
> +	int device_type;
>  	struct i2c_client *client;
>  	unsigned long select_timeout;
>  	unsigned long arb_timeout;
>  };
>
> +enum pca9x41 {
> +	PCA9541 = 0,
> +	PCA9641
> +};
> +
>  static const struct i2c_device_id pca9541_id[] = {
> -	{"pca9541", 0},
> +	{"pca9541", PCA9541},
> +	{"pca9641", PCA9641},
>  	{}
>  };
>
> @@ -178,12 +215,17 @@ static int pca9541_reg_read(struct i2c_client *client, u8 command)
>  /* Release bus. Also reset NTESTON and BUSINIT if it was set. */

This comment now only applies to pca9541.

>  static void pca9541_release_bus(struct i2c_client *client)
>  {
> +	struct pca9541 *data = i2c_get_clientdata(client);
>  	int reg;
>
> -	reg = pca9541_reg_read(client, PCA9541_CONTROL);
> -	if (reg >= 0 && !busoff(reg) && mybus(reg))
> -		pca9541_reg_write(client, PCA9541_CONTROL,
> -				  (reg & PCA9541_CTL_NBUSON) >> 1);
> +	if (data->device_type == PCA9541) {
> +		reg = pca9541_reg_read(client, PCA9541_CONTROL);
> +		if (reg >= 0 && !busoff(reg) && mybus(reg))
> +			pca9541_reg_write(client, PCA9541_CONTROL,
> +				(reg & PCA9541_CTL_NBUSON) >> 1);
> +	} else
> +		pca9541_reg_write(client, PCA9641_CONTROL, 0);

if {} else {}

Please run checkpatch.

> +
>  }
>
>  /*
> @@ -294,6 +336,90 @@ static int pca9541_arbitrate(struct i2c_client *client)
>  	return 0;
>  }
>
> +/*
> + * Channel arbitration
> + *
> + * Return values:
> + *  <0: error
> + *  0 : bus not acquired
> + *  1 : bus acquired
> + */
> +static int pca9641_arbitrate(struct i2c_client *client)
> +{
> +	struct pca9541 *data = i2c_get_clientdata(client);
> +	int reg_ctl, reg_sts;
> +
> +	reg_ctl = pca9541_reg_read(client, PCA9641_CONTROL);
> +	if (reg_ctl < 0)
> +		return reg_ctl;
> +
> +	reg_sts = pca9541_reg_read(client, PCA9641_STATUS);
> +	if (!other_lock(reg_sts) && !lock_grant(reg_ctl)) {
> +		/*
> +		 * Bus is off. Request ownership or turn it on unless
> +		 * other master requested ownership.
> +		 */
> +		/* FIXME: bus reserve time (1-255) for without interrupt */
> +		/*  Lock forever
> +		 * pca9541_reg_write(client, PCA9641_RES_TIME, 0);
> +		 */
> +		reg_ctl |= PCA9641_CTL_LOCK_REQ;
> +		pca9541_reg_write(client, PCA9641_CONTROL, reg_ctl);
> +
> +		/* FIXME: If need Wait for lock grant */
> +		udelay(100);
> +
Presumably those and the TODOs below will be fixed. Either case,
I don't immediately see why the delay here is necessary. Delays are
supposed to be executed in the calling code.

> +		reg_ctl = pca9541_reg_read(client, PCA9641_CONTROL);
> +
Unnecessary empty line.

> +		if (lock_grant(reg_ctl)) {
> +			/*
> +			 * Other master did not request ownership,
> +			 * or arbitration timeout expired. Take the bus.
> +			 */
> +			reg_ctl |= PCA9641_CTL_BUS_CONNECT;
> +			pca9541_reg_write(client, PCA9641_CONTROL, reg_ctl);
> +			data->select_timeout = SELECT_DELAY_SHORT;
> +
> +			return 1;
> +		} else {
> +			/*
> +			 * Other master requested ownership.
> +			 * Set extra long timeout to give it time to acquire it.
> +			 */
> +			data->select_timeout = SELECT_DELAY_LONG * 2;


> +		}
> +	} else if (lock_grant(reg_ctl)) {
> +		/*
> +		 * Bus is on, and we own it. We are done with acquisition.
> +		 */
> +		reg_ctl |= PCA9641_CTL_BUS_CONNECT;
> +		pca9541_reg_write(client, PCA9641_CONTROL, reg_ctl);
> +
> +		return 1;
> +	} else if (other_lock(reg_sts)) {
> +		/*
> +		 * Other master owns the bus.
> +		 * If arbitration timeout has expired, force ownership.
> +		 * Otherwise request it.
> +		 */
> +		data->select_timeout = SELECT_DELAY_LONG;
> +		reg_ctl |= PCA9641_CTL_LOCK_REQ;
> +		pca9541_reg_write(client, PCA9641_CONTROL, reg_ctl);
> +
> +		/*
> +		 * if (time_is_before_eq_jiffies(data->arb_timeout)) {
> +		 * TODO:Time is up, take the bus and reset it.
> +		 *
> +		 *} else {
> +		 * TODO: Request bus ownership if needed

This is similar to the first condition above. It might make sense
to rework the code to be a better fit for the new chip instead of following
the pca9541 code flow.

> +		 *
> +		 *}
> +		 */
> +	}
> +
> +	return 0;
> +}
> +
>  static int pca9541_select_chan(struct i2c_mux_core *muxc, u32 chan)
>  {
>  	struct pca9541 *data = i2c_mux_priv(muxc);
> @@ -306,6 +432,11 @@ static int pca9541_select_chan(struct i2c_mux_core *muxc, u32 chan)
>  		/* force bus ownership after this time */
>
>  	do {
> +		if (data->device_type == PCA9541)
> +			ret = pca9541_arbitrate(client);
> +		else
> +			ret = pca9641_arbitrate(client);
> +
>  		ret = pca9541_arbitrate(client);

This seems wrong. Does this code work ?

>  		if (ret)
>  			return ret < 0 ? ret : 0;
> @@ -328,6 +459,17 @@ static int pca9541_release_chan(struct i2c_mux_core *muxc, u32 chan)
>  	return 0;
>  }
>
> +static int pca9641_detect_id(struct i2c_client *client)

bool.

> +{
> +	int reg;
> +
> +	reg = pca9541_reg_read(client, PCA9641_ID);
> +	if (reg == PCA9641_ID_MAGIC)
> +		return 1;
> +	else
> +		return 0;
> +}
> +
>  /*
>   * I2C init/probing/exit functions
>   */
> @@ -335,6 +477,7 @@ static int pca9541_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
>  	struct i2c_adapter *adap = client->adapter;
> +	kernel_ulong_t device_id = id->driver_data;
>  	struct pca954x_platform_data *pdata = dev_get_platdata(&client->dev);
>  	struct i2c_mux_core *muxc;
>  	struct pca9541 *data;
> @@ -344,6 +487,9 @@ static int pca9541_probe(struct i2c_client *client,
>  	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE_DATA))
>  		return -ENODEV;
>
> +	if (device_id == PCA9641 && !pca9641_detect_id(client))
> +		return ret;

And what is the value of ret ?

I don't think this code should be here in the first place. This device
isn't supposed to be probed unless requested, and the probe function
doesn't normally validate the chip type.

> +
>  	/*
>  	 * I2C accesses are unprotected here.
>  	 * We have to lock the adapter before releasing the bus.
> @@ -366,6 +512,7 @@ static int pca9541_probe(struct i2c_client *client,
>  	data = i2c_mux_priv(muxc);
>  	data->client = client;
>
> +	data->device_type = device_id;
>  	i2c_set_clientdata(client, muxc);
>
>  	ret = i2c_mux_add_adapter(muxc, force, 0, 0);
>
