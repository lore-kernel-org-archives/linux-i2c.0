From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 2/2] i2c-ibm_iic driver
Date: Wed, 20 Feb 2008 08:20:27 +0100
Message-ID: <20080220082027.3b2c59b8@hyperion.delvare>
References: <4784FED1.2040206@pikatech.com> <47A14E23.50807@pikatech.com>
	<20080214094516.1b958ae4@hyperion.delvare>
	<47B66260.8010902@pikatech.com>
	<20080216103123.50a0128b@hyperion.delvare>
	<47BA3416.5080405@pikatech.com>
	<20080219092321.1fed233d@hyperion.delvare>
	<47BB50E9.60508@pikatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <47BB50E9.60508@pikatech.com>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Sean MacLennan <smaclennan@pikatech.com>
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

Hi Sean,

On Tue, 19 Feb 2008 16:58:01 -0500, Sean MacLennan wrote:
> Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
> 
> --- for-2.6.25/drivers/i2c/busses/orig-i2c-ibm_iic.c	2008-02-18 16:36:30.000000000 -0500
> +++ for-2.6.25/drivers/i2c/busses/i2c-ibm_iic.c	2008-02-19 16:46:35.000000000 -0500
> @@ -6,6 +6,9 @@
>   * Copyright (c) 2003, 2004 Zultys Technologies.
>   * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
>   *
> + * Copyright (c) 2008 PIKA Technologies
> + * Sean MacLennan <smaclennan@pikatech.com>
> + *
>   * Based on original work by
>   * 	Ian DaSilva  <idasilva@mvista.com>
>   *      Armin Kuster <akuster@mvista.com>
> (...)
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -244,7 +244,7 @@ config I2C_PIIX4
>  
>  config I2C_IBM_IIC
>  	tristate "IBM PPC 4xx on-chip I2C interface"
> -	depends on IBM_OCP
> +	depends on 4xx
>  	help
>  	  Say Y here if you want to use IIC peripheral found on 
>  	  embedded IBM PPC 4xx based systems. 

I've applied this version. I see that there are discussions going on
about the best "depends on" statement in Kconfig, feel free to submit
an updated (or incremental) patch as soon as a decision will have been
taken.

Thanks,
-- 
Jean Delvare
