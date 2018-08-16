From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V2] i2c: ismt: fix wrong device address when unmap the
 data buffer
Date: Thu, 16 Aug 2018 17:22:42 +0200
Message-ID: <20180816152242.GJ10648@kroah.com>
References: <1497329993-197698-1-git-send-email-liwei.song@windriver.com>
 <CAJwJo6aAGS3vB-F889zmDJjtU3xGLd=twbVVC=DydXYufKEwPQ@mail.gmail.com>
 <CAHp75VfTzzZoDGaBfnW4NKiU-2Ds6wgQtyUu22mZKwLK2a4rcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VfTzzZoDGaBfnW4NKiU-2Ds6wgQtyUu22mZKwLK2a4rcQ@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>, stable <stable@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Seth Heasley <seth.heasley@intel.com>, Neil Horman <nhorman@tuxdriver.com>, linux-i2c <linux-i2c@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Song liwei <liwei.song@windriver.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, Aug 15, 2018 at 12:25:48PM +0300, Andy Shevchenko wrote:
> On Wed, Aug 15, 2018 at 5:26 AM, Dmitry Safonov <0x7f454c46@gmail.com> wrote:
> > +Cc: stable
> >
> > Hi Greg, JFI:
> > This one has hit a couple of times on autotests on v4.9 stable.
> > The fix for BUG() is trivial, so probably worth to ship it to v4.9/v4.4/v3.18.
> >
> 
> JFYI:
> 
> commit 17e83549e199d89aace7788a9f11c108671eecf5
> Author: Liwei Song <liwei.song@windriver.com>
> Date:   Tue Jun 13 00:59:53 2017 -0400
> 
>    i2c: ismt: fix wrong device address when unmap the data buffer

Thanks, that helped :)

greg k-h
