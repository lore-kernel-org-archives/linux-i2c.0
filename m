From: <Tobias.Jordan@elektrobit.com>
Subject: RE: [SIL2review] [PATCH] i2c: img-scb: fix PM device usage count
Date: Tue, 17 Apr 2018 08:03:07 +0000
Message-ID: <84353cd0444f41c4aebbc1b6eb2eeae3@denue6es008.ebgroup.elektrobit.com>
References: <20180224224303.3mpwhal2axcr6aos@agrajag.zerfleddert.de>
 <20180225132014.GA8844@osadl.at> <20180225172730.2b443978@denkmatte>
 <20180416161845.hxizpjituo6mpvbm@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180416161845.hxizpjituo6mpvbm@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: der.herr@hofr.at, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,

> Is it easily recognizable if the drivers check the error code because
> there is a reason or if they do it "out of habit"?

Probably by looking closely at the implementation of the PM callouts
for the driver, but I couldn't find a pattern that would be easy to
recognize. Maybe I didn't look close enough ;-)

I concur that removing the check would be a better approach if it's
clear that it's just done "out of habit".

Actually, the real problem is to find the drivers that need to have
the check in, add/fix it for them, and remove it for all others.

Unfortunately, all I'm currently able to do is finding the parts that
are inconsistent.

Tobias
