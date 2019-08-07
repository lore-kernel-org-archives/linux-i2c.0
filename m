From: "Adamski, Krzysztof (Nokia - PL/Wroclaw)"
        <krzysztof.adamski@nokia.com>
Subject: Re: [PATCH] i2c-axxia: support slave mode
Date: Wed, 7 Aug 2019 07:09:32 +0000
Message-ID: <20190807070926.GB17104@localhost.localdomain>
References: <20190801132129.GA5550@localhost.localdomain>
 <20190806205124.GG911@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190806205124.GG911@ninjato>
Content-Language: en-US
Content-ID: <88B4540EB1019A4C9C932965A65343C6@eurprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

>Hi Krzysztof,
>
>> +	if (fifo_status & SLV_FIFO_DV1) {
>> +		if (fifo_status & SLV_FIFO_STRC) {
>> +			dev_dbg(dev, "First data byte sent\n");
>
>I think, however, these debug messages could go. They were surely
>helpful during development but assuming things work now, they will not
>help backend authors. Can you agree?

Good point. I'll remove those verbose messages and maybe leave one or
two debug messages with just a summary of the status which will
hopefully be a good compromise. Will that be ok?

>
>Rest looks good from what I can tell without knowing the hardware.

It also seems to work correctly and I tried to do everything in a way
that nothing is changed if slave mode is not used to eliminate the risk
of regressions.

BTW, I have added this synchronize_irq() in unreg_slave callback just to
make sure it is save to set idev->slave to NULL already. Most of the
controllers do not have such a guard and I'm wondering why that wouldn't
be a problem for them. Like the i2c-rcar.c - isn't there a small race
condition if some slave interrupt triggers just before ICSIER is cleared
and somehow does not finish before priv->slave is set to NULL? This is
the situation I was afraid of and tried to solve by using this
synchronize_irq().

Krzysztof
