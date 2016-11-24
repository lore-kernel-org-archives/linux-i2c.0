From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v5 6/6] i2c: use an IRQ to report Host Notify events, not
 alert
Date: Thu, 24 Nov 2016 16:10:18 +0100
Message-ID: <20161124151018.GS2119@mail.corp.redhat.com>
References: <1476360640-12901-1-git-send-email-benjamin.tissoires@redhat.com>
 <1476360640-12901-7-git-send-email-benjamin.tissoires@redhat.com>
 <20161107002034.GB1442@katana>
 <20161121105248.GH2119@mail.corp.redhat.com>
 <20161122114922.GA3993@katana>
 <20161124150608.GE4271@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161124150608.GE4271@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
List-Id: linux-i2c@vger.kernel.org

On Nov 24 2016 or thereabouts, Wolfram Sang wrote:
> On Tue, Nov 22, 2016 at 12:49:22PM +0100, Wolfram Sang wrote:
> > On Mon, Nov 21, 2016 at 11:52:48AM +0100, Benjamin Tissoires wrote:
> > > Hi Wolfram,
> > > 
> > > On Nov 07 2016 or thereabouts, Wolfram Sang wrote:
> > > > On Thu, Oct 13, 2016 at 02:10:40PM +0200, Benjamin Tissoires wrote:
> > > > > The current SMBus Host Notify implementation relies on .alert() to
> > > > > relay its notifications. However, the use cases where SMBus Host
> > > > > Notify is needed currently is to signal data ready on touchpads.
> > > > > 
> > > > > This is closer to an IRQ than a custom API through .alert().
> > > > > Given that the 2 touchpad manufacturers (Synaptics and Elan) that
> > > > > use SMBus Host Notify don't put any data in the SMBus payload, the
> > > > > concept actually matches one to one.
> > > > 
> > > > I see the advantages. The only question I have: What if we encounter
> > > > devices in the future which do put data in the payload? Can this
> > > > mechanism be extended to handle that?
> > > 
> > > I guess I haven't convinced you with my answer. Is there anything I can
> > > do to get this series in v4.10 or do you prefer waiting for v4.11?
> > 
> > I consider this v4.10 material. I was thinking a little about how to not
> > lose data with consecutive interrupts but then -EBUSY came along.
> > Nonetheless, it looks to me like the proper path to follow...
> 
> Applied to for-next, thanks!

Thanks!

> 
> Fixed the following checkpatch warning for you:
> 
> WARNING: struct irq_domain_ops should normally be const
> #250: FILE: drivers/i2c/i2c-core.c:1838:
> +static struct irq_domain_ops i2c_host_notify_irq_ops = {
> 

Thanks again :)

Cheers,
Benjamin
