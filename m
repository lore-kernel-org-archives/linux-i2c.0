From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH RFC] i2c: Use ID table to detect ACPI I2C devices
Date: Wed, 20 May 2015 01:35:06 +0200
Message-ID: <1894651.a3DUuyBc1c@vostro.rjw.lan>
References: <1432044209-27858-1-git-send-email-robert.dolca@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1432044209-27858-1-git-send-email-robert.dolca@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Robert Dolca <robert.dolca@intel.com>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, Daniel Baluta <daniel.baluta@intel.com>
List-Id: linux-i2c@vger.kernel.org

On Tuesday, May 19, 2015 05:03:29 PM Robert Dolca wrote:
> For i2c devices enumerated with ACPI you need to declare both
> acpi_match_table and id_table. When using ACPI, the i2c_device_id structure
> supplied to the probe function is null and you have to handle this case
> in the driver.
> 
> The current name for the i2c client when using ACPI is "HID:UID" where the
> UID has 7 or 8 characters and the UID has 2 characters. The UID is not
> relevant for identifying the chip so it does not have any practical
> purpose.
> 
> Modifying i2c_match_id we make the comparison by ignoring the UID from the
> client name when the device was discovered using ACPI. The comparison is
> case insensitive because the ACPI names are uppercase and the DT and ID
> table names are lowercase. It would not make sense to have two different
> chips with the same name and the only diference being the capitalized
> letters.
> 
> With these changes the probe function gets a valid i2c_device_id and the
> driver doesn't have to declare acpi_match_table.
> 
> Signed-off-by: Robert Dolca <robert.dolca@intel.com>
> ---
>  drivers/i2c/i2c-core.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index fec0e0d..c9b30b7 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -447,8 +447,18 @@ static inline int acpi_i2c_install_space_handler(struct i2c_adapter *adapter)
>  static const struct i2c_device_id *i2c_match_id(const struct i2c_device_id *id,
>  						const struct i2c_client *client)
>  {
> +	char name[I2C_NAME_SIZE], *c;
> +
> +	strlcpy(name, client->name, sizeof(name));
> +
> +	if (ACPI_HANDLE(&client->dev)) {

If you don't need to use the handle, it is better to call has_acpi_companion() here.

> +		c = strchr(name, ':');
> +		if (c)
> +			*c = 0;
> +	}
> +
>  	while (id->name[0]) {
> -		if (strcmp(client->name, id->name) == 0)
> +		if (strncasecmp(name, id->name, sizeof(id->name)) == 0)
>  			return id;
>  		id++;
>  	}
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
