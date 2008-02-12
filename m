From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] Add driver for AD7414 i2c temperature sensor
Date: Tue, 12 Feb 2008 17:25:42 +0100
Message-ID: <20080212172542.210f4a78@hyperion.delvare>
References: <A42C17A8FF150C4DB98BFD6497D1D00007D35D66@ussvlexmbpf1.spansion.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <A42C17A8FF150C4DB98BFD6497D1D00007D35D66-SepvG4MK2K7XgKAwtTS8dDuQPtp/YR6JAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: "Edelhaeuser, Frank" <Frank.Edelhaeuser-CBC/uQSf1AZWk0Htik3J/w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Frank,

On Fri, 1 Feb 2008 05:34:14 -0800, Edelhaeuser, Frank wrote:
> Signed-off-by: Frank Edelhaeuser <frank.edelhaeuser-CBC/uQSf1AZWk0Htik3J/w@public.gmane.org>
> ---
> diff -Nur a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> --- a/drivers/hwmon/Kconfig	2007-11-11 21:49:02.000000000 +0100
> +++ b/drivers/hwmon/Kconfig	2008-02-01 11:54:48.000000000 +0100
> @@ -57,6 +57,16 @@
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called abituguru3.
> 
> +config SENSORS_AD7414
> +	tristate "Analog Devices AD7414"
> +	depends on I2C && EXPERIMENTAL
> +	help
> +	  If you say yes here you get support for the Analog Devices
> +	  AD7414 temperature monitoring chip.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called ad7414.
> +
>  config SENSORS_AD7418
>  	tristate "Analog Devices AD7416, AD7417 and AD7418"
>  	depends on I2C && EXPERIMENTAL

--> lm-sensors list, please.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
