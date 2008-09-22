From: "Andrew Victor" <avictor.za-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC: 2.6 patch] remove the i2c-at91.c driver
Date: Mon, 22 Sep 2008 20:22:20 +0200
Message-ID: <cd73a99e0809221122u1fd9304le92a29fcca874ae7@mail.gmail.com>
References: <20080831161005.GC3695@cs181140183.pp.htv.fi>
	<200809041218.49604.david-b@pacbell.net>
	<cd73a99e0809041314i54c7fd71ued53270517ecc829@mail.gmail.com>
	<200809041325.30330.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200809041325.30330.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Content-Disposition: inline
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
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

hi,

> Maybe the best answer would be to remove this and have a g20-specific
> driver later.

The comment from Atmel is that in the short-term they don't have time
to look into testing or fixing the driver on the G20.

So I think we might aswell just apply Adrian's patch to mainline.
  Acked-by: Andrew Victor <linux-PelNFVqkFnVyf+4FbqDuWQ@public.gmane.org>

I'll include it in the -at91 patch incase anybody still wants to use it.


Regards,
  Andrew Victor

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
