From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: multi-master lost-arbitration improvement
 for i2c-algo-pcf (take 2)
Date: Thu, 7 Aug 2008 11:29:25 +0200
Message-ID: <20080807112925.7d772e52@hyperion.delvare>
References: <ec7cefb0806121410g154b546dx1cb2562898dba4b6@mail.gmail.com>
	<48851363.1010303@mydatex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <48851363.1010303-0pWKB23IDFjrBKCeMvbIDA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Daniel Smolik <marvin-0pWKB23IDFjrBKCeMvbIDA@public.gmane.org>
Cc: Eric Brower <ebrower-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, envctrl-VCrIQ7D8lE7fOqXh0n4+lyp2UmYkHbXO@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Daniel,

On Tue, 22 Jul 2008 00:53:23 +0200, Daniel Smolik wrote:
> Sorry for long delay I was on holiday. I today compile 2.6.26
> and start testing. I patch vanilla with take2 without problem. But I
> found  may be bug in 2.6.26 because is not possible select algos in
> i2c and i2c-algo-pcf is not compiled. This is needed by i2-envctrl.

I see that you have opened bug #11140 for that:
http://bugzilla.kernel.org/show_bug.cgi?id=11140

The algorithm modules were removed from the menu because they are
selected automatically by drivers which need them. Obviously this
doesn't work for external drivers. Maybe it's time to push your i2c bus
driver upstream?

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
