From: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH 07/12] i2c: pxa: Reset i2c controller on timeout in interrupt and pio mode
Date: Fri, 29 May 2015 23:13:51 +0200
Message-ID: <87r3pzxf1s.fsf@belgarion.home>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
	<1432818224-17070-8-git-send-email-vaibhav.hiremath@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432818224-17070-8-git-send-email-vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
	(Vaibhav Hiremath's message of "Thu, 28 May 2015 18:33:39 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:

> In case of timeout during msg xfer assert reset to
> i2c controller for both interrupt and PIO mode of operation.
>
> Signed-off-by: Jett.Zhou <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> [vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org: Split & merge patches into logical changes
> and update the Changelog]
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
I have the same comment as before.
I don't like a reset in the transfer path, especially in normal busy phases for
slow I2C devices. A quirk as before.

Cheers.

--
Robert
