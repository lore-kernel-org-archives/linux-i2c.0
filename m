From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] i2c: acorn: add MODULE_LICENSE tag
Date: Mon, 15 Jan 2018 21:31:51 +0100
Message-ID: <CAK8P3a1M1szCGm4TQSePvZR95zR6zLmNRNHOpUajW9P=pogfDA@mail.gmail.com>
References: <20180111103751.1506236-1-arnd@arndb.de> <20180115171027.ynorej3x7nal7ttj@ninjato>
 <20180115171920.GA32698@flint.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180115171920.GA32698@flint.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@armlinux.org.uk>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Jan 15, 2018 at 6:19 PM, Russell King <linux@armlinux.org.uk> wrote:
> On Mon, Jan 15, 2018 at 06:10:28PM +0100, Wolfram Sang wrote:
>> On Thu, Jan 11, 2018 at 11:37:45AM +0100, Arnd Bergmann wrote:
>> > As of v4.15, Kbuild warns about missing MODULE_LICENSE tags:
>> >
>> > WARNING: modpost: missing MODULE_LICENSE() in drivers/i2c/busses/i2c-acorn.o
>> >
>> > This adds a license, author and description tag, matching the
>> > comment at the start of the acorn i2c driver.
>> >
>> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>> Looks good, but since rmk is still around, let's add him to CC...

Oops, I just went with the default from scripts/get_maintainer.pl and
forgot to ensure the author was listed there.

>> >  drivers/i2c/busses/i2c-acorn.c | 4 ++++
>> >  1 file changed, 4 insertions(+)
>> >
>> > diff --git a/drivers/i2c/busses/i2c-acorn.c b/drivers/i2c/busses/i2c-acorn.c
>> > index 9d7be5af2bf2..6463189ca183 100644
>> > --- a/drivers/i2c/busses/i2c-acorn.c
>> > +++ b/drivers/i2c/busses/i2c-acorn.c
>> > @@ -94,3 +94,7 @@ static int __init i2c_ioc_init(void)
>> >  }
>> >
>> >  module_init(i2c_ioc_init);
>> > +
>> > +MODULE_AUTHOR("Russell King <rmk@arm.linux.org.uk>");
>
> linux@armlinux.org.uk please - dspam on _this_ account files such mails
> into the spam mailbox.

Ok, resent now. I think what I did there was to check which address you
use most commonly in the other MODULE_AUTHOR entries.

       Arnd
