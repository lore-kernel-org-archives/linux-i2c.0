From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v5 0/4] Fix i2c bus hang on A0 version of the Armada XP
 SoCs
Date: Tue, 14 Jan 2014 09:46:30 +0100
Message-ID: <52D4F966.6060200@free-electrons.com>
References: <1389193589-18485-1-git-send-email-gregory.clement@free-electrons.com> <20140114021421.GK19878@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20140114021421.GK19878@titan.lakedaemon.net>
Sender: stable-owner@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>, stable@vger.kernel.org, linux-i2c@vger.kernel.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-i2c@vger.kernel.org

On 14/01/2014 03:14, Jason Cooper wrote:
> Gregory,
> 
> On Wed, Jan 08, 2014 at 04:06:25PM +0100, Gregory CLEMENT wrote:
>> Hi,
>>
>> Here come the 5th version of the series fixing the i2c bus hang on A0
>> version of the Armada XP SoCs. It occurred on the early release of the
>> OpenBlocks AX3-4 boards. Indeed the first variants of Armada XP SoCs
>> (A0 stepping) have issues related to the i2c controller which prevent
>> to use the offload mechanism and lead to a kernel hang during boot.
>>
>> The main change are the use of marvell,mv78230-a0-i2c and that the
>> function mvebu_get_soc_id() is now local to mach-mvebu.
>>
>> The first patch add a mean to detect the SoCs version at run-time and
>> the second one use this feature in the driver.
>>
>> The 3 first patches should be applied on 3.13-rc and on stable kernel
>> 3.12 as it fixes a regression introduce by the commit 930ab3d403ae
>> "i2c: mv64xxx: Add I2C Transaction Generator support".
> 
> Ok, I've pulled this in by cherrypicking the commits.  I needed to add
> the 'Fixes: ...' and 'Cc: stable ...' language, so the commit ids were
> going to change anyhow.  I also added the note to the binding as we
> discussed.  I've also based this against v3.13-rc1 as there doesn't
> appear to be any need to drag in everything up to -rc6.
> 
> I've pushed this to mvebu/fixes.  Please take a look.  If it all looks
> good I'll send the pull request off tomorrow.
Hi Jason,

Everything looks perfect!

Thanks for having improved it,

Gregory

> 
> thx,
> 
> Jason.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
