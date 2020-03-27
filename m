From: Slawomir Stepien <sst@poczta.fm>
Subject: Re: [RFCv3] i2c: hold the core_lock for the whole execution of
 i2c_register_adapter()
Date: Fri, 27 Mar 2020 15:01:26 +0100
Message-ID: <20200327140126.GA2112@t480s.localdomain>
References: <20191008163956.GB566933@t480s.localdomain>
 <20200321191532.GF5632@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtpo.poczta.interia.pl ([217.74.65.155]:45252 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgC0OJR (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 27 Mar 2020 10:09:17 -0400
Content-Disposition: inline
In-Reply-To: <20200321191532.GF5632@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, krzysztof.adamski@nokia.com, jakub.lewalski@nokia.com, slawomir.stepien@nokia.com, alexander.sverdlin@nokia.com

On mar 21, 2020 20:15, Wolfram Sang wrote:
> Hi Slawomir,

Hello Wolfram,

> On Tue, Oct 08, 2019 at 06:39:56PM +0200, Slawomir Stepien wrote:
> > From: Sławomir Stępień <slawomir.stepien@nokia.com>
> > 
> > There is a race condition between the i2c_get_adapter() and the
> > i2c_add_adapter() if this mutex isn't hold for the whole execution of
> > i2c_register_adapter().
> > 
> > If the mutex isn't locked, it is possible to find idr that points to
> > adapter that hasn't been registered yet (i.e. it's
> > kobj.state_initialized is still false), which will end up with warning
> > message:
> > 
> > "... is not initialized, yet kobject_get() is being called."
> > 
> > This patch will change how the locking is arranged around
> > i2c_register_adapter() call and will prevent such situations. The part
> > of the i2c_register_adapter() that do not need to be under the lock has
> > been moved to a new function i2c_process_adapter.
> > 
> > Signed-off-by: Sławomir Stępień <slawomir.stepien@nokia.com>
> 
> Thank you for tackling this one and sorry for the late reply.
> 
> Do you have a test case for me so I could reproduce the bad case here?

I don't have any test case ready on hand, but please take a look at this flow:

Note: The assumption is that i2c_add_adapter() and i2c_get_adapter() are called
from separate threads of execution.

time | i2c_add_adapter()     | i2c_get_adapter()
------------------------------------------------
0001 | lock of core_lock     |
0002 | new idr via idr_alloc |
0003 | unlock of core_lock   |
0004 |                       | lock of core_lock
0005 |                       | idr_find
0006 |                       | get_device [1]
0007 | i2c_register_adapter  |

At point [1], the i2c_get_adapter() assumes the device is ready only because it
was found in idr. It calls get_device() which causes kobject_get() to fail.

-- 
Slawomir Stepien
