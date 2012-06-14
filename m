From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c-piix4: separate registration and probing code
Date: Thu, 14 Jun 2012 21:38:04 +0200
Message-ID: <20120614213804.46ffe67d@endymion.delvare>
References: <20120613094739.360967aa@endymion.delvare>
 <1339606749-4578-1-git-send-email-andrew@asquaredlabs.com>
 <1339606749-4578-3-git-send-email-andrew@asquaredlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1339606749-4578-3-git-send-email-andrew-Lwj1yN59in/Ib2jZbfQ/kQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Armenia <andrew-Lwj1yN59in/Ib2jZbfQ/kQ@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Andrew,

On Wed, 13 Jun 2012 12:59:08 -0400, Andrew Armenia wrote:
> Some chipsets have multiple sets of SMBus registers each controlling a
> separate SMBus. Supporting these chipsets properly will require registering
> multiple I2C adapters for one piix4.
> 
> The code to initialize and register the i2c_adapter structure has been
> separated from piix4_probe and allows registration of a piix4 adapter
> given its base address. Note that the i2c_adapter and i2c_piix4_adapdata
> structures are now dynamically allocated.
> 
> Signed-off-by: Andrew Armenia <andrew-Lwj1yN59in/Ib2jZbfQ/kQ@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-piix4.c |  113 ++++++++++++++++++++++++++--------------
>  1 file changed, 73 insertions(+), 40 deletions(-)
> (...)

Applied, with the minor changes below:

> -static int piix4_transaction(unsigned short piix4_smba)
> +static int piix4_transaction(struct i2c_adapter *piix4_adapter)
>  {
>  	int temp;
>  	int result = 0;
>  	int timeout = 0;
>  
> -	dev_dbg(&piix4_adapter.dev, "Transaction (pre): CNT=%02x, CMD=%02x, "
> +	struct i2c_piix4_adapdata *adapdata;
> +	unsigned short piix4_smba;
> +
> +	adapdata = i2c_get_adapdata(piix4_adapter);
> +	piix4_smba = adapdata->smba;

It is customary to declare and assign all at once in this case:

	struct i2c_piix4_adapdata *adapdata = i2c_get_adapdata(piix4_adapter);
	unsigned short piix4_smba = adapdata->smba;

This makes the code more compact and more readable too. I've fixed it
and everywhere else.

> (...)
> +static int __devinit piix4_add_adapter(struct pci_dev *dev,
> +					unsigned short smba,
> +					struct i2c_adapter **padap)
> +{
> +	struct i2c_adapter *adap;
> +	struct i2c_piix4_adapdata *adapdata;
> +
> +	int retval;
> +
> +	adap = kzalloc(sizeof(*adap), GFP_KERNEL);
> +	if (NULL == adap)

There's no point in inverting comparisons this way. Compilers would let
you know if you had it wrong, they do for at least 10 years now.

-- 
Jean Delvare
