From: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCHv4 2.6.25] i2c: adds support for i2c bus on Freescale	CPM1/CPM2
 controllers
Date: Mon, 25 Feb 2008 17:48:27 +0100
Message-ID: <47C2F15B.8070703@scram.de>
References: <47A1C4E9.4000003@scram.de> <20080221130520.12b01553@hyperion.delvare> <47BEAF00.50106@scram.de> <20080223212823.GA22131@lixom.net> <47C18A4E.5080804@scram.de> <20080224181509.GA6745@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759279AbYBYSfv@vger.kernel.org>
In-Reply-To: <20080224181509.GA6745@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>, i2c@lm-sensors.org, Scott Wood <scottwood@freescale.com>
List-Id: linux-i2c@vger.kernel.org

Hi Olof,

> And even if you DO decide to go that route, guess what? You need a
> translation table just as with (3) anyway!

True.

>>>> 3. use a glue layer with a translation map.
>>> In my opinion this is an OK solution since the same information has to
>>> be added somewhere already anyway -- eiither to the drivers or to this
>>> translation table. It should of course be an abstacted shared table,
>>> preferrably contained under the i2c source directories since several
>>> platforms and architectures might share them.
>> I could think of a mixture between 2. and 3.:
>>
>> Using the compatible attribute with the manufacturer stripped off as I2c name by default
>> and using an exception table. For now, the struct i2c_driver_device would currently only
>> need one entry ("dallas,ds1374", "rtc-ds1374").
> 
> You still need the translation table, you're just flattening the
> namespace to one string instead of two, the same information still has
> to be encoded. I can't see what the benefit of this approach compared to
> the other one is. "dallas,ds1374" already only has one translation entry
> in the table?

As soon as http://lists.lm-sensors.org/pipermail/i2c/2008-January/002752.html has been
applied, one could get rid of all entries where the I2c (alias) name can be obtained from
the OF name just by stripping the manufacturer.

Thanks,
Jochen
