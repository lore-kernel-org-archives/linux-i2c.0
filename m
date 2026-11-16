Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794844177;
	b=CkxQW07OW6GDVSXzaCopFUEWYYQ3vzk07E9cK1Bi+CBWosskhsoXbJoRtI0/NQtKjw3q
	 pYoSQpBAzllJRvJo1XXnW/UrKvbUWIe4luUcjrUGwILE4tPBnmLzOxN5bVq1NYZCdDl5f
	 DFCbLZkbBZij6De3ALrIrOiXf6/ISQZlVn5T6zgAmQcdZafFLeHjaZvaceIh7n22Av7Yi
	 d4YX6/aRc27w8sWcyr1prMv7+56PANZPhli/P4Fjl6krO7ST4OS+BKZnAN4T3lbFGE+zJ
	 U/6OoeW14vNg2WctirIhzylKpLI+kNKQR1WGFJKFwc4wiiQuCXbYyFvCB6MHg36N2RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794844177;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9LPqHJ7+1oVkvrwe5gK+4+RwocL1Gh6Vu3hJ8plLtpc=;
	b=Dal6y1JXsA3OMhjIxomMExBgwIRgThS+pGSnve6nJkqQs7/C0Bru2Gv6jwZnpdsO90o+
	 NqQkVFMAhHjhASGE9BXxDY+g7kEg8k1QE3jkHh2uWIY8HDw5oIH6iqyrZ2Y6XD7Jd8/39
	 hTo2tyO8qNKosyqQrb3SvkX0tWHZGbPwA/qd/QOBBwuo9wuuArJjVbPjH0tqpeh92TnrH
	 t0AA8CDI1+RM/BZu+VdKTKuP3iIrOTBESD3f1Pnm+Apx6UY0jUcHMm8R/2CsPK6MIcjns
	 d6DOcddPhqOnobI4rb8NhJiXjcqZ2tgfsXV0vvrmeweEjlycLlwrEFoYFdTyLG2PmhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IC+bJO5H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0CC606A333;
	Mon, 16 Nov 2026 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IC+bJO5H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DF91F000CD;
	Mon, 16 Nov 2026 15:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794844177;
	bh=9LPqHJ7+1oVkvrwe5gK+4+RwocL1Gh6Vu3hJ8plLtpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IC+bJO5HUXPPRjfFNoVDEPS6n3cyhDdWgaeENHn/BaxaCvGr5Rhi0vtoxhG4RV9uC
	 elU9xOd4Mx+DFTSdNTcgsOsmncba3S/wt/wQhhsBwCHUOdaEB4ef8ECh/UJeJUf8KA
	 /8W1FrYIanntePWIvLYohIWcz9/90xE0LmTilcqLvJZz+1A4JgayGhxmi43I6VwimX
	 Xak7oTi2LH+YfFCKD1xdgSvxF4ea7q6NOnJhHy2vOgYqsL93FKE5IQS6hPu5Iqxgb0
	 h8YUSKS6aRCe1Dk66+btrlLQehaf8v69iosXEob/ytswjX+IO7uH/2HQD8+qHgTQGJ
	 XmqYesdB7iXrA==
Date: Mon, 16 Nov 2026 15:49:32 +0000
From: Lee Jones <lee@kernel.org>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v5 4/9] i2c: cgbc: Use plateform data to get bus ID and
 adapter name
Message-ID: <20261116154932.GA97865@joneslee-macbookpro.roam.internal>
References: <20261103-cgbc-i2c-storage-devices-support-v5-0-ac11f23fae51@bootlin.com>
 <20261103-cgbc-i2c-storage-devices-support-v5-4-ac11f23fae51@bootlin.com>
 <78cf973d-3434-4f81-82be-a22f4abcfe0c@bootlin.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78cf973d-3434-4f81-82be-a22f4abcfe0c@bootlin.com>

On Mon, 16 Nov 2026, Thomas Richard wrote:

> Hi Lee,
> 
> On 11/3/26 5:49 PM, Thomas Richard (congatec GmbH) wrote:
> > Obtain the bus ID (from the BC point of view) and adapter name from
> > platform data. This allows the specific definitions to be removed, leaving
> > only a generic adapter definition.
> > 
> > Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
> > ---
> >  drivers/i2c/busses/i2c-cgbc.c | 68 ++++++++++++++++---------------------------
> >  1 file changed, 25 insertions(+), 43 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-cgbc.c b/drivers/i2c/busses/i2c-cgbc.c
> > index ac23435b731b..40ffab4fd0bc 100644
> > --- a/drivers/i2c/busses/i2c-cgbc.c
> > +++ b/drivers/i2c/busses/i2c-cgbc.c
> > @@ -12,9 +12,6 @@
> >  #include <linux/module.h>
> >  #include <linux/platform_device.h>
> >  
> > -#define CGBC_I2C_PRIMARY_BUS_ID	0
> > -#define CGBC_I2C_PM_BUS_ID	4
> > -
> >  #define CGBC_I2C_CMD_START	0x40
> >  #define CGBC_I2C_CMD_STAT	0x48
> >  #define CGBC_I2C_CMD_DATA	0x50
> > @@ -60,11 +57,6 @@ enum cgbc_i2c_state {
> >  	CGBC_I2C_STATE_ERROR,
> >  };
> >  
> > -struct i2c_algo_cgbc_data {
> > -	u8		bus_id;
> > -	unsigned long	read_maxtime_us;
> > -};
> > -
> >  struct cgbc_i2c_data {
> >  	struct device		*dev;
> >  	struct cgbc_device_data *cgbc;
> > @@ -73,6 +65,8 @@ struct cgbc_i2c_data {
> >  	int			nmsgs;
> >  	int			pos;
> >  	enum cgbc_i2c_state	state;
> > +	u8			bus_id;
> > +	unsigned long		read_maxtime_us;
> >  };
> >  
> >  struct cgbc_i2c_transfer {
> > @@ -115,10 +109,9 @@ static unsigned int cgbc_i2c_reg_to_freq(u8 reg)
> >  
> >  static int cgbc_i2c_get_status(struct i2c_adapter *adap)
> >  {
> > -	struct i2c_algo_cgbc_data *algo_data = adap->algo_data;
> >  	struct cgbc_i2c_data *i2c = i2c_get_adapdata(adap);
> >  	struct cgbc_device_data *cgbc = i2c->cgbc;
> > -	u8 cmd = CGBC_I2C_CMD_STAT | algo_data->bus_id;
> > +	u8 cmd = CGBC_I2C_CMD_STAT | i2c->bus_id;
> >  	u8 status;
> >  	int ret;
> >  
> > @@ -132,7 +125,6 @@ static int cgbc_i2c_get_status(struct i2c_adapter *adap)
> >  static int cgbc_i2c_set_frequency(struct i2c_adapter *adap,
> >  				  unsigned int bus_frequency)
> >  {
> > -	struct i2c_algo_cgbc_data *algo_data = adap->algo_data;
> >  	struct cgbc_i2c_data *i2c = i2c_get_adapdata(adap);
> >  	struct cgbc_device_data *cgbc = i2c->cgbc;
> >  	u8 cmd[2], data;
> > @@ -144,7 +136,7 @@ static int cgbc_i2c_set_frequency(struct i2c_adapter *adap,
> >  		bus_frequency = I2C_MAX_STANDARD_MODE_FREQ;
> >  	}
> >  
> > -	cmd[0] = CGBC_I2C_CMD_SPEED | algo_data->bus_id;
> > +	cmd[0] = CGBC_I2C_CMD_SPEED | i2c->bus_id;
> >  	cmd[1] = cgbc_i2c_freq_to_reg(bus_frequency);
> >  
> >  	ret = cgbc_command(cgbc, &cmd, sizeof(cmd), &data, 1, NULL);
> > @@ -170,7 +162,7 @@ static int cgbc_i2c_set_frequency(struct i2c_adapter *adap,
> >  	 * can be read by a command is CGBC_I2C_READ_MAX_LEN.
> >  	 * Therefore, calculate the max time to properly size the timeout.
> >  	 */
> > -	algo_data->read_maxtime_us = (BITS_PER_BYTE + 1) * CGBC_I2C_READ_MAX_LEN
> > +	i2c->read_maxtime_us = (BITS_PER_BYTE + 1) * CGBC_I2C_READ_MAX_LEN
> >  		* USEC_PER_SEC / bus_frequency;
> >  
> >  	return 0;
> > @@ -200,7 +192,6 @@ static unsigned int cgbc_i2c_xfer_to_cmd(struct cgbc_i2c_transfer xfer, u8 *cmd)
> >  
> >  static int cgbc_i2c_xfer_msg(struct i2c_adapter *adap)
> >  {
> > -	struct i2c_algo_cgbc_data *algo_data = adap->algo_data;
> >  	struct cgbc_i2c_data *i2c = i2c_get_adapdata(adap);
> >  	struct cgbc_device_data *cgbc = i2c->cgbc;
> >  	struct i2c_msg *msg = i2c->msg;
> > @@ -210,7 +201,7 @@ static int cgbc_i2c_xfer_msg(struct i2c_adapter *adap)
> >  	u8 cmd_data, data_len;
> >  
> >  	struct cgbc_i2c_transfer xfer = {
> > -		.bus_id = algo_data->bus_id,
> > +		.bus_id = i2c->bus_id,
> >  		.addr = i2c_8bit_addr_from_msg(msg),
> >  	};
> >  
> > @@ -268,7 +259,7 @@ static int cgbc_i2c_xfer_msg(struct i2c_adapter *adap)
> >  
> >  		ret = read_poll_timeout(cgbc_i2c_get_status, status,
> >  					status != CGBC_I2C_STAT_BUSY, 0,
> > -					2 * algo_data->read_maxtime_us, false, adap);
> > +					2 * i2c->read_maxtime_us, false, adap);
> >  		if (ret)
> >  			goto err;
> >  
> > @@ -282,7 +273,7 @@ static int cgbc_i2c_xfer_msg(struct i2c_adapter *adap)
> >  			goto err;
> >  		}
> >  
> > -		cmd_data = CGBC_I2C_CMD_DATA | algo_data->bus_id;
> > +		cmd_data = CGBC_I2C_CMD_DATA | i2c->bus_id;
> >  		ret = cgbc_command(cgbc, &cmd_data, sizeof(cmd_data),
> >  				   msg->buf + i2c->pos, len, &data_len);
> >  		if (ret)
> > @@ -350,44 +341,35 @@ static const struct i2c_algorithm cgbc_i2c_algorithm = {
> >  	.functionality = cgbc_i2c_func,
> >  };
> >  
> > -static struct i2c_algo_cgbc_data cgbc_i2c_algo_data[] = {
> > -	{ .bus_id = CGBC_I2C_PRIMARY_BUS_ID },
> > -	{ .bus_id = CGBC_I2C_PM_BUS_ID },
> > -};
> > -
> > -static const struct i2c_adapter cgbc_i2c_adapter[] = {
> > -	{
> > -		.owner		= THIS_MODULE,
> > -		.name		= "cgbc-i2c0",
> > -		.class		= I2C_CLASS_DEPRECATED,
> > -		.algo		= &cgbc_i2c_algorithm,
> > -		.algo_data	= &cgbc_i2c_algo_data[0],
> > -		.nr		= -1,
> > -	},
> > -	{
> > -		.owner		= THIS_MODULE,
> > -		.name		= "cgbc-ddc0",
> > -		.class		= I2C_CLASS_DEPRECATED,
> > -		.algo		= &cgbc_i2c_algorithm,
> > -		.algo_data	= &cgbc_i2c_algo_data[1],
> > -		.nr		= -1,
> > -	},
> > +static const struct i2c_adapter cgbc_i2c_adapter = {
> > +	.owner		= THIS_MODULE,
> > +	.class		= I2C_CLASS_DEPRECATED,
> > +	.algo		= &cgbc_i2c_algorithm,
> > +	.nr		= -1,
> >  };
> >  
> >  static int cgbc_i2c_probe(struct platform_device *pdev)
> >  {
> > -	struct cgbc_device_data *cgbc = dev_get_drvdata(pdev->dev.parent);
> > +	struct device *dev = &pdev->dev;
> > +	struct cgbc_device_data *cgbc = dev_get_drvdata(dev->parent);
> > +	struct cgbc_i2c_platform_data *pdata;
> >  	struct cgbc_i2c_data *i2c;
> >  	int ret;
> >  
> > -	i2c = devm_kzalloc(&pdev->dev, sizeof(*i2c), GFP_KERNEL);
> > +	i2c = devm_kzalloc(dev, sizeof(*i2c), GFP_KERNEL);
> I was ready to send you the v6 (with your I2C patch) based on mfd-next,
> but I noticed an issue with this line. In v7.4-rc2 devm_kzalloc() has
> been replaced by devm_kzalloc_obj() (commit
> 4dd10fbbeb9c33709edc89916e19c03c780a0751). I guess this will conflict
> during the merge. So I don't know how to proceed. Please let me know
> what to do.

Rebase your set onto v7.4-rc2 or -next.

-- 
Lee Jones
