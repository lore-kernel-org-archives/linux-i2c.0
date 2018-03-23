From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH 03/21] eeprom: at24: arrange local variables
Date: Fri, 23 Mar 2018 17:06:30 +0100
Message-ID: <CAMRc=Mce2SV+JHqFvm66H-FnuGvH6PSg=cgrtxzoR+xZgkzg+A@mail.gmail.com>
References: <20180319091721.18193-1-brgl@bgdev.pl> <20180319091721.18193-4-brgl@bgdev.pl>
 <20180323152157.GA6934@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180323152157.GA6934@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

2018-03-23 16:21 GMT+01:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> On Mon, Mar 19, 2018 at 10:17:03AM +0100, Bartosz Golaszewski wrote:
>> Arrange declarations of local variables by line length as visually
>> it's easier to read.
>
> That's the craziest thing I've seen in a while...
>
> ok, if it makes it easier for you :)
>
> greg k-h

Hi Greg,

this isn't something unusual, see for example:

bef6b1b7a6ff ("nfp: reorder variables in nfp_net_tx()")
5318c53d5b4b ("crypto: s5p-sss - Use consistent indentation for
variables and members")

Thanks,
Bart
