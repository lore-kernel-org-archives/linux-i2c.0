From: "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
Subject: Re: [PATCH v15] i2c: Add drivers for the AMD PCIe MP2 I2C controller
Date: Thu, 7 Feb 2019 16:47:13 +0000
Message-ID: <8d70ae32-8e4d-d2aa-e213-4b2f678d7da0@amd.com>
References: <20181226232258.GA23526@syn-yoga530> <20190205120545.GA1045@kunai>
 <CAErSpo5kvFVwo-DCLYT_7UmRQKS1jHahFXawvnZUtZ=ApHKz1Q@mail.gmail.com>
 <20190207155326.GC4796@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190207155326.GC4796@kunai>
Content-Language: en-US
Content-ID: <A6D645E046359C44939CA1EC24687EE6@namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Elie Morisse <syniurge@gmail.com>, linux-i2c <linux-i2c@vger.kernel.org>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "Singh, Sandeep" <Sandeep.Singh@amd.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Bjorn Helgaas <helgaas@kernel.org>
List-Id: linux-i2c@vger.kernel.org


 Hi Bjorn and Wolfram,
On 2/7/2019 9:23 PM, Wolfram Sang wrote:
> Hi Bjorn,
>=20
> thanks a lot for your additional information!
>=20
>> IMHO the split into two drivers is a bit of a mess and doesn't really
>> correspond with the hardware, as I mentioned at [1].  The PCI device
>> is the real hardware and the driver should claim that.  AFAICT the
>> ACPI device exists only to pass some config information to the PCI
>> driver.  I think the natural approach would be for the PCI driver to
>> directly search the ACPI namespace for that config information.
>=20
> AFAIR the AMD folks insisted on the two driver setup because they need
> it in the future? Maybe they can explain again here?
>=20
>> The fact that driver_find_device() is essentially unused except for a
>> few very special cases is a good clue that there's probably a better
>> way.
>=20
> Excactly this thinking made me recommend something else, too. Let's see
> what we can come up with.

First of really thanks for your valuable review. It may seem to be illogica=
l to have two separate drivers, however as explained
in past we are working on another solution for some upcoming thing. In that=
 case we need MP2-PCI communication driver which will be reused.
At this point of time i can't talk much about that but once solution is rea=
dy, we will be pushing that as well. Hence i sincerely requesting
to  have two separate driver.

For rest of remaining comments will look into the same. Elie hope you will =
also have a look and we will have a common understanding.


> Thanks,
>=20
>    Wolfram
>=20


Thanks for consideration and your understanding.

Regards
Nehal Shah
