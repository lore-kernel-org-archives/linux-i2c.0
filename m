From: "Ruslan Babayev (fib)" <fib@cisco.com>
Subject: Re: [PATCH RFC v2 net-next 2/2] net: phy: sfp: enable i2c-bus
 detection on ACPI based systems
Date: Tue, 7 May 2019 03:15:44 +0000
Message-ID: <BYAPR11MB3383B74F06254EDA7157D314AD310@BYAPR11MB3383.namprd11.prod.outlook.com>
References: <20190505220524.37266-2-ruslan@babayev.com>
 <20190507003557.40648-3-ruslan@babayev.com>,<20190507023812.GA12262@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190507023812.GA12262@lunn.ch>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, "20190505220524.37266-2-ruslan@babayev.com" <20190505220524.37266-2-ruslan@babayev.com>
Cc: "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "davem@davemloft.net" <davem@davemloft.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
List-Id: linux-i2c@vger.kernel.org

=0A=
> As i said before, i know ~0 about ACPI. Does devm_gpiod_get() just=0A=
> work for ACPI?=0A=
> Thanks=0A=
>        Andrew=0A=
=0A=
It does.=0A=
=0A=
Regards,=0A=
Ruslan=0A=
