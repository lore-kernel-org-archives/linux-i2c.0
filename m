From: Minkyu Kang <promsoft-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] misc: adds support the FSA9480 USB Switch
Date: Tue, 28 Sep 2010 14:58:30 +0900
Message-ID: <AANLkTim2UhJAhOw1qHvZ9bbctR0tNSMvE61T=sxffHxO@mail.gmail.com>
References: <4C7CD95A.5040309@samsung.com>
	<20100917150731.f1f44f3c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100917150731.f1f44f3c.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Andrew Morton,

On 18 September 2010 07:07, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org> w=
rote:
> (catching up!)
>
> On Tue, 31 Aug 2010 19:28:42 +0900
> Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
>
>> The FSA9480 is a USB port accessory detector and switch.
>> This patch adds support the FSA9480 USB Switch.
>>
>
> What a strange device.
>
> Is there a data sheet available?

Hello :)
I couldn't find the fsa9480 data sheet on the web.
But I found the fsa9280 data sheet instead.
It looks very similar.
http://www.fairchildsemi.com/ds/FS/FSA9280A.pdf

>
>> +config USB_SWITCH_FSA9480
>> + =A0 =A0 tristate "FSA9480 USB Switch"
>> + =A0 =A0 depends on I2C
>> + =A0 =A0 help
>> + =A0 =A0 =A0 The FSA9480 is a USB port accessory detector and switc=
h.
>> + =A0 =A0 =A0 The FSA9480 is fully controlled using I2C and enables =
USB data,
>> + =A0 =A0 =A0 stereo and mono audio, video, microphone and UART data=
 to use
>> + =A0 =A0 =A0 a common connector port.
>
> So if I'm understanding it correctly, it's an i2c-controlled device
> which turns USB devices on and off, multiplexing them into a single U=
SB
> port? =A0So if I switch from "USB data" over to "microphone", the USB
> subsystem will see the "USB data" device get unplugged and will see a
> "microphone" get plugged in?
>
> Or something else. =A0Am I even vaguely understanding this thing?
>
> It would help if the changelog were to contain a paragraph
> describing the overall behaviour of this device.
>
>>
>> ...
>>
>> +void fsa9480_set_switch(const char *buf)
>> +{
>> + =A0 =A0 struct fsa9480_usbsw *usbsw =3D chip;
>> + =A0 =A0 struct i2c_client *client =3D usbsw->client;
>> + =A0 =A0 unsigned int value;
>> + =A0 =A0 unsigned int path =3D 0;
>> +
>> + =A0 =A0 value =3D fsa9480_read_reg(client, FSA9480_REG_CTRL);
>> +
>> + =A0 =A0 if (!strncmp(buf, "VAUDIO", 6)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 path =3D SW_VAUDIO;
>> + =A0 =A0 =A0 =A0 =A0 =A0 value &=3D ~CON_MANUAL_SW;
>> + =A0 =A0 } else if (!strncmp(buf, "UART", 4)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 path =3D SW_UART;
>> + =A0 =A0 =A0 =A0 =A0 =A0 value &=3D ~CON_MANUAL_SW;
>> + =A0 =A0 } else if (!strncmp(buf, "AUDIO", 5)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 path =3D SW_AUDIO;
>> + =A0 =A0 =A0 =A0 =A0 =A0 value &=3D ~CON_MANUAL_SW;
>> + =A0 =A0 } else if (!strncmp(buf, "DHOST", 5)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 path =3D SW_DHOST;
>> + =A0 =A0 =A0 =A0 =A0 =A0 value &=3D ~CON_MANUAL_SW;
>> + =A0 =A0 } else if (!strncmp(buf, "AUTO", 4)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 path =3D SW_AUTO;
>> + =A0 =A0 =A0 =A0 =A0 =A0 value |=3D CON_MANUAL_SW;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Wrong command\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 usbsw->mansw =3D path;
>> + =A0 =A0 fsa9480_write_reg(client, FSA9480_REG_MANSW1, path);
>> + =A0 =A0 fsa9480_write_reg(client, FSA9480_REG_CTRL, value);
>> +}
>> +EXPORT_SYMBOL_GPL(fsa9480_set_switch);
>
> Why was this exported?

Kyungmin already explained about it.

>
>> +ssize_t fsa9480_get_switch(char *buf)
>> +{
>> + =A0 =A0 struct fsa9480_usbsw *usbsw =3D chip;
>> + =A0 =A0 struct i2c_client *client =3D usbsw->client;
>> + =A0 =A0 unsigned int value;
>> +
>> + =A0 =A0 value =3D fsa9480_read_reg(client, FSA9480_REG_MANSW1);
>> +
>> + =A0 =A0 if (value =3D=3D SW_VAUDIO)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "VAUDIO\n");
>> + =A0 =A0 else if (value =3D=3D SW_UART)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "UART\n");
>> + =A0 =A0 else if (value =3D=3D SW_AUDIO)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "AUDIO\n");
>> + =A0 =A0 else if (value =3D=3D SW_DHOST)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "DHOST\n");
>> + =A0 =A0 else if (value =3D=3D SW_AUTO)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "AUTO\n");
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "%x", value);
>> +}
>> +EXPORT_SYMBOL_GPL(fsa9480_get_switch);
>
> This export also has no callers?

It's for other drivers.
=46or example.. When USB cable is connected, PMIC driver enable the
power for each device.
But if use the manual switch, PMIC driver can't know what device is ena=
bled.
So, this function was exported.

>
> These functions implement a userspace API. =A0Userspace APIs are
> important. =A0But the patch provided no documentation for that API.
> Please always fully, exhaustively document userspace APIs! =A0For the=
y
> are the one part of the driver which we can never change.
>
> Documenting them in a documentation file is OK. =A0Also there's
> Documentation/ABI/. =A0And they can be nicely described in the change=
log
> too.
>
> But providing us with no description at all makes review harder and
> less effective than we'd like it to be, and results in a driver which
> is harder for our users to use.
>
> OK?
>
>> +static ssize_t fsa9480_show_status(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0str=
uct device_attribute *attr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cha=
r *buf)
>> +{
>> + =A0 =A0 struct fsa9480_usbsw *usbsw =3D dev_get_drvdata(dev);
>> + =A0 =A0 struct i2c_client *client =3D usbsw->client;
>> + =A0 =A0 int devid, ctrl, adc, dev1, dev2, intr,
>> + =A0 =A0 =A0 =A0 intmask1, intmask2, time1, time2, mansw1;
>> +
>> + =A0 =A0 devid =3D fsa9480_read_reg(client, FSA9480_REG_DEVID);
>> + =A0 =A0 ctrl =3D fsa9480_read_reg(client, FSA9480_REG_CTRL);
>> + =A0 =A0 adc =3D fsa9480_read_reg(client, FSA9480_REG_ADC);
>> + =A0 =A0 intmask1 =3D fsa9480_read_reg(client, FSA9480_REG_INT1_MAS=
K);
>> + =A0 =A0 intmask2 =3D fsa9480_read_reg(client, FSA9480_REG_INT2_MAS=
K);
>> + =A0 =A0 dev1 =3D fsa9480_read_reg(client, FSA9480_REG_DEV_T1);
>> + =A0 =A0 dev2 =3D fsa9480_read_reg(client, FSA9480_REG_DEV_T2);
>> + =A0 =A0 time1 =3D fsa9480_read_reg(client, FSA9480_REG_TIMING1);
>> + =A0 =A0 time2 =3D fsa9480_read_reg(client, FSA9480_REG_TIMING2);
>> + =A0 =A0 mansw1 =3D fsa9480_read_reg(client, FSA9480_REG_MANSW1);
>> +
>> + =A0 =A0 fsa9480_read_irq(client, &intr);
>> +
>> + =A0 =A0 return sprintf(buf, "Device ID(%02x), CTRL(%02x)\n"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "ADC(%02x), DEV_T1(%02x), =
DEV_T2(%02x)\n"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "INT(%04x), INTMASK(%02x, =
%02x)\n"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "TIMING(%02x, %02x), MANSW=
1(%02x)\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 devid, ctrl, adc, dev1, de=
v2, intr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 intmask1, intmask2, time1,=
 time2, mansw1);
>> +}
>
> That's will produce odd-looking output I suspect. =A0More conventiona=
l
> would be
>
> =A0 =A0 =A0 =A0Device ID:%02x CTRL:%02x
>
> or something like that.
>
> But that result is basically unparseable by software and a better out=
put
> would be
>
> Device_ID: %02x
> CTRL: %02x
> ADC: %02x
>
> etc.
>
> But even that violates the sysfs one-value-per-file guideline.
>
> So this interface is problematic. =A0It should have been discussed
> up-front in the changelog so we can all take a look at the proposal a=
nd
> have a think about it.

Yes. It's for debugging.
I'll remove some features and separate this sysfs file.

>
>>
>> ...
>>
>> +static irqreturn_t fsa9480_irq_handler(int irq, void *data)
>> +{
>> + =A0 =A0 struct fsa9480_usbsw *usbsw =3D data;
>> +
>> + =A0 =A0 if (!work_pending(&usbsw->work)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 disable_irq_nosync(irq);
>> + =A0 =A0 =A0 =A0 =A0 =A0 schedule_work(&usbsw->work);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return IRQ_HANDLED;
>> +}
>
> I expect that this driver can be converted to the new threaded IRQ co=
de
> (request_threaded_irq) and it will all become simpler.

Ok, I'll convert to new IRQ code.

>
>>
>> ...
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

Thanks
Minkyu Kang.
--=20
from. prom.
www.promsoft.net
