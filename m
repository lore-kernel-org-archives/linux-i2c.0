From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: [PATCH] i2c: virtual i2c adapter support.
Date: Mon, 23 Jun 2008 09:51:48 +0200
Message-ID: <8763s0pp0r.fsf@macbook.be.48ers.dk>
References: <1213895701-9872-1-git-send-email-giometti@linux.it>
	<1213895701-9872-2-git-send-email-giometti@linux.it>
	<87fxr5sw5f.fsf@macbook.be.48ers.dk>
	<20080622085206.GM10695@enneenne.com>
	<87bq1tsue5.fsf@macbook.be.48ers.dk>
	<20080622093939.GO10695@enneenne.com>
	<8763s1spuw.fsf@macbook.be.48ers.dk>
	<20080622125010.GP10695@enneenne.com>
	<87hcblqmi0.fsf@macbook.be.48ers.dk>
	<20080623092658.75bddce4@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080623092658.75bddce4-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org> (Jean Delvare's
	message of "Mon\, 23 Jun 2008 09\:26\:58 +0200")
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
Cc: Ben Dooks <ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

>>>>> "Jean" == Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> writes:

Hi,

 >> Except that core_lock is static in i2c-core.c.

 Jean> This construct is broken by design. If you don't know if the
 Jean> mutex is locked, it means that you're not the one holding
 Jean> it. If you're not the one holding it, you don't know when it
 Jean> will be released. So it could be released in the middle of
 Jean> whatever you are doing which requires the lock to be held, and
 Jean> that's bad.

Exactly. Either we put it on hold for the core rework or we add a
i2c_del_virt_adapter_nolock() variant for the mux-on-i2c case.

-- 
Bye, Peter Korsgaard

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
