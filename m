From: Adrian Bunk <bunk@kernel.org>
Subject: Re: [4.9/4.14 patch] eeprom: at24: add support for 24c2048
Date: Sun, 17 Feb 2019 13:15:37 +0200
Message-ID: <20190217111537.GC6606@localhost>
References: <20190214154158.GA21871@localhost>
 <20190214155727.GA11308@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190214155727.GA11308@kroah.com>
Sender: stable-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-i2c@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

On Thu, Feb 14, 2019 at 04:57:27PM +0100, Greg KH wrote:
> On Thu, Feb 14, 2019 at 05:41:58PM +0200, Adrian Bunk wrote:
> > commit 6c0c5dc33ff42af49243e94842d0ebdb153189ea upstream.
> > commit 37cf28d3b5bca1b532a0b6aac722e7f2788a9294 upstream.
> 
> Please do not merge two different commits together, but backport them
> individually, it's safer that way over time.

Sorry for that, resent as two patches.

> thanks,
> 
> greg k-h

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
