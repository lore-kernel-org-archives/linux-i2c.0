From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/2] [resend] Add polling transfer for i2c-pxa
Date: Thu, 10 Jan 2008 14:54:39 +0100
Message-ID: <20080110145439.2e6a49af@hyperion.delvare>
References: <476A7761.3050103@compulab.co.il>
	<20080110112413.3b379781@hyperion.delvare>
	<47860C86.5050801@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <47860C86.5050801-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: eric miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, ARM Linux <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 10 Jan 2008 14:16:06 +0200, Mike Rapoport wrote:
> Jean Delvare wrote:
> > Hi Mike,
> > 
> > On Thu, 20 Dec 2007 16:08:33 +0200, Mike Rapoport wrote:
> >> The below patch adds polling I2C transfer implementation for PXA I2C.
> > 
> > This patch doesn't apply on top of my current stack, most probably due
> > to a conflict with this patch by Eric Miao:
> > 
> > http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/i2c-pxa-use-cpu_is_pxa27x.patch
> > 
> > Can you please update your patch so that it applies cleanly on top of
> > 2.6.24-rc7 + the patch above?
> 
> Hope this one will go...

Yes, this one applied just fine, thank you. I've added it to my tree.
However I don't have the hardware to test it, I can't even built the
i2c-pxa driver. Can someone else please review and/or test the patch
and add his/her Acked-by?

Thanks,
-- 
Jean Delvare
