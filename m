From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 2.6.26-rc1-git] i2c-core: return -Errno, not -1
Date: Sat, 17 May 2008 16:43:34 +0200
Message-ID: <20080517164334.6d824ff4@hyperion.delvare>
References: <200805031306.16698.david-b@pacbell.net>
	<20080516091458.28f9f5ca@hyperion.delvare>
	<20080517081537.17220cd0@hyperion.delvare>
	<200805170653.19424.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200805170653.19424.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, 17 May 2008 06:53:18 -0700, David Brownell wrote:
> On Friday 16 May 2008, Jean Delvare wrote:
> > I'll do all this myself now, no need to resend.
> 
> Good.  In general, when it's down to the last set of small
> comments like this, it's probably easier all around if you
> do stuff like that (rather than writing it up in email, having
> someone like me both read it and make time to act on it, then
> have you re-review).  That's fairly common maintainer practice.

Well, the patch has your name on it, so I think it's only fair to give
you a chance to nack if I am going to change it before I push it
upstream. But if you don't care, I can skip this step on future
patches, no problem.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
