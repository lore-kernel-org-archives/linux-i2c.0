From: Sam Povilus <kernel.development@povil.us>
Subject: Re: [PATCH v5] hwmon: ads7828 optional parameters from the device
 tree
Date: Wed, 22 Mar 2017 07:05:55 -0600
Message-ID: <20170322130555.wgwrkeju43dvj232@irascible.povil.us>
References: <20170321032434.9268-1-kernel.development@povil.us>
 <20170322084240.xspj432z2mpyzykq@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-hwmon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170322084240.xspj432z2mpyzykq@ninjato>
Sender: linux-hwmon-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
List-Id: linux-i2c@vger.kernel.org

On Wed, Mar 22, 2017 at 09:42:40AM +0100, Wolfram Sang wrote:
> 
> >  .../devicetree/bindings/i2c/trivial-devices.txt    |  2 --
> 
> This file is about to get moved one directory up:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/commit/?h=dt/next&id=b7e252fcddfa573bb1ee275b53bba6cef85671d4
> 
> Just so you know already...
> 

Thanks! I'm a bit new to this, what's the best way for me to handle
this? Submit against Linus' tree (presumably making a merge nightmare
for someone) or rebase my branch off robh's (and presumably risking some
other branch's patch conflicting)?
