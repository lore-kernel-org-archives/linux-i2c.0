From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v2] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
Date: Tue, 28 May 2019 11:41:32 +0200
Message-ID: <20190528094132.ytsittb5hcgthoy2@pali>
References: <CAHp75VdU1OMTqLcDuzhQMHuX9rMhjw6p3CkSWaW5Y4kOy8ggqg@mail.gmail.com>
 <20180131120348.azy25aqvn5wrdkeh@pali>
 <CAHp75Vf=-RQvCtS684Q5+X=YKmZXgP_1kr0to8BGZX0jQAsuZw@mail.gmail.com>
 <20180212153012.vffvjmz26ifyxbj5@pali>
 <CAHp75VfF+qwCXcr3yuayE-Z+UG9wuMOKfGzLhdyPk79daEi9gQ@mail.gmail.com>
 <20180213150004.5d2v7y7wwuure4io@pali>
 <CAHp75VfxgbFiDxyrqyMRE8s85L1_EzkVvrA1NGYA5_su=5oGVQ@mail.gmail.com>
 <20180213165023.xmzovx7fd3gdljxw@pali>
 <20180226203255.lnnzipipjz5l2itz@ninjato>
 <20190528111953.0e5415f4@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190528111953.0e5415f4@endymion>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andy.shevchenko@gmail.com>, Jean Delvare <jdelvare@suse.com>, =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <Mario_Limonciello@dell.com>, Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi! Thank you finally for response!

On Tuesday 28 May 2019 11:19:53 Jean Delvare wrote:
> On Mon, 26 Feb 2018 21:32:55 +0100, Wolfram Sang wrote:
> > > I'm not maintainer of i2c-i801.ko, Jean Delvare & Wolfram Sang are.
> > > Therefore instructing future contributors would be up to them.  
> > 
> > This is really Jean's realm.
> 
> Sorry for the delay. As a general rule I'm all in favor of
> instantiating I2C devices from i2c-i801 when we can, as it makes the
> user's life easier. However I agree with Andy that:
> 1* We want to have an explicit list of supported ACPI device IDs, not a
>    just a prefix.
> 2* We don't want to over-engineer it with a common header file or an
>    exported symbol. I see no problem with duplicating the lists if 2
>    drivers happen to be needed on the same set of devices. This is
>    easily managed by adding a comment before each list that the other
>    list may need to be kept in sync. It also gives us the flexibility
>    to *not* keep them in sync if needed.

Ok, I will then make list of supported ACPI devices and put them into
two places with comment about syncing.

> Instantiating the I2C device from dell-smo8800 doesn't seem practical
> because that driver has no idea about the i2c subsystem in the first
> place.

Yes. And in same way instantiating ACPI driver dell-smo8800 from
i2c-i801 is not practical too.

> What worries me is that we seem to have 2 drivers binding to the same
> device (the accelerometer), one natively (lis3lv02d), and one through
> an ACPI layer (dell-smo8800). I don't really understand why this is
> needed (don't they serve the same purpose?) nor how it can be safe
> (what guarantees that both drivers won't attempt to access the hardware
> at the same time?)

This is not a problem. lis3lv02d provides two things:

1) 3 axes accelerometer
2) optional interrupt and signal it to userspace via misc device

dell-smo8800 does not call any parts of lis2lv02d module. It just
provides for userspace same misc device API as lis3lv02d.

As lis3lv02d has misc device optional, registered i2c device from
i2c-i801 does not enable it.

So technically it is one device, but their functionality divided into
two modules. One which reports accelerometer axes and one which signals
disk fall interrupt. These two modules and functionalities does not have
to interact, so it is safe to have them separated.

-- 
Pali Rohár
pali.rohar@gmail.com
