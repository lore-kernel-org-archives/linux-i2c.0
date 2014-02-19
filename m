From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V4 16/17] i2c: nomadik: Remove busy check for transfers at
 suspend late
Date: Wed, 19 Feb 2014 19:07:28 +0100
Message-ID: <CAPDyKFrA4hSj0b2MGzp48TkcXCrFDY2J_dYZyRYSnjvfBbpMqA@mail.gmail.com>
References: <1392812867-19212-1-git-send-email-ulf.hansson@linaro.org>
	<20140219160504.GC13973@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140219160504.GC13973@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 19 February 2014 17:05, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> On Wed, Feb 19, 2014 at 01:27:47PM +0100, Ulf Hansson wrote:
>> We should never be busy performing transfers at suspend late, thus
>> there are no reason to check for it.
>>
>> Cc: Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>
>> Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
>> Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> Okay applied up to patch 16 in a local branch. Waiting for LinusW to
> comment on the 100kHz vs 400kHz issue before pushing out. If patch 17
> can be applied now, please say so. If not, please resend when
> dependencies are upstream.
>

Thanks Wolfram!

Again, sorry for screwing up several times. Let's wait with patch 17,
I will resend later.

Kind regards
Uffe
