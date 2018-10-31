From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 2/2] i2c: Clear client->irq in i2c_device_remove
Date: Wed, 31 Oct 2018 09:52:30 +0000
Message-ID: <20181031095230.GK16508@imbe.wolfsonmicro.main>
References: <20181019085958.32694-1-ckeepax@opensource.cirrus.com>
 <20181019085958.32694-2-ckeepax@opensource.cirrus.com>
 <20181028223116.GJ1882@kunai>
 <CAO-hwJLw74k+jBnDuQ7OrVzJOy8i82OXKNWuNhxNqUj+8nzwhg@mail.gmail.com>
 <20181030115120.GI16508@imbe.wolfsonmicro.main>
 <CAO-hwJ+B5iUpbUamsCfNKGwxJMM9fNBUnrb2-csn1VpNG58KBA@mail.gmail.com>
 <20181030145549.GB2459@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181030145549.GB2459@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Linux I2C <linux-i2c@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

On Tue, Oct 30, 2018 at 02:55:50PM +0000, Wolfram Sang wrote:
> 
> > No, that's fine. Now I get this, and I totally agree with the approach:
> > 
> > Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> Thanks! If one of you could provide me with a Fixes tag (for this. or
> both patches?), that would be most helpful.
> 

It's a bit of a long chain and fairly tricky to say exactly when
the bug was introduced but I think this is probably the closest
match:

Fixes: 2fd36c552649 ("i2c: core: Map OF IRQ at probe time")

I suspect the process of unbinding/rebinding would have also
not worked before that commit but it would have not worked
for different reasons.

Thanks,
Charles
