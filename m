From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Subject: Re: [PATCHv3] hwmon: Add tc654 driver
Date: Mon, 10 Oct 2016 20:08:14 +0000
Message-ID: <f82bbcd4330e4389990f95bd9d0d7b02@svr-chch-ex1.atlnz.lc>
References: <20161007182939.GA9031@roeck-us.net>
 <20161009221222.29409-1-chris.packham@alliedtelesis.co.nz>
 <b8294ac3-7bac-eeb3-8923-ed569a19cab2@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Cc: Masahiko Iwamoto <iwamoto@allied-telesis.co.jp>, Joshua Scott <Joshua.Scott@alliedtelesis.co.nz>, Kevin Tsai <ktsai@capellamicro.com>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 10/11/2016 02:22 AM, Guenter Roeck wrote:=0A=
>> +	if (val)=0A=
>> > +		data->config |=3D TC654_REG_CONFIG_DUTYC;=0A=
>> > +	else=0A=
>> > +		data->config &=3D ~TC654_REG_CONFIG_DUTYC;=0A=
> I just realized that this won't work as intended. Problem is that you=0A=
> only fill data->config when reading an attribute. So, if a set function=
=0A=
> is called prior to reading an attribute, data->config will be 0, and=0A=
> you end up overwriting the original configuration.=0A=
>=0A=
=0A=
Should I just read it in the probe function or fill it in with the =0A=
documented hardware defaults?=0A=
