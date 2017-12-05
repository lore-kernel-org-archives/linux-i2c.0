From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/6] i2c: add 'set_sda' to bus_recovery_info
Date: Tue, 5 Dec 2017 11:34:12 +0100
Message-ID: <CACRpkdY1nuRpk5BRn2iWXqhfRycLRb2VtwEUA4pA9FM+7JrTog@mail.gmail.com>
References: <20171204123640.3382-1-wsa+renesas@sang-engineering.com>
 <20171204123640.3382-4-wsa+renesas@sang-engineering.com> <CACRpkdZzwo9UhT08VDHXg6=eXdK80Pt1omZ4Xda_HFwguyNpaw@mail.gmail.com>
 <53d5696c-6f0d-1717-5c9e-4facf397f284@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <53d5696c-6f0d-1717-5c9e-4facf397f284@electromag.com.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Claudio Foellmi <claudio.foellmi@ergon.ch>, Andrzej Hajda <a.hajda@samsung.com>
List-Id: linux-i2c@vger.kernel.org

On Tue, Dec 5, 2017 at 10:57 AM, Phil Reid <preid@electromag.com.au> wrote:
> On 5/12/2017 16:39, Linus Walleij wrote:

>> Just compare it to zero. if (!gpiod_get_direction())
>>
>> This flag is only for requesting GPIOs in the old API.
>> We didn't add a define in the new API, it seemed overengineered.
>>
>
> Perhaps the docs need updating?
> as of 4.15-rc2 it says
>  * Return GPIOF_DIR_IN or GPIOF_DIR_OUT, or an error code in case of error.
>
> I can submit something if you wish.

Hit me.

Sorry for the incoherent information.

Yours,
Linus Walleij
