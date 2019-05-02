From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: Prevent runtime suspend of adapter when Host Notify
 is required
Date: Thu, 2 May 2019 15:32:24 +0300
Message-ID: <7f989564-e994-5be6-02da-2838639efe59@linux.intel.com>
References: <20190430142322.15013-1-jarkko.nikula@linux.intel.com>
 <20190430155637.1B45E21743@mail.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190430155637.1B45E21743@mail.kernel.org>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, stable@vger.kernel.org, Charles Keepax <ckeepax@opensource.cirrus.com>
List-Id: linux-i2c@vger.kernel.org

On 4/30/19 6:56 PM, Sasha Levin wrote:
> Hi,
> 
> [This is an automated email]
> 
> This commit has been processed because it contains a "Fixes:" tag,
> fixing commit: c5eb1190074c PCI / PM: Allow runtime PM without callback functions.
> 
> The bot has tested the following trees: v5.0.10, v4.19.37.
> 
> v5.0.10: Build OK!
> v4.19.37: Failed to apply! Possible dependencies:
>      6f108dd70d30 ("i2c: Clear client->irq in i2c_device_remove")
>      93b6604c5a66 ("i2c: Allow recovery of the initial IRQ by an I2C client device.")
> 
> 
> How should we proceed with this patch?
> 
There's also dependency to commit
b9bb3fdf4e87 ("i2c: Remove unnecessary call to irq_find_mapping")

Without it 93b6604c5a66 doesn't apply.

Otherwise my patch don't have dependency into these so I can have 
another version for 4.19 if needed.

I got impression from the mail thread for 6f108dd70d30 that it could be 
also stable material but cannot really judge.

Charles: does your commits b9bb3fdf4e87 and 6f108dd70d30 with the fix 
93b6604c5a66 qualify for 4.19? (background: my fix doesn't apply without 
them but doesn't depend on them).

-- 
Jarkko
