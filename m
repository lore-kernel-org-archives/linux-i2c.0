From: "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
Subject: Re: [PATCH v16] i2c: Add drivers for the AMD PCIe MP2 I2C controller
Date: Thu, 28 Feb 2019 09:56:16 +0000
Message-ID: <360a227c-68f9-81f8-bcf4-9aeefa837cc0@amd.com>
References: <20190226161243.GA21539@syn-yoga530>
 <CAC_JBqrE_g-neObMMvsdAG4USDqgc+oqAs2y6WYRdrT6PBAiSQ@mail.gmail.com>
 <20190226165001.GD839@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190226165001.GD839@kunai>
Content-Language: en-US
Content-ID: <9822404167586D49A0494CEABEFCA6CE@namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Elie Morisse <syniurge@gmail.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "Singh, Sandeep" <Sandeep.Singh@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Elie,

On 2/26/2019 10:20 PM, Wolfram Sang wrote:
> Hi Elie,
>=20
>> My apologies for the time it took to apply those changes.
>=20
> No worries. I am super happy that you are still around and willing to
> continue the work!
>=20
>> I will also start working on an alternate (v17?) version with only one
>> module and replacing the platform driver by an ACPI lookup as
>> requested by Bjorn Helgaas, unless Nehal clarifies how AMD plans to
>> expand the platform driver.
>=20
> Sounds really good to me.

Thanks for the patch. For our upcoming sensor hub design we need MP2-PCIE a=
s independent driver.Hence i am requesting to keep the two separate modules=
.
> Thanks,
>=20
>    Wolfram
>=20

Regards
Nehal Shah
