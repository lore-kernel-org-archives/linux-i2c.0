From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3] iio: light: Adding driver for ISL29018 ALS
Date: Tue, 05 Oct 2010 18:36:48 -0700
Message-ID: <1286329008.2156.78.camel@Joe-Laptop>
References: <1286318566-9782-1-git-send-email-rklein@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1286318566-9782-1-git-send-email-rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, achew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 2010-10-05 at 15:42 -0700, rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org wrote:
> From: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Hi again.

> diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
[]
> +#define ISL29018_REG_ADD_DATA_LSB	0x02
> +#define ISL29018_REG_ADD_DATA_MSB	0x03
> +#define ISL29018_MAX_REGS		ISL29018_REG_ADD_DATA_MSB
> +
> +struct isl29018_chip {
> +	struct iio_dev		*indio_dev;
> +	struct i2c_client	*client;
> +	struct mutex		lock;
> +	unsigned int		range;
> +	unsigned int		adc_bit;
> +	int			prox_scheme;
> +	u8			reg_cache[ISL29018_MAX_REGS];
> +};
[]
> +static int isl29018_chip_init(struct i2c_client *client)
> +{
> +	struct isl29018_chip *chip = i2c_get_clientdata(client);
[]
> +	memset((void *)chip->reg_cache, 0, ARRAY_SIZE(chip->reg_cache));

Turns out there's only 3 of these registers.
Earlier, I believe you said 32 bytes. 

I think the normal kernel style is:

	memset(chip->reg_cache, 0, sizeof(chip->reg_cache));

ARRAY_SIZE works, but only because reg_cache is u8.

cheers, Joe
