From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: virtual i2c adapter support.
Date: Mon, 23 Jun 2008 09:21:41 +0200
Message-ID: <20080623092141.6282f418@hyperion.delvare>
References: <1213895701-9872-1-git-send-email-giometti@linux.it>
	<1213895701-9872-2-git-send-email-giometti@linux.it>
	<87fxr5sw5f.fsf@macbook.be.48ers.dk>
	<20080622085206.GM10695@enneenne.com>
	<87bq1tsue5.fsf@macbook.be.48ers.dk>
	<20080622093939.GO10695@enneenne.com>
	<8763s1spuw.fsf@macbook.be.48ers.dk>
	<20080622125010.GP10695@enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080622125010.GP10695-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Ben Dooks <ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, 22 Jun 2008 14:50:10 +0200, Rodolfo Giometti wrote:
> On Sun, Jun 22, 2008 at 12:53:11PM +0200, Peter Korsgaard wrote:
> > >>>>> "Rodolfo" == Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org> writes:
> > 
> >  Rodolfo> Maybe if you provide a littke code I may understand exactly
> >  Rodolfo> what you mean. ;)
> > 
> > But I did?!
> 
> I mean the code that shows how you wish adding your i2c mux by using
> i2c_add_virt_adapter(). :)
> 
> However, we also should make attention at i2c_del_virt_adapter() which
> must call (new) i2c_del_adapter_nolock() since the core_lock is hold
> by i2c_del_driver() when the mux is an i2c device.
> 
> If you define a virtual adapter as a non-i2c device I suppose we
> should use the lock...

My feeling is that we'd be better off killing the legacy i2c binding
model before we try to add support for i2c bus multiplexers. This will
clean up the i2c-core locking model significantly and limit the number
of cases we have to think about for everything we implement.

This isn't so far away, I'm working on it these days and it isn't
impossible that kernel 2.6.28 will be completely i2c-legacy-model-free.

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
