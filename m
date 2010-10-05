From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] iio: light: Adding driver for ISL29018 ALS
Date: Tue, 05 Oct 2010 14:35:17 -0700
Message-ID: <1286314517.2156.50.camel@Joe-Laptop>
References: <1286313561-6456-1-git-send-email-rklein@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1286313561-6456-1-git-send-email-rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, achew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 2010-10-05 at 14:19 -0700, rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org wrote:
> Adding support for the ISL 29018 ambient light and proximity sensor.

Trivial comments below.

> diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
[]
> +static int isl29018_set_range(struct i2c_client *client, unsigned long range,
> +		unsigned int *new_range)
> +{
> +	unsigned long supp_ranges[] = {1000, 4000, 16000, 64000};

static const

> +static int isl29018_set_resolution(struct i2c_client *client,
> +			unsigned long adcbit, unsigned int *conf_adc_bit)
> +{
> +	unsigned long supp_adcbit[] = {16, 12, 8, 4};

here too

> +static int isl29018_chip_init(struct i2c_client *client)
> +{
> +	struct isl29018_chip *chip = i2c_get_clientdata(client);
> +	int status;
> +	int i;
> +	int new_adc_bit;
> +	unsigned int new_range;
> +
> +	for (i = 0; i < ARRAY_SIZE(chip->reg_cache); i++)
> +		chip->reg_cache[i] = 0;

memset?
