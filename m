From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH] i2c: piix4: Disable completely the IMC during SMBUS_BLOCK_DATA
Date: Thu, 5 Oct 2017 16:53:28 +0200
Message-ID: <CAPybu_3gLtW2n_Acy2ufZp3Gwsf-iQUfNRze0=Dogo5au=8s0w@mail.gmail.com>
References: <20170921073743.3052-1-ricardo.ribalda@gmail.com> <20171005162217.025f9339@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171005162217.025f9339@endymion>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean

Thanks for your review! Long story short, we experimented some
corrupted smbus transactions and even code locks on our Bettong board.
This errors did not happen when the IMC was disabled. We contacted AMD
about this, which could replicate the bug and came back with a fix
consisting in two parts, a change in the driver (similar to this, but
not mergeable), and an updated imc firmware.

I have already notified AMD for ACK or NACK this patch.

On Thu, Oct 5, 2017 at 4:22 PM, Jean Delvare <jdelvare@suse.de> wrote:
> Hi Ribalda,
>
> On Thu, 21 Sep 2017 09:37:43 +0200, Ricardo Ribalda Delgado wrote:
>> SMBUS_BLOCK_DATA transactions might fail due to a race condition with
>> the IMC, even when the IMC semaphore is used.
>
> An explanation of what IMC stands for, both in description and in the
> code, would be appreciated.
>
> What are the consequences of disabling the IMC temporarily at random
> times?

I am not aware of any terrible consecuence. The IMC is in charge of
monitoring the fan and temperature sensors through smbus. It looks
like for long transactions, like SMBUS_BLOCK_DATA, the IMC does not
play nice with the integrated hardware semaphore and we need to
complete disable the IMC.
Seems like this approach has been used before:
https://github.com/pcengines/sortbootorder/blob/master/spi.c#L237 We
are not that clever :)


>
>> This bug has been reported and confirmed by AMD, who suggested as a
>> solution an IMC firmware upgrade (obtained via BIOS update) and
>> disabling the IMC during SMBUS_BLOCK_DATA transactions.
>>
>> Even without the IMC upgrade, the smbus is much more stable with this
>> patch.
>>
>> Tested on a Bettong-alike board.
>
> Unfortunately I no longer have any system with a compatible chipset so
> I can't test.

If you have some specific test to run, I can test it on my hardware.


>
>> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
>> ---
>>  drivers/i2c/busses/i2c-piix4.c | 89 +++++++++++++++++++++++++++++++++++=
+++----
>>  1 file changed, 82 insertions(+), 7 deletions(-)
>
> First of all: your patch adds the following 2 warnings which you will
> have to fix before acceptance:
>
>   CC [M]  drivers/i2c/busses/i2c-piix4.o
> drivers/i2c/busses/i2c-piix4.c:591:5: warning: no previous prototype for =
=E2=80=98piix4_imc_sleep=E2=80=99 [-Wmissing-prototypes]
>  int piix4_imc_sleep(void)
>      ^
> drivers/i2c/busses/i2c-piix4.c:608:6: warning: no previous prototype for =
=E2=80=98piix4_imc_wakeup=E2=80=99 [-Wmissing-prototypes]
>  void piix4_imc_wakeup(void)

Sorry about that, my gcc is more stupid that your gcc it seems :),
Will fix and resend, probably rebased on the last patch that you have
acked.

>       ^
>
> As far as I can see these functions should be static.
>
>> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-pii=
x4.c
>> index 0ecdb47a23ab..3b8a5eaad956 100644
>> --- a/drivers/i2c/busses/i2c-piix4.c
>> +++ b/drivers/i2c/busses/i2c-piix4.c
>> @@ -85,6 +85,8 @@
>>  /* SB800 constants */
>>  #define SB800_PIIX4_SMB_IDX          0xcd6
>>
>> +#define IMC_SMB_IDX                  0x3e
>> +
>>  /*
>>   * SB800 port is selected by bits 2:1 of the smb_en register (0x2c)
>>   * or the smb_sel register (0x2e), depending on bit 0 of register 0x2f.
>> @@ -160,6 +162,8 @@ struct i2c_piix4_adapdata {
>>       /* SB800 */
>>       bool sb800_main;
>>       u8 port;                /* Port number, shifted */
>> +
>> +     bool notify_imc;
>
> Put right after sb800_main?

ack

>
>>  };
>>
>>  static int piix4_setup(struct pci_dev *PIIX4_dev,
>> @@ -572,6 +576,50 @@ static s32 piix4_access(struct i2c_adapter * adap, =
u16 addr,
>>       return 0;
>>  }
>>
>> +static uint8_t piix4_imc_read(uint8_t idx)
>> +{
>> +     outb_p(idx, IMC_SMB_IDX);
>> +     return inb_p(IMC_SMB_IDX + 1);
>
> Please define IMC_SMB_DAT or some such, and use it.

ack
>
>> +}
>> +
>> +static void piix4_imc_write(uint8_t idx, uint8_t value)
>> +{
>> +     outb_p(idx, IMC_SMB_IDX);
>> +     outb_p(value, IMC_SMB_IDX + 1);
>> +}
>> +
>> +int piix4_imc_sleep(void)
>> +{
>> +     int timeout =3D MAX_TIMEOUT;
>> +
>> +     piix4_imc_write(0x82, 0x00);
>> +     piix4_imc_write(0x83, 0xB4);
>> +     piix4_imc_write(0x80, 0x96);
>> +
>> +     while (timeout--) {
>> +             if (piix4_imc_read(0x82) =3D=3D 0xfa)
>> +                     return 0;
>> +             usleep_range(1000, 2000);
>> +     }
>
> Is there some minimum time we know we'll have to wait before completion?

Not as far as I know.
>
>> +
>> +     return -ETIMEDOUT;
>> +}
>> +
>> +void piix4_imc_wakeup(void)
>> +{
>> +     int timeout =3D MAX_TIMEOUT;
>> +
>> +     piix4_imc_write(0x82, 0x00);
>> +     piix4_imc_write(0x83, 0xB5);
>> +     piix4_imc_write(0x80, 0x96);
>> +
>> +     while (timeout--) {
>> +             if (piix4_imc_read(0x82) =3D=3D 0xfa)
>> +                     break;
>> +             usleep_range(1000, 2000);
>> +     }
>
> Same question here.
>
> Why don't you check for timeout here?
>
> In both functions above, you will write the same value to IMC_SMB_IDX
> again and again while checking for completion. Is this a hardware
> requirement? If not, it would be more efficient to implement some
> piix4_imc_quick_read() function which assumes that the index is already
> set.

Good idea, but maybe we want to do something different... keep reading :)

>
>> +}
>> +
>>  /*
>>   * Handles access to multiple SMBus ports on the SB800.
>>   * The port is selected by bits 2:1 of the smb_en register (0x2c).
>> @@ -586,7 +634,7 @@ static s32 piix4_access_sb800(struct i2c_adapter *ad=
ap, u16 addr,
>>  {
>>       struct i2c_piix4_adapdata *adapdata =3D i2c_get_adapdata(adap);
>>       unsigned short piix4_smba =3D adapdata->smba;
>> -     int retries =3D MAX_TIMEOUT;
>> +     int retries =3D adapdata->notify_imc ? MAX_TIMEOUT * 2 : MAX_TIMEO=
UT;
>
> What's the rationale for this change?

Taken from AMD patch.

>
>>       int smbslvcnt;
>>       u8 smba_en_lo;
>>       u8 port;
>> @@ -612,6 +660,15 @@ static s32 piix4_access_sb800(struct i2c_adapter *a=
dap, u16 addr,
>>               return -EBUSY;
>>       }
>>
>> +     /* Block data transfers require disabling the imc */
>
> IMC in capitals please. And they *may* require - not all chipsets are
> affected.

ack
>
>> +     if ((size =3D=3D I2C_SMBUS_BLOCK_DATA) && adapdata->notify_imc)
>> +             /* If IMC communication fails do not retry*/
>> +             if (piix4_imc_sleep()) {
>> +                     dev_warn(&adap->dev,
>> +                              "Failed to communicate with the IMC, enab=
le it and/or upgrade your BIOS.\n");
>
> The IMC is a hardware thing, how is upgrading the BIOS supposed to
> help? Is there no way to check if the IMC is actually disabled, to
> print a more accurate message?

The imc firmware is part of the BIOS. I am not aware of a way to
figure out if the imc is disabled, will take a closer look to the doc.

>
>> +                     adapdata->notify_imc =3D false;
>> +             }
>> +
>>       outb_p(piix4_port_sel_sb800, SB800_PIIX4_SMB_IDX);
>>       smba_en_lo =3D inb_p(SB800_PIIX4_SMB_IDX + 1);
>>
>> @@ -628,6 +685,9 @@ static s32 piix4_access_sb800(struct i2c_adapter *ad=
ap, u16 addr,
>>       /* Release the semaphore */
>>       outb_p(smbslvcnt | 0x20, SMBSLVCNT);
>>
>> +     if ((size =3D=3D I2C_SMBUS_BLOCK_DATA) && adapdata->notify_imc)
>> +             piix4_imc_wakeup();
>> +
>>       mutex_unlock(&piix4_mutex_sb800);
>>
>>       return retval;
>> @@ -679,7 +739,7 @@ static struct i2c_adapter *piix4_main_adapters[PIIX4=
_MAX_ADAPTERS];
>>  static struct i2c_adapter *piix4_aux_adapter;
>>
>>  static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
>> -                          bool sb800_main, u8 port,
>> +                          bool sb800_main, u8 port, bool notify_imc,
>>                            const char *name, struct i2c_adapter **padap)
>>  {
>>       struct i2c_adapter *adap;
>> @@ -707,6 +767,7 @@ static int piix4_add_adapter(struct pci_dev *dev, un=
signed short smba,
>>       adapdata->smba =3D smba;
>>       adapdata->sb800_main =3D sb800_main;
>>       adapdata->port =3D port << 1;
>> +     adapdata->notify_imc =3D notify_imc;
>>
>>       /* set up the sysfs linkage to our parent device */
>>       adap->dev.parent =3D &dev->dev;
>> @@ -728,14 +789,15 @@ static int piix4_add_adapter(struct pci_dev *dev, =
unsigned short smba,
>>       return 0;
>>  }
>>
>> -static int piix4_add_adapters_sb800(struct pci_dev *dev, unsigned short=
 smba)
>> +static int piix4_add_adapters_sb800(struct pci_dev *dev, unsigned short=
 smba,
>> +                                 bool notify_imc)
>>  {
>>       struct i2c_piix4_adapdata *adapdata;
>>       int port;
>>       int retval;
>>
>>       for (port =3D 0; port < PIIX4_MAX_ADAPTERS; port++) {
>> -             retval =3D piix4_add_adapter(dev, smba, true, port,
>> +             retval =3D piix4_add_adapter(dev, smba, true, port, notify=
_imc,
>>                                          piix4_main_port_names_sb800[por=
t],
>>                                          &piix4_main_adapters[port]);
>>               if (retval < 0)
>> @@ -769,6 +831,7 @@ static int piix4_probe(struct pci_dev *dev, const st=
ruct pci_device_id *id)
>>            dev->device =3D=3D PCI_DEVICE_ID_ATI_SBX00_SMBUS &&
>>            dev->revision >=3D 0x40) ||
>>           dev->vendor =3D=3D PCI_VENDOR_ID_AMD) {
>> +             bool notify_imc =3D false;
>>               is_sb800 =3D true;
>>
>>               if (!request_region(SB800_PIIX4_SMB_IDX, 2, "smba_idx")) {
>> @@ -778,6 +841,18 @@ static int piix4_probe(struct pci_dev *dev, const s=
truct pci_device_id *id)
>>                       return -EBUSY;
>>               }
>>
>> +             if (dev->vendor =3D=3D PCI_VENDOR_ID_AMD &&
>> +                 dev->device =3D=3D PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) {
>> +                     if (!devm_request_region(&dev->dev, IMC_SMB_IDX, 2=
,
>> +                                              "kerncz_imc_idx")) {
>> +                             dev_warn(&dev->dev,
>> +                                     "IMC base address index region 0x%=
x already in use!\n",
>> +                                     SB800_PIIX4_SMB_IDX);
>
> How is the IMC related with the SMBus? I'm surprised that you touch the
> IMC right from the SMBus driver like that. I'd expect other device
> drivers to potentially have similar needs, which would require sharing
> the region and proper locking.

The imc monitors the fans and temperature via SMBUS, this is why we
need to tisable it.

Maybe I could use request_muxed_region(),every time that I interact
with the IMC, that way other drivers could also share it?

>
> Not blocking, but mixing managed and non-managed resources in the same
> driver is not so nice.
>
>> +                     } else {
>> +                             notify_imc =3D true;
>> +                     }
>> +             }
>> +
>>               /* base address location etc changed in SB800 */
>>               retval =3D piix4_setup_sb800(dev, id, 0);
>>               if (retval < 0) {
>> @@ -789,7 +864,7 @@ static int piix4_probe(struct pci_dev *dev, const st=
ruct pci_device_id *id)
>>                * Try to register multiplexed main SMBus adapter,
>>                * give up if we can't
>>                */
>> -             retval =3D piix4_add_adapters_sb800(dev, retval);
>> +             retval =3D piix4_add_adapters_sb800(dev, retval, notify_im=
c);
>>               if (retval < 0) {
>>                       release_region(SB800_PIIX4_SMB_IDX, 2);
>>                       return retval;
>> @@ -800,7 +875,7 @@ static int piix4_probe(struct pci_dev *dev, const st=
ruct pci_device_id *id)
>>                       return retval;
>>
>>               /* Try to register main SMBus adapter, give up if we can't=
 */
>> -             retval =3D piix4_add_adapter(dev, retval, false, 0, "",
>> +             retval =3D piix4_add_adapter(dev, retval, false, 0, false,=
 "",
>>                                          &piix4_main_adapters[0]);
>>               if (retval < 0)
>>                       return retval;
>> @@ -827,7 +902,7 @@ static int piix4_probe(struct pci_dev *dev, const st=
ruct pci_device_id *id)
>>       if (retval > 0) {
>>               /* Try to add the aux adapter if it exists,
>>                * piix4_add_adapter will clean up if this fails */
>> -             piix4_add_adapter(dev, retval, false, 0,
>> +             piix4_add_adapter(dev, retval, false, 0, false,
>>                                 is_sb800 ? piix4_aux_port_name_sb800 : "=
",
>>                                 &piix4_aux_adapter);
>>       }
>
>
> --
> Jean Delvare
> SUSE L3 Support

This week and next week I have access to the hardware, so it would be
great if we could figure this out soon.


Thanks for your help!


--=20
Ricardo Ribalda
