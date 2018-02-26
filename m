From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] i2c: imx: Fix PM device usage count
Date: Mon, 26 Feb 2018 11:08:29 +0100
Message-ID: <31679751.ihdXrgd1zD@aspire.rjw.lan>
References: <20180224224328.2pfki7rqcxqetmlz@agrajag.zerfleddert.de> <20180225195748.5itrchj36wz5mquu@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180225195748.5itrchj36wz5mquu@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Tobias Jordan <Tobias.Jordan@elektrobit.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

On Sunday, February 25, 2018 8:57:48 PM CET Uwe Kleine-König wrote:
> On Sat, Feb 24, 2018 at 11:43:28PM +0100, Tobias Jordan wrote:
> > pm_runtime_get_sync() increases the device's usage count even when
> > reporting an error, so add a call to pm_runtime_put_noidle() in the
> > related error branches.
> > 
> > Fixes: 588eb93ea49f ("i2c: imx: add runtime pm support to improve the
> >   performance")
> > Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
> > ---
> > In i2c_imx_xfer(), one could also move the "out" label up (in front of
> > the call to pm_runtime_put_autosuspend()), but I'm not sure what the
> > underlying error scenario is; calling _put_noidle() seems to be the
> > safer bet.
> > 
> > This is one of a number of patches for problems found using coccinelle 
> > scripting in the SIL2LinuxMP project. The patch has been compile-tested;
> > it's based on linux-next-20180223.
> > 
> > For a discussion of the corresponding issue, see
> > https://marc.info/?l=linux-pm&m=151904483924999&w=2
> 
> I don't get the original mail, so reply here. In reply to the question I
> would have asked here, too:
> 
> > Why isn't ...get_sync() directly calling ...put_noidle() but relies on
> > the driver implementation to do it? It seems unintuitive for a _get_
> > function to increase the usage count although returning an error.
> 
> Rafael replied:
> 
> > Because ...get_sync() returns an error when runtime PM is disabled and
> > we wanted that case to be transparent for the users of it.
> > 
> > In the majority of cases (if not always) errors returned by
> > ...get_sync()
> > mean disabled runtime PM or flaky hardware and the latter is much less
> > common (and generally there's not much to do about them in the kernel
> > anyway).
> 
> If pm_runtime_get_sync() should be transparent for the users if PM is
> disable, why not simply return success then?

Because *some* users of it want to get the error.

They generally need to handle the rumtime PM disabled situation differently.

Thanks,
Rafael
