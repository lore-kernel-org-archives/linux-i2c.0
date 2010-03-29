From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 05/24] hwmon: fix dangling pointers
Date: Mon, 29 Mar 2010 16:30:07 +0200
Message-ID: <20100329163007.0ec2f04d@hyperion.delvare>
References: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de>
	<1269094385-16114-6-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1269094385-16114-6-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Corentin Labbe <corentin.labbe-Um+J1D3rkBVWj0EZb7rXcA@public.gmane.org>, "Mark M. Hoffman" <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>, Juerg Haefliger <juergh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Riku Voipio <riku.voipio-X3B1VOXEql0@public.gmane.org>, "Hans J. Koch" <hjk-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Marc Hulsman <m.hulsman-hGVxb2UgFK3z+pZb47iToQ@public.gmane.org>, Rudolf Marek <r.marek-/xGekIyIa4Ap1Coe8Ar9gA@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, 20 Mar 2010 15:12:46 +0100, Wolfram Sang wrote:
> Fix I2C-drivers which missed setting clientdata to NULL before freeing the
> structure it points to. Also fix drivers which do this _after_ the structure
> was freed already.
> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Corentin Labbe <corentin.labbe-Um+J1D3rkBVWj0EZb7rXcA@public.gmane.org>
> Cc: "Mark M. Hoffman" <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>
> Cc: Juerg Haefliger <juergh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Riku Voipio <riku.voipio-X3B1VOXEql0@public.gmane.org>
> Cc: "Hans J. Koch" <hjk-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> Cc: Marc Hulsman <m.hulsman-hGVxb2UgFK3z+pZb47iToQ@public.gmane.org>
> Cc: Rudolf Marek <r.marek-/xGekIyIa4Ap1Coe8Ar9gA@public.gmane.org>
> ---
> 
> Found using coccinelle, then reviewed. Full patchset is available via
> kernel-janitors, linux-i2c, and LKML.
> ---
>  drivers/hwmon/ad7414.c     |    2 ++
>  drivers/hwmon/ad7418.c     |    2 ++
>  drivers/hwmon/adm1021.c    |    2 ++
>  drivers/hwmon/adm1025.c    |    2 ++
>  drivers/hwmon/adm1026.c    |    2 ++
>  drivers/hwmon/adm1029.c    |    2 ++
>  drivers/hwmon/adm1031.c    |    2 ++
>  drivers/hwmon/adm9240.c    |    2 ++
>  drivers/hwmon/ads7828.c    |    5 ++++-
>  drivers/hwmon/adt7462.c    |    2 ++
>  drivers/hwmon/adt7470.c    |    2 ++
>  drivers/hwmon/adt7475.c    |    2 ++
>  drivers/hwmon/amc6821.c    |    2 ++
>  drivers/hwmon/asb100.c     |    2 ++
>  drivers/hwmon/atxp1.c      |    2 ++
>  drivers/hwmon/dme1737.c    |    2 ++
>  drivers/hwmon/ds1621.c     |    2 ++
>  drivers/hwmon/f75375s.c    |    4 ++--
>  drivers/hwmon/g760a.c      |    4 ++--
>  drivers/hwmon/gl518sm.c    |    2 ++
>  drivers/hwmon/gl520sm.c    |    2 ++
>  drivers/hwmon/lm63.c       |    2 ++
>  drivers/hwmon/lm77.c       |    2 ++
>  drivers/hwmon/lm78.c       |    2 ++
>  drivers/hwmon/lm80.c       |    2 ++
>  drivers/hwmon/lm83.c       |    2 ++
>  drivers/hwmon/lm85.c       |    2 ++
>  drivers/hwmon/lm87.c       |    2 ++
>  drivers/hwmon/lm90.c       |    2 ++
>  drivers/hwmon/lm92.c       |    2 ++
>  drivers/hwmon/lm93.c       |    2 ++
>  drivers/hwmon/lm95241.c    |    1 +
>  drivers/hwmon/ltc4215.c    |    2 ++
>  drivers/hwmon/ltc4245.c    |    2 ++
>  drivers/hwmon/max1619.c    |    2 ++
>  drivers/hwmon/max6650.c    |    2 ++
>  drivers/hwmon/pcf8591.c    |    6 +++++-
>  drivers/hwmon/smsc47m192.c |    2 ++
>  drivers/hwmon/thmc50.c     |    2 ++
>  drivers/hwmon/tmp401.c     |    1 +
>  drivers/hwmon/w83791d.c    |    2 ++
>  drivers/hwmon/w83792d.c    |    2 ++
>  drivers/hwmon/w83793.c     |    1 +
>  drivers/hwmon/w83l785ts.c  |    2 ++
>  drivers/hwmon/w83l786ng.c  |    2 ++
>  45 files changed, 92 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/ad7414.c b/drivers/hwmon/ad7414.c
> index bfda8c8..0cfae01 100644
> --- a/drivers/hwmon/ad7414.c
> +++ b/drivers/hwmon/ad7414.c
> @@ -220,6 +220,7 @@ static int ad7414_probe(struct i2c_client *client,
>  exit_remove:
>  	sysfs_remove_group(&client->dev.kobj, &ad7414_group);
>  exit_free:
> +	i2c_set_clientdata(client, NULL);
>  	kfree(data);
>  exit:
>  	return err;
> @@ -231,6 +232,7 @@ static int __devexit ad7414_remove(struct i2c_client *client)
>  
>  	hwmon_device_unregister(data->hwmon_dev);
>  	sysfs_remove_group(&client->dev.kobj, &ad7414_group);
> +	i2c_set_clientdata(client, NULL);
>  	kfree(data);
>  	return 0;
>  }
> (...)

As discussed on the i2c list, I won't apply this patch. Instead, we
want i2c-core to call i2c_set_clientdata() after the remove() function
returns. This saves a lot of code duplication.

-- 
Jean Delvare
