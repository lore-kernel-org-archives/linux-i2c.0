From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: temperature monitor
Date: Tue, 15 Jul 2008 18:04:39 +0200
Message-ID: <20080715180439.01ade138@hyperion.delvare>
References: <487CC596.3050608@GMail.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <487CC596.3050608-0K3CJo2NoDF8zQARNC3f2A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Agile.Aspect-0K3CJo2NoDF8zQARNC3f2A@public.gmane.org
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 15 Jul 2008 08:43:18 -0700, Agile Aspect wrote:
> Hi - I'm new to lm_sensors and I'm trying to monitor the temperature on
> a 8 CPU (Intel Xeon CPU X5460  @ 3.16GHz) running CentOS 4.4
> (2.6.9-42.ELsmp.)
> 
> The command
> 
>     i2cdetect -l
> 
> returns
> 
>     i2c-0   dummy           ISA main adapter                        ISA 
> bus algorithm
> 
> and the command
> 
>     No sensors found!
>    
> Enclosed is the output of lspci.
> 
> Any ideas on how I get a temperature monitor working?
> 
> For instance, is this the right mailing list?

No, it's not. Please use instead:
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
