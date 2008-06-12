From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch/rfc 2.6.26-rc5] i2c: schedule legacy gpio driver
 removal
Date: Thu, 12 Jun 2008 12:57:29 +0200
Message-ID: <20080612125729.136d642b@hyperion.delvare>
References: <200806111317.21060.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200806111317.21060.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

Hi David,

On Wed, 11 Jun 2008 13:17:20 -0700, David Brownell wrote:
> Just sending this as an RFC ... clearly it shouldn't merge until
> the GPIO_SYSFS code merges, which I'm assuming is 2.6.27.

Certainly.

> And presumably Jean will want to be the "who removes this"?

Not necessarily.

> I think the only other blocking issue would be a way to configure
> such new-style drivers from sysfs, primarily for one-off hardware
> hacking usage (in at least this case).

This is the problem. Until there is a way to instantiate new-style
drivers from user-space, we just can't remove the deprecated drivers.
Even tagging it as deprecated is dishonest to some extent. So I see no
point in adding these drivers to the feature removal list for now. We
can do that later, when we really offer an alternative with the same
features.

You shouldn't fear that we forget to remove these drivers. They are the
dust in my eye, I can't forget them.

>                                       Teaching the two new-style
> drivers to use dynamic GPIO number allocation when there's no
> platform_data is trivial,

Good to know...

>                           and not otherwise desirable.

I'm confused now.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
