From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: How the lm-sensors communicate with the device driver
Date: Tue, 21 Oct 2008 13:14:49 +0200
Message-ID: <20081021131449.32d4b429@hyperion.delvare>
References: <CF6163088BDE8747873ADAA4AF922BF258D527@zmy16exm21.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <CF6163088BDE8747873ADAA4AF922BF258D527-6lxYB4K41cniD3AT8lUqWFjVikpgYyvb5NbjCUgZEJk@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Hu Mingkai-B21284 <B21284-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Vincent,

On Tue, 21 Oct 2008 18:31:07 +0800, Hu Mingkai-B21284 wrote:
> I wrote a MCP3021's driver using the new I2C device model under Linux
> 2.6.26.
> The chip MCP3021 is connected to Freescale's I2C controller.
> Now it works well, the following is the log info:
>  
> -sh-2.05b# ls /sys/bus/i2c/drivers/mcp3021/
> 0-004d  1-004d  bind  module  uevent  unbind
> -sh-2.05b#
>  
> -sh-2.05b# cat /sys/bus/i2c/drivers/mcp3021/0-004d/name
> mcp3021
> -sh-2.05b# cat /sys/bus/i2c/drivers/mcp3021/0-004d/in0_input
> 213
> -sh-2.05b# cat /sys/bus/i2c/drivers/mcp3021/0-004d/in0_max
> 213
> -sh-2.05b# cat /sys/bus/i2c/drivers/mcp3021/0-004d/in0_min
> 192 
> -sh-2.05b# cat /sys/bus/i2c/drivers/mcp3021/0-004d/curr1_input
> 960
> -sh-2.05b# cat /sys/bus/i2c/drivers/mcp3021/0-004d/curr1_max
> 1065
> -sh-2.05b# cat /sys/bus/i2c/drivers/mcp3021/0-004d/curr1_min
> 945
>  
> -sh-2.05b# sensors
> mcp3021-i2c-0-4d
> 
> Adapter: MPC adapter
> in0:         +0.21 V  (min =  +0.19 V, max =  +0.22 V)
>  
> mcp3021-i2c-1-4d
> Adapter: MPC adapter
> in0:         +0.41 V  (min =  +0.41 V, max =  +0.41 V)
> 
> Q:
> 1. How the lm-sensors communicate with the device driver? 
> 2. How the lm-sensors get the attribute info?
> 2. Why the current info, i.e. curr1_x, doesn't list ?

Wrong mailing list. Questions about lm-sensors go to the lm-sensors
mailing list:
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
