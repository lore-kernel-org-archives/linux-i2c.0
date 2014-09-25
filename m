From: Octavian Purdila <octavian.purdila@intel.com>
Subject: Re: [PATCH v5 1/4] mfd: add support for Diolan DLN-2 devices
Date: Thu, 25 Sep 2014 13:41:16 +0300
Message-ID: <CAE1zotL2A7Y_xbgCJD2mxiJ=F97GX7PkkB+YTUQjHD6tkDGs-g@mail.gmail.com>
References: <1411158165-25794-1-git-send-email-octavian.purdila@intel.com>
	<1411158165-25794-2-git-send-email-octavian.purdila@intel.com>
	<20140924104809.GA16198@localhost>
	<CAE1zotLu7pN9pC_C+iRwSpMh2iPW5E1CL4RiycLK-jV_FZEfOQ@mail.gmail.com>
	<20140924135444.GD16198@localhost>
	<CAE1zot+BqL4=kTJaQYwPxL-19W-+2nomXXrKaogJZRXuvrVE0A@mail.gmail.com>
	<20140924150749.GG16198@localhost>
	<CAE1zotLbziKCaXio-LTu0hoz+jjTzqZD=PC3yP3VSn2+f7j62Q@mail.gmail.com>
	<CAE1zot+NGpLFC2fT5giNdXowhaesOux97e_7N9T6EV1OaWWdtg@mail.gmail.com>
	<20140925103011.GA32124@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20140925103011.GA32124@localhost>
Sender: linux-gpio-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, wsa@the-dreams.de, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Daniel Baluta <daniel.baluta@intel.com>, Laurentiu Palcu <laurentiu.palcu@intel.com>, linux-usb@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Sep 25, 2014 at 1:30 PM, Johan Hovold <johan@kernel.org> wrote:
> On Thu, Sep 25, 2014 at 01:25:24PM +0300, Octavian Purdila wrote:
>
>> Johan, I think we don't really need the spinlock, the disconnect flag
>> and an atomic counter should work. Do you see any issues with that?
>
> No, you need to test and increment atomically so the lock is needed.
>
> Consider what could happen if you get a disconnect after testing but
> before incrementing.
>

I am still not seeing the problem. We would continue with the
increment, we will try to send which will fail and go on the error
path where we will decrement and wake_up. What am I missing?
