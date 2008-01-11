From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/2] [resend] Add polling transfer for i2c-pxa
Date: Fri, 11 Jan 2008 08:44:22 +0100
Message-ID: <20080111084422.05b1e4d8@hyperion.delvare>
References: <476A7761.3050103@compulab.co.il>
	<20080110112413.3b379781@hyperion.delvare>
	<47860C86.5050801@compulab.co.il>
	<20080110145439.2e6a49af@hyperion.delvare>
	<E913911567467945BBEB9277E27868B06BC773@msiexch01.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <E913911567467945BBEB9277E27868B06BC773-3TKN+kxLw8+HXkj8w7BxOhL4W9x8LtSr@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Eric Miao <ymiao3-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Cc: ARM Linux <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 10 Jan 2008 19:33:57 -0800, Eric Miao wrote:
> > Yes, this one applied just fine, thank you. I've added it to my tree.
> > However I don't have the hardware to test it, I can't even built the
> > i2c-pxa driver. Can someone else please review and/or test the patch
> > and add his/her Acked-by?
> 
> Acked-by: eric miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> 
> I've tested this patch on zylonite/pxa3xx platform with both 'use_pio = 0'
> and 'use_pio = 1', and is known to work.

Great, thanks Eric!

-- 
Jean Delvare
