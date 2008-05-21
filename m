From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 1/3] i2c : use class_for_each_device
Date: Wed, 21 May 2008 08:00:39 +0200
Message-ID: <20080521080039.49e6ea9f@hyperion.delvare>
References: <20080509072029.GA2740@darkstar.te-china.tietoenator.com>
	<20080520193113.19ef0dc5@hyperion.delvare>
	<a8e1da0805201829n439f251uef438bca0b1d006@mail.gmail.com>
	<a8e1da0805201830q88665afnf00e5f96f832f90@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933718AbYEUGBE@vger.kernel.org>
In-Reply-To: <a8e1da0805201830q88665afnf00e5f96f832f90@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Young <hidave.darkstar@gmail.com>
Cc: gregkh@suse.de, i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 21 May 2008 09:30:59 +0800, Dave Young wrote:
> On Wed, May 21, 2008 at 9:29 AM, Dave Young <hidave.darkstar@gmail.com> wrote:
> > On Wed, May 21, 2008 at 1:31 AM, Jean Delvare <khali@linux-fr.org> wrote:
> >> ... but calling another one? Can't be correct. Which raises a question:
> >> you didn't test your patch, did you? I'm also surprised how you managed
> >> to mess this up, given that all you had to do was to move already
> >> existing code around.
> >
> > Thanks for review, It's only boot-tested with i2c part as built-in by
> > me because I have the i2c device to test.
> 
> should be "have no the i2c device to test" ;)

Too late for this time, but for next time, you can emulate an i2c
device using the i2c-stub driver, that's very convenient when you want
to test a change that affects i2c and don't have any physical device to
test it.

-- 
Jean Delvare
