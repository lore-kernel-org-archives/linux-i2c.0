From: Chris Metcalf <cmetcalf-kv+TWInifGbQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] drivers/i2c: add support for tile architecture "bus"
 for I2C devices
Date: Tue, 2 Nov 2010 17:04:33 -0400
Message-ID: <4CD07CE1.7050002@tilera.com>
References: <201011021712.oA2HCsMe028141@farm-0010.internal.tilera.com> <20101102173622.GA10830@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101102173622.GA10830-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 11/2/2010 1:36 PM, Ben Dooks wrote:
> On Tue, Nov 02, 2010 at 01:05:34PM -0400, Chris Metcalf wrote:
>> This change enables the Linux driver to access i2c devices via
>> the Tilera hypervisor's virtualized API.

Ben, thanks for your detailed review of the code!

>> Note that the arch/tile/include/hv/ headers are "upstream" headers
>> that likely benefit less from LKML review.

As you may have seen in my reply to Randy, the "hv/" headers are from our
"upstream", so while I'm happy to improve on them in some ways, I'm
unlikely to make wholesale stylistic changes.  See the other files in
arch/tile/include/hv/ for the stylistic similarity of the new
drv_i2cm_intf.h header.  But let me reply to your specific concerns.

>> +typedef struct
>> +{
>> +  uint32_t addr:8;               /**< I2C device slave address */
>> +  uint32_t data_offset:24;       /**< I2C device data offset */
>> +}
>> +tile_i2c_addr_desc_t;
> You'll be better off just having this as a uint32 and assembling it
> in code, gcc isn't guaranteed to pack these as you'd think it should.
>
> Go for something like
>
> ADDR_DESC(addr, data) (((data) << 8) | (addr))

We have a lot of use of bitfields in our low-level architecture headers
(that describe things like SPR bitfields, I/O memory accesses for TILE-Gx,
etc.), so it's actually a good fit stylistically for the hypervisor code,
which is close to the hardware.  Since we wrote the tile gcc backend, and
will likely be maintaining it for a good long while to come, we are pretty
confident that gcc will pack things the way we intend.  (And the i2c-tile
code isn't relevant to any other architecture than tile, of course.)

That said... that cast is pretty heinous.  We have another idiom that we
use frequently in the hypervisor layer, and should use here as well:

union
{
  struct
  {
    uint32_t addr:8;               /**< I2C device slave address */
    uint32_t data_offset:24;       /**< I2C device data offset */
  };
  uint32_t word;                   /**< To pass to the hypervisor */
}


This allows you to manipulate the fields as we do now, and then just pass
"hv_offset.word" to the hypervisor.

> could you could even ignore the offset and just increment the buffer
> pointer?

Is that guaranteed to work in all cases?  I would think you'd want the
hv_offset offset to match the buffer offset.

> really, is HV_VirtAddr not compatible with 'void *'?

We've had conversations about this internally (and even have a bugzilla
filed internally).  The type is "uint32_t" for TILEPro ("uint64_t" for
TILE-Gx).  The original concern was that we wanted to be able to use types
like this not just natively, but also when doing various kind of
cross-compilation work.  In particular, if hardware structures hold virtual
addresses, we don't want to use "void *" when it may be a 32-bit tile chip
being simulated by 64-bit simulator userspace, etc.  In addition, we use
this type in the hypervisor, where it connotes a "client" (i.e. Linux)
address that shouldn't be directly dereferenced, much like Linux "__user". 
However, I've argued that function declarations for hypervisor calls as
seen by Linux might as well be "void *", and we just haven't yet made time
to do this.  When we do, we'll come through and bomb these uses away.

>> +             if (hv_retval < 0) {
>> +                     pr_err(DRV_NAME ": %s failed, error %d\n",
>> +                             (pmsg->flags & I2C_M_RD) ? "hv_dev_pread" :
>> +                             "hv_dev_pwrite", hv_retval);
>> +                     if (hv_retval == HV_ENODEV)
>> +                             retval = -ENODEV;
>> +                     else
>> +                             retval = -EIO;
>> +                     break;
> see (a) comments about retval conversion

Which comment was that?  I don't see it in this email.

> and (b), can you really lose a device in the middle of a transfer?

Probably not.  I think the intent was just to capture all possible return
values from the hypervisor.

> note, what happens if you run i2c-detect, do you get lots of console output?

I'll try that.  Obviously it would be annoying if we did. :-)

>> +     for (i = 0; i < num; i++) {
>> +             if (pmsg->len && pmsg->buf) {
> pmsg->len == 0 would still mean sending an address to the other end and
> getting an ack from it.

Do you mean we should force a zero-length read or write operation in this case?

>> +     /* Open the HV i2cm device. */
>> +     i2cm_hv_devhdl = hv_dev_open((HV_VirtAddr)i2cm_device, 0);
> yeurk, why not either have it sa a HV_VirtAddr in the first place or
> make the api take a 'char *' instead.

See above.   (The actual i2cm_device is a char array, so it can't be
anything but a pointer type here.)

>> +     if (i2cm_hv_devhdl < 0) {
>> +             switch (i2cm_hv_devhdl) {
>> +             case HV_ENODEV:
>> +                     return -ENODEV;
> returning -ENODEV means there's no device here, not that something went
> wrong when we knew a device was meant to be here. You'll lose the error
> in the upper layer.

The failure mode here is not that an I2C device is missing, but that the
hypervisor is not configured with support for its i2cm driver.  In fact
HV_ENODEV ("no i2cm driver configured in hypervisor") merits a printk()
here, and in practice no other error will be returned.  I'll fix this area
of code, and just return -EINVAL if things aren't good, which is more normal.

>> +     tile_i2c_desc = kzalloc(i2c_desc_size, GFP_KERNEL);
>> +     if (!tile_i2c_desc)
>> +             return -ENOMEM;
> no error print here?

If kmalloc() and friends return NULL, you'll get a kernel message about it
anyway (unless you set GFP_NOWARN).  The slab allocator will always try to
get memory from the page allocator, which will report "page allocation
failure" and dump a backtrace.

> +     ret = i2c_register_board_info(0, tile_i2c_devices, i2c_devs);
> are you sure you're registered as bus 0? what happens if there's >1 bus?

I think our hardware doesn't support that, but I'll check.

>> +     adapter->nr = dev->id != -1 ? dev->id : 0;
>> +     snprintf(adapter->name, sizeof(adapter->name), "tile_i2c-i2c.%u",
>> +              adapter->nr);
> you could just use the dev_name() of the platform device here.

Just to be clear, you mean something like this?

        snprintf(adapter->name, sizeof(adapter->name), "%s.%u",
                 dev_name(&dev->dev), adapter->nr);


Thanks again.  If I didn't reply to one of your comments, I just made the
change as suggested.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
