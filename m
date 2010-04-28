From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v6] OMAP2/3: I2C: Errata ID i207: Clear wrong RDR interrupt
Date: Wed, 28 Apr 2010 07:17:48 -0700
Message-ID: <87wrvrhd9v.fsf@deeprootsystems.com>
References: <1272433677-28658-1-git-send-email-manjugk@ti.com>
	<4BD80867.7020801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <4BD80867.7020801@ti.com> (Nishanth Menon's message of "Wed\, 28 Apr 2010 05\:05\:27 -0500")
Sender: linux-omap-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "Kalliguddi, Hema" <hemahk@ti.com>, Aaro Koskinen <Aaro.Koskinen@nokia.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-i2c@vger.kernel.org

Nishanth Menon <nm@ti.com> writes:

> very minor comments below:
> On 04/28/2010 12:47 AM, G, Manjunath Kondaiah wrote:

[...]

>>   struct omap_i2c_dev {
>>   	struct device		*dev;
>> @@ -199,6 +201,7 @@ struct omap_i2c_dev {
>>   	u16			bufstate;
>>   	u16			syscstate;
>>   	u16			westate;
>> +	u16			errata;
> overall I'd prefer the term quirk over errata - quirk is more of a
> standard linux term used accross network, usb and other drivers, will
> allow the code to be a little more familiar with the upstream
> maintainers/reviewers.. but i leave it to tony and others to comment
> more.. maybe it is just me being an ass again ;)

I prefer the term errata since it is also the term used by TI docs.

Kevin
