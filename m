From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: [PATCH] i2c: virtual i2c adapter support.
Date: Sun, 22 Jun 2008 12:53:11 +0200
Message-ID: <8763s1spuw.fsf@macbook.be.48ers.dk>
References: <1213895701-9872-1-git-send-email-giometti@linux.it>
	<1213895701-9872-2-git-send-email-giometti@linux.it>
	<87fxr5sw5f.fsf@macbook.be.48ers.dk>
	<20080622085206.GM10695@enneenne.com>
	<87bq1tsue5.fsf@macbook.be.48ers.dk>
	<20080622093939.GO10695@enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080622093939.GO10695-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org> (Rodolfo Giometti's message
	of "Sun\, 22 Jun 2008 11\:39\:39 +0200")
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

 Rodolfo> On Sun, Jun 22, 2008 at 11:15:14AM +0200, Peter Korsgaard wrote:

 >> That's not the problem, the struct i2c_client is. The i2c-virtual
 >> stuff doesn't do anything with it, it simply forwards it to the
 >> select/deselect callbacks - So changing it to a void *data shouldn't
 >> really be a problem.
 >> 
 >> You don't derive the parent i2c bus from the i2c_client.

 Rodolfo> Ok, but what do you suggest to put in "struct i2c_adapter *parent"?

The real parent bus. The hardware works pretty much like the pcfs,
except it has a memory mapped register interface instead of i2c for
controlling the mux. See the driver I sent for details.

 Rodolfo> What do you think about this solution? :)
 >> 
 >> Sorry, I don't see what the problem is?

 Rodolfo> Maybe if you provide a littke code I may understand exactly
 Rodolfo> what you mean. ;)

But I did?!

-- 
Bye, Peter Korsgaard

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
