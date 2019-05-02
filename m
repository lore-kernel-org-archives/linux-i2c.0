From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] i2c: Prevent runtime suspend of adapter when Host Notify
 is required
Date: Thu, 2 May 2019 16:32:51 +0100
Message-ID: <20190502153251.GG81578@ediswmail.ad.cirrus.com>
References: <20190430142322.15013-1-jarkko.nikula@linux.intel.com>
 <20190430155637.1B45E21743@mail.kernel.org>
 <7f989564-e994-5be6-02da-2838639efe59@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7f989564-e994-5be6-02da-2838639efe59@linux.intel.com>
Sender: stable-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, May 02, 2019 at 03:32:24PM +0300, Jarkko Nikula wrote:
> On 4/30/19 6:56 PM, Sasha Levin wrote:
> >This commit has been processed because it contains a "Fixes:" tag,
> >fixing commit: c5eb1190074c PCI / PM: Allow runtime PM without callback functions.
> >
> >The bot has tested the following trees: v5.0.10, v4.19.37.
> >
> >v5.0.10: Build OK!
> >v4.19.37: Failed to apply! Possible dependencies:
> >     6f108dd70d30 ("i2c: Clear client->irq in i2c_device_remove")
> >     93b6604c5a66 ("i2c: Allow recovery of the initial IRQ by an I2C client device.")
> >
> >
> >How should we proceed with this patch?
> >
> There's also dependency to commit
> b9bb3fdf4e87 ("i2c: Remove unnecessary call to irq_find_mapping")
> 
> Without it 93b6604c5a66 doesn't apply.
> 
> Otherwise my patch don't have dependency into these so I can have
> another version for 4.19 if needed.
> 
> I got impression from the mail thread for 6f108dd70d30 that it could
> be also stable material but cannot really judge.
> 
> Charles: does your commits b9bb3fdf4e87 and 6f108dd70d30 with the
> fix 93b6604c5a66 qualify for 4.19? (background: my fix doesn't apply
> without them but doesn't depend on them).
> 

b9bb3fdf4e87 ("i2c: Remove unnecessary call to irq_find_mapping")

I don't think this one would make sense to backport it's not
fixing any issues it just removes a redundant call. The call just
repeats work it does no harm.

6f108dd70d30 ("i2c: Clear client->irq in i2c_device_remove")
93b6604c5a66 ("i2c: Allow recovery of the initial IRQ by an I2C client device.")

These two are much more of a grey area, they do fix an actual
issue, although that issue only happens when you unbind and
rebind both an I2C device and the device providing its IRQs. A
couple of us have been trying to look for a better fix as well
which further complicates matters.

I would suggest you just backport your patch and leave these
ones. As evidenced by the fixup patch there is a slight chance
of regressions from backporting this fix and the issue it
fixes is clearly not something people are normally hitting.

Thanks,
Charles
