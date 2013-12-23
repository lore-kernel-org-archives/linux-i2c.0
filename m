From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: nomadik: auto-calculate slave setup time
Date: Mon, 23 Dec 2013 18:18:09 +0100
Message-ID: <CACRpkdZzxhaZv82padERvcD8OAs0EhjSOj0kVJAiviy57TR-RA@mail.gmail.com>
References: <1385676705-15051-1-git-send-email-linus.walleij@linaro.org>
	<CACRpkdZioyQ_yj40Vvd1vCdMa__oRrQ_G0D=pC-hkwb9rdVn9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdZioyQ_yj40Vvd1vCdMa__oRrQ_G0D=pC-hkwb9rdVn9Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Dec 14, 2013 at 1:19 AM, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On Thu, Nov 28, 2013 at 11:11 PM, Linus Walleij
> <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>
>> The Nomadik I2C controller needs to have the slave set-up time
>> configured based off the clock used to drive the I2C bus block.
>> Currently this is done with static assignments assuming that the
>> block is clocked 48MHz which is pretty likely to be bug-prone.
>> Calculate the SLSU from the equation given in the datasheet
>> instead.
>>
>> Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> Wolfram: ping on this.

Ping on this again.

Yours,
Linus Walleij
