From: vitor <vitor.soares@synopsys.com>
Subject: Re: [PATCH v10 0/9] Add the I3C subsystem
Date: Thu, 15 Nov 2018 15:18:21 +0000
Message-ID: <7f21765a-87b3-9137-fb92-6c59483776de@synopsys.com>
References: <20181026144333.12276-1-boris.brezillon@bootlin.com>
 <76b1d15d-232c-d8ba-5eba-8394e71be725@synopsys.com>
 <20181115135731.25f60990@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181115135731.25f60990@bbrezillon>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>, vitor <vitor.soares@synopsys.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetr>
List-Id: linux-i2c@vger.kernel.org

Hi,

On 15/11/18 12:57, Boris Brezillon wrote:
> +Mark Brown for the question about /dev/spidev
>
> Hi Vitor,
>
> On Thu, 15 Nov 2018 12:14:37 +0000
> vitor <vitor.soares@synopsys.com> wrote:
>
>> Hi Boris,
>>
>> Given the current state of the subsystem I think it might worth start to
>> think how to expose the devices under /dev.
> Thanks for starting this discussion. I'm not against the idea in
> general, we just need to be careful when doing that.
>
>> My initial thoughts are to do the same think as for i2c, expose the
>> buses or the i3c_devices and use ioctl for private transfers.
> Exposing the bus is dangerous IMO, because an I3C bus is not like an
> I2C bus:
>
>     * I3C device needs to be discovered through DAA
>     * I2C devices need to be declared ahead of time, and LVR is used to
>       determine the limitations on the bus at runtime
>
> So you'd anyway be able to interact only with devices that have
> previously been discovered.
>
> Note that the virtual I2C bus is already exposed, but any command
> targeting an address that is not attached to a registered I2C dev will
> get a -ENOENT error.
I initially thought to do the same thing for the i3c devices adding a 
routine get_i3c_dev_by_addr()...
>
> What we could do though, is expose I3C devices that do not have a
> driver in kernel space, like spidev does.

...but I like more this approach.

>> Some
>> direct CCC commands can be sent through the /sys as you plan for SETNEWDA .
> Yes, CCC commands that need to be exposed to userspace should be
> exposed through sysfs, or, if we decide to create a /dev/i3cX device
> per bus, through ioctls.

There already some attributes exposed, just need to add the possibility 
to write to them and off course add some that are missing like GETSTATUS.

>
>> What do you think about this?
> I think this request is perfectly valid, we just need to decide how it
> should be done, and before we take this decision, I'd like to get
> inputs from other maintainers.
>
> Mark, Wolfram, Arnd, Greg, any opinion?
>
> Regards,
>
> Boris


Best regards,

Vitor Soares
