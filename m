From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: virtual i2c adapter support.
Date: Mon, 23 Jun 2008 09:26:58 +0200
Message-ID: <20080623092658.75bddce4@hyperion.delvare>
References: <1213895701-9872-1-git-send-email-giometti@linux.it>
	<1213895701-9872-2-git-send-email-giometti@linux.it>
	<87fxr5sw5f.fsf@macbook.be.48ers.dk>
	<20080622085206.GM10695@enneenne.com>
	<87bq1tsue5.fsf@macbook.be.48ers.dk>
	<20080622093939.GO10695@enneenne.com>
	<8763s1spuw.fsf@macbook.be.48ers.dk>
	<20080622125010.GP10695@enneenne.com>
	<87hcblqmi0.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <87hcblqmi0.fsf-uXGAPMMVk8amE9MCos8gUmSdvHPH+/yF@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Cc: Ben Dooks <ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Peter,

On Sun, 22 Jun 2008 21:48:39 +0200, Peter Korsgaard wrote:
> >>>>> "Rodolfo" == Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org> writes:
>  Rodolfo> However, we also should make attention at
>  Rodolfo> i2c_del_virt_adapter() which must call (new)
>  Rodolfo> i2c_del_adapter_nolock() since the core_lock is hold by
>  Rodolfo> i2c_del_driver() when the mux is an i2c device.
> 
>  Rodolfo> If you define a virtual adapter as a non-i2c device I
>  Rodolfo> suppose we should use the lock...
> 
> I guess we could do:
> 
> 	if (mutex_is_locked(&core_lock))
> 		ret = i2c_del_adapter_nolock(adap);
> 	else
> 		ret = i2c_del_adapter(adap);
> 
> Except that core_lock is static in i2c-core.c.

This construct is broken by design. If you don't know if the mutex is
locked, it means that you're not the one holding it. If you're not the
one holding it, you don't know when it will be released. So it could be
released in the middle of whatever you are doing which requires the
lock to be held, and that's bad.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
