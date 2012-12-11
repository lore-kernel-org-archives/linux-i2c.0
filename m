From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: Re: I2C and devicetrees
Date: Tue, 11 Dec 2012 12:21:52 -0800
Message-ID: <CAOesGMhUVwB4+kuCA8hSmfhoVzkznNbjj6hjngDMaQkB83WqjQ@mail.gmail.com>
References: <201212052336.24233.PeterHuewe@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201212052336.24233.PeterHuewe-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Huewe <PeterHuewe-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

[+devicetree-discuss]

On Wed, Dec 5, 2012 at 2:36 PM, Peter Huewe <PeterHuewe-Mmb7MZpHnFY@public.gmane.org> wrote:
> Hi,
>
> I have a short question about the relations between i2c and devicetrees.
>
> I was wondering
> is the device part of the compatible string of a (trivial) i2c device
> instanciated via devicetree _always_ identical to name in i2c_client.name ?
> Or can it be somehow different?

It can be different, but the driver will then need to add a OF table
that matches the probing. By default the i2c/dt core code will strip
off the vendor prefix (before ",") and try probing with the rest of
the device name. If that doesn't match the client name, that is when
you need the additional table.


> Here's a short example:
> device tree:
> test {
>         compatible = "vendor,device1", "vendor,device2";
>         reg = <0x20>;
> }
>
> The driver has in its id table only this entry:
> static const struct i2c_device_id my_i2c_table[] = {
>         {"device2", 0},
>         {},
> };
>
> -> "vendor,device2" matches and the driver is called.
> --> Is i2c_client.name guaranteed to be "device2" ?
>
> Second question:
> Where would you probably add an i2c tpm?
> Would you add it to
>  Documentation/devicetree/bindings/i2c/trivial-devices.txt
> or if it's not trivial add it to a new file under
>  Documentation/devicetree/bindings/i2c/

A trivial device is a device that takes at most an address (or address
range) and an interrupt.

If it has a more elaborate binding than that, then a separate small
binding doc is needed.

> or create a new folder
>  Documentation/devicetree/bindings/tpm
> as there probably are more i2c tpms to come in the near future.

I'd leave it under i2c for now, we tend to group per bus, not per function.

> I'd probably prefer the first one, whereas Google already uses the second
> option:
> http://git.chromium.org/gitweb/?p=chromiumos/third_party/kernel.git;a=history;f=Documentation/devicetree/bindings/tpm;hb=refs/heads/chromeos-3.4

The location of the file doesn't matter and it can easily be moved. I
was more concerned with getting the document written and included than
stored in the perfect location at the time.



-Olof
