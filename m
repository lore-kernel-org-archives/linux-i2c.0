From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [patch v3 1/1] i2c: add master driver for mellanox systems
Date: Fri, 4 Nov 2016 00:48:48 +0200
Message-ID: <8c1a3c26-e24d-014a-7bee-98d08c76ecfe@mleia.com>
References: <1478199036-188306-1-git-send-email-vadimp@mellanox.com>
 <4708bff8-db23-e9c3-197d-ab337affa080@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4708bff8-db23-e9c3-197d-ab337affa080@mleia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vadimp@mellanox.com, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@resnulli.us, Michael Shych <michaelsh@mellanox.com>
List-Id: linux-i2c@vger.kernel.org

On 04.11.2016 00:34, Vladimir Zapolskiy wrote:
>> +
>> +static int mlxcpld_i2c_probe(struct platform_device *pdev)
>> +{
>> +	struct mlxcpld_i2c_priv *priv;
>> +	int err;
>> +
>> +	priv = devm_kzalloc(&pdev->dev, sizeof(struct mlxcpld_i2c_priv),
>> +			    GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	mutex_init(&priv->lock);
>> +	platform_set_drvdata(pdev, priv);
>> +
>> +	priv->dev = &pdev->dev;
>> +
>> +	/* Register with i2c layer */
>> +	priv->adap = mlxcpld_i2c_adapter;

See a correction below.

>> +	priv->adap.dev.parent = &pdev->dev;
>> +	priv->adap.retries = MLXCPLD_I2C_RETR_NUM;
>> +	priv->adap.nr = MLXCPLD_I2C_BUS_NUM;
> 
> So since you want to allow the registration of only one such controller
> on a board (by the way in the opposite case it is also expected that
> "struct i2c_adapter" is allocated dynamically to avoid rewriting of
> data), you probably know the good reason behind it.

I've just noticed that you do a struct copy-on-assignment, while I think
it is very rarely used in the kernel sources (I don't know why), it cancels
my concern expressed above.

> 
> But in that case you may consider to move .retries and .nr
> instantiation to the "static struct i2c_adapter" declaration above.
> 

--
With best wishes,
Vladimir
