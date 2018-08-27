From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PULL REQUEST] i2c for 4.19
Date: Mon, 27 Aug 2018 15:58:06 +0200
Message-ID: <1535378286.5079.7.camel@suse.de>
References: <20180824153735.ffqgp6k3utguwpwb@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180824153735.ffqgp6k3utguwpwb@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

On Fri, 2018-08-24 at 17:37 +0200, Wolfram Sang wrote:
> Linus,
> 
> as promised, here is my 2nd pull request for I2C, containing:
> 
> * removal of the attach_adapter callback, converting its last user
> * removal of any __deprecated usage within I2C
> * one email address update
> * some SPDX conversion
> 
> CCing Jean on this one, he will probably be happy to finally see
> attach_adapter be gone for good as well :)

You have no idea :-)

Huge thanks to everyone who made it happen!

-- 
Jean Delvare
SUSE L3 Support
