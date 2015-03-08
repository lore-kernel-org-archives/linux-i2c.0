From: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c_imc: New driver for Intel's iMC, found on LGA2011 chips
Date: Sun, 8 Mar 2015 12:30:34 -0700
Message-ID: <CALCETrUYwvF6cbmGy4zU-HNYe7xamw61+7nuryN0KaRdS7i24A@mail.gmail.com>
References: <cover.1425695891.git.luto@amacapital.net> <13443f0542fb447a4c0e558a5f6077c6a76a6e95.1425695891.git.luto@amacapital.net>
 <54FB0D7D.8060402@roeck-us.net> <CALCETrUwwhFS5H+dwpOyxqnr24pSmZt460i-CwUb0bt=VCOfMw@mail.gmail.com>
 <54FC6D2B.3060307@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54FC6D2B.3060307-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Boaz Harrosh <boaz-/8YdC2HfS5554TAoqtyWWQ@public.gmane.org>, One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Rui Wang <ruiv.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alun Evans <alun-eX+YDEU5biwsV2N9l4h3zg@public.gmane.org>, Robert Elliott <Elliott-VXdhtT5mjnY@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, Mar 8, 2015 at 8:39 AM, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org> wrote:
> On 03/08/2015 07:03 AM, Andy Lutomirski wrote:
>>
>> On Mar 7, 2015 6:39 AM, "Guenter Roeck" <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org> wrote:
>>>
>>>
>>> On 03/06/2015 06:50 PM, Andy Lutomirski wrote:
>>>>
>>>>
>>>> Sandy Bridge Xeon and Extreme chips have integrated memory
>>>> controllers with (rather limited) onboard SMBUS masters.  This
>>>> driver gives access to the bus.
>>>>
>>>> There are various groups working on standardizing a way to arbitrate
>>>> access to the bus between the OS, SMM firmware, a BMC, hardware
>>>> thermal control, etc.  In the mean time, running this driver is
>>>> unsafe except under special circumstances.  Nonetheless, this driver
>>>> has real users.
>>>>
>>>> As a compromise, the driver will refuse to load unless
>>>> i2c_imc.allow_unsafe_access=Y.  When safe access becomes available,
>>>> we can leave this option as a way for legacy users to run the
>>>> driver, and we'll allow the driver to load by default if safe bus
>>>> access is available.
>>>>
>>>> Signed-off-by: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
>>>> ---
>
> [ ... ]
>
>>>> +
>>>> +       if (imc_wait_not_busy(priv, chan, &stat) != 0) {
>>>> +               /* Timeout.  TODO: Reset the controller? */
>>>> +               ret = -EIO;
>>>
>>>
>>>
>>> timeout -> -ETIMEDOUT ?
>>
>>
>> OK
>>
> Actually, I just realized that imc_wait_not_busy returns a valid error code.
> Given that, some static analysis checkers (and now me) will ask you
> why you don't just use the error code from imc_wait_not_busy.
> This applies to other calls to the same function as well.

I changed it the other way.  One if the imc_wait_not_busy callers is
trying to get access to the bus in the first place.  If that fails,
then I think that -EBUSY is appropriate -- we're failing because the
thing is in use, not because our transaction timed out.  If the other
caller of imc_wait_not_busy fails, then our transaction timed out.  So
I'll make imc_wait_not_busy return bool.  This ends up simplifying the
code a bit, too.

>
>>>
>>>
>>>> +               dev_err(&priv->pci_dev->dev, "controller is wedged\n");
>>>
>>>
>>>
>>> If this happens, it will presumably happen all the time and the message
>>> will
>>> pollute the log. Is the message really necessary ?
>>
>>
>> I'd rather log something to help diagnose.  Would rate-limiting it be
>> okay?
>>
> It would still pollute the log because it doesn't happen that often.
> A message once a second still fills the log.
>
> If it is for diagnose/debugging, why not dev_dbg ?
>

OK.  I demoted some other log lines, too.

>>>
>>>
>>>> +               goto out_release;
>>>> +       }
>>>> +
>>>> +       /*
>>>> +        * Be paranoid: try to detect races.  This will only detect
>>>> races
>>>> +        * against BIOS, not against hardware.  (I've never seen this
>>>> happen.)
>>>> +        */
>>>> +       pci_read_config_dword(priv->pci_dev, SMBCMD(chan), &final_cmd);
>>>> +       pci_read_config_dword(priv->pci_dev, SMBCNTL(chan),
>>>> &final_cntl);
>>>> +       if (((cmd ^ final_cmd) & SMBCMD_OUR_BITS) ||
>>>> +           ((cntl ^ final_cntl) & SMBCNTL_OUR_BITS)) {
>>>> +               WARN(1, "iMC SMBUS raced against firmware");
>>>> +               dev_emerg(&priv->pci_dev->dev,
>>>
>>>
>>>
>>> Is a stack trace and dev_emerg really warranted here ?
>>>
>>
>> If this happens, something's very wrong and the user should stop using
>> the driver.  We could potentially write the wrong address, and, if we
>> manage to screw up thermal management, we could potentially corrupt
>> data for to an inappropriate refresh interval.
>>
>> IOW, I want to hear about it if this happens.
>>
> Ok, that explains the WARN. Still not an "emergency", though.
>

It's dev_err now.

> Coding style suggests
>
>         if (!(stat & SMBSTAT_RDO)) {
>                 dev_err();
>                 ret - -EIO;
>                 goto out_release;
>         }
>
> and
>
>         if (!(stat & SMBSTAT_WOD)) {
>                 dev_err();
>                 ret = -EIO;
>                 goto out_release;
>         }

Done.  dev_dbg, too -- I think that either all of these errors should
be dev_dbg or none should be.

> On a side note, I am a bit confused about the note "same bug as in the read
> case".
> Do you want to say that RDO is sometimes/often set in the write case ?
> If so, it might make more sense to just say it.

Yes, fixed.

>
> [ ... ]
>
>>>> +static void imc_free_channel(struct imc_priv *priv, int i)
>>>> +{
>>>> +       struct imc_channel *ch = &priv->channels[i];
>>>> +
>>>> +       /* This can recurse into imc_smbus_xfer. */
>>>
>>>
>>>
>>> So ?
>>
>>
>> It needs to happen before mutex_destroy.  I improved the comment.
>>
> Seems to me obvious that a mutex would be destroyed last in cleanup.
>

It wasn't to me.  I'll remove the comment.


>> I want to be ready for future hardware that might support more than
>> two channels.
>>
> Not my call to make, but I am a bit wary of future hardware support which
> may
> never materialize. I prefer writing code liks this for the current use case.
> The time to optimize the code for the future hardware is if and when the
> future
> hardware materializes.
>
> In general, I am also in favor of the guidance in the coding style document,
> which suggests to have a single error exit and handle any necessary cleanup
> there.
> In this case, it could be
>
>                 if (err)
>                         goto exit_cleanup;
> ...
> exit_cleanup:
>         for (i--; i >= 0; i--)
>                 imc_free_channel(priv, i);
> exit_free:
>
> ...

Fair enough.  I did this.

>
>>>> +       }
>>>> +
>>>> +       pr_warn("using this driver is dangerous unless your firmware is
>>>> specifically designed for it; use at your own risk\n");
>>>
>>>
>>>
>>> Seems to me this is a bit noisy. User should already know.
>>
>>
>> I think I'm willing to mildly annoy the smallish number of legitimate
>> allow_unsafe_access users to help scare away all the people who like
>> shiny decode-dimms toys and enable this because some forum told them
>> to.  I could be convinced otherwise, though.
>>
> Not my call to make ... you'll have to convince the maintainer.
>
> Anyway, I wonder if it would make sense to use
> acpi_check_resource_conflict()
> to check if there is a resource conflict with the BIOS instead of all these
> warnings, and if that would answer the concerns about unsynchronized access.
> From looking into the datasheet, I don't really see the difference to the
> i2c-i801 driver and other drivers where chip access might conflict with
> BIOS / ACPI access. I may have missed some discussion, though, so maybe that
> has been discussed already and doesn't work in this case.

I don't think that BIOS will ever claim these resources.  It'll just
use them :(  Also, I don't think we can do this anyway -- the resource
we're accessing is a range of PCI configuration registers, not a BAR,
and I don't think that the resource system supports that.

In i2c-i801, I think that these issues are mostly mitigated by ACPI
code using OpRegions.

>
>> One other question: from my reading of the spec, it should be possible to
>> augment this driver to expose a temporate sensor subdevice that shows
>> recent cached temperatures from HW DIMM measurements.  They would be
>> redundant with the jc42 outputs, but it would be safe to use them even on
>> systems without safe SMBUS arbitration.  Should I do that as a followup
>> later on?
>>
>
> Without thinking too much about it, this should be a separate driver,
> and I think it might actually be more valuable (since less risky)
> than this entire patch set.

The main problem there is that they'll fight over the PCI ids.

--Andy
