From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c Questions
Date: Fri, 4 Apr 2008 10:16:13 +0200
Message-ID: <20080404101613.78834183@hyperion.delvare>
References: <BLU106-W751DECBB6A8A8CAAE3C71B0FE0@phx.gbl>
	<20080329230927.3b9b47e5@hyperion.delvare>
	<BLU106-W27A7B34F7BE0CC6E2D9B94B0F80@phx.gbl>
	<20080330135409.06f8fd09@hyperion.delvare>
	<BLU106-W43B41606462A4205B13FF0B0F70@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <BLU106-W43B41606462A4205B13FF0B0F70-MsuGFMq8XAE@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: badguy development <badguydevelopment-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 3 Apr 2008 22:39:59 +0000, badguy development wrote:
> Well I now plan to write a new style as soon as my test spike code written using legacy code is working :)
> heh, I am using Kernel 2.6.19.2 is the new style available here?

No, it's not. The infrastructure for new-style i2c drivers was added by
David Brownell in 2.6.22.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
