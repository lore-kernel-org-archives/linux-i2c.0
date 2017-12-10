From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3 1/2] eeprom: at24: fix coding style issues
Date: Sun, 10 Dec 2017 14:55:45 -0800
Message-ID: <1512946545.26342.20.camel@perches.com>
References: <20171207133915.29448-1-brgl@bgdev.pl>
         <20171207133915.29448-2-brgl@bgdev.pl>
         <CAHp75VfoG++eRAhZ9ZT7me6tZqxxVMzQHd8GcauszRQDDkGGFg@mail.gmail.com>
         <CAMRc=MesSDBmqLWAWw7gKz_Gaqhwuy7CtFS4gob_8Oy1ztTVHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMRc=MesSDBmqLWAWw7gKz_Gaqhwuy7CtFS4gob_8Oy1ztTVHw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Peter Rosin <peda@axentia.se>, linux-i2c <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, 2017-12-10 at 19:42 +0100, Bartosz Golaszewski wrote:
> 2017-12-10 13:57 GMT+01:00 Andy Shevchenko <andy.shevchenko@gmail.com>:
> > On Thu, Dec 7, 2017 at 3:39 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > Fix issues reported by checkpatch for at24.c.
> > > +module_param(io_limit, uint, 0000);
> > > +module_param(write_timeout, uint, 0000);
> > 
> > 
> > 0 is a pretty much octal number as 0000.
> > So, I would prefer not to blindly follow the stupid advise from
> > checkpatch, better to teach checkpatch about 0.
> > 
> > 
> 
> I submitted a patch for that - let's see what checkpatch maintainers say.

Personally, I prefer 4 digit octal in most cases as it
shows the coder knows that the argument is a permissions
use and not just some generic 0.

There are not many uses of 0 for permissions outside of
module_param*.

I suppose all the variants of module_param calls, as a
0 there is specifically a "not to appear in sysfs" flag,
could or should be excluded from that octal test.
