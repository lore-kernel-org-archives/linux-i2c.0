From: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Subject: Re: Grouping i2c bus drivers
Date: Mon, 30 Jun 2008 13:46:53 +0200
Message-ID: <200806301346.53185.sr@denx.de>
References: <20080627145236.2a20aaad@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080627145236.2a20aaad-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Friday 27 June 2008, Jean Delvare wrote:
> # Other I2C/SMBus bus drivers
> obj-$(CONFIG_I2C_ACORN)		+= i2c-acorn.o
> obj-$(CONFIG_I2C_AU1550)	+= i2c-au1550.o
> obj-$(CONFIG_I2C_BLACKFIN_TWI)	+= i2c-bfin-twi.o
> obj-$(CONFIG_I2C_ELEKTOR)	+= i2c-elektor.o
> obj-$(CONFIG_I2C_CPM)		+= i2c-cpm.o
> obj-$(CONFIG_I2C_IBM_IIC)	+= i2c-ibm_iic.o

IBM-I2C is embedded too. It's used on IBM/AMCC PPC4xx embedded PPC's. Perhaps 
it would sense to rename this driver to i2c-ppc4xx at some time.

Best regards,
Stefan

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
