From: Riku Voipio <riku.voipio-WgUW+8SLYMv1KXRcyAk9cg@public.gmane.org>
Subject: Re: Grouping i2c bus drivers
Date: Mon, 30 Jun 2008 14:06:31 +0300
Message-ID: <4868BE37.1090405@movial.fi>
References: <20080627145236.2a20aaad@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080627145236.2a20aaad-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Jean Delvare wrote:
> Hi all,
>
> As was mentioned previously, I have decided to group the i2c bus
> drivers to make it easier for the users to know what they need (and also
> for me to know what drivers might be affected by a given problem.) Here
> is the list I have at the moment. There are still many drivers in the
> "Other" category. I suspect that many of these should move to the
> "Embedded" category, but I don't know for sure. So I would welcome
> comments and suggestions for improvements.
>
>
> # Other I2C/SMBus bus drivers
>
> obj-$(CONFIG_I2C_AU1550)	+= i2c-au1550.o
> obj-$(CONFIG_I2C_IOP3XX)	+= i2c-iop3xx.o
> obj-$(CONFIG_I2C_SIMTEC)	+= i2c-simtec.o
>   
Wolfram picked others, these are embedded too.

 > obj-$(CONFIG_I2C_PASEMI) += i2c-pasemi.o

I'm not sure if one would classify pa semi dualcore 2GHz systems
as "embedded", but this i2c controller is embedded into the
PA SEMI cpu.. 




_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
