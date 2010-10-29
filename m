From: "Matti J. Aaltonen" <matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 0/1] PN544 NFC driver.
Date: Fri, 29 Oct 2010 09:26:08 +0300
Message-ID: <1288333569-19979-1-git-send-email-matti.j.aaltonen@nokia.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: "Matti J. Aaltonen" <matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello.

And thanks to Andrew for the comments.

>> include/linux/pn544.h |   99 ++++++
> 
> Is drivers/misc/ the best place for this?
> 
> Don't be afraid to create a new drivers/nfc/ even if it has only one
> driver in it.  If someone later comes in and adds a new NFC driver then
> things will all fall into place.

OK. Now I've created directories drivers/nfc, include/linux/nfc and Documentation/nfc.

>> +      Say yes if you want PN544 Near Field Communication driver.
> 
> OK, I did google it ;)  Interesting.

I agree... ;-)

>> +     pr_info("\n");
> 
> You might be able to use print_hex_dump() here, but I wouldn't blame
> you if you didn't ;)

I replaced the debug function with calls to print_hex_dump.


>> +/* sysfs interface */
> 
> OK, this is more serious.
> 
> You're proposing a permanent addition to the kernel ABI.  This is the
> most important part of the driver because it is something we can never
> change.  This interface is the very first thing we'll want to
> understand and review, before we even look at the implementation.
> 
> And it isn't even described!  Not in the changelog, not in a
> documentation file, not even in code comments.
> 
> Please, provide a description of this proposed interface.  Sufficient
> for reviewers to understand it and for users to use it.  Pobably this
> will require some description of the hardware functions as well.
> 
> Please also consider updating Documentation/ABI/

I've added a documentation file. But I didn't make changes to the interface
yet.

>> +                                            GFP_KERNEL);
> 
> From my reading, later code will crash the kernel if this allocation failed.
> 
> Also, is there a race here between reading info->fw_buf and setting it?
> Can two CPUs get into thei function at the same time?  If so, there
> should be locking.  Say, a mutex local to this function.

I moved the data buffer allocation to probe and also changed the locking.

>> +             return -EBADMSG;
> 
> EBADMSG is a unix streams errno.  It's quite inappropriate that a
> device driver be using it.  Imagine the poor user's confution if he
> sees this message pop up on his screen.

Changed to EINVAL.

>> +     if (r == -EREMOTEIO) { /* Retry, chip was in standby */
> 
> And what on earth is EREMOTEIO?  Is it appropriate for use in a driver?

I think it is, because it comes from i2c_master_send and it's kind of
just forwarded here.

>> +             return -EOVERFLOW;
> 
> EOVERFLOW refers to a floating point overflow!

It's used for buffer overflow in many places in the kernel, but that's
not an excuse so I removed it.

>> +             return -ENOSPC;
> 
> Disk full!

Also removed...

>> +     mutex_unlock(&info->read_mutex);
> 
> It usually doesn't make much sense to add locking around a single
> atomic read instruction.

Yes, but if there's a sequence of instructions somewhere else in the
code that the single instruction is not allowd to intersect then it
can be valid.

>> +                       size_t count, loff_t *offset)
> 
> Again, I really cannot review this code when I haven't been told what
> it's reading from, what's in the payload, what it is all to be used
> for, etc.  It's just C code to me.
> 

I've added a documentation file to explain things but basically the
driver doesn't much care about the data it passes through, apart from
message lengths and check sums.

>> +             len = min(count, (size_t) PN544_MAX_I2C_TRANSFER);
> 
> min_t() is the preferred way of solving this.

Good to know, but because of a code change it wasn't necessary.

> +}
> 
> So it can poll() somethnig as well!  This driver *really* needs
> documentation!
> 

Yes, you can wait for something to read.

>> +     if (info->state == PN544_ST_FW_READY) {
> 
> Is some locking needed here?  What prevents info->state from
> transitioning while this code is executing?

Locking added.

>> +static long pn544_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> 
> And an ioctl interface as well!  An undocmented one.
> 
> ioctls are pretty unpopular for various reasons.  To a large extent,
> people have been using sysfs interfaces as a repalcement for ioctl()s.
> But this driver has both!

Some explanatory text written into the documentation file.
 
> Does this code need compat handling, or it is 32/64-bit clean?

I think it is...

>> +                     pn544_disable(info);
> 
> bug.  pn544_disable() calls msleep(), but msleep() is very illegal
> under spin_lock_irqsave().  This tells me that this code hasn't been
> tested with even rudimentary kernel rimtime debugging options enabled.
> Documentation/SubmitChecklist section 12 is fairly up-to-date here.

Removed spinlocks and in general revised the locking...

>> +                     pn544_disable(info);
> 
> Many more such bugs there.

Well, yes...

>> +#ifdef DO_RSET_TEST
> 
> I'd suggest enabling this via a module parameter if it's at all useful.
> Otherwise it should be enabled with a Kconfig variable, not via a code
> edit.

Removed the test...

>> +     flush_scheduled_work();
> 
> This seems unneeded?  We're trying to get rid of flush_scheduled_work(), btw.

Removed flush_scheduled_work...

Cheers,
Matti

Matti J. Aaltonen (1):
  NFC: Driver for NXP Semiconductors PN544 NFC chip.

 Documentation/nfc/nfc-pn544.txt |  105 +++++
 drivers/Kconfig                 |    2 +
 drivers/Makefile                |    2 +-
 drivers/nfc/Kconfig             |   30 ++
 drivers/nfc/Makefile            |    5 +
 drivers/nfc/pn544.c             |  893 +++++++++++++++++++++++++++++++++++++++
 include/linux/nfc/pn544.h       |   99 +++++
 7 files changed, 1135 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/nfc/nfc-pn544.txt
 create mode 100644 drivers/nfc/Kconfig
 create mode 100644 drivers/nfc/Makefile
 create mode 100644 drivers/nfc/pn544.c
 create mode 100644 include/linux/nfc/pn544.h
