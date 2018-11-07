From: vitor <vitor.soares@synopsys.com>
Subject: Re: [PATCH 1/3] i3c: master: Add driver for Synopsys DesignWare IP
Date: Wed, 7 Nov 2018 17:16:01 +0000
Message-ID: <4e05e568-c010-a6db-92b1-4c26ad503333@synopsys.com>
References: <1540807618-13246-1-git-send-email-soares@synopsys.com>
 <1540807618-13246-2-git-send-email-soares@synopsys.com>
 <20181029134100.GD28520@bombadil.infradead.org>
 <8a71cb94-ccf5-8ec0-446a-37a29405f585@synopsys.com>
 <CAMuHMdUO5_-TsGiu3otuLqNtLNgdnw=1QdKjTzPmSxHp9QotxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUO5_-TsGiu3otuLqNtLNgdnw=1QdKjTzPmSxHp9QotxQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Vitor Soares <vitor.soares@synopsys.com>
Cc: Matthew Wilcox <willy@infradead.org>, Boris Brezillon <boris.brezillon@bootlin.com>, Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>Rob Herring <r>
List-Id: linux-i2c@vger.kernel.org

Hi Geert,

On 07/11/18 15:34, Geert Uytterhoeven wrote:
> Hi Vitor,
>
> On Wed, Nov 7, 2018 at 4:15 PM vitor <vitor.soares@synopsys.com> wrote:
>> On 29/10/18 13:41, Matthew Wilcox wrote:
>>> On Mon, Oct 29, 2018 at 10:06:56AM +0000, Vitor soares wrote:
>>>> +config DW_I3C_MASTER
>>>> +    tristate "Synospsys DesignWare I3C master driver"
>>>> +    depends on I3C
>>>> +    depends on !(ALPHA || PARISC)
>>> why?
>> Please check this email thread: https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.org_lkml_2018_10_8_393&d=DwIBaQ&c=DPL6_X_6JkXFx7AXWqB0tg&r=qVuU64u9x77Y0Kd0PhDK_lpxFgg6PK9PateHwjb_DY0&m=dVPXOATdi751iTXEXYcWuChJA6hcIkXr8tF-i9hrv4E&s=Nk3lXNpRMzhvKMnlXUsFySTr5VYAr2228vXaZfiGBgM&e=
> Hence this deserves a comment, so we know when/what to do to drop the
> dependency:
>
>      depends on  !(ALPHA || PARISC) # needs {read,write}sl()
>
> Gr{oetje,eeting}s,
>
>                          Geert
>
I agree with you, I just didn't know if I should comment or not. I will 
do that next version.


Best regards,

Vitor Soares
