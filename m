From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v2] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
Date: Tue, 28 May 2019 12:00:11 +0200
Message-ID: <20190528120011.288189f9@endymion>
References: <CAHp75Vf=-RQvCtS684Q5+X=YKmZXgP_1kr0to8BGZX0jQAsuZw@mail.gmail.com>
        <20180212153012.vffvjmz26ifyxbj5@pali>
        <CAHp75VfF+qwCXcr3yuayE-Z+UG9wuMOKfGzLhdyPk79daEi9gQ@mail.gmail.com>
        <20180213150004.5d2v7y7wwuure4io@pali>
        <CAHp75VfxgbFiDxyrqyMRE8s85L1_EzkVvrA1NGYA5_su=5oGVQ@mail.gmail.com>
        <20180213165023.xmzovx7fd3gdljxw@pali>
        <20180226203255.lnnzipipjz5l2itz@ninjato>
        <20190528111953.0e5415f4@endymion>
        <20190528094132.ytsittb5hcgthoy2@pali>
        <1559037015.6521.3.camel@suse.de>
        <20190528095402.hlnqfon6jk452one@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190528095402.hlnqfon6jk452one@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?UTF-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andy.shevchenko@gmail.com>, =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <Mario_Limonciello@dell.com>, Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 28 May 2019 11:54:02 +0200, Pali Rohár wrote:
> On Tuesday 28 May 2019 11:50:15 Jean Delvare wrote:
> > OK, thanks for the explanation. But assuming that we now instantiate
> > the lis2lv02d device from i2c-i801 for exactly all the same machines,
> > can't we just *enable* the freefall misc device feature of lis2lv02d
> > and kill the dell-smo8800 driver completely? Seems more simple to
> > maintain going forward.  
> 
> I though about it and I already wrote that is it not practical. For ACPI
> drivers there is easy way to get that interrupt number from ACPI tables.
> From i2c-i801 PCI driver it is hard to get interrupt number for
> particular ACPI device...
> 
> That is way I preferred simple solution: ACPI driver for ACPI device and
> i2c driver for i2c device.

OK, fine with me then :-)

-- 
Jean Delvare
SUSE L3 Support
