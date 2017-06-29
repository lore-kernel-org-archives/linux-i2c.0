From: Peter Rosin <peda@axentia.se>
Subject: Re: PCA9541 as mux and gatekeeper mode in Linux?
Date: Thu, 29 Jun 2017 17:09:36 +0200
Message-ID: <59551830.1070505@axentia.se>
References: <CAGXyBZnSFfGALfQWMb3jjbCjiECMn1aWGhjZwYb_P81iL3Tm_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0124.outbound.protection.outlook.com ([104.47.2.124]:9280
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752852AbdF2PJp (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 29 Jun 2017 11:09:45 -0400
In-Reply-To: <CAGXyBZnSFfGALfQWMb3jjbCjiECMn1aWGhjZwYb_P81iL3Tm_g@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bruce Hyde <chrome.bureau@gmail.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Hi!

(please cc: the linux-i2c@ list; even though I'm the listed maintainer,
I'm not the only one who is able to answer questions, and others may get
hits while searching the list archives...)

On 2017-06-29 15:29, Bruce Hyde wrote:
> Hi!
> 
> I've noticed that you're currently the main maintainer of the i2c-mux
> functionality. I hope you will be able to help in my considerations or at least
> point to some useful information :-)
> Enclosed, you will find .txt file with my I2C topology illustrated (I wasn't
> sure if this would send in the proper plain text mode).

I read almost all my email with a fixed width typeface. I hate non-plaintext
email...

> In a nutshell: I'd like to use PCA9541 as a mux device. The main
> problem is that I'm
> not sure if it would be safe to let D1 and D3 have an address 0x30,
> and D2 and D4
> to have an address 0x40 => two devices with the same addresses on the i2c-0 bus
> from the master perspective.

If you could only consider one master, this topology would work. However,
since you presumably don't know what the other master is up to, that other
master may open the other pca9541 while "your" master tries to operate the
first pca9541. If that ever happens (and it will, probably for the first
time with some really awkward timing, in accordance with Murphy's law...)
then two client devices with the same address are visible on i2c-0 while one
(or both) master(s) does an access. That must not happen.

You are better off having one pca9541 do the 2-1 arbitration, followed
by one mux of some other kind doing 1-2 muxing on the client side of the
single pca9541. Like so:


+---------+       +---------+   +---------+             +----+
|         |       |  0x10   |   |  0x70   +---------+---+ D1 | 0x30
| MASTER1 +-------+         +---+         |         |   +----+
|         |       | PCA9541 |   | PCA9542 |         |   +----+
+---------+  +----+         |   |         +----+    +---+ D2 | 0x40
             |    +---------+   +---------+    |        +----+
             |                                 |
             |                                 |        +----+
+---------+  |                                 +----+---+ D3 | 0x30
|         |  |                                      |   +----+
| MASTER2 +--+                                      |   +----+
|         |                                         +---+ D4 | 0x40
+---------+                                             +----+

Cheers,
peda


> It's stated in the PCA9541 datasheet (section 10.4) that:
> 
>> Since each PCA9541/03 has its own unique address (for example, ‘A’, ‘B’, ‘C’, and so on), the EEPROMs
>> can be connected to the master, one at a time, by connecting one PCA9541/03 (Master 0 position) while
>> keeping the rest of the cards/devices isolated (off position).
> 
> but should I really care about setting the PCA9541 to off position
> (isolation) while
> using Linux mux interface? I mean, for example, when I'd like to communicate
> with D1 (0x30) device, kernel knows that it is on the virtual bus
> i2c-11 (for example),
> so it will first send the request to the particular PCA9541 device to
> ->select proper
> channel and then allow to communicate with D1 device, blocking any
> requests to the
> other PCA9541, since this is parent locked mux.
> 
> So, it's *not* possible that the master will somehow try to talk with
> D3 device (also with an address 0x30), because it is behind another PCA9541 mux.
> Could you please confirm if my thinking is correct and explain what am
> I missing, if it is
> not? Is that possible that mentioned topology will lead to I2C address
> collision and the
> only way to make it safe is to allow only one PCA9541 to be enabled at
> the particular
> time frame?
> 
> Best regards,
> Bruce.

[attachment inlined for those on the list]

> +---------+                +---------+    +----+
> |         |                |  0x10   +----+ D1 | 0x30
> | MASTER1 +---+------------+         |    +----+
> |         |   |            | PCA9541 |    +----+
> +---------+   | +----------+         +----+ D2 | 0x40
>               | |          +---------+    +----+
>               | |
>               | |          +---------+    +----+
> +---------+   +------------+         +----+ D3 | 0x30
> |         |     |          | PCA9541 |    +----+
> | MASTER2 +-----+----------+  0x11   |    +----+
> |         |                |         +----+ D4 | 0x40
> +---------+                +---------+    +----+
