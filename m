From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-piix4-inc-delay-after-starting-transaction
Date: Sat, 3 May 2008 12:03:43 +0200
Message-ID: <20080503120343.04ff0ea5@hyperion.delvare>
References: <20080429170053.GA16863@dhcp-210.hsv.redhat.com>
	<20080502220528.65c07727@hyperion.delvare>
	<481B86D0.7080306@redhat.com>
	<20080503082250.39fdaf60@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080503082250.39fdaf60-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Milburn <dmilburn-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, 3 May 2008 08:22:50 +0200, Jean Delvare wrote:
> I think I have a old SuperMicro board with a ServerWorks OSB4, I'll do
> some tests with it. I think it has only seen 2.4 kernels so far, so
> HZ=100, where the initial delay was at least 10 ms. I'll test it at
> HZ=1000 and see if I can reproduce the problem. If I can, then I guess
> we are better increasing the delay for all the old ServerWorks chips
> (OSB4, CSB5 and CSB6.) If I can't then maybe just increase the delay
> for the CSB5?

I've tested my OSB4 for 2 hours continuously at HZ=1000 without your
patch and it worked perfectly. So I suggest that we only increase the
initial delay for the CSB5 for now - if that's what the reporter has.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
