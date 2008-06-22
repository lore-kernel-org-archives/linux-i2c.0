From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: [PATCH] i2c: virtual i2c adapter support.
Date: Sun, 22 Jun 2008 11:15:14 +0200
Message-ID: <87bq1tsue5.fsf@macbook.be.48ers.dk>
References: <1213895701-9872-1-git-send-email-giometti@linux.it>
	<1213895701-9872-2-git-send-email-giometti@linux.it>
	<87fxr5sw5f.fsf@macbook.be.48ers.dk>
	<20080622085206.GM10695@enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080622085206.GM10695-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org> (Rodolfo Giometti's message
	of "Sun\, 22 Jun 2008 10\:52\:06 +0200")
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
Cc: Ben Dooks <ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

>>>>> "Rodolfo" == Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org> writes:

Hi,

 >> It would be nice to be able to use the i2c-virtual stuff for it.

 Rodolfo> Mmm... I suppose is not so easy as we wish since there are several
 Rodolfo> references to the i2c parent struct into the code.

That's not the problem, the struct i2c_client is. The i2c-virtual
stuff doesn't do anything with it, it simply forwards it to the
select/deselect callbacks - So changing it to a void *data shouldn't
really be a problem.

You don't derive the parent i2c bus from the i2c_client.

 Rodolfo> I suppose you can get better result if you define your i2c
 Rodolfo> multiplexer as a dummy i2c device. The you can force it to
 Rodolfo> be connected with a real i2c parent by using the
 Rodolfo> i2c_register_board_info() function.

 Rodolfo> What do you think about this solution? :)

Sorry, I don't see what the problem is?

-- 
Bye, Peter Korsgaard

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
