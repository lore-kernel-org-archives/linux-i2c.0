From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v3 4/4] eeprom: Add a MODULE_DEVICE_TABLE
Date: Thu, 18 Jul 2013 09:11:16 +0200
Message-ID: <20130718091116.6757e088@endymion.delvare>
References: <cover.1374093761.git.luto@amacapital.net>
	<5661ebb4676a4d20678f369df3a2da5d587e9100.1374093761.git.luto@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5661ebb4676a4d20678f369df3a2da5d587e9100.1374093761.git.luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Andy,

On Wed, 17 Jul 2013 13:53:08 -0700, Andy Lutomirski wrote:
> The new DIMM-bus code can detect eeproms, so give the eeprom driver
> an appropriate modalias.
> 
> Signed-off-by: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
> ---
>  drivers/misc/eeprom/eeprom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/eeprom/eeprom.c b/drivers/misc/eeprom/eeprom.c
> index c169e07..1ec85b8 100644
> --- a/drivers/misc/eeprom/eeprom.c
> +++ b/drivers/misc/eeprom/eeprom.c
> @@ -215,6 +215,7 @@ static const struct i2c_device_id eeprom_id[] = {
>  	{ "eeprom", 0 },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(i2c, eeprom_id);
>  
>  static struct i2c_driver eeprom_driver = {
>  	.driver = {

Nack. The eeprom driver will eventually die, I don't want to see
anything like that added to it. Please use the at24 driver for anything
new.

Thanks,
-- 
Jean Delvare
