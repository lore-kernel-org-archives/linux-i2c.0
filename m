From: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 0/3 v2] i2c: i801: enable irq
Date: Wed, 27 Jun 2012 21:56:34 +0800
Message-ID: <CAGS+omDYaPBQiKBiVewbwZR2Vnjv+NfqbZxc+fknpCBNvRFRKw@mail.gmail.com>
References: <1325847502-17841-1-git-send-email-djkurtz@chromium.org> <20120627112402.26576746@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120627112402.26576746-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org, David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean

On Wed, Jun 27, 2012 at 5:24 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrot=
e:
> Hi again Daniel,
>
> On Fri, =A06 Jan 2012 18:58:19 +0800, Daniel Kurtz wrote:
>> This is a second version of a set of patches enables the Intel PCH S=
MBus
>> controller interrupt. =A0It refactors the second two patches a littl=
e bit by
>> relying on DEV_ERR interrupt for timeouts, instead of using an expli=
cit
>> wait_event_timeout.
>>
>> The first attempt received absolutely no response. Maybe this time s=
omeone
>> will be interested.
>>
>> The SMBus Host Controller Interrupt can signify:
>> =A0INTR - the end of a complete transaction
>> =A0DEV_ERR - that a device did not ACK a transaction
>> =A0BYTE_DONE - the completion of a single byte during a byte-by-byte=
 transaction
>>
>> This patchset arrives with the following caveats:
>>
>> =A01) =A0It has only been tested with a Cougar Point (Intel 6 Series=
 PCH) SMBus
>> controller, so the irq is only enabled for that chip type.
>
> I just finished testing (my modified version of the driver [1] which
> includes all the fixes discussed in this thread so far) on my ICH7-M
> machine which is running kernel 3.0. I could only test SMBus quick
> write and SMBus byte read, but that worked just fine. Speed boost is
> impressive, with a factor 7.0x for the former and 2.1x for the latter=
!
> Very nice, thanks Daniel!

Thanks for your testing and reviews!

> [1] http://khali.linux-fr.org/devel/misc/i2c-i801/
> =A0 =A0Everyone is invited to test this on ICH5+, just add your devic=
e ID
> =A0 =A0to the list of interrupt-enabled devices if it's not there yet=
,
> =A0 =A0test and report.
>
>> =A02) It has not been tested with any devices that do transactions t=
hat use the
>> =A0 =A0 PEC. =A0In fact, I believe that an additional small patch wo=
uld be required
>> =A0 =A0 to the driver working correctly in interrupt mode with PEC.
>
> Couldn't test that either.
>
>>
>> =A03) It has not been tested in SMBus Slave mode.
>
> Well the driver doesn't support it yet anyway.
>
>>
>> =A04) It has not been tested with SMI#-type interrupts.
>
> I don't think it can work at all. As I understand it, you have to fal=
l
> back to polled mode if interrupts are set to SMI#. Probably not a big
> deal in practice, my 4 test systems have interrupt set to PCI type. I
> think it's easier for the BIOS to do busy polling than interrupt
> handling, so unless the BIOS needs the SMBus slave mode, it probably
> will never set interrupt mode to SMI# for the SMBus.
>
>>
>> =A05) The BIOS has to configure the PCH SMBus IRQ properly.
>
> Sounds like a reasonable assumption.
>
>>
>> =A06) It has not been tested with a device that does byte-by-byte sm=
bus (non-i2c)
>> =A0 =A0 reads.
>
> I planned on testing this on my ICH3-M system, but it turns out your
> interrupt-based implementation only works for ICH5 and later chips. A=
s
> ICH5 and later chips all implement the block buffer, there's no reaso=
n
> for the byte-by-byte-code to ever be used for SMBus block transaction=
s.
> However, the block buffer feature can be disabled for testing purpose
> by passing module parameter disable_features=3D0x0002.
>
> I just did, and actually it doesn't work. i2cdump shows 32 bytes no
> matter what the device said. Debug log shows that the driver reads
> fewer bytes from the device though, as it is supposed to. So I think
> the problem is simply that the interrupt path is missing this compare=
d
> to the polled path:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (i =3D=3D 1 && read_write =3D=3D I2=
C_SMBUS_READ
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && command !=3D I2C_SMBUS_I2C_BLOCK_D=
ATA) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0len =3D inb_p(SMBHSTDA=
T0(priv));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(...)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->block[0] =3D len=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> I.e. we don't let the caller know how many bytes we actually read fro=
m
> the device. I fixed it with:
>

I was just in the middle of finalizing a new patchset when I saw your
last email.
I incorporated (and tested for no-regressions) the snippet below.
Unfortunately, I'm not set up to test this type of transaction, so
hopefully you can double check my version of this patch with your
setup.

> --- i2c-i801.orig/i2c-i801.c =A0 =A02012-06-27 09:51:25.000000000 +02=
00
> +++ i2c-i801/i2c-i801.c 2012-06-27 11:10:25.362853361 +0200
> @@ -408,6 +408,24 @@ static irqreturn_t i801_isr(int irq, voi
>
> =A0 =A0 =A0 =A0if (hststs & SMBHSTSTS_BYTE_DONE) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (priv->is_read) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (priv->count =3D=3D =
0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&& (priv->cmd & 0x1c=
) =3D=3D I801_BLOCK_DATA) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->l=
en =3D inb_p(SMBHSTDAT0(priv));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pri=
v->len < 1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|| p=
riv->len > I2C_SMBUS_BLOCK_MAX) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 dev_err(&priv->pci_dev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 "Illegal SMBus block read size %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 priv->len);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 /* FIXME: Recover */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 priv->len =3D I2C_SMBUS_BLOCK_MAX;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 dev_dbg(&priv->pci_dev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 "SMBus block read size is %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 priv->len);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->d=
ata[-1] =3D priv->len;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (priv->count < priv=
->len) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->=
data[priv->count++] =3D inb(SMBBLKDAT(priv));
>
>
> Context in your version of the driver will be somewhat different, but
> you get the idea.
>
>> =A07) It has not been tested with smbus 'process call' transactions.
>
> Can't test this either. Devices implementing these are quite rare.
>
>>
>> If would be very helpful if somebody could help test on other chipse=
ts, with
>> a PEC device, or on additional BIOS that woudl be very helpful.
>>
>> In the meantime, the interrupt behavior is only enabled on the Couga=
r Point,
>> and even here, it can be completely disabled with the "Interrupt" fe=
ature like
>> other advanced features of the driver.
>
> Tested so far, successfully: ICH5, ICH7-M and ICH10. Tested and didn'=
t
> work: ICH3-M (but at least I tested there was no regression introduce=
d
> by your patches.)
>
> I think it's time to respin this patch series with all the fixes I
> suggested, unless you object to some of the non-critical changes. If
> you don't have the time, just tell me and I can take care, if you don=
't
> mind. I really would like to see this patch set go in kernel 3.6, whi=
ch
> means it should go into linux-next ASAP.
>
> Thanks again,
> --
> Jean Delvare

Thanks again!
-Daniel
