Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794836145;
	b=eE29HQZJlDKxMLwtu2hVURf7MW+kjzJr6Us5Ld6Pa7NiMNEkRoauzDzWbB2tjy/pBRd1
	 iYYfY1yL7xshH2Ru125R6E5HHjGAp2fi1SHJWsJWQSsuRvX6QcMzOC8FNbgxzZCAbnKYa
	 j6tjs4XiVckutDQvysnSNIalujBT3vvJQA/U5IJp0HqbWwUOUY6kjHApMHLkqfJl+VHic
	 uemRY9uYfn+pwNtqieyM3WUm3/mC3FEOTkaaVG2j3ikhYuughbiIBsgUjCWXZLLD1yEAu
	 kqyGqZlY23cyaTKPNpVCpacPs4eKPVWlb8X+pVP2Ay8f9e/8ECMbtGuo5XSTpps0SXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794836145;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=Vcx9KzmvnNYkPSs4VQKPwTuksU5sZnTHAg7TtizLtvE=;
	b=Nizn0I+B1uNGyyJJrKeluuSgJWinAFLuCpL6zmwvo2bpNDNAs18uEmfc6qBekklyj0Aa
	 3phNcppCUhwxtJdqoxGHkljf5EXGBzt+SawQRO9wLRVgcHFIsW7h+myx3i4it84xQ5Pq1
	 LQRr5k1o5EbAkqvyJ+0ns1DqOv80vWTZtPMi9ZlSplwtJCsh+F76scE8m+QJJ9OTrn8+I
	 VgQ6Gq/Zr9NlzsU+dMC1dIXA/FssWu0WzY4l7rd7uU/eQc+ROFKcJGbn11U6bde9uMZtL
	 loa1jwuBxPJEtpnc6N5s94EQwNqQCQ95faDkXujahsCtc6ez08pwwp8n0JMtC2eB1IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ioEkh3ts;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BE0606A329
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 13:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73BE0606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ioEkh3ts
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A6C071A1114;
	Mon, 16 Nov 2026 13:35:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 72F9D6023F;
	Mon, 16 Nov 2026 13:35:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 364D011BC02CF;
	Mon, 16 Nov 2026 14:35:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794836141; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Vcx9KzmvnNYkPSs4VQKPwTuksU5sZnTHAg7TtizLtvE=;
	b=ioEkh3tsLe2NF6NNv4sEdmBgaZvBUu9PSfy9XNfzagsjXMUZ/rEq6DAgQ7l3MYDt301sBD
	7y9KHYjJQOaIDVp2EJpx1g/26pMZ0imn/g7o0U3cyH31zqVF5O2UUwpJRc/otrNQdC29f2
	n77jkhSrh4zuy7FEQt60+/VZIAtX86i4o6ianzl/Q6eU6EVBp/Sa4PqBc0tHevHG0/dqEy
	/Q4og2XtZdtHtu2qhxbFItonKaxej5/4pmNX1UTgKKphQNmTKcdy67nz+1MaEwH8JTGELK
	ehBOEwq8192YHBdN8RbZe82tgHhm/hInBs2J5RaZ8pwtM5NhOl0RVQ/Mxxzs0w==
Message-ID: <78cf973d-3434-4f81-82be-a22f4abcfe0c@bootlin.com>
Date: Mon, 16 Nov 2026 14:35:39 +0100
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/9] i2c: cgbc: Use plateform data to get bus ID and
 adapter name
To: Lee Jones <lee@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20261103-cgbc-i2c-storage-devices-support-v5-0-ac11f23fae51@bootlin.com>
 <20261103-cgbc-i2c-storage-devices-support-v5-4-ac11f23fae51@bootlin.com>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20261103-cgbc-i2c-storage-devices-support-v5-4-ac11f23fae51@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Lee,

On 11/3/26 5:49 PM, Thomas Richard (congatec GmbH) wrote:
> Obtain the bus ID (from the BC point of view) and adapter name from
> platform data. This allows the specific definitions to be removed, leaving
> only a generic adapter definition.
> 
> Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
> ---
>  drivers/i2c/busses/i2c-cgbc.c | 68 ++++++++++++++++---------------------------
>  1 file changed, 25 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-cgbc.c b/drivers/i2c/busses/i2c-cgbc.c
> index ac23435b731b..40ffab4fd0bc 100644
> --- a/drivers/i2c/busses/i2c-cgbc.c
> +++ b/drivers/i2c/busses/i2c-cgbc.c
> @@ -12,9 +12,6 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  
> -#define CGBC_I2C_PRIMARY_BUS_ID	0
> -#define CGBC_I2C_PM_BUS_ID	4
> -
>  #define CGBC_I2C_CMD_START	0x40
>  #define CGBC_I2C_CMD_STAT	0x48
>  #define CGBC_I2C_CMD_DATA	0x50
> @@ -60,11 +57,6 @@ enum cgbc_i2c_state {
>  	CGBC_I2C_STATE_ERROR,
>  };
>  
> -struct i2c_algo_cgbc_data {
> -	u8		bus_id;
> -	unsigned long	read_maxtime_us;
> -};
> -
>  struct cgbc_i2c_data {
>  	struct device		*dev;
>  	struct cgbc_device_data *cgbc;
> @@ -73,6 +65,8 @@ struct cgbc_i2c_data {
>  	int			nmsgs;
>  	int			pos;
>  	enum cgbc_i2c_state	state;
> +	u8			bus_id;
> +	unsigned long		read_maxtime_us;
>  };
>  
>  struct cgbc_i2c_transfer {
> @@ -115,10 +109,9 @@ static unsigned int cgbc_i2c_reg_to_freq(u8 reg)
>  
>  static int cgbc_i2c_get_status(struct i2c_adapter *adap)
>  {
> -	struct i2c_algo_cgbc_data *algo_data = adap->algo_data;
>  	struct cgbc_i2c_data *i2c = i2c_get_adapdata(adap);
>  	struct cgbc_device_data *cgbc = i2c->cgbc;
> -	u8 cmd = CGBC_I2C_CMD_STAT | algo_data->bus_id;
> +	u8 cmd = CGBC_I2C_CMD_STAT | i2c->bus_id;
>  	u8 status;
>  	int ret;
>  
> @@ -132,7 +125,6 @@ static int cgbc_i2c_get_status(struct i2c_adapter *adap)
>  static int cgbc_i2c_set_frequency(struct i2c_adapter *adap,
>  				  unsigned int bus_frequency)
>  {
> -	struct i2c_algo_cgbc_data *algo_data = adap->algo_data;
>  	struct cgbc_i2c_data *i2c = i2c_get_adapdata(adap);
>  	struct cgbc_device_data *cgbc = i2c->cgbc;
>  	u8 cmd[2], data;
> @@ -144,7 +136,7 @@ static int cgbc_i2c_set_frequency(struct i2c_adapter *adap,
>  		bus_frequency = I2C_MAX_STANDARD_MODE_FREQ;
>  	}
>  
> -	cmd[0] = CGBC_I2C_CMD_SPEED | algo_data->bus_id;
> +	cmd[0] = CGBC_I2C_CMD_SPEED | i2c->bus_id;
>  	cmd[1] = cgbc_i2c_freq_to_reg(bus_frequency);
>  
>  	ret = cgbc_command(cgbc, &cmd, sizeof(cmd), &data, 1, NULL);
> @@ -170,7 +162,7 @@ static int cgbc_i2c_set_frequency(struct i2c_adapter *adap,
>  	 * can be read by a command is CGBC_I2C_READ_MAX_LEN.
>  	 * Therefore, calculate the max time to properly size the timeout.
>  	 */
> -	algo_data->read_maxtime_us = (BITS_PER_BYTE + 1) * CGBC_I2C_READ_MAX_LEN
> +	i2c->read_maxtime_us = (BITS_PER_BYTE + 1) * CGBC_I2C_READ_MAX_LEN
>  		* USEC_PER_SEC / bus_frequency;
>  
>  	return 0;
> @@ -200,7 +192,6 @@ static unsigned int cgbc_i2c_xfer_to_cmd(struct cgbc_i2c_transfer xfer, u8 *cmd)
>  
>  static int cgbc_i2c_xfer_msg(struct i2c_adapter *adap)
>  {
> -	struct i2c_algo_cgbc_data *algo_data = adap->algo_data;
>  	struct cgbc_i2c_data *i2c = i2c_get_adapdata(adap);
>  	struct cgbc_device_data *cgbc = i2c->cgbc;
>  	struct i2c_msg *msg = i2c->msg;
> @@ -210,7 +201,7 @@ static int cgbc_i2c_xfer_msg(struct i2c_adapter *adap)
>  	u8 cmd_data, data_len;
>  
>  	struct cgbc_i2c_transfer xfer = {
> -		.bus_id = algo_data->bus_id,
> +		.bus_id = i2c->bus_id,
>  		.addr = i2c_8bit_addr_from_msg(msg),
>  	};
>  
> @@ -268,7 +259,7 @@ static int cgbc_i2c_xfer_msg(struct i2c_adapter *adap)
>  
>  		ret = read_poll_timeout(cgbc_i2c_get_status, status,
>  					status != CGBC_I2C_STAT_BUSY, 0,
> -					2 * algo_data->read_maxtime_us, false, adap);
> +					2 * i2c->read_maxtime_us, false, adap);
>  		if (ret)
>  			goto err;
>  
> @@ -282,7 +273,7 @@ static int cgbc_i2c_xfer_msg(struct i2c_adapter *adap)
>  			goto err;
>  		}
>  
> -		cmd_data = CGBC_I2C_CMD_DATA | algo_data->bus_id;
> +		cmd_data = CGBC_I2C_CMD_DATA | i2c->bus_id;
>  		ret = cgbc_command(cgbc, &cmd_data, sizeof(cmd_data),
>  				   msg->buf + i2c->pos, len, &data_len);
>  		if (ret)
> @@ -350,44 +341,35 @@ static const struct i2c_algorithm cgbc_i2c_algorithm = {
>  	.functionality = cgbc_i2c_func,
>  };
>  
> -static struct i2c_algo_cgbc_data cgbc_i2c_algo_data[] = {
> -	{ .bus_id = CGBC_I2C_PRIMARY_BUS_ID },
> -	{ .bus_id = CGBC_I2C_PM_BUS_ID },
> -};
> -
> -static const struct i2c_adapter cgbc_i2c_adapter[] = {
> -	{
> -		.owner		= THIS_MODULE,
> -		.name		= "cgbc-i2c0",
> -		.class		= I2C_CLASS_DEPRECATED,
> -		.algo		= &cgbc_i2c_algorithm,
> -		.algo_data	= &cgbc_i2c_algo_data[0],
> -		.nr		= -1,
> -	},
> -	{
> -		.owner		= THIS_MODULE,
> -		.name		= "cgbc-ddc0",
> -		.class		= I2C_CLASS_DEPRECATED,
> -		.algo		= &cgbc_i2c_algorithm,
> -		.algo_data	= &cgbc_i2c_algo_data[1],
> -		.nr		= -1,
> -	},
> +static const struct i2c_adapter cgbc_i2c_adapter = {
> +	.owner		= THIS_MODULE,
> +	.class		= I2C_CLASS_DEPRECATED,
> +	.algo		= &cgbc_i2c_algorithm,
> +	.nr		= -1,
>  };
>  
>  static int cgbc_i2c_probe(struct platform_device *pdev)
>  {
> -	struct cgbc_device_data *cgbc = dev_get_drvdata(pdev->dev.parent);
> +	struct device *dev = &pdev->dev;
> +	struct cgbc_device_data *cgbc = dev_get_drvdata(dev->parent);
> +	struct cgbc_i2c_platform_data *pdata;
>  	struct cgbc_i2c_data *i2c;
>  	int ret;
>  
> -	i2c = devm_kzalloc(&pdev->dev, sizeof(*i2c), GFP_KERNEL);
> +	i2c = devm_kzalloc(dev, sizeof(*i2c), GFP_KERNEL);
I was ready to send you the v6 (with your I2C patch) based on mfd-next,
but I noticed an issue with this line. In v7.4-rc2 devm_kzalloc() has
been replaced by devm_kzalloc_obj() (commit
4dd10fbbeb9c33709edc89916e19c03c780a0751). I guess this will conflict
during the merge. So I don't know how to proceed. Please let me know
what to do.

Best Regards,
Thomas



