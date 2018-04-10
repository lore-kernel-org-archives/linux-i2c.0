From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] MAINTAINERS: remove me as maintainer for I2C host
 drivers
Date: Tue, 10 Apr 2018 08:14:33 -0700
Message-ID: <a3ffaea6a161e667854127d2e021a04034985a97.camel@perches.com>
References: <20180410141125.4477-1-wsa@the-dreams.de>
         <f0ce07bdb69602450ea1681936706b16962ce41f.camel@perches.com>
         <20180410144654.fg2pbvh4d2y3rucv@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180410144654.fg2pbvh4d2y3rucv@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 2018-04-10 at 16:46 +0200, Wolfram Sang wrote:
> > As far as I understand, all this seems correct to me.
> 
> Good. Thank you, Joe!
> /
> > You want to maintain the core files in drivers/i2c/
> > but not any files in any of algos/, busses/, or muxes/.
> 
> More specific: I don't want get_maintainer.pl to print me as a
> maintainer for these drivers.

I believe get_maintainer.pl is still going to do that for
awhile as you are a commit signer for several of these driver
files.  Files that are not either "supported" or "maintained"
by default add the --git-fallback option.

For instance, With your patch:
$ ./scripts/get_maintainer.pl -f drivers/i2c/algos/i2c-algo-bit.c
Wolfram Sang <wsa+renesas@sang-engineering.com> (commit_signer:3/2=100%,authored:1/2=50%,added_lines:5/15=33%)
Jean Delvare <jdelvare@suse.de> (commit_signer:1/2=50%,authored:1/2=50%,added_lines:10/15=67%,removed_lines:3/3=100%)
linux-i2c@vger.kernel.org (open list:I2C SUBSYSTEM DRIVERS)
linux-kernel@vger.kernel.org (open list)

Your name should not be shown after a year or so unless you
actually sign-off on patches to those subdirectories.

btw: You signed-off using 2 different addresses on one
of those patches.  I think that's odd.

commit 3e5f06bed72fe72166a6778f630241a893f67799
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Mon Dec 4 09:16:18 2017 +0100

    i2c: algo-bit: init the bus to a known state
    
    Ensure the bus is free when we register the adapter. Before the SCL/SDA
    wires were in an unknown state. It used to work because sending a byte
    has a retry mechanism which was triggered if the bus was initially in a
    non-free state. But the graceful way to do it is to initialize
    correctly.
    
    Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
