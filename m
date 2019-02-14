From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [4.9/4.14 patch] eeprom: at24: add support for 24c2048
Date: Thu, 14 Feb 2019 16:57:27 +0100
Message-ID: <20190214155727.GA11308@kroah.com>
References: <20190214154158.GA21871@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190214154158.GA21871@localhost>
Sender: stable-owner@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: stable@vger.kernel.org, linux-i2c@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

On Thu, Feb 14, 2019 at 05:41:58PM +0200, Adrian Bunk wrote:
> commit 6c0c5dc33ff42af49243e94842d0ebdb153189ea upstream.
> commit 37cf28d3b5bca1b532a0b6aac722e7f2788a9294 upstream.

Please do not merge two different commits together, but backport them
individually, it's safer that way over time.

thanks,

greg k-h
