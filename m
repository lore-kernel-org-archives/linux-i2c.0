From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] i2c: core: make it possible to match a pure device
 tree driver
Date: Thu, 30 May 2013 10:00:16 +0200
Message-ID: <CACRpkdY3YrkhK+vziZTO2cGSr0Ywi=y9Hk+nubo3rTTqwqUn6A@mail.gmail.com>
References: <1368476301-10495-1-git-send-email-linus.walleij@linaro.org>
	<CACRpkdae1chj9ZKuQV5MuiaicLUTKr4hZqr8rtjbB3Yjt+U_fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdae1chj9ZKuQV5MuiaicLUTKr4hZqr8rtjbB3Yjt+U_fg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, May 22, 2013 at 9:56 AM, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On Mon, May 13, 2013 at 10:18 PM, Linus Walleij
> <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>
>> This tries to address an issue found when writing an MFD driver
>> for the Nomadik STw481x PMICs: as the platform is using device
>> tree exclusively I want to specify the driver matching like
>> this:
> (...)
>> ---
>> ChangeLog v1->v2:
>> - Use of_match_device() to determine if there is a DT match in
>>   the probe code. If there is a match we pass NULL for the
>>   id_table match parameter.
>
> Ping on this.
>
> v2 should be doing what Grant suggested...

Ping, nocheinmal.

Yours,
Linus Walleij
