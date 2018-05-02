From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4 03/10] i3c: Add sysfs ABI spec
Date: Wed, 2 May 2018 13:32:04 +0200
Message-ID: <CAMuHMdWgmPOntSQH0artOgBf4GrxOHJmHX8gyw1gmAW0ichPyg@mail.gmail.com>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
 <20180330074751.25987-4-boris.brezillon@bootlin.com> <20180429133700.GD28913@kroah.com>
 <CAMuHMdUe=zauTS7BQXyTvMbmc-AsEVdWN0gG_3Ejg3E4T-xFXQ@mail.gmail.com> <20180502111046.GA22091@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180502111046.GA22091@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>, Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+>
List-Id: linux-i2c@vger.kernel.org

Hi Greg,

On Wed, May 2, 2018 at 1:10 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Wed, May 02, 2018 at 11:47:49AM +0200, Geert Uytterhoeven wrote:
>> On Sun, Apr 29, 2018 at 3:37 PM, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>> > On Fri, Mar 30, 2018 at 09:47:44AM +0200, Boris Brezillon wrote:
>> >> Document sysfs files/directories/symlinks exposed by the I3C subsystem.
>> >>
>> >> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
>> >> ---
>> >> Changes in v2:
>> >> - new patch
>> >> ---
>> >>  Documentation/ABI/testing/sysfs-bus-i3c | 95 +++++++++++++++++++++++++++++++++
>> >>  1 file changed, 95 insertions(+)
>> >>  create mode 100644 Documentation/ABI/testing/sysfs-bus-i3c
>> >>
>> >> diff --git a/Documentation/ABI/testing/sysfs-bus-i3c b/Documentation/ABI/testing/sysfs-bus-i3c
>> >> new file mode 100644
>> >> index 000000000000..5e88cc093e0e
>> >> --- /dev/null
>> >> +++ b/Documentation/ABI/testing/sysfs-bus-i3c
>> >> @@ -0,0 +1,95 @@
>> >> +What:                /sys/bus/i3c/devices/i3c-<bus-id>
>> >> +KernelVersion:  4.16
>> >
>> > Wrong kernel versions :)
>>
>> Do you update these when backporting to stable? ;-)
>
> I'm not adding new features/subsystems to stable :)

True. So let's leave that for the LTSI patch monkey ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
