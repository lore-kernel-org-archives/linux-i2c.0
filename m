From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v5 6/6] i2c: use an IRQ to report Host Notify events, not
 alert
Date: Mon, 21 Nov 2016 11:52:48 +0100
Message-ID: <20161121105248.GH2119@mail.corp.redhat.com>
References: <1476360640-12901-1-git-send-email-benjamin.tissoires@redhat.com>
 <1476360640-12901-7-git-send-email-benjamin.tissoires@redhat.com>
 <20161107002034.GB1442@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55314 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753848AbcKUKww (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 21 Nov 2016 05:52:52 -0500
Content-Disposition: inline
In-Reply-To: <20161107002034.GB1442@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>

Hi Wolfram,

On Nov 07 2016 or thereabouts, Wolfram Sang wrote:
> On Thu, Oct 13, 2016 at 02:10:40PM +0200, Benjamin Tissoires wrote:
> > The current SMBus Host Notify implementation relies on .alert() to
> > relay its notifications. However, the use cases where SMBus Host
> > Notify is needed currently is to signal data ready on touchpads.
> > 
> > This is closer to an IRQ than a custom API through .alert().
> > Given that the 2 touchpad manufacturers (Synaptics and Elan) that
> > use SMBus Host Notify don't put any data in the SMBus payload, the
> > concept actually matches one to one.
> 
> I see the advantages. The only question I have: What if we encounter
> devices in the future which do put data in the payload? Can this
> mechanism be extended to handle that?

I guess I haven't convinced you with my answer. Is there anything I can
do to get this series in v4.10 or do you prefer waiting for v4.11?

Cheers,
Benjamin

> 
> > 
> > Benefits are multiple:
> > - simpler code and API: the client will just have an IRQ, and
> >   nothing needs to be added in the adapter beside internally
> >   enabling it.
> > - no more specific workqueue, the threading is handled by IRQ core
> >   directly (when required)
> > - no more races when removing the device (the drivers are already
> >   required to disable irq on remove)
> > - simpler handling for drivers: use plain regular IRQs
> > - no more dependency on i2c-smbus for i2c-i801 (and any other adapter)
> > - the IRQ domain is created automatically when the adapter exports
> >   the Host Notify capability
> > - the IRQ are assign only if ACPI, OF and the caller did not assign
> >   one already
> > - the domain is automatically destroyed on remove
> > - fewer lines of code (minus 20, yeah!)
> > 
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> Thanks for keeping at it!
> 
