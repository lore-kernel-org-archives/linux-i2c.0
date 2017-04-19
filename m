From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PMBus and SMBUS_BLOCK with "extended" lenght
Date: Wed, 19 Apr 2017 15:40:27 +1000
Message-ID: <1492580427.25766.131.camel@kernel.crashing.org>
References: <1490948247.3177.233.camel@kernel.crashing.org>
         <20170331163336.4sy4br3i2o5etcoe@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:58612 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759886AbdDSFkg (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 19 Apr 2017 01:40:36 -0400
In-Reply-To: <20170331163336.4sy4br3i2o5etcoe@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c <linux-i2c@vger.kernel.org>

On Fri, 2017-03-31 at 18:33 +0200, Wolfram Sang wrote:
> Hi,
> 
> > Did anybody give thoughts to how we could support "smbus" block
> > transfers with a size up to 0xff ? This is an extension of smbus
> > that part of the PMbus protocol spec.
> 
> For completeness, SMBus Spec V3 (released 2015) increased the allowed
> transfer size to 255 as well.
> 
> > 
> > Our current code has a lot of places where I2C_SMBUS_BLOCK_MAX is
> > hard wired. Including down in almost all drivers.
> > 
> > So it would have to be an evolutionary process.
> > 
> > I was thinking a message flag along with a functionality bit
> > maybe ?
> 
> I have never really scratched my head about this issue yet and don't
> know of any on-going activity. It is notable, though, that we export
> I2C_SMBUS_BLOCK_MAX to userspace, too.

Right. I don't think we can change it. We could either define a whole
new set of block read/write that support "extended" max, or probably
easier, a msg flag indicating that this is supported.

We would need a backend bus capability as well since all the busses
today will barf if the device returns something larger than
I2C_SMBUS_BLOCK_MAX.

Not a huge deal, all this is just a thought, I don't think I have a
device to deal with today that will return more on any of my systems (I
can double check later). I just noticed that while reading the PMbus
spec.

Cheers,
Ben.
