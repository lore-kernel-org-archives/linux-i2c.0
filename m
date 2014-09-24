From: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 1/4] mfd: add support for Diolan DLN-2 devices
Date: Wed, 24 Sep 2014 16:36:22 +0300
Message-ID: <CAE1zotLu7pN9pC_C+iRwSpMh2iPW5E1CL4RiycLK-jV_FZEfOQ@mail.gmail.com>
References: <1411158165-25794-1-git-send-email-octavian.purdila@intel.com>
	<1411158165-25794-2-git-send-email-octavian.purdila@intel.com>
	<20140924104809.GA16198@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140924104809.GA16198@localhost>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Sep 24, 2014 at 1:48 PM, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Sep 19, 2014 at 11:22:42PM +0300, Octavian Purdila wrote:

<snip>

>> + * dln2_dev.mod_rx_slots and then the echo header field to index the
>> + * slots field and find the receive context for a particular
>> + * request.
>> + */
>> +struct dln2_mod_rx_slots {
>> +     /* RX slots bitmap */
>> +     unsigned long bmap;
>> +
>> +     /* used to wait for a free RX slot */
>> +     wait_queue_head_t wq;
>> +
>> +     /* used to wait for an RX operation to complete */
>> +     struct dln2_rx_context slots[DLN2_MAX_RX_SLOTS];
>> +
>> +     /* device has been disconnected */
>> +     bool disconnected;
>
> This belongs in the dln2_dev struct.
>
> I think you're overcomplicating the disconnect handling by intertwining
> it with your slots.
>
> Add a lock, an active-transfer counter, a disconnected flag, and a wait
> queue to struct dln2_dev.
>

I agree that disconnected is better suited in dln2_dev.

However, I don't think that we need the active-transfer counter and a
new wait queue. We can simply use the existing waiting queues and the
implicit alloc_rx_slot()/free_rx_slot() calls to see if we are still
waiting for I/O.

<snip>

>> +
>> +static int _dln2_transfer(struct dln2_dev *dln2, u16 handle, u16 cmd,
>> +                       const void *obuf, unsigned obuf_len,
>> +                       void *ibuf, unsigned *ibuf_len)
>> +{
>> +     int ret = 0;
>> +     u16 result;
>> +     int rx_slot;
>> +     unsigned long flags;
>> +     struct dln2_response *rsp;
>> +     struct dln2_rx_context *rxc;
>> +     struct device *dev;
>> +     const int timeout = DLN2_USB_TIMEOUT * HZ / 1000;
>> +     struct dln2_mod_rx_slots *rxs = &dln2->mod_rx_slots[handle];
>> +
>
> Check the disconnected flag before incrementing the transfer count
> (while holding the device lock) here. Then decrement counter before
> returning and wake up an waiters if disconnected below.
>
> That is sufficient to implement wait-until-io-has-completed. Anything
> else you do below and in the helper functions is only to speed things
> up at disconnect (and can be done without locking the device).
>
>> +     rx_slot = alloc_rx_slot(rxs);
>> +     if (rx_slot < 0)
>> +             return rx_slot;
>> +
>> +     dev = &dln2->interface->dev;
>> +
>> +     ret = dln2_send_wait(dln2, handle, cmd, rx_slot, obuf, obuf_len);
>> +     if (ret < 0) {
>> +             free_rx_slot(dln2, rxs, rx_slot);
>
> goto out_free_rx_slot
>
>> +             dev_err(dev, "USB write failed: %d", ret);
>> +             return ret;
>> +     }
>> +
>> +     rxc = &rxs->slots[rx_slot];
>> +
>> +     ret = wait_for_completion_interruptible_timeout(&rxc->done, timeout);
>> +     if (ret <= 0) {
>> +             if (!ret)
>> +                     ret = -ETIMEDOUT;
>> +             goto out_free_rx_slot;
>> +     }
>> +
>> +     spin_lock_irqsave(&rxs->lock, flags);
>> +
>> +     if (!rxc->urb) {
>
> Just check the disconnected flag directly here. Locking not needed (see
> below).
>

I think we need the check here for the case when we cancel the
completion and no response has been received yet. In that case rx->urb
will be NULL (even if we remove the rx->urb = NULL statement in
dln2_stop).

>> +             ret = -ECONNRESET;
>
> -ENODEV

OK.

>
>> +             spin_unlock_irqrestore(&rxs->lock, flags);
>> +             goto out_free_rx_slot;
>> +     }
>> +
>> +     /* if we got here we know that the response header has been checked */
>> +     rsp = rxc->urb->transfer_buffer;
>> +
>> +     spin_unlock_irqrestore(&rxs->lock, flags);
>> +
>> +
>> +static void dln2_stop(struct dln2_dev *dln2)
>> +{
>> +     int i, j;
>> +
>> +     for (i = 0; i < DLN2_HANDLES; i++) {
>> +             struct dln2_mod_rx_slots *rxs = &dln2->mod_rx_slots[i];
>> +             unsigned long flags;
>> +
>> +             spin_lock_irqsave(&rxs->lock, flags);
>> +
>> +             /* fail further alloc_rx_slot calls */
>> +             rxs->disconnected = true;
>> +
>> +             /* cancel all response waiters */
>> +             for (j = 0; j < DLN2_MAX_RX_SLOTS; j++) {
>> +                     struct dln2_rx_context *rxc = &rxs->slots[j];
>> +
>> +                     if (rxc->connected) {
>> +                             rxc->urb = NULL;
>
> Don't overload the meaning of urb. Check the disconnected flag were
> needed.
>
> Also what would prevent a racing completion handler from setting
> rxc->urb again when you release the lock below?
>

That should not be an issue, in that case _dln2_transfer will complete
successfully. But you are right, we don't need to set rxc->urb to NULL
here.

>> +                             complete(&rxc->done);
>> +                     }
>> +             }
>> +             spin_unlock_irqrestore(&rxs->lock, flags);
>> +
>> +             /* wait for callers to release all rx_slots */
>> +             wait_event(rxs->wq, dln2_all_rx_slots_free(rxs));
>> +     }
>> +}
>> +
>> +static void dln2_disconnect(struct usb_interface *interface)
>> +{
>> +     struct dln2_dev *dln2 = usb_get_intfdata(interface);
>> +
>
> First set the disconnected flag directly here to prevent any new
> transfers from starting.
>
>> +     dln2_stop(dln2);
>
> Then do all the completions (to speed things up somewhat).
>
> Then wait for the transfer counter to reach 0.
>
>> +     mfd_remove_devices(&interface->dev);
>> +     dln2_free(dln2);
>> +}
>> +

As I mentioned above, I don't think we need the transfer counter, we
can rely on the slots bitmap. Yes, a counter is simpler but it also
requires adding a new waiting queue and a new lock.

<snip>

>> +     ret = dln2_hw_init(dln2);
>> +     if (ret < 0) {
>> +             dev_err(dev, "failed to initialize hardware\n");
>> +             goto out_cleanup;
>> +     }
>> +
>> +     ret = mfd_add_devices(dev, -1, dln2_devs, ARRAY_SIZE(dln2_devs),
>
> Use
>         busnum << 8 | devnum
>
> as id for now (as mentioned earlier).
>

Right, forgot about this, sorry.
