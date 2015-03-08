From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] i2c_imc: New driver for Intel's iMC, found on LGA2011
 chips
Date: Sun, 08 Mar 2015 08:39:23 -0700
Message-ID: <54FC6D2B.3060307@roeck-us.net>
References: <cover.1425695891.git.luto@amacapital.net> <13443f0542fb447a4c0e558a5f6077c6a76a6e95.1425695891.git.luto@amacapital.net> <54FB0D7D.8060402@roeck-us.net> <CALCETrUwwhFS5H+dwpOyxqnr24pSmZt460i-CwUb0bt=VCOfMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALCETrUwwhFS5H+dwpOyxqnr24pSmZt460i-CwUb0bt=VCOfMw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Jean Delvare <khali@linux-fr.org>, Boaz Harrosh <boaz@plexistor.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Rui Wang <ruiv.wang@gmail.com>, Alun Evans <alun@badgerous.net>, Robert Elliott <Elliott@hp.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mauro Carvalho Chehab <m.chehab@samsung.com>, Tony Luck <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 03/08/2015 07:03 AM, Andy Lutomirski wrote:
> On Mar 7, 2015 6:39 AM, "Guenter Roeck" <linux@roeck-us.net> wrote:
>>
>> On 03/06/2015 06:50 PM, Andy Lutomirski wrote:
>>>
>>> Sandy Bridge Xeon and Extreme chips have integrated memory
>>> controllers with (rather limited) onboard SMBUS masters.  This
>>> driver gives access to the bus.
>>>
>>> There are various groups working on standardizing a way to arbitrate
>>> access to the bus between the OS, SMM firmware, a BMC, hardware
>>> thermal control, etc.  In the mean time, running this driver is
>>> unsafe except under special circumstances.  Nonetheless, this driver
>>> has real users.
>>>
>>> As a compromise, the driver will refuse to load unless
>>> i2c_imc.allow_unsafe_access=Y.  When safe access becomes available,
>>> we can leave this option as a way for legacy users to run the
>>> driver, and we'll allow the driver to load by default if safe bus
>>> access is available.
>>>
>>> Signed-off-by: Andy Lutomirski <luto@amacapital.net>
>>> ---
[ ... ]

>>> +
>>> +       if (imc_wait_not_busy(priv, chan, &stat) != 0) {
>>> +               /* Timeout.  TODO: Reset the controller? */
>>> +               ret = -EIO;
>>
>>
>> timeout -> -ETIMEDOUT ?
>
> OK
>
Actually, I just realized that imc_wait_not_busy returns a valid error code.
Given that, some static analysis checkers (and now me) will ask you
why you don't just use the error code from imc_wait_not_busy.
This applies to other calls to the same function as well.

>>
>>
>>> +               dev_err(&priv->pci_dev->dev, "controller is wedged\n");
>>
>>
>> If this happens, it will presumably happen all the time and the message will
>> pollute the log. Is the message really necessary ?
>
> I'd rather log something to help diagnose.  Would rate-limiting it be okay?
>
It would still pollute the log because it doesn't happen that often.
A message once a second still fills the log.

If it is for diagnose/debugging, why not dev_dbg ?

>>
>>
>>> +               goto out_release;
>>> +       }
>>> +
>>> +       /*
>>> +        * Be paranoid: try to detect races.  This will only detect races
>>> +        * against BIOS, not against hardware.  (I've never seen this happen.)
>>> +        */
>>> +       pci_read_config_dword(priv->pci_dev, SMBCMD(chan), &final_cmd);
>>> +       pci_read_config_dword(priv->pci_dev, SMBCNTL(chan), &final_cntl);
>>> +       if (((cmd ^ final_cmd) & SMBCMD_OUR_BITS) ||
>>> +           ((cntl ^ final_cntl) & SMBCNTL_OUR_BITS)) {
>>> +               WARN(1, "iMC SMBUS raced against firmware");
>>> +               dev_emerg(&priv->pci_dev->dev,
>>
>>
>> Is a stack trace and dev_emerg really warranted here ?
>>
>
> If this happens, something's very wrong and the user should stop using
> the driver.  We could potentially write the wrong address, and, if we
> manage to screw up thermal management, we could potentially corrupt
> data for to an inappropriate refresh interval.
>
> IOW, I want to hear about it if this happens.
>
Ok, that explains the WARN. Still not an "emergency", though.

>>
>>> +                         "Access to channel %d raced: cmd 0x%08X->0x%08X, cntl 0x%08X->0x%08X\n",
>>> +                         chan, cmd, final_cmd, cntl, final_cntl);
>>> +               atomic_set(&imc_raced, 1);
>>> +               ret = -EIO;
>>> +               goto out_release;
>>> +       }
>>> +
>>> +       if (stat & SMBSTAT_SBE) {
>>> +               /*
>>> +                * Clear the error to re-enable TSOD polling.  The docs say
>>> +                * that, as long as SBE is set, TSOD polling won't happen.
>>> +                * The docs also say that writing zero to this bit (which is
>>> +                * the only writable bit in the whole register) will clear
>>> +                * the error.  Empirically, writing 0 does not clear SBE, but
>>> +                * it's probably still good to do the write in compliance with
>>> +                * the spec.  (TSOD polling still happens and seems to
>>> +                * clear SBE on its own.)
>>> +                */
>>> +               pci_write_config_dword(priv->pci_dev, SMBSTAT(chan), 0);
>>> +               ret = -ENXIO;
>>> +               goto out_release;
>>> +       }
>>> +
>>> +       if (read_write == I2C_SMBUS_READ) {
>>> +               if (stat & SMBSTAT_RDO) {
>>> +                       /*
>>> +                        * The iMC SMBUS controller thinks of SMBUS
>>> +                        * words as being big-endian (MSB first).
>>> +                        * Linux treats them as little-endian, so we need
>>> +                        * to swap them.
>>> +                        *
>>> +                        * Note: the controller will often (always?) set
>>> +                        * WOD here.  This is probably a bug.
>>> +                        */
>>> +                       if (size == I2C_SMBUS_WORD_DATA)
>>> +                               data->word = swab16(stat & SMBSTAT_RDATA_MASK);
>>> +                       else
>>> +                               data->byte = stat & 0xFF;
>>> +                       ret = 0;
>>
>>
>> ret is already guaranteed to be 0 here.
>>
>>
>>> +               } else {
>>> +                       dev_err(&priv->pci_dev->dev,
>>> +                               "Unexpected read status 0x%08X\n", stat);
>>> +                       ret = -EIO;
>>> +               }
>>> +       } else {
>>> +               if (stat & SMBSTAT_WOD) {
>>> +                       /* Same bug (?) as in the read case. */
>>> +                       ret = 0;
>>
>>
>> ret is already 0, so only the else case is really needed.
>>
>
> I wanted to keep the success and failure paths in the same order in
> both the read and write cases.  I'll remove the unnecessary
> assignment, though.
>
Coding style suggests

	if (!(stat & SMBSTAT_RDO)) {
		dev_err();
		ret - -EIO;
		goto out_release;
	}

and

	if (!(stat & SMBSTAT_WOD)) {
		dev_err();
		ret = -EIO;
		goto out_release;
	}

which would improve readability here a lot since it would reduce
indentation level by one.

On a side note, I am a bit confused about the note "same bug as in the read case".
Do you want to say that RDO is sometimes/often set in the write case ?
If so, it might make more sense to just say it.

[ ... ]

>>> +static void imc_free_channel(struct imc_priv *priv, int i)
>>> +{
>>> +       struct imc_channel *ch = &priv->channels[i];
>>> +
>>> +       /* This can recurse into imc_smbus_xfer. */
>>
>>
>> So ?
>
> It needs to happen before mutex_destroy.  I improved the comment.
>
Seems to me obvious that a mutex would be destroyed last in cleanup.

>>
>>
>>> +       i2c_del_adapter(&ch->adapter);
>>> +
>>> +       mutex_destroy(&ch->mutex);
>>> +}
>>> +
>>> +static struct pci_dev *imc_get_related_device(struct pci_bus *bus, unsigned int devfn, u16 devid)
>>> +{
>>> +       struct pci_dev *ret = pci_get_slot(bus, devfn);
>>
>>
>> ret is a bit unusual as variable name for a pointer. dev, maybe ?
>>
>>
>>> +       if (!ret)
>>> +               return NULL;
>>> +       if (ret->vendor != PCI_VENDOR_ID_INTEL || ret->device != devid) {
>>> +               pci_dev_put(ret);
>>> +               return NULL;
>>> +       }
>>> +       return ret;
>>> +}
>>> +
>>> +static int imc_probe(struct pci_dev *dev, const struct pci_device_id *id)
>>> +{
>>> +       int i, err;
>>> +       struct imc_priv *priv;
>>> +       struct pci_dev *sad;  /* System Address Decoder */
>>> +       u32 sad_control;
>>> +
>>> +       /* Paranoia: the datasheet says this is always at 15.0 */
>>> +       if (dev->devfn != PCI_DEVFN(15, 0))
>>> +               return -ENODEV;
>>> +
>>> +       /*
>>> +        * The socket number is hidden away on a different PCI device.
>>> +        * There's another copy at devfn 11.0 offset 0x40, and an even
>>> +        * less convincing copy at 5.0 0x140.  The actual APICID register
>>> +        * is "not used ... and is still implemented in hardware because
>>> +        * of FUD".
>>> +        *
>>> +        * In principle we could double-check that the socket matches
>>> +        * the numa_node from SRAT, but this is probably not worth it.
>>> +        */
>>> +       sad = imc_get_related_device(dev->bus, PCI_DEVFN(13, 6),
>>> +                                    PCI_DEVICE_ID_INTEL_SBRIDGE_BR);
>>> +       if (!sad)
>>> +               return -ENODEV;
>>> +       pci_read_config_dword(sad, SAD_CONTROL, &sad_control);
>>> +       pci_dev_put(sad);
>>> +
>>> +       priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>>
>>
>> devm_kzalloc() ?
>>
>
> Done.
>
>>
>>> +       if (!priv)
>>> +               return -ENOMEM;
>>> +       priv->pci_dev = dev;
>>> +
>>> +       pci_set_drvdata(dev, priv);
>>> +
>>> +       for (i = 0; i < 2; i++) {
>>> +               int j;
>>> +               err = imc_init_channel(priv, i, sad_control & 0x7);
>>> +               if (err) {
>>> +                       for (j = 0; j < i; j++)
>>
>>
>>                          if (i)
>>                                  imc_free_channel(priv, 0);
>>
>> would be a bit simpler and accomplish the same.
>
> I want to be ready for future hardware that might support more than
> two channels.
>
Not my call to make, but I am a bit wary of future hardware support which may
never materialize. I prefer writing code liks this for the current use case.
The time to optimize the code for the future hardware is if and when the future
hardware materializes.

In general, I am also in favor of the guidance in the coding style document,
which suggests to have a single error exit and handle any necessary cleanup there.
In this case, it could be

		if (err)
			goto exit_cleanup;
...
exit_cleanup:
	for (i--; i >= 0; i--)
		imc_free_channel(priv, i);
exit_free:

...

>>> +       }
>>> +
>>> +       pr_warn("using this driver is dangerous unless your firmware is specifically designed for it; use at your own risk\n");
>>
>>
>> Seems to me this is a bit noisy. User should already know.
>
> I think I'm willing to mildly annoy the smallish number of legitimate
> allow_unsafe_access users to help scare away all the people who like
> shiny decode-dimms toys and enable this because some forum told them
> to.  I could be convinced otherwise, though.
>
Not my call to make ... you'll have to convince the maintainer.

Anyway, I wonder if it would make sense to use acpi_check_resource_conflict()
to check if there is a resource conflict with the BIOS instead of all these
warnings, and if that would answer the concerns about unsynchronized access.
 From looking into the datasheet, I don't really see the difference to the
i2c-i801 driver and other drivers where chip access might conflict with
BIOS / ACPI access. I may have missed some discussion, though, so maybe that
has been discussed already and doesn't work in this case.

> One other question: from my reading of the spec, it should be possible to
> augment this driver to expose a temporate sensor subdevice that shows
> recent cached temperatures from HW DIMM measurements.  They would be
> redundant with the jc42 outputs, but it would be safe to use them even on
> systems without safe SMBUS arbitration.  Should I do that as a followup
> later on?
>

Without thinking too much about it, this should be a separate driver,
and I think it might actually be more valuable (since less risky)
than this entire patch set.

Thanks,
Guenter
