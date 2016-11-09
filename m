From: Romain Perier <romain.perier@free-electrons.com>
Subject: Re: [PATCH v2 1/3] i2c: pxa: Add support for the I2C units found in
 Armada 3700
Date: Wed, 9 Nov 2016 10:55:04 +0100
Message-ID: <c68c9d6b-b1e6-5bdd-7725-7c409da2df2d@free-electrons.com>
References: <20161109081431.10115-1-romain.perier@free-electrons.com>
 <20161109081431.10115-2-romain.perier@free-electrons.com>
 <20161109085946.cmd4ltaxpiojq7il@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161109085946.cmd4ltaxpiojq7il@tarshish>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Baruch Siach <baruch@tkos.co.il>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Wolfram Sang <wsa@the-dreams.de>, Hanna Hawa <hannah@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Neta Zur Hershkovits <neta@marvell.com>, linux-i2c@vger.kernel.org, Yahuda Yitschak <yehuday@marvell.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Omri Itach <omrii@marvell.com>, Rob Herring <robh+dt@kernel.org>, Gregory Clement <gregory.clement@free-electrons.com>, Marcin Wojtas <mw@semihalf.com>, Igal Liberman <igall@marvell.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Shadi Ammouri <shadi@marvell.com>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-i2c@vger.kernel.org

Hi Baruch

Le 09/11/2016 =E0 09:59, Baruch Siach a =E9crit :

>> @@ -193,6 +204,8 @@ struct pxa_i2c {
>>  	unsigned char		master_code;
>>  	unsigned long		rate;
>>  	bool			highmode_enter;
>> +	unsigned long		fm_mask;
>> +	unsigned long		hs_mask;
>
> Do you really need 64bit for that?
>
> baruch

Mhhh, good point. No I think that I can use an unsigned int.
I will fix it.

Thanks,
Romain

-- =

Romain Perier, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
