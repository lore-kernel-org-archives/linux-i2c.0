From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v5 6/6] i2c: use an IRQ to report Host Notify events, not
 alert
Date: Mon, 7 Nov 2016 17:18:50 +0100
Message-ID: <20161107161850.GA6689@mail.corp.redhat.com>
References: <1476360640-12901-1-git-send-email-benjamin.tissoires@redhat.com>
 <1476360640-12901-7-git-send-email-benjamin.tissoires@redhat.com>
 <20161107002034.GB1442@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161107002034.GB1442@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
List-Id: linux-i2c@vger.kernel.org

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

I had this very same problem when dealing with hid-rmi. In that case, we
have an interrupt that contains data.

I somewhat solved this by the following commit transposed in the hid-rmi
world:
https://github.com/bentiss/linux/commit/d24d938e1eabba026c3c5e4daeee3a16403295de

The idea is the following:
- we extend the internal call of i2c_handle_smbus_host_notify() by
  re-adding a data payload.
- this call takes a spinlock, and copy the data into an internal
  placeholder, releases the spinlock and then triggers the irq
- when the client gets an interrupt, it calls
  i2c_retrieve_host_notify_data() which is protected by the spinlock and
  returns the *current* data

The only difficulty for the client now is that it might access newer
data than the origin interrupt. This can be solved by 2 solutions. Either
we use a kfifo in i2c_core, to the risk of having some complex processing.
Either we just let the client dealing with that by implementing itself
the kfifo. The data just needs to be retrieved in the non threaded part
of the interrupt handler, and stored by the client itself.

So all in all, I think adding the data will be just adding a spinlock, a
placeholder and a new internal API to retrieve it.

I am not sure we have other means of extending the IRQ processing, but I
am open to suggestions.

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
