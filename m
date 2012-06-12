From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 09/14] i2c: Add Device Tree support to the Nomadik I2C
 driver
Date: Tue, 12 Jun 2012 08:34:00 +0100
Message-ID: <4FD6F0E8.5040606@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org> <1339428307-3850-10-git-send-email-lee.jones@linaro.org> <CACRpkdaMDbH4NkiHRLAfbJZ_j4QXbwg94bvaWsdYRPH+dSfc8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdaMDbH4NkiHRLAfbJZ_j4QXbwg94bvaWsdYRPH+dSfc8Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 11/06/12 21:37, Linus Walleij wrote:
> On Mon, Jun 11, 2012 at 5:25 PM, Lee Jones<lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>  wro=
te:
>
>> As new users are
>> added, it is expected that they will be Device Tree compliant.
>> If this is the case, we will look up their initialisation values
>> by compatible entry, then apply them forthwith.
> (...)
>> +static struct nmk_i2c_controller u8500_i2c =3D {
>> +       /*
>> +        * slave data setup time, which is
>> +        * 250 ns,100ns,10ns which is 14,6,2
>> +        * respectively for a 48 Mhz
>> +        * i2c clock
>> +        */
>> +       .slsu           =3D 0xe,
>> +       /* Tx FIFO threshold */
>> +       .tft            =3D 1,
>> +       /* Rx FIFO threshold */
>> +       .rft            =3D 8,
>> +       /* std. mode operation */
>> +       .clk_freq       =3D 100000,
>> +       /* Slave response timeout(ms) */
>> +       .timeout        =3D 200,
>> +       .sm             =3D I2C_FREQ_MODE_FAST,
>> +};
>
> So why don't we create proper device tree bindings for the above plat=
form
> data?
>
> For example several driver under
> Documentation/devicetree/bindings/i2c/*
> define the .clk_freq above as "clock-frequency"
>
> samsung-i2c even has this:
> samsung,i2c-sda-delay =3D<100>;
> samsung,i2c-max-bus-freq =3D<100000>;
>
> Where i2c-sda-delay corresponds to slsu above.
>
> I suspect .sm can be derived from the frequency so it
> is "FAST" whenever the frequency>  100000.
>
> This looks to me like a way to push the burden of doing the real
> device tree binding for the above to the next user.
> (Which will likely be me, so therefore I care a bit ...)

On the contrary. This will avoid any added Device Tree complexity and=20
ensure that no extra vendor specific bindings are required. When a new=20
user wishes to use the driver, all they (you) have to do is create a ne=
w=20
struct with the platform specific information and add the entry to=20
nmk_gpio_match[], simples.

I've even added the logic to extract any information you provide via=20
nmk_gpio_match[] for use as platform data. This keeps it both out of=20
platform code and the Device Tree binary. Everyone's a winner. :)

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
