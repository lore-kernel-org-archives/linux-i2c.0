From: Markus Gothe <nietzsche@lysator.liu.se>
Subject: Re: [PATCH 0/3] Add I2C support for Octeon SOCs.
Date: Wed, 13 Jan 2010 01:49:08 +0100
Message-ID: <F5F1F5D1-6057-49CF-A5B3-A921E1C0EEEB@lysator.liu.se>
References: <4B463B1F.6000404@caviumnetworks.com> <4B463C71.3080005@caviumnetworks.com> <20100111144416.GA23157@linux-mips.org> <4B4B5CD3.4040204@caviumnetworks.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <4B4B5CD3.4040204@caviumnetworks.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-i2c@vger.kernel.org, "Bozic, Rade (EXT-Other - DE/Ulm)" <rade.bozic.ext@nsn.com>, linux-mips <linux-mips@linux-mips.org>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>
List-Id: linux-i2c@vger.kernel.org

Methinks this goes to I2C...

//Markus
On 11 Jan 2010, at 18:16, David Daney wrote:

> Ralf Baechle wrote:
>> On Thu, Jan 07, 2010 at 11:56:33AM -0800, David Daney wrote:
>>> David Daney wrote:
>>>> This patch set adds I2C driver support for Cavium Networks' Octeon
>>>> processor family.  The Octeon is a multi-core MIPS64 based SOC.
>>>>
>>>> The first patch adds platform devices for the I2C devices.  The  
>>>> second
>>>> patch is the main driver.  Finally the third patch registers some
>>>> devices so we have something to control with the fancy new driver.
>>>>
>>>> I will reply with the three patches.
>>>>
>>>> David Daney (2):
>>>> MIPS: Octeon: Add I2C platform driver.
>>>> MIPS: Octeon: Register some devices on the I2C bus.
>>>>
>>>> Rade Bozic (1):
>>>> I2C: Add driver for Cavium OCTEON I2C ports.
>> Do you want to merge this series through the MIPS tree?
>
> Two of the patches touch only arch/mips/cavium-octeon, so it might  
> make sense.  But the I2C maintainers may have other desires, so I  
> would defer to them.
>
> David Daney
>
