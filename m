From: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH-V2 02/12] i2c: pxa: No need to set slave addr for i2c master mode reset
Date: Fri, 03 Jul 2015 22:58:38 +0200
Message-ID: <87wpyh9cw1.fsf@belgarion.home>
References: <vaibhav.hiremath@linaro.org>
	<1434383399-2370-1-git-send-email-vaibhav.hiremath@linaro.org>
	<1434383399-2370-3-git-send-email-vaibhav.hiremath@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434383399-2370-3-git-send-email-vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
	(Vaibhav Hiremath's message of "Mon, 15 Jun 2015 21:19:49 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:

> Normally i2c controller works as master, so slave addr is not needed, or it
> will impact some slave device (eg. ST NFC chip) i2c accesses, because it has
> the same i2c address with controller.
>
> Signed-off-by: Jett.Zhou <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Acked-by: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>

Cheers.

-- 
Robert
