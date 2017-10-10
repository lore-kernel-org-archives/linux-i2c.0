From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: piix4: Disable completely the IMC during
 SMBUS_BLOCK_DATA
Date: Tue, 10 Oct 2017 11:01:07 +0200
Message-ID: <20171010110107.010b7dd2@endymion>
References: <20170921073743.3052-1-ricardo.ribalda@gmail.com>
        <20171005162217.025f9339@endymion>
        <CAPybu_3gLtW2n_Acy2ufZp3Gwsf-iQUfNRze0=Dogo5au=8s0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPybu_3gLtW2n_Acy2ufZp3Gwsf-iQUfNRze0=Dogo5au=8s0w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Ricardo,

On Thu, 5 Oct 2017 16:53:28 +0200, Ricardo Ribalda Delgado wrote:
> On Thu, Oct 5, 2017 at 4:22 PM, Jean Delvare <jdelvare@suse.de> wrote:
> > Unfortunately I no longer have any system with a compatible chipset so
> > I can't test.  
> 
> If you have some specific test to run, I can test it on my hardware.

Nothing specific, if I still had some compatible hardware I'd run the
code on it just to make sure we did not introduce a regression.

> >> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> >> ---
> >>  drivers/i2c/busses/i2c-piix4.c | 89 ++++++++++++++++++++++++++++++++++++++----
> >>  1 file changed, 82 insertions(+), 7 deletions(-)  
> >
> > First of all: your patch adds the following 2 warnings which you will
> > have to fix before acceptance:
> >
> >   CC [M]  drivers/i2c/busses/i2c-piix4.o
> > drivers/i2c/busses/i2c-piix4.c:591:5: warning: no previous prototype for ‘piix4_imc_sleep’ [-Wmissing-prototypes]
> >  int piix4_imc_sleep(void)
> >      ^
> > drivers/i2c/busses/i2c-piix4.c:608:6: warning: no previous prototype for ‘piix4_imc_wakeup’ [-Wmissing-prototypes]
> >  void piix4_imc_wakeup(void)  
> 
> Sorry about that, my gcc is more stupid that your gcc it seems :),

I'm building with W=1, maybe that's the difference.

> Will fix and resend, probably rebased on the last patch that you have
> acked.

That would be perfect.

> >> +}
> >> +
> >>  /*
> >>   * Handles access to multiple SMBus ports on the SB800.
> >>   * The port is selected by bits 2:1 of the smb_en register (0x2c).
> >> @@ -586,7 +634,7 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
> >>  {
> >>       struct i2c_piix4_adapdata *adapdata = i2c_get_adapdata(adap);
> >>       unsigned short piix4_smba = adapdata->smba;
> >> -     int retries = MAX_TIMEOUT;
> >> +     int retries = adapdata->notify_imc ? MAX_TIMEOUT * 2 : MAX_TIMEOUT;  
> >
> > What's the rationale for this change?  
> 
> Taken from AMD patch.

That's an explanation, not a rationale ;-) I can't see what sense it
makes. The timeout period is already re-used in piix4_imc_sleep() and
piix4_imc_wakeup(), so the extra time needed to toggle the IMC is
already accounted for. There's no reason why the transaction itself
would take twice as long to complete. Please double check with AMD.

> >> (...)
> >> @@ -778,6 +841,18 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
> >>                       return -EBUSY;
> >>               }
> >>
> >> +             if (dev->vendor == PCI_VENDOR_ID_AMD &&
> >> +                 dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) {
> >> +                     if (!devm_request_region(&dev->dev, IMC_SMB_IDX, 2,
> >> +                                              "kerncz_imc_idx")) {
> >> +                             dev_warn(&dev->dev,
> >> +                                     "IMC base address index region 0x%x already in use!\n",
> >> +                                     SB800_PIIX4_SMB_IDX);  
> >
> > How is the IMC related with the SMBus? I'm surprised that you touch the
> > IMC right from the SMBus driver like that. I'd expect other device
> > drivers to potentially have similar needs, which would require sharing
> > the region and proper locking.  
> 
> The imc monitors the fans and temperature via SMBUS, this is why we
> need to tisable it.
> 
> Maybe I could use request_muxed_region(),every time that I interact
> with the IMC, that way other drivers could also share it?

If the only piece of hardware the IMC interacts with is the SMBus, then
having that code in the i2c-piix4 driver is fine. However this pointer
you provided above is about SPI, not I2C/SMBus. So I take it that the
chipset (or CPU itself?) also supports SPI, and if we ever have a
driver for that feature, then both drivers will need to access the same
I/O registers, and the second one requesting the region will lose. We
already have this problem with the watchdog driver, I don't want to
make the same mistake again.

(BTW, in the code you pointed me to, they have comments to explain the
magic numbers they write to the IMC. Sounds like a good idea, you could
do that too.)

I'm not familiar with the muxed region API, and can't find
documentation about it either. Do I understand right that the idea is
to request and release the region every time you need to access it? If
so, it seems OK as long as SMBus Block transactions are not too
frequent and not time critical.

The other option I can think of is to have a dedicated driver for the
IMC, which would request the region, and implement and export
piix4_imc_sleep() and piix4_imc_wakeup(), as well as request and
release functions, and i2c-piix4 would simply call these functions.
It's a bit more work and complexity, but also avoids duplicating the
code in any other driver that would need to touch the IMC at some
later time. Not sure if it would be faster though, as you still need to
request and release explicitly to avoid racing with any other driver.

I do not have a strong opinion between these 2 options, so I'll let you
implement the one you prefer.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
